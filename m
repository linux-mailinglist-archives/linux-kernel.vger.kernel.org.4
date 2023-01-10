Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961FC66469D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbjAJQyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjAJQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:54:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D603140D5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673369602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kup4HOCIEU1szEBLKhvEmi75KAA9Nb/HeMnvSYwk5j0=;
        b=BeYGIxp8G7Uj7FTRWZ3nH6AcdIeFXtSift1R3PfUYX8DCUGRueqXBghqi9O4DYDeqVbpl7
        EppW633gGR5DrzYUCUIwLmFI3FsUddsft0ZvPlmP1x3M+oM3mCTdk01VVNmo9HDHWDLRzZ
        XchYwigR8NpEASmE2fXS/NgaeVwPccQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-n8pWfBRENF-4h4PauZbfig-1; Tue, 10 Jan 2023 11:53:21 -0500
X-MC-Unique: n8pWfBRENF-4h4PauZbfig-1
Received: by mail-qt1-f198.google.com with SMTP id z6-20020ac87106000000b003aeb099620cso2082220qto.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kup4HOCIEU1szEBLKhvEmi75KAA9Nb/HeMnvSYwk5j0=;
        b=Nd6JCTz8d4b7/w6WjVcGt62m8yg8Ctk+9WYkIWMcuste4h0V2kut3Y0BASX2N5H6Eq
         CbC6Q+nZ2NcbLk0T3pzwOYUtJifPCkM411bShME7U5pEXXpG6R714NqtHU374JaUJD4v
         sWddZoVaiOq1gIrXc2eQQPJKGaOGLnVphTGcU2MZ14NSTSnZG+a4nVwCF78DlZ2tklYd
         Xky4DgD2BjJAeaZzoJvIp/FvopiQG7VjBJlQf5bePTQqd1yHMGXy/tJJiTUp5wrE4t/g
         +nxtzjl8K5gkevPLVIokW9tXuNKSci7WrLHc53VW3og5ZY1yV0GpglgMLEeH5hSeyNed
         Yg0Q==
X-Gm-Message-State: AFqh2kq8IDTFH1lQrtUAiVCbMStA3WcJ+1b8naXBJvQ9Z83CCiEe42SQ
        TH3N5A7Ed7yS9hGrBEIgj7z5BUF4YG5LG2TZayUjD6ryst/JA1/XnmySZLBNHFzIMiF+42mNbLP
        eXzgJ9Bk6kgXdtILTOcltjxu6
X-Received: by 2002:a05:622a:1f06:b0:3ae:55ba:8392 with SMTP id ca6-20020a05622a1f0600b003ae55ba8392mr8544549qtb.32.1673369600684;
        Tue, 10 Jan 2023 08:53:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1gy+R4UVBxdneGHh2kFQ1PNWrp1or09a54OsiH2i2fXOwcKnmCac0ajbB6/JUU7bf9dSNdA==
X-Received: by 2002:a05:622a:1f06:b0:3ae:55ba:8392 with SMTP id ca6-20020a05622a1f0600b003ae55ba8392mr8544521qtb.32.1673369600490;
        Tue, 10 Jan 2023 08:53:20 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006fba44843a5sm7452833qkp.52.2023.01.10.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:53:20 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     brijesh.singh@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] crypto: ccp: initialize error
Date:   Tue, 10 Jan 2023 11:53:16 -0500
Message-Id: <20230110165316.2870300-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang static analysis reports this problem
drivers/crypto/ccp/sev-dev.c:1347:3: warning: 3rd function call
  argument is an uninitialized value [core.CallAndMessage]
    dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__sev_platform_init_locked() can return without setting the
error parameter, causing the dev_err() to report a garbage
value.

Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2 : cleanup commit log
---
drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 56998bc579d6..643cccc06a0b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	int error, rc;
+	int error = 0, rc;
 
 	if (!sev)
 		return;
-- 
2.27.0

