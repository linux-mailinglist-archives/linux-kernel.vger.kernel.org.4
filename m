Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0A6A3BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjB0Hyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0Hyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:54:53 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D8EC66
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:54:51 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c3so1411985qtc.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snnxk3R92ahys5e04/EBmiQcmHyLqTEXiwOEel0/hFE=;
        b=nthjjN7F18kRwv+48Iyl0RX0Qii5yotlmEg9MWcNO5K0QwP+8FFIjQL4w7Wv8A5eTb
         H2PF1Q1+CxKx3xdedQGwn5H4V1FmShL/CyteobA5E+wOMrQaz6FHhqFrHFznbtYHxfnj
         PfOiRHYOwBdahlS7h9PqN3XwNEMmtlmHLJIoEgJfZBMK/Y6ysb9ZfQxZlfU8VtCVoEw0
         Ly2obf7xDiqbxWrB40nwcRPJPfy3EihV2bN646nX8R3+irNHMhetKfAZYvfwm3YjwccP
         FL4K0fexvYujbmHOwQpyzpaYtX7oHMv9SlELftHitnCUpsbw1HxuFyYSTR6WLR8T8xsr
         bMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snnxk3R92ahys5e04/EBmiQcmHyLqTEXiwOEel0/hFE=;
        b=zwY027lvdevlUfFRBHz1gexwYzBy+PgIUyD3P8Yyf7JwzBQZbIfH3XQHrfsxlIG5wR
         UjME8ykq/GqxFusWh+fRVesw5hGL0snm+bbX8ocVowhg10asBpLQ+mYHfJNh6U4stm4v
         hWHD11uv8S6XNvJGZSK/Nov4wEPaiMnKNN5cCUTqMGffceupyLKXkYYIHE2DiVaERlaf
         SUkrZuvmY38X9WOix/JeU8MRUhSswstqjD3gTEkvAIhE31H35SG4cQM/jM+p3oXobdUE
         fU6f6/J+r5BtsNwwcL5o7vAPbwkDRN8FfrCGOBn5R9SOUy2X37yv6tJi9vdX7myBSE52
         COsg==
X-Gm-Message-State: AO0yUKU3JoeDq09xmRcbS7PwliJRhBwyEjbIBnWEvQpFDg83xGtlVl+f
        J4GlYr6JFU/kAnF9tjbQNYoXER1vK/w=
X-Google-Smtp-Source: AK7set/C5bCr630zyecI6+trMCubXC9xPZO58fw95qgfjznPusl5KIqb7YUlG+Q4SOS0pQEacu6iDw==
X-Received: by 2002:a05:622a:1a29:b0:3ac:1bd5:b7ad with SMTP id f41-20020a05622a1a2900b003ac1bd5b7admr29204131qtb.33.1677484489581;
        Sun, 26 Feb 2023 23:54:49 -0800 (PST)
Received: from MBP.lan ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id r23-20020ac85217000000b003b8238114d9sm4235937qtn.12.2023.02.26.23.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Feb 2023 23:54:49 -0800 (PST)
From:   Schspa Shi <schspa@gmail.com>
To:     linux-kernel@vger.kernel.org, cocci@inria.fr, peterz@infradead.org,
        mcgrof@kernel.org
Cc:     Schspa Shi <schspa@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [RFC PATCH] cocci: cpi: add complete api check script
Date:   Mon, 27 Feb 2023 15:53:47 +0800
Message-Id: <20230227075346.69658-1-schspa@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
process won't reference the completion variable on stack. For a
killable/interruptiable version, we need extra code(add locks/use xchg) to
ensure this.

This patch provide a SmPL script to detect bad
DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.

This is a common problem, and a lot of drivers have simpler problem. The
fellowing is a list of problems find by this SmPL patch, due to the complex
use of wait_for_complete* API, there will still be some false negatives and
false positives. This RFC patch is mainly used to discuss improvement
methods. If we introduce the wait_for_complete*_onstack API, it will be
easier to modify these problems, and the patch rules of SmPL will be very
easy. In the process of trying to write SmPL scripts, I strongly recommend
introducing two onstack APIs to complete this operation.

file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/misc/tifm_7xx1.c::268 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/firmware/arm_scmi/driver.c::1001 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::595 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::491 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::538 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::645 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::3175 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2360 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2314 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2634 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1804 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1758 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::2034 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wireless/marvell/mwl8k.c::2259 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wireless/mediatek/mt7601u/mcu.c::317 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wireless/ti/wlcore/main.c::6674 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wwan/t7xx/t7xx_state_monitor.c::416 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::647 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::653 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/soc/qcom/rpmh.c::269 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic94xx/aic94xx_tmf.c::339 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_ctl.c::242 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1811 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2266 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1603 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2073 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1807 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1328 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/ibmvscsi/ibmvfc.c::2466 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::844 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::2334 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c::2297 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/lpfc/lpfc_nvmet.c::2119 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/ipr.c::5153 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/scsi_error.c::1157 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_main.c::1215 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c::996 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c::867 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/isci/task.c::317 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::1844 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2310 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2086 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2579 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::6752 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::4074 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/thunderbolt/ctl.c::604 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i2c/busses/i2c-hisi.c::206 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/s390/cio/vfio_ccw_drv.c::71 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/messaging.c::154 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::894 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::932 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ctrl.c::377 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/usb/core/devio.c::1142 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/usb/core/hcd.c::2229 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/spi/spi-hisi-sfc-v3xx.c::337 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/bluetooth/hci_bcm4377.c::955 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c::336 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c::278 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::360 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::312 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::238 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/ata/libata-core.c::1558 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::285 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::233 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::262 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/lib/kunit/try-catch.c::76 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/sound/aoa/soundbus/i2sbus/pcm.c::264 was suspected to return a variable on stack

To fix this, we can add introducing two new API for this.

+
+void complete_on_stack(struct completion **x)
+{
+       struct completion *comp = xchg(*x, NULL);
+
+       if (comp)
+               complete(comp);
+}
+EXPORT_SYMBOL(complete_on_stack);
+
+int __sched wait_for_completion_state_on_stack(struct completion **x,
+                                       unsigned int state)
+{
+       struct completion *comp = *x;
+       int retval;
+
+       retval = wait_for_completion_state(comp, state);
+       if (retval) {
+               if (xchg(*x, NULL))
+                       return retval;
+
+               /*
+                * complete_on_stack will call complete shortly.
+                */
+               wait_for_completion(comp);
+       }
+
+       return retval;
+}
+EXPORT_SYMBOL(wait_for_completion_state_on_stack);

Link: https://lore.kernel.org/all/20221115140233.21981-1-schspa@gmail.com/T/#mf6a41a7009bb47af1b15adf2b7b355e495f609c4
Link: https://lore.kernel.org/all/7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp/

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: Matthias Brugger <matthias.bgg@gmail.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Valentin Schneider <vschneid@redhat.com>

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 scripts/coccinelle/api/complete.cocci | 160 ++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 scripts/coccinelle/api/complete.cocci

diff --git a/scripts/coccinelle/api/complete.cocci b/scripts/coccinelle/api/complete.cocci
new file mode 100644
index 000000000000..d4cf32187180
--- /dev/null
+++ b/scripts/coccinelle/api/complete.cocci
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+///
+//  Copyright: (C) 2023 Schspa Shi.
+//  Confidence: High
+virtual report
+
+@r1 exists@
+declarer name DECLARE_COMPLETION_ONSTACK;
+declarer name DECLARE_COMPLETION_ONSTACK_MAP;
+position p;
+identifier done;
+identifier func;
+@@
+
+func(...) {
+...
+(
+DECLARE_COMPLETION_ONSTACK(done@p);
+|
+DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...);
+)
+...
+}
+
+@locked exists@
+identifier func=r1.func;
+identifier done=r1.done;
+position p1,p;
+@@
+
+func(...) {
+...
+(
+mutex_lock@p1
+|
+mutex_trylock@p1
+)
+ (...)
+...  when != mutex_unlock(...)
+done@p
+...
+}
+
+
+@elocked exists@
+identifier func=r1.func;
+identifier done=r1.done;
+position p1,p;
+expression e;
+@@
+
+func(...) {
+...
+e = &done;
+...
+(
+mutex_lock@p1
+|
+mutex_trylock@p1
+)
+ (...)
+...  when != mutex_unlock(...)
+e@p
+...
+}
+
+
+@has_wait_for_completion exists@
+position p;
+identifier done;
+identifier func=r1.func;
+identifier fb = { wait_for_completion, wait_for_completion_io};
+expression e;
+@@
+
+func(...) {
+...
+(
+...
+fb(&done@p);
+...
+|
+e = &done;
+...
+fb(e@p);
+)
+...
+}
+
+@has_while_wait exists@
+position p;
+identifier done, ret;
+identifier func=r1.func;
+identifier fb =~ "wait_for_completion.*";
+expression e;
+@@
+
+func(...) {
+...
+while (...) {
+	...
+	ret = fb(&done@p, e);
+	...
+}
+...
+}
+
+@has_while_wait2 exists@
+position p;
+identifier done;
+identifier func=r1.func;
+expression fb =~ "wait_for_completion.*";
+@@
+
+func(...) {
+...
+while (fb(&done@p, ...) == 0) {
+	...
+}
+...
+}
+
+
+@r2 depends on (!has_wait_for_completion && !has_while_wait && !has_while_wait2) exists@
+declarer name DECLARE_COMPLETION_ONSTACK;
+position p!={locked.p, elocked.p};
+identifier done=r1.done;
+identifier func=r1.func;
+expression e;
+@@
+
+func(...) {
+...
+(
+wait_for_completion_interruptible(&done@p)
+|
+wait_for_completion_killable(&done@p)
+|
+wait_for_completion_timeout(&done@p, ...)
+|
+wait_for_completion_io_timeout(&done@p, ...)
+|
+wait_for_completion_interruptible_timeout(&done@p, ...)
+|
+wait_for_completion_killable_timeout(&done@p, ...)
+|
+try_wait_for_completion(&done@p)
+|
+wait_for_completion_timeout(e@p, ...)
+)
+...
+}
+
+
+@script:python depends on report@
+fp << r2.p;
+@@
+
+print('file:{:s}::{:s} was suspected to return a variable on stack'.format(fp[0].file, fp[0].line))
+
-- 
2.37.3

