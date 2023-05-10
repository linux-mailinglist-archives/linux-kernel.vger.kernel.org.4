Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C76FD343
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjEJAMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 20:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjEJAMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:12:10 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D91BEF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 17:12:05 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 73C0C2C053F;
        Wed, 10 May 2023 12:12:02 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1683677522;
        bh=/ksLABzUrIZWsJWJmdsPhQq0uvIaq/7K5AgQ+TMphdE=;
        h=From:To:Cc:Subject:Date:From;
        b=DrtO7nnlyuEHL2jVK7UHNqCuW6RYCdHum1WIaThD8BrVlDPTgqbtqi0Qd0vVx1PBf
         AYK6upxAJvyK5SF0BLflq8kwrCo5S9NlCcKvr33hvrzuIyTZhcA4zO22tg3ERIjxvb
         JcHDIvpQRVTtgbxKRkOh+A7jRaa59b2FP+2+yKyoHwv4pnrAWW5wwkrRWhcD1WaFIx
         SPFqzrGCOx4gIYGJNMeipZYeAWCoHY8HrC5WRRShOypWFIp6Orfa/QLqlsSee5zibu
         g/SXCJ6qqf3vpod+5UiNjiZMpVKLr4YLEB8YFyjPMrbHJF5bMhGD+9RCYmuuWuVnLG
         hgJ4OU0p9QV2g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B645ae1520000>; Wed, 10 May 2023 12:12:02 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 4EDFF13EE32;
        Wed, 10 May 2023 12:12:02 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 48E062840D6; Wed, 10 May 2023 12:12:02 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, mkshah@codeaurora.org,
        Ben Brown <ben.brown@alliedtelesis.co.nz>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] gpiolib: Don't implicitly disable irq when masking
Date:   Wed, 10 May 2023 12:11:51 +1200
Message-Id: <20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=nMxpP1W9oJYa0-x6mvsA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When preparing to kexec into a new kernel the kexec code will mask all
interrupts for all interrupt domains before disabling them. In the case
of a gpio chip which has a mix of gpio and irq pins a warning would be
triggered as follows

  [root@localhost ~]# echo c >/proc/sysrq-trigger
  [  175.677728] sysrq: Trigger a crash
  <snip expected dump from SysRq>
  [  175.803409] WARNING: CPU: 1 PID: 2345 at drivers/gpio/gpiolib.c:3284=
 gpiochip_disable_irq+0x68/0xac
  [  175.918321] CPU: 1 PID: 2345 Comm: sh Kdump: loaded Tainted: G      =
     O      5.15.109+ #5
  [  175.926742] Hardware name: Allied Telesis x240-26GHXm (DT)
  [  175.932216] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
  [  175.939165] pc : gpiochip_disable_irq+0x68/0xac
  [  175.943686] lr : gpiochip_disable_irq+0x58/0xac
  [  175.948208] sp : ffff80000c03ba00
  [  175.951513] x29: ffff80000c03ba00 x28: ffff00002843c4c0 x27: 0000000=
000000000
  [  175.958638] x26: 0000000000000000 x25: ffff800008df0790 x24: 0000000=
000000000
  [  175.965763] x23: ffff8000095397f0 x22: ffff800009485178 x21: ffff000=
016ea38f0
  [  175.972888] x20: ffff000016ea3a20 x19: ffff000016073cc0 x18: fffffff=
fffffffff
  [  175.980012] x17: 20204f2020202020 x16: 2020202020204720 x15: ffff800=
08c03b667
  [  175.987136] x14: 0000000000000000 x13: ffff800009415148 x12: 0000000=
000000555
  [  175.994260] x11: 00000000000001c7 x10: ffff800009415148 x9 : ffff800=
009415148
  [  176.001385] x8 : 00000000ffffefff x7 : ffff80000946d148 x6 : ffff800=
00946d148
  [  176.008510] x5 : ffff00003fdc59a0 x4 : 0000000000000000 x3 : 0000000=
000000000
  [  176.015634] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000=
000000007
  [  176.022757] Call trace:
  [  176.025197]  gpiochip_disable_irq+0x68/0xac
  [  176.029373]  gpiochip_irq_mask+0x30/0x40
  [  176.033289]  machine_crash_shutdown+0xb4/0x11c
  [  176.037727]  __crash_kexec+0x88/0x16c
  [  176.041384]  panic+0x194/0x348
  [  176.044433]  sysrq_reset_seq_param_set+0x0/0x90
  [  176.048954]  __handle_sysrq+0x8c/0x1a0
  [  176.052695]  write_sysrq_trigger+0x88/0xc0
  [  176.056783]  proc_reg_write+0xa8/0x100
  [  176.060527]  vfs_write+0xf0/0x290
  [  176.063835]  ksys_write+0x68/0xf4
  [  176.067144]  __arm64_sys_write+0x1c/0x2c
  [  176.071058]  invoke_syscall+0x48/0x114
  [  176.074800]  el0_svc_common.constprop.0+0x44/0xfc
  [  176.079495]  do_el0_svc+0x28/0xa0
  [  176.082803]  el0_svc+0x28/0x80
  [  176.085851]  el0t_64_sync_handler+0xa4/0x130
  [  176.090112]  el0t_64_sync+0x1a0/0x1a4
  [  176.093768] ---[ end trace 486d53a4eb15ab42 ]---
  <more warnings for each gpio pin that is not used as an interrupt>

This is because gpiochip_irq_mask was being used to mask all possible
irqs in the domain but gpiochip_disable_irq will WARN if any of those
gpios haven't been requested as interrupts yet. Remove the call to
gpiochip_disable_irq to stop the warning.

Fixes: a8173820f441 ("gpio: gpiolib: Allow GPIO IRQs to lazy disable")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/gpio/gpiolib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8c041a8dd9d8..903f5185ae55 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1451,7 +1451,6 @@ static void gpiochip_irq_mask(struct irq_data *d)
=20
 	if (gc->irq.irq_mask)
 		gc->irq.irq_mask(d);
-	gpiochip_disable_irq(gc, d->hwirq);
 }
=20
 static void gpiochip_irq_unmask(struct irq_data *d)
--=20
2.40.1

