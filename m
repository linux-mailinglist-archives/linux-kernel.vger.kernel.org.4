Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D4613EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJaUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJaUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:04:31 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E110544
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:04:27 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 4252 invoked from network); 31 Oct 2022 21:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1667246664; bh=9IjJqGVTZabWCs/dedhzkbL8tJT9Ns177X7pv3XLhqY=;
          h=To:From:Subject;
          b=UMDuuUpoDBDsEU1nTjnWs5CT29H3zJs+6wge7ka3kHhAaQp793SMLOTFZuiAO8i2/
           iggz1KCL8u2Dr8PqmNTM7Iv4h4Yjs6hu6e5RdhpWQ5ZRUwRfSTQADujx8GMZbj2kb5
           QzaRFwFDrGKENioyVvni2ef6tPr/hM91zNdS3kfk=
Received: from aaew218.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.126.218])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <brian.gix@intel.com>; 31 Oct 2022 21:04:23 +0100
Message-ID: <aac93511-d5e5-7a1b-6b1c-65e008ce068e@o2.pl>
Date:   Mon, 31 Oct 2022 21:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-GB
To:     Brian Gix <brian.gix@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
Subject: "Bluetooth: hci0: HCI_REQ-0xfcf0" errors in dmesg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 1ee182185c9470e7185e55275f5579e1
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [gaIR]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 6.1.0-rc3, I have been seeing this error message in dmesg:

        Bluetooth: hci0: HCI_REQ-0xfcf0

It is printed on every boot, resume from suspend and rfkill unblock of the Bluetooth device.
The device seems to be functioning normally though (but I have done limited testing only).

After some investigation, it turned out to be caused by
        commit dd50a864ffae ("Bluetooth: Delete unreferenced hci_request code")
which modified hci_req_add() in net/bluetooth/hci_request.c to always print an error message
when that function is executed.

I have added dump_stack() to hci_req_add() and got the following backtraces:

On boot:

[   18.487766] Bluetooth: hci0: RTL: fw version 0xab6b705c
[   18.548951] Bluetooth: hci0: HCI_REQ-0xfcf0
[   18.548961] CPU: 3 PID: 108 Comm: kworker/u9:0 Not tainted 6.1.0-rc3unif4-00001-gb33a0948e932 #86
[   18.548965] Hardware name: HP HP Laptop 17-by0xxx/84CA, BIOS F.66 03/29/2022
[   18.548968] Workqueue: hci0 hci_power_on [bluetooth]
[   18.549018] Call Trace:
[   18.549020]  <TASK>
[   18.549022]  dump_stack_lvl+0x38/0x4d
[   18.549030]  dump_stack+0x10/0x16
[   18.549035]  hci_req_add+0x47/0x70 [bluetooth]
[   18.549093]  msft_set_filter_enable+0x59/0x90 [bluetooth]
[   18.549147]  msft_do_open+0x131/0x220 [bluetooth]
[   18.549198]  hci_dev_open_sync+0x646/0xc20 [bluetooth]
[   18.549249]  hci_dev_do_open+0x2a/0x60 [bluetooth]
[   18.549282]  hci_power_on+0x53/0x210 [bluetooth]
[   18.549317]  process_one_work+0x21f/0x3f0
[   18.549323]  worker_thread+0x4a/0x3c0
[   18.549328]  ? process_one_work+0x3f0/0x3f0
[   18.549332]  kthread+0xff/0x130
[   18.549336]  ? kthread_complete_and_exit+0x20/0x20
[   18.549340]  ret_from_fork+0x22/0x30
[   18.549347]  </TASK>
[   21.165060] EXT4-fs (dm-7): mounted filesystem with ordered data mode. Quota mode: none.

on rfkill unblock:

[ 1671.040970] Bluetooth: hci0: HCI_REQ-0xfcf0
[ 1671.040992] CPU: 3 PID: 5006 Comm: kworker/u9:2 Not tainted 6.1.0-rc3unif4-00001-gb33a0948e932 #86
[ 1671.041005] Hardware name: HP HP Laptop 17-by0xxx/84CA, BIOS F.66 03/29/2022
[ 1671.041012] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
[ 1671.041194] Call Trace:
[ 1671.041200]  <TASK>
[ 1671.041208]  dump_stack_lvl+0x38/0x4d
[ 1671.041227]  dump_stack+0x10/0x16
[ 1671.041241]  hci_req_add+0x47/0x70 [bluetooth]
[ 1671.041408]  msft_set_filter_enable+0x59/0x90 [bluetooth]
[ 1671.041579]  msft_do_open+0x131/0x220 [bluetooth]
[ 1671.041683]  hci_dev_open_sync+0x646/0xc20 [bluetooth]
[ 1671.041787]  hci_set_powered_sync+0xd4/0x240 [bluetooth]
[ 1671.041887]  set_powered_sync+0x20/0x60 [bluetooth]
[ 1671.041975]  hci_cmd_sync_work+0xa8/0x150 [bluetooth]
[ 1671.042079]  process_one_work+0x21f/0x3f0
[ 1671.042092]  worker_thread+0x4a/0x3c0
[ 1671.042102]  ? process_one_work+0x3f0/0x3f0
[ 1671.042111]  kthread+0xff/0x130
[ 1671.042119]  ? kthread_complete_and_exit+0x20/0x20
[ 1671.042128]  ret_from_fork+0x22/0x30
[ 1671.042142]  </TASK>

My hardware: HP laptop 17-by0001nw, device is a Realtek combo card:

"Realtek RTL8822BE 802.11 ac 2×2 WiFi + Bluetooth 4.2 Combo Adapter (MU-MIMO supported)"

I am ready to provide additional information and testing, if need be.

Greetings,

Mateusz Jończyk

