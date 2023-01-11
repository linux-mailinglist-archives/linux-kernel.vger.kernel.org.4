Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79779665B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjAKMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbjAKMTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:19:36 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 04:19:35 PST
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338599FE4;
        Wed, 11 Jan 2023 04:19:34 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,315,1665475200"; 
   d="scan'208";a="96576786"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 11 Jan 2023 04:18:32 -0800
IronPort-SDR: Cv8xFRVl5CkzZ6EtQkmL327DUwxQGE0JRibk5G0CPeUGRjT/Wt7oiQ0+bd3x4OqwJUAE8fItCq
 29O57XzIIF4Y46Dx3DRkThDzs3q1bLTVRS0mPIJfyzeaUzQQPyggQpUvIlITEn5dZ+1OV7ohuR
 txHXY5an+/J16xFUZRDOInkM6xB7BMCV3GJ1rkFD9a/yeCNJ/EdAtwZdd0jHa/7iWmR4o7dOrb
 QYlFc+n/nortnbTllFzAcPIWPLYirEyovL2EWtgEXVzlRp6eMsNv/joHIcKRKaPv7+Eas3wCOO
 vQU=
From:   <bhuvanesh_surachari@mentor.com>
CC:     <gregkh@linuxfoundation.org>,
        Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>,
        John Keeping <john@metanate.com>,
        "Linyu Yuan" <quic_linyyuan@quicinc.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Dan Carpenter" <error27@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: f_fs: Make sure to unregister gadget item in unbind
Date:   Wed, 11 Jan 2023 17:47:17 +0530
Message-ID: <20230111121719.5258-1-bhuvanesh_surachari@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>

In functionfs_unbind() the FFS_FL_BOUND flag was cleared before
calling ffs_data_put() which was preventing the execution of function
unregister_gadget_item().
This was leading to Kernel panic due to NULL pointer dereference as
below:
Unable to handle kernel NULL pointer dereference at virtual address 00000020
Mem abort info:
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgd = ffff80062cb6a000
[0000000000000020] *pgd=000000066c966003, *pud=000000067a170003, *pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
tftp nf_nat nf_conntrack_tftp nf_conntrack adv7180 optee tee quota_v2 quota_tree max20010_regulator aesi adc_inc input_inc cpufreq_dt thermal_sys ravb snd_soc_rcar snd_aloop snd_soc_skeleton ravb_mdio snd_soc_generic_card
tp pps_core sbrrc spidev spi_sh_msiof evdev boottime gpio_inc i2c_dev usb8251x_firmware ipv6 autofs4 [last unloaded: atmel_mxt_ts]
Process swapper/1 (pid: 0, stack limit = 0xffff000008e30000)
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G         C      4.14.295-ltsi-08448-g8e327c2d87fb #1
Hardware name: RBCM A-IVI2 CCS1.1 B board based on r8a7796 (DT)
pc : usb_ep_queue+0xe0/0x110 [udc_core]
lr : eth_start_xmit+0x280/0x30c [u_ether]
sp : ffff00000800bde0 pstate : 80000145
x29: ffff00000800bde0 x28: 0000000000000006
x27: 0000000000000140 x26: ffff8005fbb7a518
x25: ffff80063b2c98a8 x24: ffff80063a6f73b8
x23: ffff80063b2c98a0 x22: ffff8005fbb7a518
x21: ffff80063b2c9000 x20: ffff80063a6f73b8
x19: ffff8005fbb7a558 x18: 000000000049a1dc
x17: 000000365edd6f88 x16: ffff000008204254
x15: 0000000000000000 x14: 0000000000000400
x13: 0000000000000400 x12: 0000000000000000
x11: 0101010101010101 x10: 0000000000000000
x9 : 0000000000000484 x8 : ffff8005d9a44214
x7 : 0000000000000000 x6 : ffff8005d9a44210
x5 : ffff8005d9a44210 x4 : 0000000000000214
x3 : 0000000000000001 x2 : 0000000001080020
x1 : ffff8005fbb7a518 x0 : 0000000000000000
Call trace:
 usb_ep_queue+0xe0/0x110 [udc_core]
 eth_start_xmit+0x280/0x30c [u_ether]
 ncm_tx_tasklet+0x3c/0x50 [usb_f_ncm]
 tasklet_action+0xa0/0x104
 __do_softirq+0x260/0x3b8
 irq_exit+0x7c/0xd8
 __handle_domain_irq+0x78/0xac
 gic_handle_irq+0x68/0xa8
 el1_irq+0xb4/0x12c
 cpuidle_enter_state+0x1b4/0x2d4
 cpuidle_enter+0x18/0x20
 call_cpuidle+0x34/0x38
 do_idle+0x158/0x1a8
 cpu_startup_entry+0x20/0x30
 secondary_start_kernel+0x10c/0x118
Code: 95e9c147 17ffffe3 f9400a80 aa1603e1 (f9401003)
---[ end trace ffcd984d149a0f4e ]---
Kernel panic - not syncing: Fatal exception in interrupt
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x21002004
Memory Limit: 3968 MB
Rebooting in 3 seconds..

Hence clear the FFS_FL_BOUND flag after checking using
test_and_clear_bit() in function ffs_closed() which ensures calling
of unregister_gadget_item().

Signed-off-by: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>
---
 drivers/usb/gadget/function/f_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 73dc10a77cde..8bed3c800dff 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1895,7 +1895,6 @@ static void functionfs_unbind(struct ffs_data *ffs)
 		usb_ep_free_request(ffs->gadget->ep0, ffs->ep0req);
 		ffs->ep0req = NULL;
 		ffs->gadget = NULL;
-		clear_bit(FFS_FL_BOUND, &ffs->flags);
 		ffs_data_put(ffs);
 	}
 }
@@ -3847,7 +3846,7 @@ static void ffs_closed(struct ffs_data *ffs)
 	ci = opts->func_inst.group.cg_item.ci_parent->ci_parent;
 	ffs_dev_unlock();
 
-	if (test_bit(FFS_FL_BOUND, &ffs->flags))
+	if (test_and_clear_bit(FFS_FL_BOUND, &ffs->flags))
 		unregister_gadget_item(ci);
 	return;
 done:
-- 
2.17.1

