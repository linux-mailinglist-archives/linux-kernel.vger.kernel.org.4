Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476A75EC591
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiI0OKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiI0OKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:10:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367F838B0;
        Tue, 27 Sep 2022 07:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQM8023HqkDedeY7a96ClJJEHCqY8vygeF8COICNTlgQFdGYapBjCJi+5h7NONxPjBQch15txUIB2SnORuVX2c1zX/oilNCo7wDzlKOthxJDEGBPw1KnqPWhDAxySgpmUiH/evr4Z5DpBPmF6Gl3s45vbsYaJTEKiZxlLhP42ckeFOEeJL+J6ppBeLRq2lQ9IRLJAwmKbhGavaiCqR2pyx/2r+fOJRyadtixhxHqDYf91m32GRJQQQ9yoTIcmluSfh3AzjFoUQGO07DLiwb6StfzAe7wHZp7uzBIcu56tKIl9dQJ1PE1A4fgbX4kQ8Mo4UZ9Ld6fh7YX8jUjagOMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whwClgSa8QJbiaW5rkopTnR6kSH4Qvu0UYiMagqQ4Y8=;
 b=fpXDBU72FAi1W+ZTfExR0aYcGqu24ia3TF4KpaY8EbNlLpxpJ0aebFFvcu9/20pTdylp613CtxSZRQN1veCnWcitR3EnoTIqhJRZ5KnTlaUkmiKbALj0L+cnBXHEvX0Uug3mFcYYd2xxbKN6LBXZ2MiCH1g3CFqVoNJv/byOwjUgqRLQ8mZlSNeIvDqqeI+TIkXFsXFH5fTRG9hyxNNFuo/XM4Q+kcrqTiW4c83y5zWeWFxpZJfeZ51dV/WB6CQ4MaNFq/G7dZPeSoZsQ8SA+N1uu1xoumavvYuu1wz3raskcs3mFwAld/JSVrLkS4oJuzw59lFaQXlKp8zypx5D/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whwClgSa8QJbiaW5rkopTnR6kSH4Qvu0UYiMagqQ4Y8=;
 b=xXvB2YZyWLvgKwKNqApYvmc0e9FoOgqp5/96jDji+VoAwydB1mt4R1EXiReNqKFrDdtWb898Drad3varDXfNj4yYioE02EZ2YhEsd+HkDwq8Lwurwm/nvwJMVebS0gpbXRnKmZFZ5X4GYKeoU48QWcvaIWXTG5oPYDbOrs+IRTs=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 14:10:25 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::19) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15 via Frontend
 Transport; Tue, 27 Sep 2022 14:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 14:10:24 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 09:10:21 -0500
Message-ID: <cbe89899-7f56-c43a-f8c9-887825fbe4a6@amd.com>
Date:   Tue, 27 Sep 2022 16:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Alex Helms <alexander.helms.jy@renesas.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <geert+renesas@glider.be>
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com>
 <20220926230438.GA3128861-robh@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220926230438.GA3128861-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 481dfd42-6b20-43cc-e678-08daa09205ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez8swxI9xtHPDv0e0fcqA2vlg0W5rLVYNX0jku/F95jDhHR47zxwHHf1BPYURWnlFRbSCYr/EZJPB2uITPNtNqB/XrX1FReEtGWFgQab9280OJ7Bl/NTaoIOJYpShmClttKfVpLrlVteU+L0TjAQvo2RKy4ohoW4LkZTrGiMhixHVOq7M6mJgMdutPG9fBYAn2swTohwzYMSZNYpcU1km6pPiqWeuLi1WBoDkPLEcQcnNpIxehOs+Nxq5dR89Wqw6DcjUC48Zn9vyXDYfPiMs29cbLAJ1cm5q5VqwVhfQeFwcFCDkP7K9xUxbzyYdqn+pG660ELOtK9pKORlURCeU3z9Ip0DdJe9FaTiYZiKkDY6H0Ju7xmqF3+uS9gZ02vyjs07pxem/hpX/WkbBA711/SIAZWued61px6Y6H+NlGvTF83S7WPaYZC28zCB7CEYJUv6XXc3prd7Jn3G/FRNyhgz2VDQ6mKHFP6nmfoo9NsWUAEt3wO3j8tr4ZltPyuCLnghyvChoY2rZIiMVAbtJU+NrLj2DdQwtIP8INJIy5Mq6xZUllNaNyOst78OmZ2vWvXmgPWoCg4OU4+fk7T58ZmWZhEl3IRBZ5jl2+Y0TZkmAX+8zHluVy5lnoNpZw0vanOQsLDSX0m1c5vDNxPFx+BAgoALmFoXsoSC2SNCf8Vg/eJ3CM4BUrUVW2AEKxWBzNtCHrxoaLyOkS5GU2tApkR4jJQOCrNaFaa+dZPQ3uMKGYRAzTL2SnrTB1LGGpK8J2KcZnv7+X2lvtQIiUQyZmwm8s7+nzFGE2A6xBZlI5ywknIT1I+39no0RJOWefKHOBXREcR3p3tmnxT1Yq3w3cm8dm/2RD4K3axViDpaOq7sn4n2hAVyECUrP3JsbTg8uPLnsa50XTwq/yYJl8XX3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(186003)(2616005)(86362001)(426003)(336012)(31696002)(82740400003)(356005)(36860700001)(40460700003)(44832011)(47076005)(8936002)(966005)(8676002)(40480700001)(4326008)(70586007)(70206006)(81166007)(82310400005)(5660300002)(2906002)(41300700001)(26005)(478600001)(53546011)(6666004)(16576012)(316002)(54906003)(36756003)(16526019)(110136005)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:10:24.5580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481dfd42-6b20-43cc-e678-08daa09205ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 9/27/22 01:04, Rob Herring wrote:
> On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
>> Add dt bindings for the Renesas ProXO oscillator.
>>
>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>> ---
>>   .../bindings/clock/renesas,proxo.yaml         | 49 +++++++++++++++++++
>>   MAINTAINERS                                   |  5 ++
>>   2 files changed, 54 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> new file mode 100644
>> index 000000000..79d62f399
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/renesas,proxo.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Renesas ProXO Oscillator Device Tree Bindings
>> +
>> +maintainers:
>> +  - Alex Helms <alexander.helms.jy@renesas.com>
>> +
>> +description:
>> +  Renesas ProXO is a family of programmable ultra-low phase noise
>> +  quartz-based oscillators.
>> +
>> +properties:
>> +  '#clock-cells':
>> +    const: 0
>> +
>> +  compatible:
>> +    enum:
>> +      - renesas,proxo-xp
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  renesas,crystal-frequency:
>> +    description: Internal crystal frequency, default is 50000000 (50MHz)
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> 'clock-frequency' doesn't work here?
> 
> Anything else needs '-hz' suffix.
> 


Driver is also using clock-output-names which is not listed here.

Thanks,
Michal
