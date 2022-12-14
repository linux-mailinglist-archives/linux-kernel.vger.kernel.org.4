Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108A764D13D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiLNUcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiLNUcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:32:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89E5436C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:21:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t5-20020a5b07c5000000b006dfa2102debso1098889ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L22LQH7KmOjrT8G6djNy9I40Y6DACrH51I/z1yt47rc=;
        b=UXt16BrghWlfjJ3XF28huqJShfounRuXVxB3uz3pPGPcotNdlL2dNrrOF5OwG3WvTt
         7fgw/t0HRdPYJAl48IqtiQ3QRWCzeJZozMRHvgzy97kLH8vWOkBNK6Hd+2UeQzPo/kLZ
         Xq+FAPFw8iWaFFifDrqEwYCRDMwY8Xsgd4b3FPUqP0MPS9FsW/vVNeeZ9IyLQ63P8XRM
         Jw7Pwrx7WNqbEbmY2mO0Nm4MdgutDRFg/T4crCr2s/m8G1BP3+0ISXdsrYdlxo69VWy8
         e174P5Io5tr8AuA8LO/U9kGHNroBuh0mvPHmAbW/eJtHybSPiucqDw0huwjzo60NqAm9
         0o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L22LQH7KmOjrT8G6djNy9I40Y6DACrH51I/z1yt47rc=;
        b=4ZrsszsbAx7ZqImgcPF5itZJhhHHRrWUAIS9H9TPNV03uX90o/FhZoq8awgb9yyCE1
         xmIPXvd9L1xVDWjgQkJlo9vSat2ykN4HOLikREXhI04XAbVph6Ay6seKSTLlzUa0ejzm
         T/xkDVeedmYmWCrIbThSNjsxY9as/BPs2yxwY+xPucQs91pSDhurIIebRnu18ZgpfJcl
         I01AydfOReLn0o7chEATNueGM9gMrGmqOIuauUpwAVb7rlyv5h+NkJc1jJHQL9NH/3F3
         VuC5VWO7hvUqWU5LjruXYBUfvEpQHOtXEcYJUJJ2rhRdj+jn5C96K+Z/ZivUcT7f8/fZ
         tZ/Q==
X-Gm-Message-State: ANoB5pkFrJrvgEY0oZob9cf22ozttbwiFnEG74BzsgrScT5q8GXM0aSc
        zPYWReclt9TZ8n6SHAjgtQgCyyQI4lY=
X-Google-Smtp-Source: AA0mqf5er0t0Z6NzSbBwHoupkBE/aAiAby9eU++DWgEG66GmPY5p0RGLfP+wTFkJgGI5Yje4G0waeky+4Wo=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:19c4:743c:e0e0:b558])
 (user=pgonda job=sendgmr) by 2002:a25:8743:0:b0:6f0:c9e7:68bf with SMTP id
 e3-20020a258743000000b006f0c9e768bfmr68411640ybn.78.1671049262522; Wed, 14
 Dec 2022 12:21:02 -0800 (PST)
Date:   Wed, 14 Dec 2022 12:20:46 -0800
Message-Id: <20221214202046.719598-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH] crypto: ccp - Limit memory allocation in SEV_GET_ID2 ioctl
From:   Peter Gonda <pgonda@google.com>
To:     herbert@gondor.apana.org.au
Cc:     Peter Gonda <pgonda@google.com>, Andy Nguyen <theflow@google.com>,
        David Rientjes <rientjes@google.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        John Allen <john.allen@amd.com>,
        "Thomas . Lendacky" <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently userspace can ask for any uint32 size allocation for the
SEV_GET_ID2. Limit this allocation size to the max physically
contiguously allocation: MAX_ORDER.

Reported-by: Andy Nguyen <theflow@google.com>
Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: John Allen <john.allen@amd.com>
Cc: Thomas.Lendacky <thomas.lendacky@amd.com>

---
 drivers/crypto/ccp/sev-dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 06fc7156c04f..5c16c4406764 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -878,6 +878,10 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
 		return -EFAULT;
 
+	/* Max length that can be allocated physically contiguously */
+	if (get_order(input.length) >= MAX_ORDER)
+		return -ENOMEM;
+
 	input_address = (void __user *)input.address;
 
 	if (input.address && input.length) {
-- 
2.39.0.rc1.256.g54fd8350bd-goog

