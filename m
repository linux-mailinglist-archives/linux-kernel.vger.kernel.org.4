Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595417415E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjF1QAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:00:06 -0400
Received: from mail-dm3nam02on2062.outbound.protection.outlook.com ([40.107.95.62]:19168
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232245AbjF1QAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfEyP9ZrIMpka7Ud7E8yOvXu7ojDaFDDEQmXN9B1G5fpEGu5OouOuDNl0OySLNK5XxmVarHbeG0EP8qy0xapmxvPaJt/BWY65jecXzB0T7Z1n9EKec9uz/KpnxqAo48n01kdxxm84AOM9SL1UXBoo0bDvC8fHWgRhHTGQu1HQ8TYQc+b56BC30eafqLhFu1i+NIcW3p2eOvzmwr1oA8q5AjLyvrEmLHDsR5H3OKmhV465YdplqAg9ixyAvfRU9PN7Ze367EzXhGW0Tl2J/U72PjBdK2ZTPRXYO8BYamPeDUoUo4RMeurQK1mZmtmDR4ZZN9yGBIMOO4k9nnV6yTb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MqI/cLeOKTmvQqmEVt+L3GJrpO7oa8E6R7VLK2llYo=;
 b=eLwit1SjbAGNgZVo3S3j2YQZCt5TYPL8zy7PdG3Q3b9XL9sNigw4juWPTLbTOE9okOS9YI6jExYjBLBQjDAt/N8PTbJHJ6NypjkukncwyM3AxVL/xGeM9gkXrvTFk1VD6UNuwRVMePTNMwoeB1vZ26ywBcfUL9vODVmnAtsFeziuhJ1XHLI6uVPDzZ10x2qFbtnN9aetbWTC5xNCYMRnMQ59cqbAN0PA53ukCiNds2Ib6sYhBbeHgZ4xDiKezCxnfzFG8KPJHDlnbSo0rIKPAh8/CwSQMSGX/mCtOLIjxkr3YHEwPnVqXPc/eB/5ADLL0ttPZHz5ZzL+/kl7XeE1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MqI/cLeOKTmvQqmEVt+L3GJrpO7oa8E6R7VLK2llYo=;
 b=fTxmhtvcKHcjCEIelGRBwH7PZVnY9O5FyzV3cdADEAuRSXKnSJfaqK6jR32C+wqmgEss8M91NFwtCACOG1JVEC7S0K+g8Sa40sCH6/i//ehyVrwJF8VEblzbGRhsD3dt0EH4FcfUxEdQ5PivsOUTCMboEJSEy70IaxzgtXVqmX2tynaZivRlMFhH6kSRuyfGWE9VLvKIuB0aW6+xItQvOI9f7yrsozqyicxUXN7+ojW+GEX+NnNFCHBbKT1hYTh09GqpvyK2Q5qDV3nifiawyyNYLV/hD6C6gDEAb5kms/Z4N6rzOQ+WBbumKTDyhsxZ+xedN5YOplJyPydtuSMq6Q==
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 15:59:59 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::2e) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 15:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 15:59:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 08:59:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 28 Jun 2023 08:59:49 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 28 Jun 2023 08:59:48 -0700
Date:   Wed, 28 Jun 2023 08:59:47 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <yangyicong@hisilicon.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZJxY8wyNZiAI40lm@Asurada-Nvidia>
References: <20230627033326.5236-1-nicolinc@nvidia.com>
 <826cbb86-ac7d-c40b-f7e3-51681cda50b8@arm.com>
 <ZJsXLFtH8WkRK41w@Asurada-Nvidia>
 <1b0c9677-4e2a-6767-f8f2-23081e6af3e0@arm.com>
 <ZJt7GhV4IOLvRhhr@Asurada-Nvidia>
 <2274ba47-7def-082c-8429-8f2cc18adf9f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2274ba47-7def-082c-8429-8f2cc18adf9f@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 289c7a32-1031-49ba-da7f-08db77f0b989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLIOhUep2thKfcG/buthMq92C9OW2TszQxmV+WZmOUlKnc4/KZTJrlj/p01Bw8MVseWxJjPVCI4hI6ZMZGr/Hi7uORsMGCY94LYdqiJhi6hjk/4NO8MEh0vj3hPYBuKAbdD8iSFlU4NedrRgMwUCv4BsVQBgz1FMxF2/pYsV7rAedmMXt18L4cKUh8WjkUhovSxoyYsek2O8uhzwn+aDvo9j/OE5e48zDSHQt7NYmtV6vt0ThErdljLu5dM3X1f0bRptzwt+lMu9/7zp0FpS2L/j/c0jADcxkHsIm3is2nS58LTB/6I+S9slnCNkRxoSo2t65nwctYXbC5hecg24T27QZiKMkcXFCZnJmm15XMDkcEOIgP4ksZrWJqfzAvV2ALdeboYZYhQKR7VunCvOUPtgiRwG7uEIxpyubc7RuaKVPKXMkM9ufzXixieTlchmmFTtVAgS9HOeKv+r4uHgVDIkL8PZeQDHespWrFd3Lpx9+wxopeF/nL0tjJpLoDBoUy7XmNAuvTysi8S6+kxw60B98WiRQqN15BdV8PTQkPTIHA5ski/hLV07qJx+19Zoj6Ddg9TA3UYSQlz8vACsLWnzt2MNe3si6kOnz4Ck2x2mAwlden/2uqp7mn6wde0MO1f1B+CwfokXCtqzIGFPtXk0tMsNUKr4gIhFFQIvlISlePLh1RMKmPhZR+gG8On0RAm1XdoTtZRjBOVWMgkixM1CJ7MClisguhK3Nshg8C+3/12FnYZKxZ0FoeEJDUb7kMKhMnJ2yOlKK5RCJMbKA788P1up4UUyYv3QWLqSdHc=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(478600001)(54906003)(40480700001)(55016003)(6916009)(4326008)(70586007)(70206006)(2906002)(316002)(40460700003)(41300700001)(33716001)(26005)(9686003)(186003)(47076005)(36860700001)(426003)(336012)(5660300002)(82310400005)(82740400003)(7636003)(356005)(8936002)(8676002)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:59:59.0326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289c7a32-1031-49ba-da7f-08db77f0b989
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Jun 28, 2023 at 04:39:48PM +0100, Robin Murphy wrote:

> > > supporting properly, i.e. refactor a bit harder to separate the CD table
> > > parts which are common to both S1DSS bypass and S1 translation, from the
> > > CD/pagetable parts that are only relevant for translation. S1DSS bypass
> > > remains the same as Stream bypass in the sense that there is no
> > > structure corresponding to the identity domain itself, so not only does
> > > it not make sense to have a pagetable, there's also no valid place to
> > > put one anyway - touching the CD belonging to SSID 0 is strictly wrong.
> > 
> > I can try that. Yet, I think the S1DSS bypass case still belongs
> > to ARM_SMMU_DOMAIN_S1/arm_smmu_domain_finalise_s1, right?
> 
> That's what I'm disagreeing with - although S1DSS behaviour requires S1
> translation to be nominally enabled for the stream as a whole, the
> bypass domain is distinctly *not* an S1 translation domain, and there is
> no S1 context to finalise. I think it's either a generalisation of
> ARM_SMMU_DOMAIN_BYPASS based on s1cdmax, or it's its own new thing.

Hmm, the fundamental of my view is that the ARM_SMMU_DOMAIN_*
list is quite matching with the CONFIG field of an STE, which
turns the S1DSS bypass into the ARM_SMMU_DOMAIN_S1 category.
And after all S1DSS is named "S1" :)

Following your view, How about ARM_SMMU_DOMAIN_S1DSS_BYPASS?

> > I'd try keeping most of the parts intact while adding a pointer
> > to a structure holding pagetable stuff, to make it cleaner. Then
> > the S1DSS bypass case can be flagged by an empty pointer.
> 
> I'd expect that what you need for this is much the same as what Michael
> has already proposed for the PASID-generalisation series. The current
> inside-out notion of S1 domains owning CD tables is what's getting in
> the way of doing the right thing cleanly, in both cases.

Yea, Jason had the same remarks when I discussed this matter
with him. But I took the chance after I saw a shortcut :)

I have been aligning with Michael already, trying to figure
out how much ground that our use cases can share.

Thanks
Nic
