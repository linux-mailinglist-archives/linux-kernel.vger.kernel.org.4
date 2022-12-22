Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFDA653ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiLVCqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiLVCqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:46:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0879EE1E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:46:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3d2994e2d7dso8016197b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Efktw4hJ8FupRr4DbW13wyao5oV1mILrrOmGsxieh5g=;
        b=hIYk/tbRU8Rxy+twOLZ5QXSjOx5ydJ3m2rrO01CElOVULlqfTH9bSnDeqB/ks7/YUX
         xLp9jHyK4J6oOjvsSbRbz7KDaWUAkBbzxAcACmbn93oh1+dEoFtmLZdDMfnMrQY7+pPm
         7Fbo1dIyXEUdo69/3LBshEmzkvvwzQACMq2AAl6+8wA5g4b7kqZNWwRlZVakPROnwARV
         h6uyx68TT0yjSS3IQ0YA1+klsjVkOtSn1BF1C1L3KPC7xD5LJFyMyDX9QkOS0jo//JZB
         kYero4XVvQ1xCqa/vfs7WY9s7ko3qxOoe1JcJmm/H+u1JXlwDLqKbqtn/SvM6XC9sPA7
         gOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Efktw4hJ8FupRr4DbW13wyao5oV1mILrrOmGsxieh5g=;
        b=NxrGf/SyAhZ4jgkIEGlejLHyVVD2T8z8LsRrLWvGI4JgKSLt/g3U08EJgAf6TrnsKB
         nvGDx/wNrgei7CnYo/5b6WTWOuEGAoERqFTQsVDC69vJrLLmpwF0e968JHx0DG8GFH3p
         aKOgFpwG/7/YUyafsjbu0f94tl9SBL3qysp6MlGS+6c3blX676xyeJpC3gST3wgG2CnJ
         014UvUOdGauD69hls5iGOSfC37kDG+yNl3Oti2re5vqsReQsRsK2BDpJUbn+x6DP2cu7
         p/AqWr+zD2yKu4MwgHphC3Hd5wGRRFLCGBP5UurPM4kcJkrACYsjbCBB3yFgNe4aZio7
         JGnQ==
X-Gm-Message-State: AFqh2krVh7+m8cRWZ65PJHnrGkvYSvg1sXLRY5KuKL9rrBMmO/ONBpB8
        eZxR9IhrntG8jRTPocsP6IIPxpzf1Qg=
X-Google-Smtp-Source: AMrXdXuWlrIE6Oy8pEzY9NWbVmBoFIZ/fQ3evw1pDghtWywUSctAE6LXlqriJan1QoyX4pOxTScHAH0KakQ=
X-Received: from hhhuuu.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:c80])
 (user=hhhuuu job=sendgmr) by 2002:a05:6902:128d:b0:6f9:fd74:22f with SMTP id
 i13-20020a056902128d00b006f9fd74022fmr398672ybu.100.1671677202022; Wed, 21
 Dec 2022 18:46:42 -0800 (PST)
Date:   Thu, 22 Dec 2022 02:46:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222024630.1812735-1-hhhuuu@google.com>
Subject: [PATCH 1/1] usb: xhci: Check endpoint is valid before dereferencing it
From:   Jimmy Hu <hhhuuu@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jimmy Hu <hhhuuu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the host controller is not responding, all URBs queued to all
endpoints need to be killed. This can cause a kernel panic if we
dereference an invalid endpoint.

Fix this by using xhci_get_virt_ep() helper to find the endpoint and
checking if the endpoint is valid before dereferencing it.

[233311.853271] xhci-hcd xhci-hcd.1.auto: xHCI host controller not responding, assume dead
[233311.853393] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000e8

[233311.853964] pc : xhci_hc_died+0x10c/0x270
[233311.853971] lr : xhci_hc_died+0x1ac/0x270

[233311.854077] Call trace:
[233311.854085]  xhci_hc_died+0x10c/0x270
[233311.854093]  xhci_stop_endpoint_command_watchdog+0x100/0x1a4
[233311.854105]  call_timer_fn+0x50/0x2d4
[233311.854112]  expire_timers+0xac/0x2e4
[233311.854118]  run_timer_softirq+0x300/0xabc
[233311.854127]  __do_softirq+0x148/0x528
[233311.854135]  irq_exit+0x194/0x1a8
[233311.854143]  __handle_domain_irq+0x164/0x1d0
[233311.854149]  gic_handle_irq.22273+0x10c/0x188
[233311.854156]  el1_irq+0xfc/0x1a8
[233311.854175]  lpm_cpuidle_enter+0x25c/0x418 [msm_pm]
[233311.854185]  cpuidle_enter_state+0x1f0/0x764
[233311.854194]  do_idle+0x594/0x6ac
[233311.854201]  cpu_startup_entry+0x7c/0x80
[233311.854209]  secondary_start_kernel+0x170/0x198

Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
 drivers/usb/host/xhci-ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index ad81e9a508b1..4a514c227db7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1170,7 +1170,10 @@ static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci,
 	struct xhci_virt_ep *ep;
 	struct xhci_ring *ring;
 
-	ep = &xhci->devs[slot_id]->eps[ep_index];
+	ep = xhci_get_virt_ep(xhci, slot_id, ep_index);
+	if (!ep)
+		return;
+
 	if ((ep->ep_state & EP_HAS_STREAMS) ||
 			(ep->ep_state & EP_GETTING_NO_STREAMS)) {
 		int stream_id;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

