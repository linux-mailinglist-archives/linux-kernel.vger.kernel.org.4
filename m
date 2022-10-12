Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D555FBEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 02:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJLAXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 20:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLAXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 20:23:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C7915FE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 17:23:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id u12-20020a17090a410c00b0020b7d65a875so245940pjf.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XAIQlfhQxtiJi8UMEPSh4ft6T3GSXHlCE4VlMzFLAmA=;
        b=jnQWsqoj/L9+kkfPwOLqzTeb4pxdDPA3++KAqL6FCzRcC5K7/DR6dY7MvFvdGPoDV5
         chiLW84esu/MImcZSvaeAP5AYkADNL4bFTPkFuOna20H/nfz0nlQlhke+RtSR8NqWfNI
         UOAPtZ1ku47Gtxf5uvp1/1x3bgRZe4JNTLmMKE/CYb1+zKRt9k5o7eCOyIXVFiz1NVG+
         sWsJRNiXdfRybflCJQPxtKxUtQT4T2faz9c4DdISQtUlnlozeFE5CYDvPjFWOXV+vgOR
         3Js5R66z41iT1WjgAxZeEakH0Pl1J2OFA+8Zv4jsZG96WposnBG/4N4KlQZoTO5tP2hE
         yTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAIQlfhQxtiJi8UMEPSh4ft6T3GSXHlCE4VlMzFLAmA=;
        b=wQYdKy4yFfwbSfcgd6wnsyaZy0P5wN7K1i1qkTCjyGg28e2O1rXfRWxjTXe1MhoBKR
         z6i77QRWjm7GkLdQH/+/3HCh05EPI7dePF4lmdzgXY3HVuhQaS51G/wshZ9SdwkTTYxu
         sMcaeX/pdtc34Ct78xno+TRae6vyD2YHIb4o5y8XCQsO6pIAswm5+6DjZt/AkvEZn6ep
         /y5FL+Af7KYUf2aa/YkbSN62ywJYT5zUmP63CF6Q7r2Xx/nBOxOKRo/wuX5klIFvdfUf
         7idpebVlC383PODpqDAmtaBmk4l9SzbjeTQCh1lTn/8ybIAxylvfxIoSEIrI9EtiX5az
         VXIw==
X-Gm-Message-State: ACrzQf2H2qqm31dI4CHdOwhXuxCuH2j6Bj/sUA9uFLGpxWmcqtwb6f7j
        rw73+qTANBv6iWjxZuMMq7B5dFIzzeL+XrlD9g==
X-Google-Smtp-Source: AMsMyM4ST89r16LZrARpzsqKLu0H4+RyEaqFTqe5v5BiRRPOz7muxrWPOMJcdcehswQWkrxTq0hj4X0Yp4Lm+y9FGg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:aa7:88c2:0:b0:562:6ca0:2f7a with SMTP
 id k2-20020aa788c2000000b005626ca02f7amr28100093pff.72.1665534224024; Tue, 11
 Oct 2022 17:23:44 -0700 (PDT)
Date:   Wed, 12 Oct 2022 00:23:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012002323.2015637-1-dionnaglaze@google.com>
Subject: [PATCH] virt/coco/sev-guest: Initialize err in handle_guest_request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

The err variable may not be set in the call to snp_issue_guest_request,
yet it is unconditionally written back to fw_err if fw_err is non-null.
This is undefined behavior, and currently returns uninitialized kernel
stack memory to user space.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sevguest/sevguest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 112c0458cbda..7a62bfc063fc 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -307,7 +307,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
+	unsigned long err = 0;
 	u64 seqno;
 	int rc;
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

