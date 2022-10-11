Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0316A5FBB33
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJKTP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:15:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD25491FA;
        Tue, 11 Oct 2022 12:15:24 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 3so12863493pfw.4;
        Tue, 11 Oct 2022 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edKKOOO5SuH1hvF3YhfEYTEEKOx9kniO7RvnTL4z9JA=;
        b=feEO4VhYQSWYHVL2uNHk31XxxIgvtfdcw0erpzFt1qt/5VfQ+nu+k/Q5bD43zofoB6
         S6rYf9aBiXUJVTvCsLWv6RfAQv9EBpnzn47Sy5O9fID3e5pTC1pff0IIAJYJ0yqWv03a
         9gRLkK11KOHz0/OFu1sxLUTmX5NH6gIhqLE+tt5ZNbQ3FaI7qqlGBsLmu3lwt3lLdrjV
         P6yzPWC+CyfyuSkCbnchW79FIz5A235fNSg/ZAjIRJce/zBpfeckDkyKkpyIIkZBxeJQ
         +zUTcNBKI5JpULdJfsChj5M7tdb33H3fpe/a4o7ghrOFYfOtWmBkbmX3/6hBQe24JIAx
         2xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edKKOOO5SuH1hvF3YhfEYTEEKOx9kniO7RvnTL4z9JA=;
        b=fbiULdxhYDVKsEvpgaQ7XGDJBdTDZwyGFuOuiWL4i08RSxxnUDgA/o22v1lA4LWkZ9
         O4gYsN+b9bGzil2+/4QQ9C9Tp36oSfTkNuX7fLEJZ+cgvCJSZepRNqvuB17IuOCfBgDG
         8Czb5f2M4+EoZzWtHX1cVdF9iLDWL4RtPTmREfP1BpJw8CK1fuNYx7qZZygGsC84IDPR
         Jyhy7mOFvzRC1fLrj2V1VUwuoR4WNSlDyDp7xYVnW7dX6Qd3L0fB11IoZnx5nfIV3bgB
         nbMB7ealQ8Ly3si66kEg+GYU/nOSm99MbhhrV3IGjHprpktffLmJfcItOVp4h7Pz0YIE
         X4vw==
X-Gm-Message-State: ACrzQf2oEZ8LfXnHDARzplRp2t7g4m1mKQerFQuen5Sdv9XeTlwloPHU
        hBQLnHMnX4rUS7TRMckxnwA=
X-Google-Smtp-Source: AMsMyM7zdApOlOum9a26wp9I+VCjgDp3iYH5QhsGbwtjii1hTZEHDAISUGSZTFksd37y/0kwW+IZhg==
X-Received: by 2002:a63:6285:0:b0:461:686a:f747 with SMTP id w127-20020a636285000000b00461686af747mr12817692pgb.403.1665515724412;
        Tue, 11 Oct 2022 12:15:24 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id i72-20020a639d4b000000b0044ed37dbca8sm8137242pgd.2.2022.10.11.12.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:15:23 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:15:17 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Cc:     paulo.miguel.almeida.rodenas@gmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] [next] dlm: replace one-element array with fixed size array
Message-ID: <Y0XAxX4g/9N6qdnD@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
index bae050df7abf..23de0d47cbc1 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = -ENOMEM;
 
-	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
+	ls = kzalloc(sizeof(struct dlm_ls), GFP_NOFS);
 	if (!ls)
 		goto out;
 	memcpy(ls->ls_name, name, namelen);
-- 
2.37.3

