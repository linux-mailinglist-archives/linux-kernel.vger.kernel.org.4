Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C472F5B80EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiINF3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiINF3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:29:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3AAEE26;
        Tue, 13 Sep 2022 22:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMavRbvDZm6DKa4m5yMktZOlBIl+/4+ZkUtOv4Pi3g3Y+eFx9PNQdSLyCUXk4NclUxCu/BaVD7KPHOmdE9vtgrBZROg1fQ+jxsDxxozivYvABYC9pwnV2SRP9cYJJB5VF5njBPOYrYsoDztA6eZZqmex+z254IFkIa1xzFRRjA0FbTyOK/v7ZEabuKg/FdueBhTBeFed1yC73pDLNPOLE8U0RqOPwJL9bebJRFWNgVImxJRidZh5aPgufJmFHeajVvI4RSVCq1GCYKoeF/oxTgQNh2HXvd2ONyeoktQM6UJGokjnCt8RVloMuhoZ7mNTook6fwumj5e3fbWXLKg4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxdYIc5682RaOd/T/JvqgmVBXGL1hcUE9RjWjHDq51M=;
 b=IzppbUvgOITKJXJwMBCR8YEFEFQHKfziQEWZ3RCsTSsv6hBqBGKvf9Bt/UlPoWgBrILmlPaUo3xB8b351R9HpPGhfqMioO3R+vqVAgbgBjaiFWana2ihhGO0BghEzal206QoWMgF+AYhqSohRtAurhemaNmq30rQlkrLpk2NGJeqdfknfUW5lyrS50fx3h/xE4y8Yvqqj/zXMyMXSTcdO5K7rMzatGgXlR8SJc2Wlgtu23loFWx2Rr2PSrXHwt6CfL0x6fVOQ0S0JN7h1t65nluAAfeigQpNnOUYS7Vfu8Rc1KDoNCc2A/ig6QFPK/F6eGsCyPDodwato7jov1U5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxdYIc5682RaOd/T/JvqgmVBXGL1hcUE9RjWjHDq51M=;
 b=pCJayS44DA10rHX27/BeaUZ1vcV63T1FKKc3jdZUdO94RBvPTDMjzyuYaprv138iWvD7kNkb4yPLzZl9YcvoWTmCl7YfXWSL6zH2C8ytVpRzOumb8i3gLKge9WJTYZd67Mc620e/UkzG8ihvDefKGNwiA87mwkepxP0CPqbvi72Rt0AN896yne78CZXNenCzqbuEaJLZzEtBh0Ur5ijRCa1g0+FGRpH83F+WhjsAD0Y3a6aiB8HTAS6VG4GRZNNTBXMhUn9wfk1SRUTFTJEp4Yb34ihkK+UKx0rzj51TztzL/KNrBrj/nrZKiv321ohQV8vpaaicD14Cl2q6wnfvPQ==
Received: from BN9PR03CA0468.namprd03.prod.outlook.com (2603:10b6:408:139::23)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:29:47 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::38) by BN9PR03CA0468.outlook.office365.com
 (2603:10b6:408:139::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:29:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:29:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:29:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:29:27 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:29:25 -0700
Date:   Tue, 13 Sep 2022 22:29:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>
CC:     <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <kevin.tian@intel.com>, <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2 00/13] iommu: Define EINVAL as device/domain
 incompatibility
Message-ID: <YyFmtOsvS9WHJEd2@Asurada-Nvidia>
References: <20220914051234.10006-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220914051234.10006-1-nicolinc@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0fd3db-91fb-4d09-8f5f-08da96122345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afGYiCsnMHEEvbBzqNcSfmPAS3eAes5vMGs1IjgaBSFIQfwNfnP+2xxUdQpGYmOru+/XAmmyqOeVyZyz/dsLaiBEgJow4eUuMJ1sfVQwgiLYnnnHuNc5cLAX5uVCTkgoUWjW3LhyDewsvsw8bTp/TA2uyBQKRXjcUE+mqyjzvzUsoov//ht3JXfDk8ZCIbDkNukviGgqghV0YH45bdBUZHQ3or0cP3gw25BT17riva5osD+tsQaF94Kp0hZ6W96buDCO3yFP/tkNCNVBXwE8ng0riaozEFQEdeLkARjIa3WHcVmeN2NXJMSELoyH/ldNA3gFw43sudNs05cgXIsIz+HzV09JoKJkjhauFm77rLZhOwPIhukYl3p06gDNKpJBakalH3RSp8Mml4cgpbDY8QqS+40wVtSJIo/ZHKuMW1qFIWRoTWXlhlqNwBeUi60BPk9b0foIN9nDfWRwlk7m3Bi7BRtbA1vSJCD1TomF2QXMe6LpONMtzVeOFcApXPNJ5fU309G491C7ZF2coLLznf4k7D/GaOLTkrFTgaeYOZKw8uPQa5lqt61RoJ/LWlJsvKm7RcA6wo1VwNVKCG4XBb5u6fPHot+xJiSpD9+e04IEiiSY4KLPd7zsFOObo1fn9Fxct28iwcuJMicwSuj1ObBBdUnzyoMLTP3SNBIM8VA/RJE0WD2RXgjkudHbZRddvUokeHLOTj8pdKz37YjCBqkCqgDQcYiqOq3fcBYynTFWggENEt3u86kQdR2untWTXRgrbs1box6ZnJSrzjxHdGynVssPCjvZ4El2GzdwOGKshZWin2IyJ7I+fLDp2PaiRy6YQI1xdhOOMVeF5zX02B5HBTaASUbCz/DKXg4sVCjMTz4uFh1JO11ue31emCJKlms4YSwsDyMjpAEeisFokcbDZ5Bt5/cshOISdgVg3NI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(9686003)(8936002)(82740400003)(110136005)(7406005)(36860700001)(55016003)(426003)(966005)(40460700003)(26005)(921005)(8676002)(70206006)(478600001)(70586007)(7416002)(186003)(4326008)(86362001)(7636003)(40480700001)(4744005)(5660300002)(33716001)(82310400005)(54906003)(47076005)(2906002)(336012)(316002)(41300700001)(356005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:29:46.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0fd3db-91fb-4d09-8f5f-08da96122345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Sep 13, 2022 at 10:12:33PM -0700, Nicolin Chen wrote:
 
> This series is also available on Github:
> https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v2
> 
> Changelog
> v2:

I just realized that the chain of this version is broken. Yet, I
think that people can still review the changes, though they may
not be grouped together. I will fix this in the next respin.

Thanks
Nicolin
