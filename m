Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1D5FBBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJKUXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:23:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92283FD01;
        Tue, 11 Oct 2022 13:23:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 3so13019021pfw.4;
        Tue, 11 Oct 2022 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vuYB1bfLBT/BybnhJAIKow6KEoVAgUejtP+5COBxF5k=;
        b=XgZtbw/pvujrQCJ4DONsbbA4J9Kfb3we6T6FJXUZa8feVGgigOuY50VDR9XWfC3EtV
         xcHsiBAIT4fXMAL5niqGV8PV6s8/V2jmJderQYwORIXfiKwKkAwC7OMybu0kn+Wz83YT
         nuZO/vf2MGLNITcai+mhkBhmlRyGitvhK3f9djvRSreD1LU5hikPlOZF4JC9306xO/2i
         gSoUl1Zy7NL+4ZqtADq/WyWlnxNvkxWwIwWfShONLTO17NJG45eHle1JMu0zRiHyVPyy
         FVXSb4R6MV43SiR0yD8X8J4FB69OaCX1hoS9iDfD/UstjlFnXh5QivmO1WXp6HCKAPXZ
         r8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuYB1bfLBT/BybnhJAIKow6KEoVAgUejtP+5COBxF5k=;
        b=7Gvaxo7vOWAV6le5+jVjNAL50mkqyDqdTar6QgiDdYKzkhh48YXE1igczaO4i3oaJ8
         IXf8LmrzdFWhh6jzKhfRYDBYs2ZYscl9GstinQ3v1PvzJriee0fH4XTSGRkOdBzHU4MD
         V+dzUFeJ1QS27GTg4q0KrFjvoL44c5uFi+nsEGkbNnWAqT9kb9UKacGEHWSvkShBMgKE
         1Oft8epUxq2zOWZk+7aw629S2JJXbxOY8GXFUj9DjYfOhgOll41K1B0+ho6GslphIeqY
         vb8fblGowOXiIfzP4rLTWDmGEVEnQlxjIOOb9YR9m9GjtD6mJY/bzphcayWf6k5oEe14
         Ns1A==
X-Gm-Message-State: ACrzQf0LM6qaAG0f7Fy3XWr46PE/84wGmIetBJ0FVBG5YR954qSLtgC3
        k9rXXRsrGyrF/95tNF5lqVaifYruJSWiiQ==
X-Google-Smtp-Source: AMsMyM7aZBwmnOQaMKYMww1thIRvLjyiBjPkD1azfYPOnr2//Eyj2e0j+qLVme8PE1t+Bz6rowqokw==
X-Received: by 2002:aa7:810a:0:b0:55b:674d:d123 with SMTP id b10-20020aa7810a000000b0055b674dd123mr27740591pfi.52.1665519801056;
        Tue, 11 Oct 2022 13:23:21 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id 24-20020a631558000000b0045feab454f6sm6387757pgv.51.2022.10.11.13.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:23:20 -0700 (PDT)
Date:   Wed, 12 Oct 2022 09:23:14 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v5] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XQsqdRzlrSpgOh@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210111305.743F591@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated. So, replace one-element array with
fixed size array member in struct dlm_ls, and refactor the rest of the
code, accordingly.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/228
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

v5: use preferred sizeof style. Req: Gustavo Silva
v4: resend patch using the right version number. Req: Gustavo Silva
v3: replace one-element array with a fixed size array. Req: Kees Cook
v2: patch resent as I had an issue with a <CRLF> char in my mail client
v1: https://lore.kernel.org/lkml/Y0ICbf8tCtXMn+W0@mail.google.com/
---

 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lockspace.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index e34c3d2639a5..94fadb619ba0 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -670,7 +670,7 @@ struct dlm_ls {
 	void			*ls_ops_arg;
 
 	int			ls_namelen;
-	char			ls_name[1];
+	char			ls_name[DLM_LOCKSPACE_LEN + 1];
 };
 
 /*
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index bae050df7abf..9479c8110979 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = -ENOMEM;
 
-	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
+	ls = kzalloc(sizeof(*ls), GFP_NOFS);
 	if (!ls)
 		goto out;
 	memcpy(ls->ls_name, name, namelen);
-- 
2.37.3

