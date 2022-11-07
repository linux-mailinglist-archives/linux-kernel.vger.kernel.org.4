Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B361F2E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKGMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiKGMXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:23:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01DD62
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667823759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UkKO48JHU7AdpIz5HqGu/48iS0PHjFOMt3eONI773Ns=;
        b=i9qvyZfYWmn7qOcsOBbFAuE4tBlFPWQXdndjAsoFLcM1poPRb0xnJJb0NXlK9vj9gJzZNF
        A7nVMwEUcTYTK5WvAEAzc43jbX+31RsjhAHSdvIRH8vYbYLgXFq9yzW18hLxYb7E/99nQ6
        bbTznkz7yitgQbOwCoGWfMRH5/uZETU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-SVuT1sBjMZGt4Y9bDh-Rcw-1; Mon, 07 Nov 2022 07:22:37 -0500
X-MC-Unique: SVuT1sBjMZGt4Y9bDh-Rcw-1
Received: by mail-pj1-f72.google.com with SMTP id ch8-20020a17090af40800b002140ba517b6so4510966pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkKO48JHU7AdpIz5HqGu/48iS0PHjFOMt3eONI773Ns=;
        b=KGWZuPsmk2PO1JC60S1LIjxTEjcgE86RrIE4XzC89Shpt6Zcvlk6uxPCJ5Lj9J5641
         7TVPQCTuZQg4VbD9kC3Lh57jI+STbaYrwhYt7kdAByUN0WvXIusWpVdn9U5KRi7lYNgj
         A/NpG94yHymbitNvFeVhflSzJZPYMJwRPt1pZG91odSExLwD+//teN5koy7vJ4EeIfqZ
         1Mm8Og/fol8Z2CFIy75BklEWYP77vu/aci6PrrsKKZYQnMBczHAsvhe7fhpXlx4uLdSZ
         /IsReCkzUz/hA+K6vpZKgHFxDsY4e9aqAoxsjk9RwPiAxqLhU0PPiwQv7nfLNmKanXDp
         XP6g==
X-Gm-Message-State: ACrzQf1RZUf/CQXpRgKhMMaie+ZXhfsRk3qLwRN6vSYcpamTbSBznxDE
        rGPbF+Ehf8Fe4ViRYZJ8C581g1lV2Q+0ukqaPjQKpEy3wMa6yxMgX7z2M1/H3pUxRYYemOattZk
        tjdyTFmRjj6ISz2bBkpShVUJL
X-Received: by 2002:a63:1b16:0:b0:46b:8e7:3e0a with SMTP id b22-20020a631b16000000b0046b08e73e0amr41957601pgb.86.1667823756882;
        Mon, 07 Nov 2022 04:22:36 -0800 (PST)
X-Google-Smtp-Source: AMsMyM54z0KpX6BrG0jb5HceqF99cLDbTVANVh5EEu2lAH1NfSs1sTekzka5M0bm/WOXysXAK/hMyQ==
X-Received: by 2002:a63:1b16:0:b0:46b:8e7:3e0a with SMTP id b22-20020a631b16000000b0046b08e73e0amr41957580pgb.86.1667823756640;
        Mon, 07 Nov 2022 04:22:36 -0800 (PST)
Received: from localhost ([240e:3a1:313:8350:fe71:9f84:6361:a65b])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7940b000000b0056bf29c9ba3sm4521881pfo.146.2022.11.07.04.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:22:36 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     dm-devel@redhat.com
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Milan Broz <mbroz@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dm-crypt: fix incorrect use of strcmp when telling if there is no key
Date:   Mon,  7 Nov 2022 20:22:33 +0800
Message-Id: <20221107122233.261096-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
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

strcmp returns 0 when two strings are equal.

Fixes: 69a8cfcda210 ("dm crypt: set key size early")
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/md/dm-crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..cfefe0f18150 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2590,7 +2590,7 @@ static int crypt_set_key(struct crypt_config *cc, char *key)
 	int key_string_len = strlen(key);
 
 	/* Hyphen (which gives a key_size of zero) means there is no key. */
-	if (!cc->key_size && strcmp(key, "-"))
+	if (!cc->key_size && !strcmp(key, "-"))
 		goto out;
 
 	/* ':' means the key is in kernel keyring, short-circuit normal key processing */
-- 
2.38.1

