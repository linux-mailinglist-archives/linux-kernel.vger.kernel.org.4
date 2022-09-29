Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF35EF4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiI2MBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiI2MBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:01:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6694E7F102;
        Thu, 29 Sep 2022 05:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha2apzQp4s3OIFi9rvmJUVU64vrNNxW9Pt0WVZj7xloBgEBN35HO8CYUb960kzE/+TEn/PpLVgSOSjSVMtx93+JWhcaLRqlhXbSxO3Ax/TLOCMiF96mUGZcco6sFvg/lZT3BEy2HkaN0czsCGDJcKKFIIxPcVuKGk0JD0x8wFz9SWH/B1tMuStjeFes0mOiMsG2FyZZqyg1Hg+KIYMcNrAKy8H8Qi+O8CMQb+L2cphcyjYB2zQZFknwCueqh8HJX8LDqRRPGNPLTOMyGbr4tN7+s4dwAQyN/hpcqbI+MLKQ+jEOGmEj6LvnVLmM0PymwDr2kKt/6BRbUjAKSskiYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quRAmKT5sJGfeQRrYnMyXLThKwMs4Hi0Xyqk+CPPso0=;
 b=V+bYZTiFDUI0V8pZOI0R9eDZQFTh/t4CL4xZbIZvjt2Ay+xrtNZzi6LoivLV1eQZR15cOBEWSjEsd42MyN3G827hZdLWlqzFVLOQGfTzoS8UuCrHjFz/Kp84fV5Xi1IQT1ZPASQa2LoHqRi3nCpxVFoxD8wWr72gpyDzGZvie3WJCWJTVK/hl6K8mGRZuOnTPozIvsHgeaKguBBbuEyRjdAjaLOZDiIS2C0qkiRnnrN3HgGv+65XvOGUdISWnmb4C7Ax4TkiX89DsfECgxfyKi5ZH1iQ0dbUbNATTVp7nYZ0O9araT6H26Qhy6fcGikdRC2aB/JEoPD3c4KkRj8zeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quRAmKT5sJGfeQRrYnMyXLThKwMs4Hi0Xyqk+CPPso0=;
 b=k2tDKD+rnzUTOJiED3DFSA8sBlKT5/2ft5Fe9vwyNAKWwMJwMKLiRIPoLi0DxfdLI1eml0CaRguO3XZsEh9QYRnPXD4ZZUFsubKV32uIaHHPcRsy2w2eNs7QY2O2H5uCTUK+goao5jq34YlTMZX8UVE1e6xGfcBnaOzP1S6S/38=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 12:01:11 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::61) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 29 Sep 2022 12:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 12:01:11 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 07:01:07 -0500
Message-ID: <a89b8124-78e2-f9a9-c3bf-1e30687127ca@amd.com>
Date:   Thu, 29 Sep 2022 14:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <geert+renesas@glider.be>
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com>
 <20220926230438.GA3128861-robh@kernel.org>
 <cbe89899-7f56-c43a-f8c9-887825fbe4a6@amd.com>
 <CAMuHMdUuzrdf4rmD3n_-S9ujrfmY5Y6VOsNapiLRR5MG9bKAjw@mail.gmail.com>
 <5a037955-4832-e42a-eb58-719ed4672395@renesas.com>
 <20220928234137.71ACEC433D6@smtp.kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220928234137.71ACEC433D6@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 99edaa7a-9b8d-4e11-83c0-08daa2124d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNEv0/XCqpbB26MOc+zspQ/iXRzhyypFx7dh2MuGiQLWOGIgMQRTUYTFdUHL60L+yeORAgBPVQrOUHPLfAtf073nIRuViyf8fR1MpESvAR04Mt3CH7eJ1m2ZJK+aEyEb1TVlfHI4YVhk6PLrFstu0IyYtMgjLKs9UkyAVi7AGnTg+dompHP23+RHtMBilgv4amJPYxO1W/gCVIR+SRQlWKWnU/omVdStqMHJ4A/ICsYAk2Zcq4h5BR+zDXnnV1Gi51Nvh24Oj6VagP2/bItupdLcFTkhbnXGd1TKonElILORHBZvLqqvlYiaZFYm5+Hsyml8KNZ9s1SJu2xPPlXKweqUQFa5rEk4EAIXbur2iJzR+qFwa1I55wSR7pOeNVfOhtXIlaicfeTSFvEF/GJPAxZgBs1oQi6R+J0yj1QEk/iHyjpWi1v7gxzcT6jL129W4Zu/MXlWdd3W6jaCnEIcimHbkq9a+3qGD+i3+4zK2gH2Z8lqvQdRGS76xCRwV6GUFJcmAUVPdNOVPPFALdecc7j4GHTuy9bDwaQBYOVhIbk5RXTIYBeQRxV/Sr3RhrLdn5+8kFLKJTxx7U9xTOI7ZyqtOezLJVfZOqLymlLnEg+f/rrAV+e4ReBrmAuoSUmPzi2izjE7tpx/w2xECQabCU7vNdcskqxUZK+jaySaxk2dcaF2PpI0xeeswxz5r+dxzEWB7NelMLiENiP/wzID2WPQ1x2Ai396eh8qAZEjX+x5dBD4KrJMXq5NEZElpR7r61me7xzT6Tw0eCDfQYFqzBCZ6qAuckhKh+UrIYb8nSuDNxfqNV5bG0WW4JkmKb1Gj9S1vpK+glTa+dNk+k1yBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(316002)(86362001)(110136005)(16576012)(82310400005)(478600001)(54906003)(36756003)(70586007)(70206006)(5660300002)(8676002)(8936002)(41300700001)(4326008)(31696002)(81166007)(40460700003)(26005)(36860700001)(83380400001)(53546011)(356005)(16526019)(186003)(40480700001)(44832011)(336012)(2616005)(82740400003)(47076005)(426003)(6666004)(31686004)(2906002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 12:01:11.1377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99edaa7a-9b8d-4e11-83c0-08daa2124d22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 01:41, Stephen Boyd wrote:
> Quoting Alex Helms (2022-09-28 16:16:04)
>> On 9/27/2022 7:51 AM, Geert Uytterhoeven wrote:
>>> Hi Michal,
>>>
>>> On Tue, Sep 27, 2022 at 4:10 PM Michal Simek <michal.simek@amd.com> wrote:
>>>> On 9/27/22 01:04, Rob Herring wrote:
>>>>> On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
>>>>>> Add dt bindings for the Renesas ProXO oscillator.
>>>>>>
>>>>>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>>>
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>>>
>>>> Driver is also using clock-output-names which is not listed here.
>>>
>>> ... which is deprecated, and thus should not be used by the driver
>>> at all.
>>
>> Can you point me to somewhere showing it is deprecated? It is in the
>> current dt clock documentation.
>>
> 
> I wouldn't say it is deprecated. Instead, it isn't useful if you're able
> to use struct clk_parent_data and auto-generated clk names.

I am not closely doing clk subsystem but these chips are clock provider without 
any parent. If you mean calling function like this 
of_clk_get_parent_name(client->dev.of_node, 0) then it should return null.
But maybe there is something else what you are referring to.

I see that fixed clock driver is using node->name which is also problematic 
because node name for these devices on i2c will look like clock-controller@XX
where XX could be the same when i2c muxes are used.

And in connection to deprecation. I see only one file which is saying that it is 
deprecated.
Documentation/devicetree/bindings/sound/samsung-i2s.yaml
and it was deprecated before yaml conversion already.

Thanks,
Michal


