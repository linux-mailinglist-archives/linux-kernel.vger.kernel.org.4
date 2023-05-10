Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAD6FE713
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjEJWNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjEJWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:13:13 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE807DBC;
        Wed, 10 May 2023 15:12:46 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3318961b385so77481845ab.1;
        Wed, 10 May 2023 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683756765; x=1686348765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANF2ojEn6NgL1D5sNhaC7YhuPd6wu0qnDYngj5pnPkU=;
        b=nEu9mUWoaNPoHYwPTUlOBLkE9eI5c+9gKv22yYXjwR7ORf8LbZFDqkEUGSW2agqm55
         Yb8DGVp0d7FAmN0p9viEbpVPduepM6jwLmA4JRJ2VU0XdYJiPTLwFLtV6BUZDEYh4gCP
         hAkDyM1EvORFtSlXmjwg7KhlbmotPuJITQVbsWz60AoU3o5+COesIGsGAsl1FMbaG9Xu
         YFaDUfu9USDW0/a4d84vD+wum1lsd0679vJusn0ilnkifxd2j6ytgcC8dqlWeLVDmDN2
         arLhepmewTkhOEuEy60R0Lg++bC86vlQlGzpvxYTtQCJKYQmUu6DlG+vNxE7bjN4xBqk
         VMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683756765; x=1686348765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANF2ojEn6NgL1D5sNhaC7YhuPd6wu0qnDYngj5pnPkU=;
        b=hDF8EGvdadHyYfM/pGnf1+1THtre/FIfYXV50hb+yEJISfj2wBfbBmJtzmB0taXF8r
         YD1mZuiVn/glYszhhdTNBKbGVvqPpTX4drlo9pBLyxr41Swi18cnl3oAdPdlviPTfK+D
         +kpLGEje2lA16Ijn9XaX5SApp2g2C0LNqj14MRqunGvg6rii9Uc+HbgQS490zpj7IC+W
         FOfg880IhN3w0WUBjDDbnD1eRCr+Tg3y58WjUi9PhNiPNpRUAnBBj8s2ELep8T2OM52P
         mVtSfanleCQROJ/Ff1WOwmoFrUflAtXeuuzwl2sWntGRacbMqG63VOvTUMHzktvq/nMT
         r96w==
X-Gm-Message-State: AC+VfDyAuCa6zIofiD2jtCx2rbCFGmntsM9QBXHOTK10DC9ouTo3i2Xw
        8mClo51q6DfdgJK4jdrPdsRDg8F7rLwmyg==
X-Google-Smtp-Source: ACHHUZ4Jhhks3fH3zcxryOSm0ZDL1Wf68o9U3wBGpEuGzWV3uQdUM4WI6wNLfJv2JD+Q7XeYK/0fRQ==
X-Received: by 2002:a6b:fe19:0:b0:76a:3481:2f17 with SMTP id x25-20020a6bfe19000000b0076a34812f17mr14670907ioh.1.1683756765327;
        Wed, 10 May 2023 15:12:45 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d8245000000b0075c1eb2e228sm3844485ioo.15.2023.05.10.15.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:12:44 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: Replace all non-returning strlcpy with strscpy
Date:   Wed, 10 May 2023 22:12:37 +0000
Message-ID: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/dlm/config.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index d31319d08581..2beceff024e3 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -116,9 +116,9 @@ static ssize_t cluster_cluster_name_store(struct config_item *item,
 {
 	struct dlm_cluster *cl = config_item_to_cluster(item);
 
-	strlcpy(dlm_config.ci_cluster_name, buf,
+	strscpy(dlm_config.ci_cluster_name, buf,
 				sizeof(dlm_config.ci_cluster_name));
-	strlcpy(cl->cl_cluster_name, buf, sizeof(cl->cl_cluster_name));
+	strscpy(cl->cl_cluster_name, buf, sizeof(cl->cl_cluster_name));
 	return len;
 }
 

