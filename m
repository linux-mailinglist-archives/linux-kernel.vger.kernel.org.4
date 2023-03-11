Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B16B6213
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 00:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCKXcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 18:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKXco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 18:32:44 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789BA56788;
        Sat, 11 Mar 2023 15:32:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abkrc87wvJTTeMLPsRH2EGPW8TdBa+yhI6lgaWEJZvSFp72APZdt07OSO4OS5V3AE9/anVe5lvPErUmcWjVhHm4rUYSihgbVPE1RpuZCXE1ECMOlGfmbK0xcQ1I6NNzmw3xhXVU192qrLDYYA7mz+SLQvBVTGF7GmLxIUcSk/vHjx6SBkAKKJDUQPgfKbw6H0tkZSHxvnPM5GD93CLqYgnEii5SywTgY2ub09lXuXJpHL4XhPiWYTyZH1NlINYKSAR38B+XAxDXHyb5SXb11+eXkELmG5QEyrUiY/+75PYP96FE42wB0CRPKOq6p+z3fvle1hR40pPfdv8IAdT43sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suvjxZKubvVCLM/BektFVbm1v4cooYResP2V+Fox/aU=;
 b=gzhUNVDlqnBoY2lQQRARXANZs6reYP6Rv4ij7FbN6KSNRrVsZRHZjHdZye5uGCkxkdQ3zM7cFg6CoXd5iPtykOJ5RF0cU73d8lBXdXpip9vHufKx5+BEWULY9iWZfDq721q4MYN9FwZkqO/t2KzMObZtw/Ugygku4jluSsSg8fOChsGqWcX+DPBF+HFPQgCI2M9TfsEPMcknJZI/7HuKq/fN6zUEC/E2ScF4lQO/urc0Cg7b2fqv6tG6QBK7PwK1QDTlD4D9Ib3qSFJpcqd9TtLovkd5Ay/hTuSrOsjCGe6V9/rKmqHJIxlFdEDCK9+pkR/WM/LSCmR75VCstGkYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suvjxZKubvVCLM/BektFVbm1v4cooYResP2V+Fox/aU=;
 b=KAalzDjpGLC8jgPSVjyoNRTHmIP+Rpwxbf2xv1hdEMrXg1G1nr0XfzJNji4jsG0gMCxbI1XAcwcrUDspgf45lc575ya2xxq3KbxK++W+PaQXvAkqt0ApLcx7Np0RV98agXcfOPHH4WybpNPtpvOFJx/ZluO+T/GjvdHU1Ed/amY=
Received: from BN0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:408:ec::19)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 23:32:36 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::fa) by BN0PR04CA0104.outlook.office365.com
 (2603:10b6:408:ec::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24 via Frontend
 Transport; Sat, 11 Mar 2023 23:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Sat, 11 Mar 2023 23:32:36 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 17:32:33 -0600
From:   Brad Larson <blarson@amd.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v10 05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add AMD Pensando SoC System Controller
Date:   Sat, 11 Mar 2023 15:32:26 -0800
Message-ID: <20230311233226.813-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2691debf-0596-c265-468f-bb66d19f6db0@linaro.org>
References: <2691debf-0596-c265-468f-bb66d19f6db0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 942b1a16-fefe-44f7-f4ed-08db2288e58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APnO5HW35+hoWIp2f1tOCGvbZ8WmjYXYz8BqqWKmL9Dnds2Iq3efPhwXe17rY53PxKTJMYNPfLJ6z8bJSQ7bP85FAAZCM4DJYVqLFRe4fj3cgJxQ6dxdU3qmHEJhLGAXWe6HSq2C0XNOOyxFA6p1Rds1OzGTbYkXnbxarEafNXC5M/kUl+2T9HVlje8BISfqZZ1wI9oxr51QUr900FRdEd/yk5ZJek9Kuq+LERlPq7tkSaOWzVLFjsRutq/RJ03C5YEtZzWpSkS9B23wsHqzfmFFP2kLZXxqT/H8fl7SgzocNSbqDPY7jx0payMTONq4RCnfY451PiA4vpIxdbBz61ezzAjZX+jVei7DNubeXAADm/4rv4JhQtx4TzzzJ98RkirdpfjIfzTSp8TogYxKcokUaXSSJVI3fvZA14YvmufQxAj+Q0Uw1QDoeL/M9ivvwkH5uMaJ2dlcRBmYX0J+ij5Z9I36x5G9B35LCZKMYqsYh+ULrDJnQlngNnhtoJdPV4MJa6BdpFhJLTVO68uK9Yrwe6XBC1qt/niQ6wu5XfS0/cNAiPpmqilgDUC7YDuM/1eeznIX9kVLSjAOHKcfNoEfyQLHbZyxwcIZXZY7LC3KGxC3zgoNZM2MOVTJCCNKY29hap6c+cFTUWJg2+Lt3xK/KkuN9LAGExLBouAOB8SiQItdjuGQQpLJFSGeJp/3GVJrvHpan21Gkr9jrqvc9nm+HzFZ7pE0Jb50JMmdWjc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(83380400001)(426003)(47076005)(36860700001)(82740400003)(6666004)(53546011)(1076003)(26005)(16526019)(186003)(81166007)(2616005)(966005)(40460700003)(70586007)(70206006)(41300700001)(6916009)(8936002)(8676002)(4326008)(7416002)(5660300002)(7406005)(2906002)(40480700001)(356005)(316002)(478600001)(54906003)(336012)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 23:32:36.4549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942b1a16-fefe-44f7-f4ed-08db2288e58c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 09:46, Krzysztof Kozlowski wrote:
> On 07/03/2023 03:18, Brad Larson wrote:
>> On 06/03/2023 09:35, Krzysztof Kozlowski wrote:
>>>> On 06/03/2023 05:07, Brad Larson wrote:
>>>>> Support the AMD Pensando SoC Controller which is a SPI connected device
>>>>> providing a miscellaneous set of essential board control/status registers.
>>>>> This device is present in all Pensando SoC based designs.
>>>>>
...
>>>>>  .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
>>>>>  1 file changed, 60 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..36694077b2e6
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>>
>>>> Your subject suggests this is pensando-elbasr but you write everywhere
>>>> pensando-ctrl. Confusing. Pick one.
>>>
>>> Actually pensando-ctrl is for sure not correct, because it misses the
>>> name of the SoC (you call it everywhere "elba").
>> 
>> The reason I dropped elba as part of the name is this driver and its associated 
>> SPI attached device (cpld or fpga depending on the board design) will be used
>> across a series of SoCs starting with Elba.  Implying its Elba specific is misleading.
>
> Compatibles must be specific.
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> If this is SoC part it must match SoC. What is misleading in this? Why
> Pensando is different than all other SoCs (I am really getting tired
> everytime asking why people think their solution is special)?
>
> If this is not part of the SoC, then your commit msg is misleading.
> Maybe bindings as well, so rework it.

Yes, changed it back to 'amd,pensando-elba-ctrl' and fixed the dts, driver and commit message.

Regards,
Brad
