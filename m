Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DDE662DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjAIR4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAIR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:56:19 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A3E40C28;
        Mon,  9 Jan 2023 09:51:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so9008220wrz.12;
        Mon, 09 Jan 2023 09:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2L4Nx5qVuAviVSz8W0zvvT/84e//kF+LGBMYcQHzhto=;
        b=OAT6bNAVgnQlY6KivDvwimWCgYQAWlKSZU+FsNS+g1O58an01D5QYUB38PZkGtBBX+
         HQ0aSoY8+TgnzHpcBM9LJh0ySnmFD4xbmxZqKXUtYE2SOdBDBeyY9/cXu6MgS7hgnTEW
         3wVOnf02ZgPi8H+N1lG9t7CGSi5jl6JJ7fno+ern+drJQLIxnfOV8ckd9Qxc29Sf5vvQ
         BuB187f2XcDAmLtcgD6OzUcWuf7AvQwyU+/jxT7/La71KCQWp4zQTIfX8bgNNoNCO3rE
         gDuHnSHWENE1IY9C15MNUyOmXxsol6MO1dFrBp0P7wF04CbPw+O6jTsXefbKyJq+g/Ev
         plyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L4Nx5qVuAviVSz8W0zvvT/84e//kF+LGBMYcQHzhto=;
        b=3vZol5k0hC2L8yyHn6pfsDQTe1O20ZkfCsWBeFlg/KEXrLfe2KM04YpIhydTpTX5/8
         JB6/P7Oa16hEsbe/4lTHuQE5U6VHHFaYTo3IsDVLrUxRkCpJk1ZD0AUM9+krn/D9vCrZ
         dp9KLXHHTNzfOGBAxy9uTcTYTeIcbtas7KtvqgxWtFHqWxFMStNggbkR+fXdHD29XvW3
         AQDV0iLwxnXYT0BOtMgz1FOkC0f4GTRUtOhfBBaCRyaG5aqr9svWf5xlC+vaJLTGJn/7
         pkzHairrJo6ZB13mM3OjL8e9NmeJMRF0f2Id8gr9GQPmGLc/sweGQoz//JTid1TAJ8Qs
         nNOQ==
X-Gm-Message-State: AFqh2krP5rnJdeO2vcj3u5TL2xk01ioVpFY5rY8GdDAj6aS7aKpbByw2
        cV5BjXwMisUSA/fVE2WQ0Cc=
X-Google-Smtp-Source: AMrXdXvUK6A5f5l9Ckn5YqN3cLQ6zLmOpwGjk/W0rs5SIGBpOhiinBNYvloTHGDdkEdfNx2pD/+4fQ==
X-Received: by 2002:a5d:5269:0:b0:2a6:37a6:a071 with SMTP id l9-20020a5d5269000000b002a637a6a071mr12809819wrc.21.1673286718114;
        Mon, 09 Jan 2023 09:51:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm10678421wrs.0.2023.01.09.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:51:57 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pefile: remove the redundant pointer secs
Date:   Mon,  9 Jan 2023 17:51:56 +0000
Message-Id: <20230109175156.1572877-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer secs is being assigned a value that is never read. The
pointer and assignment are redundant, remove them.

Cleans up clang scan build warning:
warning: Although the value stored to 'secs' is used in the enclosing
expression, the value is never actually read from 'secs'

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 crypto/asymmetric_keys/verify_pefile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 7553ab18db89..a660e4d68d50 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -28,7 +28,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	const struct pe32plus_opt_hdr *pe64;
 	const struct data_directory *ddir;
 	const struct data_dirent *dde;
-	const struct section_header *secs, *sec;
+	const struct section_header *sec;
 	size_t cursor, datalen = pelen;
 
 	kenter("");
@@ -110,7 +110,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	ctx->n_sections = pe->sections;
 	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
 		return -ELIBBAD;
-	ctx->secs = secs = pebuf + cursor;
+	ctx->secs = pebuf + cursor;
 
 	return 0;
 }
-- 
2.30.2

