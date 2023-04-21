Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279DC6EA1FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjDUCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjDUCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9AF7681
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:51:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a677dffb37so16334345ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045475; x=1684637475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNxWNsNkiW6dC2MPWOAlJ0DZEAiQsjxz/0ttEihBSFM=;
        b=mk8IgkQXApz1FaufEiZfvC15wekz3UMd4Nl3Mr2cB9VJ/qBecpD1Bpr+n5KabJWu6G
         cmrHDbaznnLLk6ScZLN/q0opj00Kkp0tiX9FxxwSaVFu7nOGXMg2aPYHHok0gmMBXZK7
         /1D4K/5afm3qRf9oUoK5OWZlDM0Vk7G1EyqSMAdhIPMPDFXpHItCtLA9Jd0bSBnlCrFV
         ghN652WLJTDjKK1GjX7VkJEIbiKB887uO9up9rx/DVXUrW4BRmBBWfFAUVftAvZ/9Jgw
         LGYOmv7h/LLENqWfbT5qujjToajeflNFPmZN8wmNF4xr1voiRREWbW8VVrgPUq5UMcBI
         2Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045475; x=1684637475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qNxWNsNkiW6dC2MPWOAlJ0DZEAiQsjxz/0ttEihBSFM=;
        b=M1oY0hE6Bbe6KBnQzfjBCLCOVi6wpU4HngRqnRTJXHAh22JQ4fJKIYOfj20fsjPWYN
         /7Uk+siQ7XxA0AQfsgvzU+VzkKl0eZKd6Dg7QVGJO04G7mgBFfmQyDew0uebqVMrPplr
         CN+NC6eRWaPMcG4/pkWv6qNcnbWPtWlOtFb3xw2RNBhEOSWaQFNTzAsTO4d60tdfMVG7
         Zlh4Cj+kRojSEF2DQT25x4rJjCobMLV9gRrkuwi2cDNUUK9sjSRT7qXlFcF2tic8tY9k
         SrF2buYHjE6j8yc3sLTca+fxJOzeESufla1TreDSmnQWzeXq7UFf6BTPwcXhbpJ/Y9SN
         woBQ==
X-Gm-Message-State: AAQBX9fWrDEMk3gqUjkzNIdSvNgAxEjRhMayQOl7Zs7wVRHPFXXTz0Mm
        YmSyUnFI3Zae3xEfEuaYxBE=
X-Google-Smtp-Source: AKy350ZaTyLAEijRBhWVAX5ICduoIiDBqxQR3YuwvDpYPyTLeNh4OxMVqSWoYQdO5e+ieDSbxM2mpA==
X-Received: by 2002:a17:902:ecc4:b0:1a6:9f85:9437 with SMTP id a4-20020a170902ecc400b001a69f859437mr4245549plh.67.1682045475058;
        Thu, 20 Apr 2023 19:51:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709029a4900b001a6388ce38bsm1724167plv.240.2023.04.20.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Fei Li <fei1.li@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 13/22] virt: acrn: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:37 -1000
Message-Id: <20230421025046.4008499-14-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Fei Li <fei1.li@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/ioreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index d75ab3f66da4..cecdc1c13af7 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -576,8 +576,8 @@ static void ioreq_resume(void)
 int acrn_ioreq_intr_setup(void)
 {
 	acrn_setup_intr_handler(ioreq_intr_handler);
-	ioreq_wq = alloc_workqueue("ioreq_wq",
-				   WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	ioreq_wq = alloc_ordered_workqueue("ioreq_wq",
+					   WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!ioreq_wq) {
 		dev_err(acrn_dev.this_device, "Failed to alloc workqueue!\n");
 		acrn_remove_intr_handler();
-- 
2.40.0

