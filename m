Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298EC70E8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbjEWWLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjEWWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:11:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8098BF;
        Tue, 23 May 2023 15:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0GubgZjd3q2Xenn1ouGIZQvqjSAxytJPu/08kqV4CS0sNJgeSlEJ82hIRIFetC0OBn6VmtRxQCaeBPZcOdfdWBgzEs4+z5A4ieOUrH5SMuPMxXp/dO0wsK6ZG/Dop+KbyoT3m25L5AusHVvfmmOCxvsmXN85K2EOQ8YjNEqYbaD5FciDzPN2pD1ul7F8w+oB9prC2+PJNaK945SrGroR4S0ejcQZYlK9YGwWg/3PJpxseLRRaZB6+SdYZAXHhUeUOudmzwOyyUiv+tHM62m1YdvCp6TVxtDaiPGXgXnQY4Knin3FsaNXEuPVGA0ph5KE7NFB24RMbDcnJjL/JjsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DubgyKDjyaE5/LDn6Dxn2l3TRpa344eUrqtil+luAqA=;
 b=KQMvGWYVgS39B3SNBbLx34V57orJy/OEo0NcutJeIMyUWBgsTz/W6mvACJ/8o3utv4l7/taABAFKfzqtIjbVBK1CQ4K8QyyQSf+8qEU+4bBHvMOAUi7B788gzkYWQ2815wYJ8HL6mkFiHfepyV0IDqcpVWn3RHTgBKIdIvIj9JwIp/DX+Ic/MCsNu/0iryaOQ27VNdBq6GKDCAXNNIjW6jTX5e7pWlW0tw93wcKfgeumyAgsVsgN8+2SL1An3XiL+R6XWUE/gJ1cLQ+8orTX8QoH046qf92xP8KhHaaFSLK3U+Kdo58WQHJTFyiRR2iAiRPk9XXWXqSJVJwkYsC9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DubgyKDjyaE5/LDn6Dxn2l3TRpa344eUrqtil+luAqA=;
 b=RpcHV03cAMnwSTJmW6h/HTO3iGYkFm1Tut1RtOCCwBGIC/p94oiJB6fLkltN9BOHvJRsng5fooNNonJMluWd0wcV5kj8wATgT3PQKYjBCU5tN4ka+Az8HiZykI2PaVIWcpi4oXutcdup84z7S9RweBSZtcE4J7awG3H/k67cL+8=
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 22:11:43 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::9d) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 22:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 22:11:42 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 23 May 2023 17:11:39 -0500
From:   Brad Larson <blarson@amd.com>
To:     <arnd@arndb.de>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>,
        <hal.feng@starfivetech.com>, <hasegawa-hitomi@fujitsu.com>,
        <j.neuschaefer@gmx.net>, <joel@jms.id.au>, <kernel@esmil.dk>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee.jones@linaro.org>, <lee@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Tue, 23 May 2023 15:11:32 -0700
Message-ID: <20230523221132.64464-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bc5118f2-8982-46ff-bc75-d0c71475e909@app.fastmail.com>
References: <bc5118f2-8982-46ff-bc75-d0c71475e909@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df8807b-7b7e-4b73-a9c0-08db5bdab0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: it3++5qtjJuMEyKi4xjTI65zd9l1imYAPVhfse9VlqACEjL1M48m80jR78N5UQRFhJpODnMqvJke7eemoMxsA0fHoJ56/d8CaG200adLtmlFh3Vs8jT9lS90uKSRCC6IXVYglpjFabXo+HX6yo51oDaU3mVAiGyma7mcxxClcLeUKyzgwUrHVBOWiWFwH1qAQ9BvgJH2S+VY8ho4JiPS04p4sj+Qf/wpJ9zpVnb/x+sMs30VgnKoFeFz5Bt7vAYz1Ex7UQgEcRgQNA5d4bJkUJ3ZLeeikn4Mhx14rfZ/gUqJm/cYdhFGOpNV4L5BdkuTodNhyWD+pPVcKbi1U7Ko+XY/oKpHgdTYAdFHMyIGPZcWv/eEkloMdsxYOLRhVMw0ze+b/1Hs8OUSkzdn66yOMD7J/zuzkQK6tCNJBQ89z5raFtBtbagpqeNWW7hocuHIBXU10NJJ1szRnrG3wpNjE/UzR8nKr6S2hPTejRJyEVlSUZZDXRMyBV0fTyggzOow/vhXpBufbeos9plegApltef5+UwCxjTQmf5AkMipExUByHMLY0jBQqD0OXyScYv3HuSXH/W1NhGSWqK2Fs6XVegeOpifG9yTp8Vn8e093PAB2JSXuczjivazuEPUpeyN506QV32IcqC+6kDza7ZQPjZQ4sue2+8Df9v4tz8KldXRIR29I12nv1RslD2qtLgCAQd8DZarh7fCKOoVS/2KdMKgkdh70eCidY4V+n8miG2kE5MfTtUP0CXRxGV16f/+Y4Bdhb2AULO/HUuUsey82g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(316002)(41300700001)(26005)(1076003)(70586007)(54906003)(6916009)(70206006)(4326008)(5660300002)(8936002)(8676002)(7406005)(40460700003)(7416002)(40480700001)(82310400005)(36756003)(186003)(47076005)(36860700001)(81166007)(82740400003)(356005)(2906002)(426003)(16526019)(336012)(83380400001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 22:11:42.7167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df8807b-7b7e-4b73-a9c0-08db5bdab0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> On Mon, May 15, 2023, at 20:16, Brad Larson wrote:
>> The Pensando SoC controller is a SPI connected companion device
>> that is present in all Pensando SoC board designs.  The essential
>> board management registers are accessed on chip select 0 with
>> board mgmt IO support accessed using additional chip selects.
>>
>> Signed-off-by: Brad Larson <blarson@amd.com>
>
> Hi Brad,
>
> I'm sorry I wasn't paying enough attention to this driver as the
> past 13 revisions went by.
>
No worries, bit of a saga.  See explanation below.

>> v10 changes:
>> - Different driver implementation specific to this Pensando controller device.
>> - Moved to soc/amd directory under new name based on guidance.  This driver is
>>   of no use to any design other than all Pensando SoC based cards.
>> - Removed use of builtin_driver, can be built as a module.
>
> it looks like this was a fundamental change that I failed to see.

See explanation below.

>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menu "AMD Pensando SoC drivers"
>> +
>> +config AMD_PENSANDO_CTRL
>> +	tristate "AMD Pensando SoC Controller"
>> +	depends on SPI_MASTER=y
>> +	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
>> +	default ARCH_PENSANDO
>> +	select REGMAP_SPI
>> +	select MFD_SYSCON
>> +	help
>> +	  Enables AMD Pensando SoC controller device support.  This is a SPI
>> +	  attached companion device in all Pensando SoC board designs which
>> +	  provides essential board control/status registers and management IO
>> +	  support.
>
> So generally speaking, I don't want custom user interfaces in
> drivers/soc. It looks like this one has internal interfaces for
> a reset controller and the regmap, so those parts are fine, but
> I'm confused about the purpose of the ioctl interface:
>
>> +static long
>> +penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>> +{
>
>> +	if (num_msgs > 1) {
>> +		msg++;
>> +		if (msg->len > PENCTRL_MAX_MSG_LEN) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +		t[1].rx_buf = rx_buf;
>> +		t[1].len = msg->len;
>> +	}
>> +	spi_message_init_with_transfers(&m, t, num_msgs);
>
> This seems to be just a passthrough of user space messages, which
> is what the spidev driver already provides, but using a different
> ioctl interface. I don't really want any user-level interfaces
> in drivers/soc as a rule, but having one that duplicates existing
> functionality seems particularly wrong.
>
> Can you explain what the purpose is? Is this about serializing
> access between the in-kernel reset control and the user-side
> access?
>
> Also, can you explain why this needs a low-lever user interface
> in the first place, rather than something that can be expressed
> using high-level abstractions as you already do with the reset
> control?
>
> All of the above should be part of the changelog text to get a
> driver like this merged. I don't think we can get a quick
> solution here though, so maybe you can start by removing the
> ioctl side and having the rest of the driver in drivers/reset?

In the original patchset I added a pensando compatible to spidev and that
was nacked in review and reusing some random compatible that made it into 
spidev was just wrong.  Further it was recommended this should be a system 
specific driver and don't rely on a debug driver like spidev.  I changed 
over to a platform specific driver and at that time I also needed to include 
a reset controller (emmc reset only).  I put these in drivers/mfd and 
drivers/reset.  Review of the device tree for this approach went back and 
forth to _not_ have four child nodes on the spi device each with the same 
compatible. Decision was to squash the child nodes into the parent and put 
the reset-controller there also.  One driver and since its pensando
specific its currently in drivers/soc/amd.

There are five different user processes and some utilities that access the 
functionality in the cpld/fpga.  You're correct, its passing messages that 
are specific to the IP accessed via chip-select.  No Elba system will boot 
without this driver providing ioctl access.

Regards,
Brad
