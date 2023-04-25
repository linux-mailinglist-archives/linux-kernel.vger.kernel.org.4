Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CFC6EE1C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjDYMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDYMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:20:53 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C5CC2A;
        Tue, 25 Apr 2023 05:20:49 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PBGju2016834;
        Tue, 25 Apr 2023 07:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=/x8zHhknLmyyPZ9+ptMZDlYVSrD8hGpoQbx0/t86wk8=;
 b=CE4GOBGglm+mX9NRwohwy2KPklU+4O9AW1thRkT0J1MRsRjKYIVjeWqOxzjuyLqzLDyC
 9s2d1IRIFmG36Eib+NmyxLXERmK7XX3KOKogF0djzLwlFSderEeGp4NjbcbSfuTLiGk9
 6xOeRDAvTuure1Ipjp+ozxkv7mNT4D1aZV/n4h5VqgA/F8AtkO5wK5cLgO4NABkwLtUA
 /IEeNXxsIR6N5+miy2d3K/OH/rbtx2T9GZAuvsu6hAAYX8FcZ9DTUNj8WJPFiPZprjbs
 pNWCNTgIShqOIxHPEcp1Mm0q8TILD+rt0CJel5ihPBnS9QfZ9jeS47ymWyU8WrVcKwRp wQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3q4c0pmh56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 07:20:19 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 25 Apr
 2023 07:20:17 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 25 Apr 2023 07:20:17 -0500
Received: from [198.61.64.196] (LONN2DGDQ73.ad.cirrus.com [198.61.64.196])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D10C9475;
        Tue, 25 Apr 2023 12:20:16 +0000 (UTC)
Message-ID: <3023021e-161a-cc4e-f9d1-d673b1f3e533@opensource.cirrus.com>
Date:   Tue, 25 Apr 2023 13:20:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V7 1/7] spi: Add stacked and parallel memories support in
 SPI core
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@microchip.com" <claudiu.beznea@microchip.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "vitalyr@opensource.cirrus.com" <vitalyr@opensource.cirrus.com>
References: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
 <20230406065336.10980-2-amit.kumar-mahapatra@amd.com>
 <007c01d9688d$d770c670$86525350$@opensource.cirrus.com>
 <BN7PR12MB2802CF25D5ADA9C8F00FCA0DDC9A9@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e3704956-e72c-421c-fd65-b8f17b7e2a5a@opensource.cirrus.com>
 <BN7PR12MB2802761D14D99B8001939252DC639@BN7PR12MB2802.namprd12.prod.outlook.com>
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <BN7PR12MB2802761D14D99B8001939252DC639@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QJi9-FsAJ03m0FDeU-EgMFMgrTUE8-Ff
X-Proofpoint-ORIG-GUID: QJi9-FsAJ03m0FDeU-EgMFMgrTUE8-Ff
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/04/2023 10:04, Mahapatra, Amit Kumar wrote:
> Hello Stefan,
>
>> -----Original Message-----
>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>> Sent: Wednesday, April 12, 2023 8:33 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>> michael@walle.cc; miquel.raynal@bootlin.com; richard@nod.at;
>> vigneshr@ti.com
>> Cc: git (AMD-Xilinx) <git@amd.com>; linux-spi@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-mtd@lists.infradead.org;
>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>> claudiu.beznea@microchip.com; Simek, Michal <michal.simek@amd.com>;
>> linux-arm-kernel@lists.infradead.org; amitrkcian2002@gmail.com;
>> patches@opensource.cirrus.com; vitalyr@opensource.cirrus.com
>> Subject: Re: [PATCH V7 1/7] spi: Add stacked and parallel memories support
>> in SPI core
>>
>> Hi,
>>
>> On 11/04/2023 10:07, Mahapatra, Amit Kumar wrote:
>>> Hello Stefan,
>>>
>>>> -----Original Message-----
>>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>>>> Sent: Thursday, April 6, 2023 7:14 PM
>>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>>>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>>>> michael@walle.cc; miquel.raynal@bootlin.com; richard@nod.at;
>>>> vigneshr@ti.com
>>>> Cc: git (AMD-Xilinx) <git@amd.com>; linux-spi@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; linux-mtd@lists.infradead.org;
>>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>>>> claudiu.beznea@microchip.com; Simek, Michal
>> <michal.simek@amd.com>;
>>>> linux-arm-kernel@lists.infradead.org; amitrkcian2002@gmail.com;
>>>> patches@opensource.cirrus.com; vitalyr@opensource.cirrus.com
>>>> Subject: RE: [PATCH V7 1/7] spi: Add stacked and parallel memories
>>>> support in SPI core
>>>>
>>>> Hi,
>>>>
>>>>> -----Original Message-----
>>>>> From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>>>>> Sent: Thursday, April 6, 2023 7:54 AM
>>>>> To: broonie@kernel.org; tudor.ambarus@linaro.org;
>>>>> pratyush@kernel.org; michael@walle.cc; miquel.raynal@bootlin.com;
>>>>> richard@nod.at; vigneshr@ti.com
>>>>> Cc: git@amd.com; sbinding@opensource.cirrus.com; linux-
>>>>> spi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>>>>> mtd@lists.infradead.org; nicolas.ferre@microchip.com;
>>>>> alexandre.belloni@bootlin.com; claudiu.beznea@microchip.com;
>>>>> michal.simek@amd.com; linux-arm-kernel@lists.infradead.org;
>>>>> amitrkcian2002@gmail.com; Amit Kumar Mahapatra <amit.kumar-
>>>>> mahapatra@amd.com>
>>>>> Subject: [PATCH V7 1/7] spi: Add stacked and parallel memories
>>>> support
>>>>> in SPI core
>>>>>
>>>>> For supporting multiple CS the SPI device need to be aware of all
>>>> the CS
>>>>> values. So, the "chip_select" member in the spi_device structure is
>>>> now
>>>>> an
>>>>> array that holds all the CS values.
>>>>>
>>>>> spi_device structure now has a "cs_index_mask" member. This acts as
>>>> an
>>>>> index to the chip_select array. If nth bit of spi->cs_index_mask is
>>>> set
>>>>> then the driver would assert spi->chip_select[n].
>>>>>
>>>>> In parallel mode all the chip selects are asserted/de-asserted
>>>>> simultaneously and each byte of data is stored in both devices, the
>>>> even
>>>>> bits in one, the odd bits in the other. The split is automatically
>>>> handled
>>>>> by the GQSPI controller. The GQSPI controller supports a maximum of
>>>>> two flashes connected in parallel mode. A SPI_CONTROLLER_MULTI_CS
>>>>> flag bit is added in the spi controntroller flags, through
>>>>> ctlr->flags the spi
>>>> core
>>>>> will make sure that the controller is capable of handling multiple
>>>> chip
>>>>> selects at once.
>>>>>
>>>>> For supporting multiple CS via GPIO the cs_gpiod member of the
>>>>> spi_device structure is now an array that holds the gpio descriptor
>>>>> for each chipselect.
>>>>>
>>>>> Multi CS support using GPIO is not tested due to unavailability of
>>>>> necessary hardware setup.
>>>>>
>>>>> Multi CS configuration with one native CS and one GPIO CS is not
>>>>> supported as this configuration could not be tested due to
>>>>> unavailability of necessary hardware setup.
>>>> I've tested this chain on a released laptop (HP EliteBook 840 G9)
>>>> which uses SPI to interface to 2 amps, one amp uses a native CS and
>>>> the other uses a GPIO CS, and I noticed that when using this chain,
>>>> the second amp no longer works.
>>> Thank you for testing this patch series on GPIO CS setup. As I don't
>>> have a GPIO CS setup, is it possible for you debug the failure and
>>> share more details/logs where the problem is?
>>>
>>> Regards,
>>> Amit
>> We are willing and able to debug this failure and share the failure logs.
>> The first issue that I see is a kernel crash when trying to set the GPIO CS:
>>
>> [    2.951658] general protection fault, probably for non-canonical address
>> 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI [    2.951771] CPU: 9
>> PID: 379 Comm: systemd-udevd Tainted: G A           6.3.0-rc3+ #30
>> [    2.951826] Hardware name: HP /896D, BIOS U70 Ver. 89.33.02 10/29/2021
>> [    2.951882] RIP: 0010:gpiod_set_value_cansleep+0x21/0xa0
>> [    2.951941] Code: 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 85 ff
>> 74 3e 55 48 89 e5 41 55 41 89 f5 41 54 49 89 fc 48 81 ff 00 f0 ff ff 77 2c <48>
>> 8b 3f 48 85 ff 74 53 48 83 bf 68 03 00 00 00 74 34 44 89 ee 4c [    2.952043]
>> RSP: 0018:ffffc008c0deb928 EFLAGS: 00010287 [    2.952080] RAX:
>> 0000000000000001 RBX: ffffa0a489534c00 RCX:
>> 0000000000000000
>> [    2.952124] RDX: dead000000000122 RSI: 0000000000000001 RDI:
>> dead000000000122
>> [    2.952167] RBP: ffffc008c0deb938 R08: 0000000000000000 R09:
>> ffffc008c0deb868
>> [    2.952211] R10: ffffffffffffffff R11: 00000000000000b0 R12:
>> dead000000000122
>> [    2.952256] R13: 0000000000000001 R14: 0000000000000000 R15:
>> 0000000000000000
>> [    2.952299] FS:  00007f7fa5b5b880(0000) GS:ffffa0a81f840000(0000)
>> knlGS:0000000000000000
>> [    2.952369] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    2.952407] CR2: 000055d648427100 CR3: 000000010e960003 CR4:
>> 0000000000770ee0
>> [    2.952451] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [    2.952492] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
>> 0000000000000400
>> [    2.952533] PKRU: 55555554
>> [    2.952561] Call Trace:
>> [    2.952579]  <TASK>
>> [    2.952598]  spi_set_cs+0x257/0x4a0
>> [    2.952630]  spi_setup+0x1a2/0x500
>> [    2.952667]  __spi_add_device+0x88/0x160
>> [    2.952710]  spi_add_device+0x60/0x90
>> [    2.952738]  smi_spi_probe+0x178/0x370 [serial_multi_instantiate]
>> [    2.952792]  smi_probe+0xcf/0x110 [serial_multi_instantiate]
>> [    2.952854]  platform_probe+0x42/0xb0
>> [    2.952885]  really_probe+0x1b2/0x420
>> [    2.952914]  __driver_probe_device+0x7e/0x180
>> [    2.952947]  driver_probe_device+0x23/0xa0
>> [    2.952993]  __driver_attach+0xe4/0x1e0 [    2.953021]  ?
>> __pfx___driver_attach+0x10/0x10
>> [    2.953061]  bus_for_each_dev+0x7a/0xd0
>> [    2.953088]  driver_attach+0x1e/0x30
>> [    2.953123]  bus_add_driver+0x11c/0x220
>> [    2.953150]  driver_register+0x64/0x130 [    2.953174]  ?
>> __pfx_init_module+0x10/0x10 [serial_multi_instantiate]
>> [    2.953221]  __platform_driver_register+0x1e/0x30
>> [    2.953251]  smi_driver_init+0x1c/0xff0 [serial_multi_instantiate]
>> [    2.953310]  do_one_initcall+0x46/0x220 [    2.953339]  ?
>> kmalloc_trace+0x2a/0xa0 [    2.953375]  do_init_module+0x52/0x220
>> [    2.953411]  load_module+0x223c/0x2460
>> [    2.953450]  __do_sys_finit_module+0xc8/0x140 [    2.953479]  ?
>> __do_sys_finit_module+0xc8/0x140
>> [    2.953510]  __x64_sys_finit_module+0x18/0x20
>> [    2.953538]  do_syscall_64+0x38/0x90
>> [    2.953574]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> [    2.953606] RIP: 0033:0x7f7fa5d7476d
>> [    2.953639] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
>> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
>> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f3 36 0d 00 f7 d8 64 89 01 48
>> [    2.953739] RSP: 002b:00007fff1f8dd3b8 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000139
>> [    2.956833] RAX: ffffffffffffffda RBX: 000055d648654ab0 RCX:
>> 00007f7fa5d7476d
>> [    2.959202] RDX: 0000000000000000 RSI: 00007f7fa5c54ded RDI:
>> 0000000000000006
>> [    2.961542] RBP: 0000000000020000 R08: 0000000000000000 R09:
>> 0000000000000000
>> [    2.964312] R10: 0000000000000006 R11: 0000000000000246 R12:
>> 00007f7fa5c54ded
>> [    2.966694] R13: 0000000000000000 R14: 000055d6483f41a0 R15:
>> 000055d648654ab0
>> [    2.967668] resource: resource sanity check: requesting [mem
>> 0x00000000fedc0000-0x00000000fedcffff], which spans more than pnp 00:04
>> [mem 0xfedc0000-0xfedc7fff] [    2.968998]  </TASK> [    2.971615] caller
>> igen6_probe+0x178/0x8e0 [igen6_edac] mapping multiple BARs [    2.975014]
>> Modules linked in: igen6_edac(+) fjes(-)
>> serial_multi_instantiate(+) int3403_thermal sch_fq_codel
>> int340x_thermal_zone int3400_thermal intel_hid acpi_thermal_rel acpi_tad
>> sparse_keymap acpi_pad mac_hid msr parport_pc ppdev lp parport drm
>> ramoops reed_solomon efi_pstore ip_tables x_tables autofs4
>> spi_pxa2xx_platform dw_dmac dw_dmac_core nvme intel_lpss_pci
>> intel_lpss crc32_pclmul thunderbolt i2c_i801 xhci_pci idma64 nvme_core
>> i2c_smbus virt_dma xhci_pci_renesas video wmi pinctrl_tigerlake
>> [    2.987901] ---[ end trace 0000000000000000 ]--- [    3.157030] RIP:
>> 0010:gpiod_set_value_cansleep+0x21/0xa0
>> [    3.159077] Code: 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 85 ff
>> 74 3e 55 48 89 e5 41 55 41 89 f5 41 54 49 89 fc 48 81 ff 00 f0 ff ff 77 2c <48>
>> 8b 3f 48 85 ff 74 53 48 83 bf 68 03 00 00 00 74 34 44 89 ee 4c [    3.161461]
>> RSP: 0018:ffffc008c0deb928 EFLAGS: 00010287 [    3.164005] RAX:
>> 0000000000000001 RBX: ffffa0a489534c00 RCX:
>> 0000000000000000
>> [    3.166354] RDX: dead000000000122 RSI: 0000000000000001 RDI:
>> dead000000000122
>> [    3.168499] RBP: ffffc008c0deb938 R08: 0000000000000000 R09:
>> ffffc008c0deb868
>> [    3.170609] R10: ffffffffffffffff R11: 00000000000000b0 R12:
>> dead000000000122
>> [    3.172893] R13: 0000000000000001 R14: 0000000000000000 R15:
>> 0000000000000000
>> [    3.175335] FS:  00007f7fa5b5b880(0000) GS:ffffa0a81f840000(0000)
>> knlGS:0000000000000000
>> [    3.180434] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    3.183356] CR2: 000055d648427100 CR3: 000000010e960003 CR4:
>> 0000000000770ee0
>> [    3.185107] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [    3.186840] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
>> 0000000000000400
>> [    3.188647] PKRU: 55555554
> Thank you for sharing the logs.
> As per our analysis the spi->cs_gpiod[0] is getting messed up while
> setting it in __spi_add_device( ).
> Is it possible for you to do the following changes on top of this patch
> series & re-run your test.
>
> After applying this patch series, in drivers/spi/spi.c file replace the
> following code snippet in __spi_add_device( ) function defination.
>
> if (ctlr->cs_gpiods) {
>          for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>                  spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[spi_get_chipselect(spi, idx)]);
> }
>
> with the below code snippet
>
> if (ctlr->cs_gpiods) {
>          for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>                  if (!(idx != 0 && !spi_get_chipselect(spi, idx)))
>                          spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[spi_get_chipselect(spi, idx)]);
>          }
> }
>
> then re-run your test.
>
> Regards,
> Amit

I'm still seeing a crash on probe:

[    3.265683] BUG: unable to handle page fault for address: 
00000000fffedfdd
[    3.265744] #PF: supervisor read access in kernel mode
[    3.265781] #PF: error_code(0x0000) - not-present page
[    3.265817] PGD 0 P4D 0
[    3.265840] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    3.265865] CPU: 4 PID: 385 Comm: systemd-udevd Tainted: G       
A           6.3.0-rc3+ #32
[    3.265910] Hardware name: HP /896D, BIOS U70 Ver. 89.33.02 10/29/2021
[    3.265956] RIP: 0010:gpiod_set_raw_value_commit+0x3d/0xf0
[    3.266007] Code: 48 89 e5 41 55 44 0f b6 ee 41 54 53 48 8b 17 48 2b 
82 70 03 00 00 4c 8b a2 68 03 00 00 48 c1 f8 03 48 0f af c1 66 90 48 89 
c6 <49> 8b 44 24 60 44 89 ea 4c 89 e7 ff d0 0f 1f 00 5b 41 5c 41 5d 5d
[    3.266092] RSP: 0018:ffffaad780f6f620 EFLAGS: 00010a03
[    3.266121] RAX: 333330b6bdbad102 RBX: ffff9c8d4a5f6800 RCX: 
cccccccccccccccd
[    3.266156] RDX: ffff9c8d4a5f6d40 RSI: 333330b6bdbad102 RDI: 
ffff9c8d4a5f6d40
[    3.266192] RBP: ffffaad780f6f638 R08: 00000001018c3789 R09: 
0000000000000000
[    3.266228] R10: ffff9c8c4009ee40 R11: 0000000000000000 R12: 
00000000fffedf7d
[    3.266264] R13: 0000000000000000 R14: 0000000000000001 R15: 
0000000000000001
[    3.266299] FS:  00007f98d04de880(0000) GS:ffff9c90df700000(0000) 
knlGS:0000000000000000
[    3.266358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.266388] CR2: 00000000fffedfdd CR3: 000000010b680003 CR4: 
0000000000770ee0
[    3.266422] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    3.266457] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
0000000000000400
[    3.266490] PKRU: 55555554
[    3.266513] Call Trace:
[    3.266530]  <TASK>
[    3.266546]  gpiod_set_value_nocheck+0x5b/0x70
[    3.266583]  gpiod_set_value_cansleep+0x3e/0xa0
[    3.266609]  spi_set_cs+0x257/0x4a0
[    3.266634]  spi_transfer_one_message+0x49/0x740
[    3.266672]  __spi_pump_transfer_message+0x29b/0x620
[    3.266712]  __spi_sync+0x26f/0x3b0
[    3.266735]  spi_write_then_read+0x157/0x210
[    3.266771]  ? psi_group_change+0x175/0x3b0
[    3.266802]  regmap_spi_read+0xe/0x20
[    3.266826]  _regmap_raw_read+0xe1/0x210
[    3.266861]  _regmap_bus_read+0x3a/0x70
[    3.266887]  _regmap_read+0x66/0x140
[    3.266918]  regmap_read+0x3f/0x70
[    3.266957]  cs35l41_hda_probe+0x553/0xc10 [snd_hda_scodec_cs35l41]
[    3.267027]  cs35l41_hda_spi_probe+0x62/0x80 [snd_hda_scodec_cs35l41_spi]
[    3.267096]  spi_probe+0x55/0x90
[    3.267145]  really_probe+0x1b2/0x420
[    3.267184]  __driver_probe_device+0x7e/0x180
[    3.267227]  driver_probe_device+0x23/0xa0
[    3.267287]  __driver_attach+0xe4/0x1e0
[    3.267326]  ? __pfx___driver_attach+0x10/0x10
[    3.267381]  bus_for_each_dev+0x7a/0xd0
[    3.267406]  driver_attach+0x1e/0x30
[    3.267437]  bus_add_driver+0x11c/0x220
[    3.267461]  driver_register+0x64/0x130
[    3.267483]  ? __pfx_init_module+0x10/0x10 [snd_hda_scodec_cs35l41_spi]
[    3.267525]  __spi_register_driver+0xa1/0xd0
[    3.270712]  ? __pfx_init_module+0x10/0x10 [snd_hda_scodec_cs35l41_spi]
[    3.273446]  cs35l41_spi_driver_init+0x1c/0xff0 
[snd_hda_scodec_cs35l41_spi]
[    3.275119]  do_one_initcall+0x46/0x220
[    3.276828]  ? kmalloc_trace+0x2a/0xa0
[    3.279290]  do_init_module+0x52/0x220
[    3.283593]  load_module+0x223c/0x2460
[    3.283602]  __do_sys_finit_module+0xc8/0x140
[    3.287883]  ? __do_sys_finit_module+0xc8/0x140
[    3.287907]  __x64_sys_finit_module+0x18/0x20
[    3.293156]  do_syscall_64+0x38/0x90
[    3.298937]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    3.298945] RIP: 0033:0x7f98d06f776d
[    3.319574] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f3 36 0d 00 f7 d8 64 89 01 48
[    3.319579] RSP: 002b:00007ffd988f7a08 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[    3.319585] RAX: ffffffffffffffda RBX: 000055af06a7d030 RCX: 
00007f98d06f776d
[    3.319589] RDX: 0000000000000000 RSI: 00007f98d05d7ded RDI: 
0000000000000013
[    3.329520] RBP: 0000000000020000 R08: 0000000000000000 R09: 
0000000000000000
[    3.329523] R10: 0000000000000013 R11: 0000000000000246 R12: 
00007f98d05d7ded
[    3.329525] R13: 0000000000000000 R14: 000055af06cdd040 R15: 
000055af06a7d030
[    3.329531]  </TASK>
[    3.329533] Modules linked in: snd_hda_intel(+) ttm snd_intel_dspcfg 
btusb rapl snd_seq_midi snd_intel_sdw_acpi libarc4 intel_cstate 
binfmt_misc uvcvideo(+) snd_seq_midi_event btrtl 
snd_hda_scodec_cs35l41_spi(+) snd_hda_codec drm_display_helper 
cdc_ncm(+) videobuf2_vmalloc snd_rawmidi btbcm uvc cdc_ether cec btintel 
videobuf2_memops snd_hda_scodec_cs35l41_i2c snd_hda_core videobuf2_v4l2 
uas usbnet rc_core snd_hwdep btmtk snd_hda_scodec_cs35l41 input_leds mii 
wmi_bmof videodev snd_seq processor_thermal_device_pci bluetooth iwlwifi 
drm_kms_helper snd_pcm snd_hda_cs_dsp_ctls processor_thermal_device 
mei_me videobuf2_common snd_seq_device i2c_algo_bit cs_dsp 
processor_thermal_rfim ecdh_generic usb_storage serio_raw mc syscopyarea 
ecc processor_thermal_mbox ucsi_acpi snd_soc_cs35l41_lib 8250_dw mei 
snd_timer cfg80211 sysfillrect typec_ucsi processor_thermal_rapl 
igen6_edac sysimgblt intel_rapl_common typec snd soundcore 
int3403_thermal int340x_thermal_zone serial_multi_instantiate 
int3400_thermal intel_hid acpi_thermal_rel
[    3.338475]  sparse_keymap acpi_tad acpi_pad mac_hid sch_fq_codel msr 
parport_pc ppdev lp parport drm ramoops reed_solomon efi_pstore 
ip_tables x_tables autofs4 spi_pxa2xx_platform dw_dmac dw_dmac_core 
intel_lpss_pci nvme intel_lpss i2c_i801 idma64 crc32_pclmul thunderbolt 
i2c_smbus nvme_core xhci_pci virt_dma xhci_pci_renesas video wmi 
pinctrl_tigerlake
[    3.338514] CR2: 00000000fffedfdd
[    3.338517] ---[ end trace 0000000000000000 ]---
[    3.504965] RIP: 0010:gpiod_set_raw_value_commit+0x3d/0xf0
[    3.504973] Code: 48 89 e5 41 55 44 0f b6 ee 41 54 53 48 8b 17 48 2b 
82 70 03 00 00 4c 8b a2 68 03 00 00 48 c1 f8 03 48 0f af c1 66 90 48 89 
c6 <49> 8b 44 24 60 44 89 ea 4c 89 e7 ff d0 0f 1f 00 5b 41 5c 41 5d 5d
[    3.504975] RSP: 0018:ffffaad780f6f620 EFLAGS: 00010a03
[    3.504978] RAX: 333330b6bdbad102 RBX: ffff9c8d4a5f6800 RCX: 
cccccccccccccccd
[    3.504979] RDX: ffff9c8d4a5f6d40 RSI: 333330b6bdbad102 RDI: 
ffff9c8d4a5f6d40
[    3.504980] RBP: ffffaad780f6f638 R08: 00000001018c3789 R09: 
0000000000000000
[    3.504982] R10: ffff9c8c4009ee40 R11: 0000000000000000 R12: 
00000000fffedf7d
[    3.504983] R13: 0000000000000000 R14: 0000000000000001 R15: 
0000000000000001
[    3.504984] FS:  00007f98d04de880(0000) GS:ffff9c90df700000(0000) 
knlGS:0000000000000000
[    3.504986] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.504988] CR2: 00000000fffedfdd CR3: 000000010b680003 CR4: 
0000000000770ee0
[    3.504989] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    3.504990] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
0000000000000400
[    3.504992] PKRU: 55555554

Thanks,
Stefan

>> Thanks,
>>
>> Stefan
>>
>>>> Thanks,
>>>> Stefan Binding
>>>>
>>>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
>>>> mahapatra@amd.com>
>>>>> ---
>>>>>    drivers/spi/spi.c       | 226
>>>> ++++++++++++++++++++++++++++------------
>>>>>    include/linux/spi/spi.h |  32 ++++--
>>>>>    2 files changed, 183 insertions(+), 75 deletions(-)
>>>>>
>>>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
>>>>> 9036d7a50674..04d7322170c4 100644
>>>>> --- a/drivers/spi/spi.c
>>>>> +++ b/drivers/spi/spi.c
>>>>> @@ -612,10 +612,24 @@ static int spi_dev_check(struct device *dev,
>>>>> void *data)  {
>>>>>    	struct spi_device *spi = to_spi_device(dev);
>>>>>    	struct spi_device *new_spi = data;
>>>>> +	int idx, nw_idx;
>>>>>
>>>>> -	if (spi->controller == new_spi->controller &&
>>>>> -	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi,
>>>> 0))
>>>>> -		return -EBUSY;
>>>>> +	if (spi->controller == new_spi->controller) {
>>>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX;
>>>>> nw_idx++) {
>>>>> +				if ((idx != 0 &&
>>>> !spi_get_chipselect(spi,
>>>>> idx)) ||
>>>>> +				    (nw_idx != 0 &&
>>>>> !spi_get_chipselect(spi, nw_idx))) {
>>>>> +					continue;
>>>>> +				} else if (spi_get_chipselect(spi,
>>>> idx) ==
>>>>> +				    spi_get_chipselect(new_spi,
>>>> nw_idx))
>>>>> {
>>>>> +					dev_err(dev,
>>>>> +						"chipselect %d already
>>>>> in use\n",
>>>>> +
>>>>> 	spi_get_chipselect(new_spi, nw_idx));
>>>>> +					return -EBUSY;
>>>>> +				}
>>>>> +			}
>>>>> +		}
>>>>> +	}
>>>>>    	return 0;
>>>>>    }
>>>>>
>>>>> @@ -629,7 +643,7 @@ static int __spi_add_device(struct spi_device
>>>>> *spi)
>>>>>    {
>>>>>    	struct spi_controller *ctlr = spi->controller;
>>>>>    	struct device *dev = ctlr->dev.parent;
>>>>> -	int status;
>>>>> +	int status, idx;
>>>>>
>>>>>    	/*
>>>>>    	 * We need to make sure there's no other device with this @@
>>>>> -638,8
>>>>> +652,6 @@ static int __spi_add_device(struct spi_device
>>>>> *spi)
>>>>>    	 */
>>>>>    	status = bus_for_each_dev(&spi_bus_type, NULL, spi,
>>>> spi_dev_check);
>>>>>    	if (status) {
>>>>> -		dev_err(dev, "chipselect %d already in use\n",
>>>>> -				spi_get_chipselect(spi, 0));
>>>>>    		return status;
>>>>>    	}
>>>>>
>>>>> @@ -649,8 +661,10 @@ static int __spi_add_device(struct spi_device
>>>>> *spi)
>>>>>    		return -ENODEV;
>>>>>    	}
>>>>>
>>>>> -	if (ctlr->cs_gpiods)
>>>>> -		spi_set_csgpiod(spi, 0, ctlr-
>>>>>> cs_gpiods[spi_get_chipselect(spi, 0)]);
>>>>> +	if (ctlr->cs_gpiods) {
>>>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>>>> +			spi_set_csgpiod(spi, idx, ctlr-
>>>>>> cs_gpiods[spi_get_chipselect(spi, idx)]);
>>>>> +	}
>>>>>
>>>>>    	/*
>>>>>    	 * Drivers may modify this initial i/o setup, but will @@ -690,13
>>>>> +704,15 @@ int spi_add_device(struct spi_device *spi)  {
>>>>>    	struct spi_controller *ctlr = spi->controller;
>>>>>    	struct device *dev = ctlr->dev.parent;
>>>>> -	int status;
>>>>> +	int status, idx;
>>>>>
>>>>> -	/* Chipselects are numbered 0..max; validate. */
>>>>> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
>>>>> -		dev_err(dev, "cs%d >= max %d\n",
>>>>> spi_get_chipselect(spi, 0),
>>>>> -			ctlr->num_chipselect);
>>>>> -		return -EINVAL;
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +		/* Chipselects are numbered 0..max; validate. */
>>>>> +		if (spi_get_chipselect(spi, idx) >=
>>>> ctlr->num_chipselect) {
>>>>> +			dev_err(dev, "cs%d >= max %d\n",
>>>>> spi_get_chipselect(spi, idx),
>>>>> +				ctlr->num_chipselect);
>>>>> +			return -EINVAL;
>>>>> +		}
>>>>>    	}
>>>>>
>>>>>    	/* Set the bus ID string */
>>>>> @@ -713,12 +729,15 @@ static int spi_add_device_locked(struct
>>>>> spi_device *spi)  {
>>>>>    	struct spi_controller *ctlr = spi->controller;
>>>>>    	struct device *dev = ctlr->dev.parent;
>>>>> +	int idx;
>>>>>
>>>>> -	/* Chipselects are numbered 0..max; validate. */
>>>>> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
>>>>> -		dev_err(dev, "cs%d >= max %d\n",
>>>>> spi_get_chipselect(spi, 0),
>>>>> -			ctlr->num_chipselect);
>>>>> -		return -EINVAL;
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +		/* Chipselects are numbered 0..max; validate. */
>>>>> +		if (spi_get_chipselect(spi, idx) >=
>>>> ctlr->num_chipselect) {
>>>>> +			dev_err(dev, "cs%d >= max %d\n",
>>>>> spi_get_chipselect(spi, idx),
>>>>> +				ctlr->num_chipselect);
>>>>> +			return -EINVAL;
>>>>> +		}
>>>>>    	}
>>>>>
>>>>>    	/* Set the bus ID string */
>>>>> @@ -966,58 +985,118 @@ static void spi_res_release(struct
>>>>> spi_controller *ctlr, struct spi_message *mes  static void
>>>>> spi_set_cs(struct spi_device *spi, bool enable, bool
>>>> force)
>>>>>    {
>>>>>    	bool activate = enable;
>>>>> +	u32 cs_num = __ffs(spi->cs_index_mask);
>>>>> +	int idx;
>>>>>
>>>>>    	/*
>>>>> -	 * Avoid calling into the driver (or doing delays) if the chip
>>>> select
>>>>> -	 * isn't actually changing from the last time this was called.
>>>>> +	 * In parallel mode all the chip selects are
>>>> asserted/de-asserted
>>>>> +	 * at once
>>>>>    	 */
>>>>> -	if (!force && ((enable && spi->controller->last_cs ==
>>>>> spi_get_chipselect(spi, 0)) ||
>>>>> -		       (!enable && spi->controller->last_cs !=
>>>>> spi_get_chipselect(spi, 0))) &&
>>>>> -	    (spi->controller->last_cs_mode_high == (spi->mode &
>>>>> SPI_CS_HIGH)))
>>>>> -		return;
>>>>> -
>>>>> -	trace_spi_set_cs(spi, activate);
>>>>> -
>>>>> -	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0)
>>>> : -1;
>>>>> -	spi->controller->last_cs_mode_high = spi->mode &
>>>>> SPI_CS_HIGH;
>>>>> -
>>>>> -	if ((spi_get_csgpiod(spi, 0) ||
>>>> !spi->controller->set_cs_timing)
>>>>> && !activate)
>>>>> -		spi_delay_exec(&spi->cs_hold, NULL);
>>>>> -
>>>>> -	if (spi->mode & SPI_CS_HIGH)
>>>>> -		enable = !enable;
>>>>> +	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) ==
>>>>> SPI_PARALLEL_CS_MASK) {
>>>>> +		spi->controller->last_cs_mode_high = spi->mode &
>>>>> SPI_CS_HIGH;
>>>>> +
>>>>> +		if ((spi_get_csgpiod(spi, 0) || !spi->controller-
>>>>>> set_cs_timing) && !activate)
>>>>> +			spi_delay_exec(&spi->cs_hold, NULL);
>>>>> +
>>>>> +		if (spi->mode & SPI_CS_HIGH)
>>>>> +			enable = !enable;
>>>>> +
>>>>> +		if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi,
>>>> 1)) {
>>>>> +			if (!(spi->mode & SPI_NO_CS)) {
>>>>> +				/*
>>>>> +				 * Historically ACPI has no means of
>>>> the
>>>>> GPIO polarity and
>>>>> +				 * thus the SPISerialBus() resource
>>>>> defines it on the per-chip
>>>>> +				 * basis. In order to avoid a chain of
>>>>> negations, the GPIO
>>>>> +				 * polarity is considered being Active
>>>>> High. Even for the cases
>>>>> +				 * when _DSD() is involved (in the
>>>>> updated versions of ACPI)
>>>>> +				 * the GPIO CS polarity must be
>>>> defined
>>>>> Active High to avoid
>>>>> +				 * ambiguity. That's why we use
>>>> enable,
>>>>> that takes SPI_CS_HIGH
>>>>> +				 * into account.
>>>>> +				 */
>>>>> +				if (has_acpi_companion(&spi->dev)) {
>>>>> +					for (idx = 0; idx <
>>>>> SPI_CS_CNT_MAX; idx++)
>>>>> +
>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>>>> +
>>>>> !enable);
>>>>> +				} else {
>>>>> +					for (idx = 0; idx <
>>>>> SPI_CS_CNT_MAX; idx++)
>>>>> +						/* Polarity handled by
>>>>> GPIO library */
>>>>> +
>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>>>> +
>>>>> activate);
>>>>> +				}
>>>>> +			}
>>>>> +			/* Some SPI masters need both GPIO CS &
>>>>> slave_select */
>>>>> +			if ((spi->controller->flags &
>>>>> SPI_MASTER_GPIO_SS) &&
>>>>> +			    spi->controller->set_cs)
>>>>> +				spi->controller->set_cs(spi, !enable);
>>>>> +		} else if (spi->controller->set_cs) {
>>>>> +			spi->controller->set_cs(spi, !enable);
>>>>> +		}
>>>>>
>>>>> -	if (spi_get_csgpiod(spi, 0)) {
>>>>> -		if (!(spi->mode & SPI_NO_CS)) {
>>>>> -			/*
>>>>> -			 * Historically ACPI has no means of the GPIO
>>>>> polarity and
>>>>> -			 * thus the SPISerialBus() resource defines it
>>>> on
>>>>> the per-chip
>>>>> -			 * basis. In order to avoid a chain of
>>>> negations,
>>>>> the GPIO
>>>>> -			 * polarity is considered being Active High.
>>>> Even
>>>>> for the cases
>>>>> -			 * when _DSD() is involved (in the updated
>>>>> versions of ACPI)
>>>>> -			 * the GPIO CS polarity must be defined Active
>>>>> High to avoid
>>>>> -			 * ambiguity. That's why we use enable, that
>>>>> takes SPI_CS_HIGH
>>>>> -			 * into account.
>>>>> -			 */
>>>>> -			if (has_acpi_companion(&spi->dev))
>>>>> -
>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
>>>>> +		if (spi_get_csgpiod(spi, 0) || spi_get_csgpiod(spi, 1)
>>>> ||
>>>>> +		    !spi->controller->set_cs_timing) {
>>>>> +			if (activate)
>>>>> +				spi_delay_exec(&spi->cs_setup, NULL);
>>>>>    			else
>>>>> -				/* Polarity handled by GPIO library */
>>>>> -
>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
>>>>> +				spi_delay_exec(&spi->cs_inactive,
>>>>> NULL);
>>>>>    		}
>>>>> -		/* Some SPI masters need both GPIO CS & slave_select
>>>>> */
>>>>> -		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
>>>>> -		    spi->controller->set_cs)
>>>>> +	} else {
>>>>> +		/*
>>>>> +		 * Avoid calling into the driver (or doing delays) if
>>>> the
>>>>> chip select
>>>>> +		 * isn't actually changing from the last time this was
>>>>> called.
>>>>> +		 */
>>>>> +		if (!force && ((enable && spi->controller->last_cs ==
>>>>> +				spi_get_chipselect(spi, cs_num)) ||
>>>>> +				(!enable && spi->controller->last_cs
>>>> !=
>>>>> +				 spi_get_chipselect(spi, cs_num))) &&
>>>>> +		    (spi->controller->last_cs_mode_high ==
>>>>> +		     (spi->mode & SPI_CS_HIGH)))
>>>>> +			return;
>>>>> +
>>>>> +		trace_spi_set_cs(spi, activate);
>>>>> +
>>>>> +		spi->controller->last_cs = enable ?
>>>>> spi_get_chipselect(spi, cs_num) : -1;
>>>>> +		spi->controller->last_cs_mode_high = spi->mode &
>>>>> SPI_CS_HIGH;
>>>>> +
>>>>> +		if ((spi_get_csgpiod(spi, cs_num) || !spi->controller-
>>>>>> set_cs_timing) && !activate)
>>>>> +			spi_delay_exec(&spi->cs_hold, NULL);
>>>>> +
>>>>> +		if (spi->mode & SPI_CS_HIGH)
>>>>> +			enable = !enable;
>>>>> +
>>>>> +		if (spi_get_csgpiod(spi, cs_num)) {
>>>>> +			if (!(spi->mode & SPI_NO_CS)) {
>>>>> +				/*
>>>>> +				 * Historically ACPI has no means of
>>>> the
>>>>> GPIO polarity and
>>>>> +				 * thus the SPISerialBus() resource
>>>>> defines it on the per-chip
>>>>> +				 * basis. In order to avoid a chain of
>>>>> negations, the GPIO
>>>>> +				 * polarity is considered being Active
>>>>> High. Even for the cases
>>>>> +				 * when _DSD() is involved (in the
>>>>> updated versions of ACPI)
>>>>> +				 * the GPIO CS polarity must be
>>>> defined
>>>>> Active High to avoid
>>>>> +				 * ambiguity. That's why we use
>>>> enable,
>>>>> that takes SPI_CS_HIGH
>>>>> +				 * into account.
>>>>> +				 */
>>>>> +				if (has_acpi_companion(&spi->dev))
>>>>> +
>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
>>>>> +
>>>>> !enable);
>>>>> +				else
>>>>> +					/* Polarity handled by GPIO
>>>>> library */
>>>>> +
>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
>>>>> +
>>>>> activate);
>>>>> +			}
>>>>> +			/* Some SPI masters need both GPIO CS &
>>>>> slave_select */
>>>>> +			if ((spi->controller->flags &
>>>>> SPI_MASTER_GPIO_SS) &&
>>>>> +			    spi->controller->set_cs)
>>>>> +				spi->controller->set_cs(spi, !enable);
>>>>> +		} else if (spi->controller->set_cs) {
>>>>>    			spi->controller->set_cs(spi, !enable);
>>>>> -	} else if (spi->controller->set_cs) {
>>>>> -		spi->controller->set_cs(spi, !enable);
>>>>> -	}
>>>>> +		}
>>>>>
>>>>> -	if (spi_get_csgpiod(spi, 0) ||
>>>> !spi->controller->set_cs_timing) {
>>>>> -		if (activate)
>>>>> -			spi_delay_exec(&spi->cs_setup, NULL);
>>>>> -		else
>>>>> -			spi_delay_exec(&spi->cs_inactive, NULL);
>>>>> +		if (spi_get_csgpiod(spi, cs_num) || !spi->controller-
>>>>>> set_cs_timing) {
>>>>> +			if (activate)
>>>>> +				spi_delay_exec(&spi->cs_setup, NULL);
>>>>> +			else
>>>>> +				spi_delay_exec(&spi->cs_inactive,
>>>>> NULL);
>>>>> +		}
>>>>>    	}
>>>>>    }
>>>>>
>>>>> @@ -2246,8 +2325,8 @@ static void of_spi_parse_dt_cs_delay(struct
>>>>> device_node *nc,  static int of_spi_parse_dt(struct spi_controller
>>>>> *ctlr, struct
>>>> spi_device
>>>>> *spi,
>>>>>    			   struct device_node *nc)
>>>>>    {
>>>>> -	u32 value;
>>>>> -	int rc;
>>>>> +	u32 value, cs[SPI_CS_CNT_MAX] = {0};
>>>>> +	int rc, idx;
>>>>>
>>>>>    	/* Mode (clock phase/polarity/etc.) */
>>>>>    	if (of_property_read_bool(nc, "spi-cpha")) @@ -2320,13 +2399,21
>>>> @@
>>>>> static int of_spi_parse_dt(struct spi_controller *ctlr, struct
>>>>> spi_device *spi,
>>>>>    	}
>>>>>
>>>>>    	/* Device address */
>>>>> -	rc = of_property_read_u32(nc, "reg", &value);
>>>>> -	if (rc) {
>>>>> +	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
>>>>> +						 SPI_CS_CNT_MAX);
>>>>> +	if (rc < 0 || rc > ctlr->num_chipselect) {
>>>>>    		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property
>>>> (%d)\n",
>>>>>    			nc, rc);
>>>>>    		return rc;
>>>>> +	} else if ((of_property_read_bool(nc, "parallel-memories")) &&
>>>>> +		   (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
>>>>> +		dev_err(&ctlr->dev, "SPI controller doesn't support
>>>> multi
>>>>> CS\n");
>>>>> +		return -EINVAL;
>>>>>    	}
>>>>> -	spi_set_chipselect(spi, 0, value);
>>>>> +	for (idx = 0; idx < rc; idx++)
>>>>> +		spi_set_chipselect(spi, idx, cs[idx]);
>>>>> +	/* By default set the spi->cs_index_mask as 1 */
>>>>> +	spi->cs_index_mask = 0x01;
>>>>>
>>>>>    	/* Device speed */
>>>>>    	if (!of_property_read_u32(nc, "spi-max-frequency", &value)) @@
>>>>> -3907,7 +3994,8 @@ static int __spi_validate(struct spi_device *spi,
>>>>> struct spi_message *message)
>>>>>    	 * cs_change is set for each transfer.
>>>>>    	 */
>>>>>    	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
>>>>> SPI_CS_WORD) ||
>>>>> -					  spi_get_csgpiod(spi, 0))) {
>>>>> +					  spi_get_csgpiod(spi, 0) ||
>>>>> +					  spi_get_csgpiod(spi, 1))) {
>>>>>    		size_t maxsize;
>>>>>    		int ret;
>>>>>
>>>>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
>>>>> 873ced6ae4ca..6453b246e0af 100644
>>>>> --- a/include/linux/spi/spi.h
>>>>> +++ b/include/linux/spi/spi.h
>>>>> @@ -19,6 +19,11 @@
>>>>>    #include <linux/acpi.h>
>>>>>    #include <linux/u64_stats_sync.h>
>>>>>
>>>>> +/* Max no. of CS supported per spi device */ #define SPI_CS_CNT_MAX
>>>>> +2
>>>>> +
>>>>> +/* chip select mask */
>>>>> +#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))
>>>>>    struct dma_chan;
>>>>>    struct software_node;
>>>>>    struct ptp_system_timestamp;
>>>>> @@ -166,6 +171,7 @@ extern void
>>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>>>     *	deasserted. If @cs_change_delay is used from @spi_transfer,
>>>>> then the
>>>>>     *	two delays will be added up.
>>>>>     * @pcpu_statistics: statistics for the spi_device
>>>>> + * @cs_index_mask: Bit mask of the active chipselect(s) in the
>>>>> chipselect array
>>>>>     *
>>>>>     * A @spi_device is used to interchange data between an SPI slave
>>>>>     * (usually a discrete chip) and CPU memory.
>>>>> @@ -181,7 +187,7 @@ struct spi_device {
>>>>>    	struct spi_controller	*controller;
>>>>>    	struct spi_controller	*master;	/* Compatibility layer
>>>> */
>>>>>    	u32			max_speed_hz;
>>>>> -	u8			chip_select;
>>>>> +	u8			chip_select[SPI_CS_CNT_MAX];
>>>>>    	u8			bits_per_word;
>>>>>    	bool			rt;
>>>>>    #define SPI_NO_TX	BIT(31)		/* No transmit wire */
>>>>> @@ -202,7 +208,7 @@ struct spi_device {
>>>>>    	void			*controller_data;
>>>>>    	char			modalias[SPI_NAME_SIZE];
>>>>>    	const char		*driver_override;
>>>>> -	struct gpio_desc	*cs_gpiod;	/* Chip select gpio
>>>> desc
>>>>> */
>>>>> +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/*
>>>> Chip
>>>>> select gpio desc */
>>>>>    	struct spi_delay	word_delay; /* Inter-word delay */
>>>>>    	/* CS delays */
>>>>>    	struct spi_delay	cs_setup;
>>>>> @@ -212,6 +218,13 @@ struct spi_device {
>>>>>    	/* The statistics */
>>>>>    	struct spi_statistics __percpu	*pcpu_statistics;
>>>>>
>>>>> +	/* Bit mask of the chipselect(s) that the driver need to use
>>>> from
>>>>> +	 * the chipselect array.When the controller is capable to
>>>> handle
>>>>> +	 * multiple chip selects & memories are connected in parallel
>>>>> +	 * then more than one bit need to be set in cs_index_mask.
>>>>> +	 */
>>>>> +	u32			cs_index_mask : SPI_CS_CNT_MAX;
>>>>> +
>>>>>    	/*
>>>>>    	 * likely need more hooks for more protocol options affecting how
>>>>>    	 * the controller talks to each chip, like:
>>>>> @@ -268,22 +281,22 @@ static inline void *spi_get_drvdata(const
>>>>> struct spi_device *spi)
>>>>>
>>>>>    static inline u8 spi_get_chipselect(const struct spi_device *spi,
>>>> u8 idx)
>>>>>    {
>>>>> -	return spi->chip_select;
>>>>> +	return spi->chip_select[idx];
>>>>>    }
>>>>>
>>>>>    static inline void spi_set_chipselect(struct spi_device *spi, u8
>>>> idx, u8
>>>>> chipselect)
>>>>>    {
>>>>> -	spi->chip_select = chipselect;
>>>>> +	spi->chip_select[idx] = chipselect;
>>>>>    }
>>>>>
>>>>>    static inline struct gpio_desc *spi_get_csgpiod(const struct
>>>> spi_device
>>>>> *spi, u8 idx)
>>>>>    {
>>>>> -	return spi->cs_gpiod;
>>>>> +	return spi->cs_gpiod[idx];
>>>>>    }
>>>>>
>>>>>    static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx,
>>>> struct
>>>>> gpio_desc *csgpiod)
>>>>>    {
>>>>> -	spi->cs_gpiod = csgpiod;
>>>>> +	spi->cs_gpiod[idx] = csgpiod;
>>>>>    }
>>>>>
>>>>>    /**
>>>>> @@ -388,6 +401,8 @@ extern struct spi_device
>>>>> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>>>>>     * @bus_lock_spinlock: spinlock for SPI bus locking
>>>>>     * @bus_lock_mutex: mutex for exclusion of multiple callers
>>>>>     * @bus_lock_flag: indicates that the SPI bus is locked for
>>>> exclusive use
>>>>> + * @multi_cs_cap: indicates that the SPI Controller can
>>>> assert/de-assert
>>>>> + *	more than one chip select at once.
>>>>>     * @setup: updates the device mode and clocking records used by a
>>>>>     *	device's SPI controller; protocol code may call this.  This
>>>>>     *	must fail if an unrecognized or unsupported mode is requested.
>>>>> @@ -554,6 +569,11 @@ struct spi_controller {
>>>>>    #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx
>>>>> */
>>>>>
>>>>>    #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must
>>>> select
>>>>> slave */
>>>>> +	/*
>>>>> +	 * The spi-controller has multi chip select capability and can
>>>>> +	 * assert/de-assert more than one chip select at once.
>>>>> +	 */
>>>>> +#define SPI_CONTROLLER_MULTI_CS		BIT(6)
>>>>>
>>>>>    	/* Flag indicating if the allocation of this struct is devres-
>>>>> managed */
>>>>>    	bool			devm_allocated;
>>>>> --
>>>>> 2.17.1
