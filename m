Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2750F60266E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJRIHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJRIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:07:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3CE8559B;
        Tue, 18 Oct 2022 01:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQbcKXaRU+7Yrc6HBG7JPf0xntSkDviEiUJrhwIRYO7nFqdobC5AqCF65afMLqXgFTm5f6zNv+fG84XUpzIq5QAvWi+lqvCr+XYPn54TBUlkIEXNkaAozRQLL5yuqGs/XQJ9bjbsIzrO2kFc/i86q0DqF9lXLREeWLSNdNOmGQQq3s5+L9ORniyQdn8nrdEIKijME2YHmbLPR+2zRfEcbmhqDifgmx0XZbxpLd8VdJecoCQxLxjmOftMfzff4eUg9lVyVTzMKkqbf9GO8AIto+JB6zQbn2dhmXHHdfUmE0IwxSPglhfbbujrJ89RsjbEUnwr6J0AZsic4G4BeFe90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx+yrMDh/vhQhScokhg5AOJCGl5nVvAdCROQs8ZlWNg=;
 b=dPsbtOi6TQpDYqpp4gbbOHGoUbB0VqrPyhjevrDR/9apcfJD0c3b3WiMvIDKTVS09u5p9scMC07NhRxhsWM7vrQugITv0n3LSoFxVFz37EmwYGyYVHxlsnubd3UmkCkIFyURJSC/5HTRySkSlebNhu8Tb1IeR/LDFRBkBjBmSK8XJNX5lyhf0pej2dNHz+mPGpLBnV9ggvh4NG/AVzne5wxcSXlLqyxsANORR4Jfqd92uFuA2g7lpOUCHQeeH3Ds76YKTloS/rSrmrnLlVyhgnb8B2tSynnN+9aEo5Qsehul7ErtgrYXucqvvqlDclJWA6SeTvUleHswzCh9g3FBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx+yrMDh/vhQhScokhg5AOJCGl5nVvAdCROQs8ZlWNg=;
 b=mp4V9KvHLqWaQNQf6mkx92Qc7XbqglT7I3Rq49IW9+57CEMrN2JeMRsaecAcLcAZJblwMclBlgqCJgxd3e3AX6KAOAM7sMp05kqy7xwuH0Q+CA5Ts6SpWZueRv52p3DTfQMHSSymtzWEs/H3lYIy87xMj8DowPAlOdfsmyb8oUY=
Received: from DM6PR07CA0127.namprd07.prod.outlook.com (2603:10b6:5:330::28)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 08:06:57 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::f6) by DM6PR07CA0127.outlook.office365.com
 (2603:10b6:5:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 08:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 08:06:57 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 03:06:53 -0500
Message-ID: <48b5848c-e8f6-a6f7-ba1e-8c914374e6b2@amd.com>
Date:   Tue, 18 Oct 2022 10:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 0/2] pinctrl: pinctrl-zynqmp: Revert output-enable and
 bias-high-impedance support
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>
References: <20221017130303.21746-1-sai.krishna.potthuri@amd.com>
 <CACRpkdYYvznEKQ0huj5XwNwghMP-FRw5e54Di9FLVdXdsFP3-A@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CACRpkdYYvznEKQ0huj5XwNwghMP-FRw5e54Di9FLVdXdsFP3-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: def1678d-3807-4b6f-e3c0-08dab0dfba1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BylaI06f9C+wkNzODEldsRMYJPW71zHd4ymOIBdNtzAoDJwxgkS1DcTgtlPQmK4xB1B2rCsn2r+b7QdwGefiEoHtn8tD671WBaH0dQPfsscU7eOm4vz24qZ+lNxCzFRegO7d3djYKcL6OXFA5I6Vgo6iL+sc20nURqPXRO3DXVFRYaV2EmiJiqre4QvadvDM4OpdBUY1ytSLilvAeIirJHB4HHxBdmIsSLgf0ItK/92L8qOAOTR1CgO5DA6SB/6BzuDVeVvwWqzxoAXXroXcwJkseCV4Wue8zeabxSYnjM7HYKnG3SXVW7dJi0KRitgsJcDvBDKsbLUjbi1B77mz2Y54SVsvMwJ8ofMbRkmLRD714KyJ6kfzioU+e51Ejm7d3stR8zOjdj+l4XItWxeuXl5KwFkbcSf0GrMWxueKnXYx4atePNoB8QsWe2K+N1UBK6hBGvxQ5WXdrhzq/+rHSOPpaKnawUTWNN682/RcWYmzzGrxFtRZT4fvb3rwGbeYPs0CBir/6/sfpmJBEdx4zZw3ijPT2AAnirRTM5ZmrIzO3tH9xi6seEuNa5R6/0z+Irnx2znP4y+Dmcdxo4MfWjdFz2+9m/ZTyjd2lEHkZAM6JRFMC+b74c1iSLZnK2QAp6T8GhbsboNVggVMs4CarKmQiflVwHFeWFQxUCXA0hX3r+NnhqJfoH/E8jPKz9L9qasObmiVP5szZ0T4tHuApadWnGQOi0bC8c254/bGRzQSjRHOPVXTM49Y2Q9LN4YRCPoJOrtR8u3ulgEleOGI4/nw4HwNxjjIwHTYnOn0xiXSuE803HKX3SgRCJYl0c4iJREs7aWIs6HdrQM9vCvzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(66899015)(110136005)(6636002)(316002)(54906003)(478600001)(16526019)(16576012)(186003)(2906002)(336012)(4326008)(70586007)(70206006)(8676002)(8936002)(2616005)(41300700001)(53546011)(44832011)(26005)(4744005)(5660300002)(36756003)(82740400003)(40480700001)(36860700001)(40460700003)(47076005)(86362001)(426003)(31696002)(83380400001)(31686004)(356005)(82310400005)(81166007)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:06:57.2281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def1678d-3807-4b6f-e3c0-08dab0dfba1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/22 09:51, Linus Walleij wrote:
> On Mon, Oct 17, 2022 at 3:03 PM Sai Krishna Potthuri
> <sai.krishna.potthuri@amd.com> wrote:
> 
>> Having support for output-enable and bias-high-impedance properties
>> causing system hang with older Xilinx ZynqMP Platform Management Firmware
>> because there is missing autodetection feature.
>> When this feature is implemented, support for these two properties should
>> bring back.
>>
>> changes in v2:
>> -> Added stable tree tag in 1/2 and 2/2 patches.
> 
> Patches applied for fixes!
> 
> Thanks for dealing with this, I hope you find a proper way to make
> it work with all firmwares.

The way what pmufw team described is that driver will ask firmware if that 
feature is available or not. If yes, the current calls will be made. Maybe we 
could do it via module parameter but this is the cleanest solution for now.

Thanks,
Michal

