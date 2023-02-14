Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED813696A44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjBNQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjBNQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:48:53 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C521C976F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:52 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d21-20020a170902cb9500b0019ab46166a3so1863846ply.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrJQ2wDw2LHf9efJZF0CvF6CmGL/52JTDCIgIS/uJjo=;
        b=IKFwvbb3dinO6WmpEYEZwVado7b2ZjuvmuubAEs104eU9ZB+6TV1svRGGeN7EPzrT8
         tSekFngm37JSLBSmqfU3ibD7OwxY98scdplDVEvZp8xzXfYccp5//WbeV14uaWqRp9CA
         xMAUrk81o6xUduIE0ewZRtMiVhGBndweBM322wcvZm47+N0A0U1T2WouX/YEOd+0U/yP
         Rg06nO/0x8Ac7MEWOIgVOg4tLQuhgHjf+JbYUMUM0lqk9MXix53e0YdWRy8MbPq6SWm9
         G+RnkKQ/W013ZJ3l4Awo+2ih+6lxSf/A7OgiH59Otuf5ye/jJkOKiy83OTedQZ1GTu9a
         1gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrJQ2wDw2LHf9efJZF0CvF6CmGL/52JTDCIgIS/uJjo=;
        b=NMWRdA/aLfbs4hb7qiFyy4ypNa6n5uc/xIBD1bwmHVzsDqnI4NsvhqSku6swf4mr0o
         zCoWuDUjLF3vGeMYIYPCKBrCLtdnLh5xBlyeQoxaDA8CIwAjrD5RdUOu0O+KKr+zi7S9
         UpFvoc5Z7MDtq/MoKCEUIv5iTXtBTmivEIZHw6gsqD4dcJB+BnooqoQZz+PATX7krd0S
         Sa4NEUFU3hIOPfDN149oveAQ9jXGm8TpWYbsBrM2zj1bhuuYhxHzyMYmfRM6MoObUe7z
         9df6fodw8QOg4/QF1wawkXcU51NfS4TpPXwIPObJR6pqM/uwyv2e3cSbtt65kI177aDu
         cXEg==
X-Gm-Message-State: AO0yUKVf7Kqy23PHplomP3z3bWX1+ka/r0pKjbkLGzb77kVi9A5l/rad
        saFNdOEvJh6ywZ78fElYKYQ7NPMGpjB4kFOdFe1kUUaEvoP7YntBMQPaoiASTsiPNHtSYBNga8L
        ck68njKZBC8hJpuMdibgg3R8qkIHmztAE3C4a1VOQH3bVbJYfHv0aPXKur9owcRYxGI+kSmy7w7
        pKZRit+fk=
X-Google-Smtp-Source: AK7set9axnAnXYz0NGmRmX1hq+CElbkNVSC7MbnHJPt46WHf6/z5W5PU9VcDtl7dwbTWJoA+XKit+e1L/0MLhnjmCQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a63:3502:0:b0:4fb:98ef:e33 with SMTP
 id c2-20020a633502000000b004fb98ef0e33mr4474pga.12.1676393331947; Tue, 14 Feb
 2023 08:48:51 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:46:37 +0000
In-Reply-To: <20230214164638.1189804-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230214164638.1189804-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
Message-ID: <20230214164638.1189804-4-dionnaglaze@google.com>
Subject: [PATCH v15 3/4] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>
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

From: Peter Gonda <pgonda@google.com>

The PSP can return a "firmware error" code of -1 in circumstances where
the PSP is not actually called. To make this protocol unambiguous, the
value is named SEV_RET_NO_FW_CALL.

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: John Allen <john.allen@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>

Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 Documentation/virt/coco/sev-guest.rst |  2 +-
 drivers/crypto/ccp/sev-dev.c          | 22 ++++++++++++++--------
 include/uapi/linux/psp-sev.h          |  7 +++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index bf593e88cfd9..e76393e389eb 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -41,7 +41,7 @@ The guest ioctl should be issued on a file descriptor of the /dev/sev-guest devi
 The ioctl accepts struct snp_user_guest_request. The input and output structure is
 specified through the req_data and resp_data field respectively. If the ioctl fails
 to execute due to a firmware error, then fw_err code will be set otherwise the
-fw_err will be set to 0x00000000000000ff.
+fw_err will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 06fc7156c04f..ac205f78a595 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -440,12 +440,19 @@ static int __sev_init_ex_locked(int *error)
 	return __sev_do_cmd_locked(SEV_CMD_INIT_EX, &data, error);
 }
 
+static inline int __sev_do_init_locked(int *psp_ret)
+{
+	if (sev_init_ex_buffer)
+		return __sev_init_ex_locked(psp_ret);
+	else
+		return __sev_init_locked(psp_ret);
+}
+
 static int __sev_platform_init_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
-	int rc = 0, psp_ret = -1;
-	int (*init_function)(int *error);
+	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -456,15 +463,12 @@ static int __sev_platform_init_locked(int *error)
 		return 0;
 
 	if (sev_init_ex_buffer) {
-		init_function = __sev_init_ex_locked;
 		rc = sev_read_init_ex_file();
 		if (rc)
 			return rc;
-	} else {
-		init_function = __sev_init_locked;
 	}
 
-	rc = init_function(&psp_ret);
+	rc = __sev_do_init_locked(&psp_ret);
 	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
 		/*
 		 * Initialization command returned an integrity check failure
@@ -473,9 +477,11 @@ static int __sev_platform_init_locked(int *error)
 		 * initialization function should succeed by replacing the state
 		 * with a reset state.
 		 */
-		dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
-		rc = init_function(&psp_ret);
+		dev_err(sev->dev,
+"SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
+		rc = __sev_do_init_locked(&psp_ret);
 	}
+
 	if (error)
 		*error = psp_ret;
 
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63d5cbf..e8cfb8bde0d7 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,13 @@ enum {
  * SEV Firmware status code
  */
 typedef enum {
+	/*
+	 * This error code is not in the SEV spec but is added to convey that
+	 * there was an error that prevented the SEV Firmware from being called.
+	 * The SEV API error codes are 16 bits, so the -1 value will not overlap
+	 * with possible values from the specification.
+	 */
+	SEV_RET_NO_FW_CALL = -1,
 	SEV_RET_SUCCESS = 0,
 	SEV_RET_INVALID_PLATFORM_STATE,
 	SEV_RET_INVALID_GUEST_STATE,
-- 
2.39.1.637.g21b0678d19-goog

