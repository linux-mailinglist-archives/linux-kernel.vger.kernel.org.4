Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222D06E9C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjDTTd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjDTTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:33:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B019C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:33:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b8b19901fso1819741b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682019232; x=1684611232;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y74Qw0/8a5dMAsd+sLD5I7B7gKbGCOA24GXrDYc4XOg=;
        b=UPJJd3ogPdBv/pVoXDdKlIHl0RL0ASvVb345pCL+hNq6LlD+Gn58+pJ5JsX/IL7Wfj
         rPWDH0P2HCl27BwG7gdXm913RJMv0yJ84nwS/xKcm0xNhvzbzzDCTZQ1sCj4IUasIxC7
         7AJto8DyUTA2WSxI7CKsnFl0Qs7YNVw245vTHWQj3kZLsrbN5ZfYnene5gasq3GG3doN
         WU+yxe0TAAJ/2OgIHg2vuvYgdkWPLmhlx5QiPD2DSDweWJdXuddBhEfFO2eDdFhL+iNw
         TLH+MByh8hrdJLqc6BlJMBqf5lyX/eUQawH/PMRfdh7egDhMe/mIQUKNsZszoh+fybQB
         BAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019232; x=1684611232;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y74Qw0/8a5dMAsd+sLD5I7B7gKbGCOA24GXrDYc4XOg=;
        b=fUwHzOf9h9o91r6LsRCh/pB542hDziM/kBrN6WkG7ZL2AM+bKnuGI+SsRMLAGA7dzx
         jOmnCky1r7gsPL/zFK0f0A8h3QLe7nLwEWsqAJEJn5O+yWthtrVaFuYkMEjBUBB9mgxM
         ej3I9/1mpclT3c1je0gWfXEq7toYkDSblftGSl5dvgE4Nq+qMYhyZTyfHl6RQjAYoFTQ
         0oqpA9iGk8rPJJFGr65wdsEWGt/GJ8f1h+jC7Rga5ebKAr4kRrWA1J4WT57bmRzb3VUv
         sRsGFikHR5Qu24Fmfi9tXHMM2T2pcKm5KX7WYMUAvLcnSk/t8evaEOcAbd9XWYeNpvLh
         LU6Q==
X-Gm-Message-State: AAQBX9dRt31sZy4BYufo8mKHMPqdKioKo4yUsp56W5G7BcqgrgzfXcQO
        Z4/gtCYyKqpC2Px1ewhrx+M=
X-Google-Smtp-Source: AKy350aGUH4NmuqEm9f9W5+HQVzwxSTRC2zgGk4C6AfeId04keMA4/dyzq93CgfUysCRowR7wbjzGA==
X-Received: by 2002:a05:6a20:4296:b0:ef:1457:6cdf with SMTP id o22-20020a056a20429600b000ef14576cdfmr3736647pzj.19.1682019231601;
        Thu, 20 Apr 2023 12:33:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q5-20020a056a00084500b0062dae524006sm1599698pfk.157.2023.04.20.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:33:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Apr 2023 09:33:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] firmware: arm_scmi: Fix incorrect alloc_workqueue()
 invocation
Message-ID: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

scmi_xfer_raw_worker_init() is specifying a flag, WQ_SYSFS, as @max_active.
Fix it by or'ing WQ_SYSFS into @flags so that it actually enables sysfs
interface and using 0 for @max_active for the default setting.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/firmware/arm_scmi/raw_mode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -1066,7 +1066,7 @@ static int scmi_xfer_raw_worker_init(str
 
 	raw->wait_wq = alloc_workqueue("scmi-raw-wait-wq-%d",
 				       WQ_UNBOUND | WQ_FREEZABLE |
-				       WQ_HIGHPRI, WQ_SYSFS, raw->id);
+				       WQ_HIGHPRI | WQ_SYSFS, 0, raw->id);
 	if (!raw->wait_wq)
 		return -ENOMEM;
 
