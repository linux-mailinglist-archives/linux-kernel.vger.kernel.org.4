Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0033B70F36B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjEXJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjEXJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:49:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165DF93;
        Wed, 24 May 2023 02:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqY0Q4P59/jSkyhcBJGLTgu5hIgfU7OKsTfUOmB5O+d2XptaKqXp8mdSlhmQV31cZjRk2P1RerNd5q0tIFPnv38zYU0RGJr6RlmHUEwOXEvVh9djbhTcEzgW0YU6rjzL8GncryV8Wtby6vrllgow0QNYRTgom85WmpTHW4vVbPw4e8CmacpCh6DXN74L432RnxklpXuEn6Xz5RsJcKgHckIhX5wq+jXAeT4y/n2NB1VovgOMAliizzoZXu3r4XLCCvSC09V55KrJ4o//xvhlDqk3JWMAaDuV/zLrYmTnML/Sy4YnXedQRbsLD2fKC1+nnC8l9ExZmdGVaFm/52wP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D95hhpWJqU2U2QIei4ykuVY7vz8QYbqs9IdixhMg0Dc=;
 b=UQqwTQRWQJUwv/SrqmjuVwS6ZrNApkOhhW7FD9SXdqCrB0YkCkIwMoVjsuSHvnNLcIRSSXsNMXPHys4hPDGCy/184y/tMSTlf/1CAQMueau5Bv3e6rW0MtydazG72Nu6BXhy8SP7KCgBtv6oqIRALt2bBU6TMeij7S5oHMepxrLJzHhmFdd0TuoH/TtUKJG8SthqTwiD92NY3vHY3ohM42Rmd+XIf6VVF2o+LwaYb/huoH5Xim85H3dIUauzsro9FBMp262N2/GL6qfp0hKZU0v57c7ga1OtnO4TxwieIHzZ/botMsPDg2QCEUCq2naH19Us6HNyC0csi3K2qJuT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D95hhpWJqU2U2QIei4ykuVY7vz8QYbqs9IdixhMg0Dc=;
 b=H9+Ruypumvgrq0+a/NDPKZnEItOZKvBYLnXaDQyBBrDh0vWcx7Uhy8GrJseQbKKqR+vyZKE6dcNSmRD9hgZaGhGmAeEut0hrKRyEkNlN1546CANmZYKd40YWmjq1RAK/pnnhToDAP+Pcup9cuF5S50CCR/525EwOcSgYEbFV+P0=
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 09:49:28 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::46) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Wed, 24 May 2023 09:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.31 via Frontend Transport; Wed, 24 May 2023 09:49:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 04:49:25 -0500
Date:   Wed, 24 May 2023 11:49:22 +0200
From:   Robert Richter <rrichter@amd.com>
To:     kernel test robot <lkp@intel.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 13/23] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
Message-ID: <ZG3cpEj9k8S9DMAA@rric.localdomain>
References: <20230523232214.55282-14-terry.bowman@amd.com>
 <202305240842.zr8PTfcu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202305240842.zr8PTfcu-lkp@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 626655b5-32ed-4395-eb76-08db5c3c2a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3cZ3MHZL/4jHuOedJZdgrbTWubdx7SZO2mj8YaoEa31ISG/EXHDyKwB9pCP2j4uQMjAugEE7ORPbiUIUEPx1zm6S0UFUY7qqWP3PoqkLWzmZGPpiUciopTIRDYg12+3BbBoU45dk3glCeWfe/mf63k71dhzmbZHZV2K4vVgjxl56dj5wG0XI6RcAeT4tfVgb0YHY8frPgO4zjjo59Nxrccldr0GPKkukZekEeZZWhs/6IGberinvEJhfXBQVkzq35j6RruUwXW4AzMjgYlnKcvwL89YRvtZVlq/fjbGzjc9LiT8V5F1ePJkNPi0yPRAdkFTTZDLqWZ97FZezrGq2FkoD4BDoV/QLfujkjvdjVDFYFTF1KGy+wP3QqB06mwAdEGWYpHplhfhf73FaPpADB2cFor6xpQA0qD27yGSEcKCEp5t7yX7Xyl6sXmcdiKgt5aH1FBquzt5CMpOHNKehI8A/YWqOl8PEN1qMFVYwvs4lF8AzPv03LxNWil3BgqKUXN0kAiFZ+CMSqNPYPqIVbAPlBNumpuNj0G1w3dg7Lgvj+v4Xp1ZTh4dlV3g9uvayPCMZf8Q1aGw2yxcttTUj+okaKnuDCUZa8Mk8TeRO897/vaVcalXsA/KJUJTjzTZgDUWEJBICW8v7U3qBrmRcjHUyw3xFop33/JAFmlIlsgcqXrDpEvlTo+OJeETjReCU1jrvO6Xt7RBJOFnnYaq65K2bdsDV0cR+oJjktFFrv6ckOHDwXLUOaADmFKdvDiDkIVvfUJRC3804LLbQIfiUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(40460700003)(8676002)(7416002)(8936002)(16526019)(186003)(53546011)(4744005)(36860700001)(47076005)(426003)(336012)(2906002)(83380400001)(356005)(82310400005)(82740400003)(81166007)(40480700001)(55016003)(9686003)(26005)(316002)(70206006)(4326008)(6916009)(70586007)(6666004)(54906003)(478600001)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 09:49:28.2490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626655b5-32ed-4395-eb76-08db5c3c2a71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.23 09:12:24, kernel test robot wrote:

> >> drivers/cxl/core/hdm.c:128:26: warning: no previous prototype for 'cxl_port_get_comp_map' [-Wmissing-prototypes]
>      128 | struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
>          |                          ^~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/cxl_port_get_comp_map +128 drivers/cxl/core/hdm.c
> 
>    127	
>  > 128	struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)

This should have been 'static' and also solves the warning then. Will
change.

-Robert

>    129	{
>    130		/*
>    131		 * HDM capability applies to Endpoints, USPs and VH Host
>    132		 * Bridges. The Endpoint's component register mappings are
>    133		 * located in the cxlds.
>    134		 */
>    135		if (is_cxl_endpoint(port)) {
>    136			struct cxl_memdev *memdev = to_cxl_memdev(port->uport);
>    137	
>    138			return &memdev->cxlds->comp_map;
>    139		}
>    140	
>    141		return &port->comp_map;
>    142	}
>    143	
