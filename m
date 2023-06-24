Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7356773C706
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjFXGEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjFXGDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:03:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28426272D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a52fff2f0so313483a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586623; x=1690178623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBSfn8glPT2kxNQHy+PfpOOqO6rN+IWZ6miV6QcZYkw=;
        b=NVRmC14/S1OEnqRzqTWlTQDcv+sbJhErpLvqB3BWs4Mx8Knib/+pRG2df40Gzi/ySA
         FUUWa3ijaGP33OSAlh0XF+ZADZUYgLEx7f3npCaxkn6MIAH0dSi+QEO74GRMgt36jJE4
         GJp7xCpnJuFSHKf3cE05WpNVjJHPXbBHUoTU4aQeVmwaDJ/pKKczDtF4IOI6Nn9lC7t3
         hhYPD1DPh3tGIgLG6BqjRmwHEJRUmqWpL3j0HaZkq9I8LdddDKNpz5unUvaGpjph3E6f
         Opu86HT7G+Iel/iS6uTmplkgVZjeBM9AcmZ2JIyE3HLBl9QmRXE9gUZY8umwhDN6R0Vc
         1pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586623; x=1690178623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBSfn8glPT2kxNQHy+PfpOOqO6rN+IWZ6miV6QcZYkw=;
        b=mEGSGqU/jd/wEjRXuth+c0+jW52Mr0N8Zh3utv4zM0pt5cjs7Y/jGgFqkbd9FiyLif
         VYMzi8zDpfAuJeDaShf6KrC1QZPt8L+sKIP8Ir3gvtx8qfq+jS63c99skRBc4uDm3hZl
         f5P8F9cLuUDnKnDKC6W10OP/5Nsoj16GV8H2tl6Nc7psWPuP/t1wn6+eOWXRHSHq4Pyz
         HNjhQQcECRGJzKKykuFO+Kvpg26qWFOgr8UM0HTTL4m7VCAzom5YnZyMlReA9wPryyVw
         OPDa+/k17JIghRyGNVOjPtRlAZ7jv5EzJPgg7uggFhthqbes00muabUgZA0Y3h+PZ8Zs
         W2+w==
X-Gm-Message-State: AC+VfDxLM21/zBulFO1bvSZ2C79dfEpZmwpUX1HU/cHqUrgVaNipQ6yt
        MOl4ZY34coyK2UoTAAoHRsI=
X-Google-Smtp-Source: ACHHUZ5g2n9rJ9hdt9TSwklixbRmpTWI8h2/OX/znA4tlIeI4dLnfbSPJpP/mntq1lx1LS/4DAUkjQ==
X-Received: by 2002:a17:906:73dd:b0:989:1ed3:d00b with SMTP id n29-20020a17090673dd00b009891ed3d00bmr9942539ejl.4.1687586623029;
        Fri, 23 Jun 2023 23:03:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id h9-20020a50ed89000000b0051d888df7f8sm31279edr.56.2023.06.23.23.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:03:40 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:03:38 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8192e: Remove equation of local variable
 InactTime of AdmitTS
Message-ID: <ff2d60f157059e5440a4b583f2604d99db4d8d2b.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove equation of local variable InactTime of AdmitTS as AdmitTS is only
once called with InactTime as 0. The equation is always false and
therefore dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 00f6a66c2265..ed124f85c2b1 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -188,10 +188,6 @@ static void AdmitTS(struct rtllib_device *ieee,
 		    struct ts_common_info *pTsCommonInfo, u32 InactTime)
 {
 	del_timer_sync(&pTsCommonInfo->InactTimer);
-
-	if (InactTime != 0)
-		mod_timer(&pTsCommonInfo->InactTimer, jiffies +
-			  msecs_to_jiffies(InactTime));
 }
 
 static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
-- 
2.41.0

