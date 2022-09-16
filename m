Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2962D5BB045
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiIPPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIPPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:33:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC8ABF2E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:33:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dv25so50182328ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2Y3KUPS6KhbaKXeSt32NbllpEAsejP8RFv38cwdpBtc=;
        b=BfiVfhXuwEPNc19RdhalPSQxId92CUh9keRFBJ4iiOWxFeC2ML5hSa5iZgyhLpr/4N
         nKgTwzn4/Zsag1FNkD0DAEI6CH26zzPPBGDXNL6HQ7izBv13atnn/DMh+vxIIlST/es9
         hfq5giZ8X98VHYn9op4uBASZ+6aL+/5JeeXeLPCP+jH1XvQRbX4ibKrdPFMhayY3jVwu
         yt89E6NxIQgjBWSfVGj711sIXwj9UkdV9kg/U9ONZ2imo42Qzm0mYVstBObZRCHdl+h9
         r8AEHog/pyBmn8L5Xcy1COjm2w7yIjb4JUB06fxdJj1o2EHN7uDF2XJ6xnyLv0C9hZs5
         aNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2Y3KUPS6KhbaKXeSt32NbllpEAsejP8RFv38cwdpBtc=;
        b=rXR43cSAaGeCe/eduJbBfbxbzSB67pRXpvefeZzWGoyoEgbca5QfH0de3dVnRYa9eL
         o5Dodiq9ZCym00HpvlUFU0J9Klm4rdARkakZvH6PcTq5d+qJRN7Eqb9enK318LT2JeeW
         Wt6YkUQRyXk+geT+m+WMKIU47BQebBcONYeWimHpPRutIVcwaDplqH9p/kdbgr2ds0Au
         t9hGSqvOp4PUeEyl+Zbgs6HwfRVFmD9DTPlcpKU3E8RR28/mT3WdzhFzxJqsO+MW6C1x
         lNgMEPqZ30coAJ472KLxUB+ShnGXsEhqmzK4hXLXmMXJx0YOynIiZC/6MLQcsxHp0xOB
         WA/A==
X-Gm-Message-State: ACrzQf31PETg/2zgzRShwTgHWwxhSBMME5IeZ5q3TEjELaeDKXf5aotb
        jNsPDb/OAnOpBGQhUosz9f7pbKADtWtuXNjd5Eg=
X-Google-Smtp-Source: AMsMyM59ZsfSmjomo2J0ZZttYb2oEBCKJdVTuNLKF0++dGGJKyowJGDHTRnx9soewDnXqGz7AX4cPl/iGWbbsLBjC44=
X-Received: by 2002:a17:907:1b12:b0:72f:9b44:f9e with SMTP id
 mp18-20020a1709071b1200b0072f9b440f9emr3958118ejc.653.1663342406891; Fri, 16
 Sep 2022 08:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_48738CD5589B4162E0D0B9D85B84DCD33C0A@qq.com> <YyQwsxDoaWT6Y5a0@kroah.com>
In-Reply-To: <YyQwsxDoaWT6Y5a0@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 16 Sep 2022 23:33:15 +0800
Message-ID: <CAJedcCzY72jqgF-pCPtx66vXXwdPn-KMagZnqrxcpWw1NxTLaA@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     xmzyshypnc <1002992920@qq.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7cdd08c87a3252ffa081997146dd9c3adcb37f1c Mon Sep 17 00:00:00 2001
From: xmzyshypnc <1002992920@qq.com>
Date: Fri, 16 Sep 2022 17:54:07 +0800
Subject: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os

In grufile.c, gru_file_unlocked_ioctl function can be called by user.

If the req is GRU_SET_CONTEXT_OPTION, it will call gru_set_context_option.

In gru_set_context_option, as req can be controlled by user,

We can reach gru_check_context_placement function call.

In gru_check_context_placement function, if the error path was steped,

say gru_check_chiplet_assignment return 0,

Then it will fall into gru_unload_context function.

And it will finnaly call kfree gts in gts_drop function.

Then gru_unlock_gts will be called in gru_set_context_option function.

This is a typical Use after free.

The same problem exists in gru_handle_user_call_os and gru_fault.

Fix it by introduce the return value to see if gts is in good case or not.

Free the gts in caller when gru_check_chiplet_assignment check failed.

Signed-off-by: xmzyshypnc <1002992920@qq.com>
---
 drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
 drivers/misc/sgi-gru/grumain.c   | 17 +++++++++++++----
 drivers/misc/sgi-gru/grutables.h |  2 +-
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index d7ef61e602ed..2b5b049fbd38 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
    if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
        goto exit;

-   gru_check_context_placement(gts);
+   ret = gru_check_context_placement(gts);
+   if (ret)
+       goto err;

    /*
     * CCH may contain stale data if ts_force_cch_reload is set.
@@ -677,6 +679,10 @@ int gru_handle_user_call_os(unsigned long cb)
 exit:
    gru_unlock_gts(gts);
    return ret;
+err:
+   gru_unlock_gts(gts);
+   gru_unload_context(gts, 1);
+   return -EINVAL;
 }

 /*
@@ -874,7 +880,7 @@ int gru_set_context_option(unsigned long arg)
        } else {
            gts->ts_user_blade_id = req.val1;
            gts->ts_user_chiplet_id = req.val0;
-           gru_check_context_placement(gts);
+           ret = gru_check_context_placement(gts);
        }
        break;
    case sco_gseg_owner:
@@ -889,6 +895,10 @@ int gru_set_context_option(unsigned long arg)
        ret = -EINVAL;
    }
    gru_unlock_gts(gts);
+   if (ret) {
+       gru_unload_context(gts, 1);
+       ret = -EINVAL;
+   }

    return ret;
 }
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 9afda47efbf2..79903cf7e706 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -716,9 +716,10 @@ static int gru_check_chiplet_assignment(struct
gru_state *gru,
  * chiplet. Misassignment can occur if the process migrates to a different
  * blade or if the user changes the selected blade/chiplet.
  */
-void gru_check_context_placement(struct gru_thread_state *gts)
+int gru_check_context_placement(struct gru_thread_state *gts)
 {
    struct gru_state *gru;
+   int ret = 0;

    /*
     * If the current task is the context owner, verify that the
@@ -727,14 +728,16 @@ void gru_check_context_placement(struct
gru_thread_state *gts)
     */
    gru = gts->ts_gru;
    if (!gru || gts->ts_tgid_owner != current->tgid)
-       return;
+       return ret;

    if (!gru_check_chiplet_assignment(gru, gts)) {
        STAT(check_context_unload);
-       gru_unload_context(gts, 1);
+       ret = -EINVAL;
    } else if (gru_retarget_intr(gts)) {
        STAT(check_context_retarget_intr);
    }
+
+   return ret;
 }


@@ -919,6 +922,7 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
    struct gru_thread_state *gts;
    unsigned long paddr, vaddr;
    unsigned long expires;
+   int ret;

    vaddr = vmf->address;
    gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
@@ -934,7 +938,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
    mutex_lock(&gts->ts_ctxlock);
    preempt_disable();

-   gru_check_context_placement(gts);
+   ret = gru_check_context_placement(gts);
+   if (ret) {
+       mutex_unlock(&gts->ts_ctxlock);
+       gru_unload_context(gts, 1);
+       return ret;
+   }

    if (!gts->ts_gru) {
        STAT(load_user_context);
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index 5efc869fe59a..f4a5a787685f 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -632,7 +632,7 @@ extern int gru_user_flush_tlb(unsigned long arg);
 extern int gru_user_unload_context(unsigned long arg);
 extern int gru_get_exception_detail(unsigned long arg);
 extern int gru_set_context_option(unsigned long address);
-extern void gru_check_context_placement(struct gru_thread_state *gts);
+extern int gru_check_context_placement(struct gru_thread_state *gts);
 extern int gru_cpu_fault_map_id(void);
 extern struct vm_area_struct *gru_find_vma(unsigned long vaddr);
 extern void gru_flush_all_tlb(struct gru_state *gru);
-- 
2.25.1
