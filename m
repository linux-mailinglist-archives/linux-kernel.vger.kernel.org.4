Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E76AD48D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCGCTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCGCTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:19:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EEE4AFD0;
        Mon,  6 Mar 2023 18:19:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYBFwexQGN+dYo5mhk1edKQF0CQGNp0sQKPb0pyUY3nPA9ZiRhzygkg1527FcOtIv0Km2Lf/U/GNEyPZnNNEMVIuB2pCVGunNqAT2zC/FoyJkCz/SleyxbEgy4GvHVEB5JTw5oyFBHRLnKqjjnVVGNRfPKdgkBt1xbuCHt54p2cEY98ZoXHSdeAXccaefiURN3lVuZjMNVygChRqqwuuCeqPpqkfK0VDPzT4JiZypZoOu1n/KUJJ5MZpCkHT+jPlmtJq/lzjBfZAtn0dTKY7HYfvyKFJni3vzJv6SFDpexI6sAAirLpLUaSiTRqiDlU4FsPBoeX0ttljTs92+03Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBcMV63enlFjM5SgpfE1OZzt/Yu4XPEBnCiKTaO1qjs=;
 b=c4V/Zz8+ovNHqPw0suzRuGm1LbcA58FCSUM6f4x9ZXmUJ9eVvninix6ZqTkipqB1JNzh0abfeEXcm8JeXCy2J0BGwpjh6VWnxOEBc1ZVhfSPOOm3G5Mfu1WwgyAu7UmraonZgfMbHOZBCeYtIL9gh4LCjM2oJsSKw/4KXre1qcGJ9AZ/XbwjoiMOq2reesMx7c/oc6KJYwxyOYhfoZvq+jZUNz7YjHwW3D3bI198VWHQv9yPmVoscmJM2PrmVO1iKcdR9Qxgy7j7bv1BMTVvgaIs0fPzHDDDd/x5gow4FtTA/gQyTfVCEH2eN2Kme1GpyGPDgvs9VH0buaw0PxiJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBcMV63enlFjM5SgpfE1OZzt/Yu4XPEBnCiKTaO1qjs=;
 b=TP4BtUOiTlWDENvJuY5V4XfIs/XrwUCfh8pSnbn9jZyD0C4/U1+tCalc5kdLBT1HDuv48t5OolUt6vmXRmjeQR+Rja8ApKsO+BOCswOhRahgM4Zo1A6s/gKP4iDZF0HYNPveA+JZzcEGulYPKEkI8Y1c+zOUXItkFBJvlpRfKRg=
Received: from DM6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:5:1b3::48)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 02:18:57 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::d7) by DM6PR17CA0035.outlook.office365.com
 (2603:10b6:5:1b3::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 02:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Tue, 7 Mar 2023 02:18:56 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 20:18:50 -0600
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
Date:   Mon, 6 Mar 2023 18:18:22 -0800
Message-ID: <20230307021822.71245-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e82ca6f6-0870-f9b0-172f-bc6d54a9749b@linaro.org>
References: <e82ca6f6-0870-f9b0-172f-bc6d54a9749b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 1966c802-c4e7-407d-8915-08db1eb24e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9ioQnks1yWdA1LEPugZUvUnIBdLGfGyn0YhfpzWDl/wmMuPIp/qthC6Y7oK/A5n3//MIsbGVw4XVo/RQeMwaS52wiN1LCt53LonNkYzDawh/u+RVTpYOpoJ+PuKVD3KWwG+U6jwKhmPYxHOHMWvy1ofI7GUFQ5tSG9WcfUAhOk/8ogxyEU8h6cMyJ9nGSWJFUlUvdQaRzpshfK6YndPJQZCK0NN+3Wno9EVRo0ROUvbHqo8y3ViijI8+lRh31Dxz3Q6YC3Aa6bKb3tYPBf66scuDF1PtMLuIkb/ekE0nGkfBgVkE3UzCVsxQT5d8n/7Zbc6DCxxmLyPXw1gWf5N3Lq7EW+YeKcVkLqiczewsJ1gcXzuoXfBdsm+uWhJOO6IPpf//obOEXfUtRhGsnZhmh3x5XaTm1hRozBQEDkHEQqmvd+1xZ9Caj2+9M7bxvn2KAvlBPebfJbIJAo8ytXHZCyQZo+5Ftg4qwZjzBD1hnJT5rlFP6wZpTdKBmZ33MjGR8720GkiTQ1+Fn92x/KLR097lDcgly8qoQDJH1VrwvrOGuo6NyDanSICKLIFlHd66DxObfMItNWmHGDcsiIfNrZEiOo0qOtMGSJXdIszfHYwveM+H2b/X9V+KyrunhGztiWei3mdEMR+fkHIaOcP3f3zEu5jtvzYSoxZnXsTtv56p+A/Oqsq7dLC2BZQTjyUUMVC5k7OeJfOR7TPJK7EWPPKMbYi8aIyhLjrZWyS6W4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(82740400003)(81166007)(356005)(36756003)(5660300002)(2906002)(7406005)(7416002)(70586007)(70206006)(4326008)(8676002)(6916009)(40480700001)(8936002)(41300700001)(6666004)(82310400005)(186003)(40460700003)(336012)(2616005)(53546011)(16526019)(83380400001)(47076005)(426003)(316002)(478600001)(1076003)(26005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:18:56.8598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1966c802-c4e7-407d-8915-08db1eb24e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 09:35, Krzysztof Kozlowski wrote:
>> On 06/03/2023 05:07, Brad Larson wrote:
>>> Support the AMD Pensando SoC Controller which is a SPI connected device
>>> providing a miscellaneous set of essential board control/status registers.
>>> This device is present in all Pensando SoC based designs.
>>>
>>> Signed-off-by: Brad Larson <blarson@amd.com>
>>> ---
>>>
>>> v10 changes:
>>> - Property renamed to amd,pensando-ctrl
>>> - Driver is renamed and moved to soc/drivers/amd affecting binding
>>> - Delete cs property, driver handles device node creation from parent num-cs
>>>   fixing schema reg error in a different way
>>>
>>> v9 changes:
>>> - Instead of four nodes, one per chip-select, a single
>>>   node is used with reset-cells in the parent.
>>> - No MFD API is used anymore in the driver so it made
>>>   sense to move this to drivers/spi.
>>> - This driver is common for all Pensando SoC based designs
>>>   so changed the name to pensando-sr.c to not make it Elba
>>>   SoC specific.
>>> - Added property cs for the chip-select number which is used
>>>   by the driver to create /dev/pensr0.<cs>
>>>
>>> ---
>>>  .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>> new file mode 100644
>>> index 000000000000..36694077b2e6
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>> 
>> Your subject suggests this is pensando-elbasr but you write everywhere
>> pensando-ctrl. Confusing. Pick one.
>
> Actually pensando-ctrl is for sure not correct, because it misses the
> name of the SoC (you call it everywhere "elba").

The reason I dropped elba as part of the name is this driver and its associated 
SPI attached device (cpld or fpga depending on the board design) will be used
across a series of SoCs starting with Elba.  Implying its Elba specific is misleading.

Regards,
Brad
