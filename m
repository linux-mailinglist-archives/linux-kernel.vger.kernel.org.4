Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EA6F604C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjECUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECUtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:49:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322627AB2;
        Wed,  3 May 2023 13:49:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64115e652eeso7970519b3a.0;
        Wed, 03 May 2023 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683146993; x=1685738993;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MebKpbPvjjLcVP5UK0GuwV8NZpys75qJp2kyPkxN3bg=;
        b=bFM8UMfuptbt97mtMGjQlMZblWfeOV8q1Gn3F2oTVb4cVxIgjAcd83Ry9Y0JAHJ1aU
         e74mhQ7697KPOt5uGp7yOpjnDIvQmzcDwVJwPyc7asd6YFcNJHRmmmIyKHiCz23HjonD
         ojXCcfs9lYkeqO8CdJUWVWTwso3AbLQtfN6BuBDHRAJpqhlePHXfIITJvzWUCAr04B39
         XG2T/QWdiMhr9tTB7UdR2rtPp1gN2GRT1NrfEkU8VD4zsRK71zmYVxszRHn8XDvPvJo9
         0n19F4HNGg8cXaH6B9y0OYHxh0/ihdscTDLohFh8TEvEkfn6kdf6iMs+3cRC4THzMMdn
         jTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683146993; x=1685738993;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MebKpbPvjjLcVP5UK0GuwV8NZpys75qJp2kyPkxN3bg=;
        b=WMIEGEkHQNC5CYm38K9lD0Lo2KBzMnsSjBF6xufIp0gFHT/5rWPJmdWHJMFRootsaQ
         BFvKFkYj3i/NXY+0Blk/tzMlMk+qDCuR58jWQj0T7X84GU/9WuWWwGwC0nA1VMoC2I+t
         du4VAyy70tGoPgOa39kwlNeMPsm1a0FiJ/tVSIvgzN86OH3Jcy81czGTGnKthWDJNIgb
         5fYHxy4jMs5RPpTDTVSaA40Sn/dfoNE2EV+nDrAzCogyiOwikQSAbQJ28bRfq0dIvEKO
         tI035KJyQQtRKXFLWWipXSWdd98ydWHzpYoC3Vs/C7bOcHZhGb7XdG6xcyGQpjtLypLp
         AqGA==
X-Gm-Message-State: AC+VfDy3uWkj32QC/ZlwtBgFW74pkzR1KwMpVT9fZwtk4rrPCLEeEUfW
        ESP47ChMIK4lbEGdNE7dqHmE1GVz9Lw=
X-Google-Smtp-Source: ACHHUZ4XuTitKDI4jMCmeP+CDZl87wz1kjntKSrKIEqaHu8ckR2RPubaSxvaPvjhEBrVxuCSmxEstw==
X-Received: by 2002:a17:90a:34ce:b0:24d:e97a:8846 with SMTP id m14-20020a17090a34ce00b0024de97a8846mr3492850pjf.24.1683146992956;
        Wed, 03 May 2023 13:49:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9390:e396:49ef:54dc])
        by smtp.gmail.com with ESMTPSA id em8-20020a17090b014800b0023cfdbb6496sm1855295pjb.1.2023.05.03.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 13:49:52 -0700 (PDT)
Date:   Wed, 3 May 2023 13:49:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tests - fix input_test_match_device_id test
Message-ID: <ZFLI7T2qZTGJ1UUK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly initialize input_device_id structure in
input_test_match_device_id test to make sure it contains no garbage
causing the test to randomly fail.

Fixes: fdefcbdd6f36 ("Input: Add KUnit tests for some of the input core helper functions")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/tests/input_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index 8b8ac3412a70..0540225f0288 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -87,7 +87,7 @@ static void input_test_timestamp(struct kunit *test)
 static void input_test_match_device_id(struct kunit *test)
 {
 	struct input_dev *input_dev = test->priv;
-	struct input_device_id id;
+	struct input_device_id id = { 0 };
 
 	/*
 	 * Must match when the input device bus, vendor, product, version
-- 
2.40.1.495.gc816e09b53d-goog


-- 
Dmitry
