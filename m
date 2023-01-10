Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4EB66470F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbjAJRJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjAJRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02E4EA8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673370542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dsol8v/Y6ZKSi13JaYlImDhTwgtM/ldtPi7rslMNW7w=;
        b=Z/mAHg65jzeb8GcWGvnxChmJxpcpfssNnRNNkwgeY/BKC4HqqwGy6EBgDhb1mfWQAo/WpR
        oYBEj48hn/05w13kJ/3KBIAlqQ1dTjGkPio4txU8fMKS2s2+nzm2xUxw3H7JoiJkVe+UfE
        JH9y1r5DxbnZsy44s+GdVtXEIZKq/5o=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-J8VdFLNOPh6Ku4NMthhawA-1; Tue, 10 Jan 2023 12:09:00 -0500
X-MC-Unique: J8VdFLNOPh6Ku4NMthhawA-1
Received: by mail-pf1-f199.google.com with SMTP id m5-20020a056a00164500b005825b8d2723so5524799pfc.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsol8v/Y6ZKSi13JaYlImDhTwgtM/ldtPi7rslMNW7w=;
        b=fuHz1oOdl/XrEoFDuPStFOreYy8wjrIKonija3MzYgXWq1cS2TS+9y6IVK3IK0Tx3y
         SI2XZrRaWCIN8eDW8TuQZfGhF6RhLPXYQ7s0F5F/z/qnKrlzwjHstsKx+3rmBL6zGdZH
         sp982KaE30Uuh4LyN68QADOn1p923zIVun1IeC9TCsZzrHSvwcVofriN3iKAvyU3BQKM
         IokERdjrwsZu+bfJaUXGbpUXbSrSZG7e4X8Ijaz79x3EuIYKcpJ5BeTwasD2IFpTXeKD
         psWFEWEXhGlYOAezBnJk250UYfq9h4smWjgrSwbturVmXEy8Vq3nb3+gf3OLFjBGSa7b
         ibaA==
X-Gm-Message-State: AFqh2krugcglP0pMMHvsCYSfoguSxL0jnAV4LTFFLJIfBC6ZzxwlKUL7
        5VZKkPRHvL2PWsYyQ7RuAb9MxlclO2xoIWDTBVXDxp7cK0l7NO1Mor5NrlkKrlvKh8Nlz9MKe8C
        ZqEugQwi5JdNs2j8bB5Wv9zwO
X-Received: by 2002:a17:902:7fc2:b0:192:e2bb:c98e with SMTP id t2-20020a1709027fc200b00192e2bbc98emr21816359plb.6.1673370539502;
        Tue, 10 Jan 2023 09:08:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvef1/S8komThhaW5j6OMI0KSuDQUbOtSsCLVXNnWaNixCfpkyN2Bup+O3Pe2DgRCluN/6Xyw==
X-Received: by 2002:a17:902:7fc2:b0:192:e2bb:c98e with SMTP id t2-20020a1709027fc200b00192e2bbc98emr21816345plb.6.1673370539248;
        Tue, 10 Jan 2023 09:08:59 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b00189371b5971sm8386798plf.220.2023.01.10.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 09:08:58 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     brijesh.singh@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v3] crypto: ccp: initialize 'error' variable to zero
Date:   Tue, 10 Jan 2023 12:08:48 -0500
Message-Id: <20230110170848.3022682-1-trix@redhat.com>
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

Clang static analysis reports this problem
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
v2 cleanup commit log
v3 cleanup commit log
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

