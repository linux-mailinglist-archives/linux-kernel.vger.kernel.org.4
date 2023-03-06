Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE26AB4C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCFCx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCFCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:53:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2079777;
        Sun,  5 Mar 2023 18:53:52 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PVNPP321Lz16P2r;
        Mon,  6 Mar 2023 10:51:05 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:53:49 +0800
Subject: Re: IRQ affinity problem from hisi_sas_v3_hw
To:     "liuchao (CR)" <liuchao173@huawei.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <573010d632034c248b88e00e69fe1694@huawei.com>
CC:     linfeilong <linfeilong@huawei.com>,
        "hewenliang (C)" <hewenliang4@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <cd94de69-6f2f-08b0-b2e9-6f8939116aaa@hisilicon.com>
Date:   Mon, 6 Mar 2023 10:53:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <573010d632034c248b88e00e69fe1694@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


在 2023/2/27 16:38, liuchao (CR) 写道:
> Hi All,
> I test the linux 5.10 and found the hisi_sas_v3_hw use irq_affinitt with IRQD_AFFINITY_MANAGED.
> The mechine has 96 cpus with four numa nodes.
>
> hisi_sas_v3_hw has 16 queues and affinity mask of each queue contains 6 CPUs:
>
> q0:      0 - 5
> q1:      6 - 11
> ...
> q15:    90 - 95
>
> When I make all CPU of a queue mask go offline, cpu 6-11 for example:
>
> echo 0 > /sys/devices/system/cpu/cpu6/online
> echo 0 > /sys/devices/system/cpu/cpu7/online
> ...
> echo 0 > /sys/devices/system/cpu/cpu11/online
>
> the IO will hang and errors are reported in dmesg:
>
> [344908.820022] sas: ata5: end_device-6:0: cmd error handler
> [344908.820049] sas: ata5: end_device-6:0: dev error handler
> [344908.820058] sas: ata6: end_device-6:1: dev error handler
> [344908.820071] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [344908.820080] sas: ata7: end_device-6:2: dev error handler
> [344908.820085] sas: ata8: end_device-6:3: dev error handler
> [344908.820091] sas: ata9: end_device-6:4: dev error handler
> [344908.820095] sas: ata10: end_device-6:5: dev error handler
> [344908.820097] ata5.00: failed command: WRITE DMA EXT
> [344908.820111] ata5.00: cmd 35/00:08:18:20:ae/00:00:6a:00:00/e0 tag 19 dma 4096 out
>                           res 40/00:00:47:40:9a/00:00:6c:00:00/e0 Emask 0x4 (timeout)
> [344908.820117] ata5.00: status: { DRDY }
> [344908.820126] ata5: hard resetting link
> [344908.821819] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy0 phy_state=0x3e
> [344908.821824] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy0 down
> [344908.983853] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
> [344908.983887] sas: sas_form_port: phy0 belongs to port0 already(1)!
> [344909.145280] ata5.00: configured for UDMA/33
> [344909.145308] sd 6:0:0:0: [sda] tag#814 kworker/u193:7: flush retry cmd
> [344909.145324] sd 6:0:0:0: [sda] tag#814 Inserting command 000000005d29b45d into mlqueue
> [344909.145341] ata5: EH complete
> [344909.145358] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 tries: 1
>
> Is this situation normal, or should the driver fix this problem?

Do you check whether it has the same issue on latest mainline code?
I remember Lei Ming sent a patchset to solve the issue 
(https://lore.kernel.org/linux-block/b98f055f-6f38-a47c-965d-b6bcf4f5563f@huawei.com/T/), 

and you can check whether they are merged in the code.



>
> .
>

