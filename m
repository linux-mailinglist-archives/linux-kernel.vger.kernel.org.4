Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9E6FED78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjEKIGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjEKIGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:06:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B866444A9;
        Thu, 11 May 2023 01:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZejId5latthZh4fiiyGRynYlxnJeCaF0d//zlV5panrQw1u3sfoGlx47t373Ve6jr9U32ybLRBr3r77P4lamB/q9Xc1LJGf6lgz4Mip5QZmrC5xYKF0MG7eHENknjhLxk7Lr1TM+SMurH728jzQFgzknDUuTyBl+Q5CyAqV6dmOZrBKBmaM7QNdPHaYyEn+DyTiFb545HneK/xB0HrJowxtOyzfLvOTstqyP3YoR+CXP5ARp+0uEAs+a2YM6Gm/s5CmM62w+S2WAjces2LypjABBkzecmHlrw9FxOTIj4DZNeZLa93P6llg81JPKccoUhdTw2/aBYJTcLaN+3ya5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wmIfD9yMWvZtT2ZUnbK+A0CR+cUZO5XWPj7QyFApSY=;
 b=lWIqj5Mg25NTV95uvwVe71gI7fpvbtXcHfjJNha2QLNxUDqgeJYXO7SL9RkUyMPHZDbq7KFjXiA0N+ilLF9fdce5PkxiTQXNFLIXJF5wfCPYJU7OoRhkGEVOMDvEMYdujT0M7P00sMmotcMR0EyhKRSI0iehpzM0cA0EEn46lPrSEuHCos8SDDwEiixeUhRAovVjniuyyIgjT2zsxdviL+k9B7XnEpXqJsfAxZMITgtjIJ1v0sC3jXLnJLOvYAaoCxJNCd9OD9BlGU2XaA+TD2u+3W7mZAxKEZMsNk9gbxDiVP2R7+Gqjs1jbnvhkf7rehC4QKs2e06xN00kTl70Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wmIfD9yMWvZtT2ZUnbK+A0CR+cUZO5XWPj7QyFApSY=;
 b=Ndn2sIs/CF0egrTucbMmWL1xuOyTCklLEA9yXSKHBV2s7xKbeIlPF7RZWiIRMTgufW7/8RFviUBOGDQOXOG0zBdU3TFCJwKhJqmIvsuWFwPryU7OU5uKmLdzK51xynQK75qdIN3TrOpnpolM7zaUjhwASEKt99KTRbbC7PmR2CHSLWvzbANraq54iHBBrE4KA+Oxw9SdUrRpKVkW/35pE6GFhZ/RR4i7RqrhhgzS2KKu3udFPw6i72AxUaahBisRPxf5xolVL1FvnsBuHejilodH/HBm9wCKkBMHBLTxMVryoIdQim7CafRgsGt8sixRRYvea8l8J4BqCqS4aP0E5w==
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 08:04:59 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::c3) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 08:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 08:04:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 01:04:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 01:04:58 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 11 May 2023
 01:04:57 -0700
Date:   Thu, 11 May 2023 11:04:57 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: memory-region property for
 tegra186-bpmp
Message-ID: <ZFyhqXhzOUKYUafA@44189d9-lcedt>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
 <20230510142248.183629-6-pdeschrijver@nvidia.com>
 <cdba4bb0-551b-a3b2-9329-139d6cda71be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cdba4bb0-551b-a3b2-9329-139d6cda71be@linaro.org>
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: d19059cd-8cb1-4cc4-acaf-08db51f66a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbqNA96hfyImjN9b7pPvkGbAsn0AdFTSlS3iqGYZL2peSQL/z9rFg/PK05y5XtHxyZCRP31QD4G3er0zWTVC8p2UC+rT81BpL4kPvYf81I0NuMWMESRGN+JhIcdpmHTpzkE4TC5Qkhi6rrY5r2KsSEiL7XEtAeQkqPZ78Ac3JLVcfW33SvP2hiUXLbrZrAWnzrjo4GUoQzLRdC1oKjQeYLk4R8f0oHeU+lRUZma1GetxgRIf24rzMMd4QaaClLZIbJ2N2IHysLQwzwjMgTksDvYKLfdKSFZYLJHnP7dvMaV5tcDHyNPY5VX0dJlDVkTK48ZN0rGDNjqRjD95RIZ8eVJWSrdZtZ/Zsjo/nUDKBDsOOx24PjD+aOECDTv6vVaLT09twOMvduVKkqq1X3Ia9itCwdd9jTSo0AAh/eHf99Wx+efvVDOCUM9oYVhOJI8VQAdgKODeQnIVY1ccDyEvakmKrXgoIvj6eNsck/hR/uHaZvjOwmSC+1txzGC1Z6cahR5S9DmdPKmKLVwZh8WyFSgz4zr5ivAPUyNq5Cc4+Ab7x09kKcv2qlO9zrSb4oKvUDh20WTBpP6yMaAOQMHFWTAq59ekSfkgbRhWOEWZHSkNg8kJQygdwKq2Zn2NrfZ/uO1vFChb61R9maCunbklIlqkvAkrO96LiPwvw85X+Ursjg1OTf7qXKdJN3osaWMwdoMu7zdFvCjPTSk2pEBj6Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(107886003)(186003)(47076005)(54906003)(316002)(7636003)(40480700001)(82740400003)(356005)(26005)(9686003)(41300700001)(53546011)(5660300002)(86362001)(36860700001)(8676002)(82310400005)(8936002)(70586007)(70206006)(6916009)(33716001)(4326008)(426003)(336012)(478600001)(40460700003)(2906002)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 08:04:58.9304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19059cd-8cb1-4cc4-acaf-08db51f66a5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:01:55PM +0200, Krzysztof Kozlowski wrote:
> On 10/05/2023 16:22, Peter De Schrijver wrote:
> > Add memory-region property to the tegra186-bpmp binding to support
> > DRAM MRQ GSCs.
> > 
> > Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> > Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> 
> Also no changelog. Since I do not see improvements after Thierry
> comments I assume you send the same.
> 

The changelog is in the cover letter. I will send it to you next
iteration.

Peter.
