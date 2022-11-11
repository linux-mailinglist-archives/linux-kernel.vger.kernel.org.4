Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B3625574
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiKKIhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKKIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:37:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26786315A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m22so10977873eji.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMeVhviS95T1ATK054u2qDdwy0bMtS+NUWOBe0eridQ=;
        b=iH9iTA5VKXpqT2HFYwETbz/+vaY4WLsnQs+IbfOUNUawdLJZBm/3smJ59KoKMj2V9G
         EpjPgn2TId1nY/N3qn0PJ2ae1VajgHPjXAm+/0kRJKYQ2nLYZQsgyQbvlmHeNQtgZ2Bu
         QAUnafvRC+dUfqju9fO+joNG0CfpmtAt1dt8h4+stcnVb2Wjq5ek9jerS9SJ6QWseuQu
         XvTVBHyQW9efizj6/Gi13K1XzN1F+qc8PG1FOIZYa6bama5yGzRM67o36B2LVbcsfciv
         WZq3wIijkR0DN15mSy3+XGQkpBcL9n3Qcq+of4SJfJv36TAtIazAongvCPLYkZcH1tpt
         c2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMeVhviS95T1ATK054u2qDdwy0bMtS+NUWOBe0eridQ=;
        b=Xy5hkvU9bZnrAnSw2lL1Nr9o2qnGA7nRrCgUM6jrDzqkFVNkyN8w2f/gCjGpyXHV3a
         nug/+QBfQlXZgzGecMSzdIykBkBMVWrqhirRbzpLhXTT/qJl6vEoGJWT18c5ilpRqr5K
         ViVtIun9I/nebmGyMoqz2C7lDnqA0Pkwh3G4igDKnPPvJpmHFTNnnk3HPod+WJKU7J6z
         ZBlAGOOmAS0QX6pBs+4SHsq0uF447JTKQchFL5U9c8bjM8bLWa6CONlp2oYJmriUZUGo
         t3gw321hu9ZHhOj/JwSTfC3iY+OareSxAEWlLdti4bonj3rn0BlyuEgJ0UaMzGhjk2vp
         Y+bQ==
X-Gm-Message-State: ANoB5pmNxsbo75C99qnyy9nFe5HQ4ZDzP/SmbwtdHd25dEUzOKtVzmY0
        QT9FpOi29xTKIsr3N7F7jfw=
X-Google-Smtp-Source: AA0mqf7XYO5CBBhMKAtXUNjLIJ8caar1m9Zex1CE3ThQYW7VTuLCA3XzQ/YMcq54hNtMTB5XqfeIOA==
X-Received: by 2002:a17:906:b891:b0:7a5:f8a5:6f81 with SMTP id hb17-20020a170906b89100b007a5f8a56f81mr959785ejb.570.1668155862529;
        Fri, 11 Nov 2022 00:37:42 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9a.dynamic.kabel-deutschland.de. [95.90.187.154])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007ae566edb8bsm643190ejh.73.2022.11.11.00.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:37:42 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: convert aes_cipher() to void
Date:   Fri, 11 Nov 2022 09:37:30 +0100
Message-Id: <20221111083733.3144-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111083733.3144-1-straube.linux@gmail.com>
References: <20221111083733.3144-1-straube.linux@gmail.com>
MIME-Version: 1.0
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

The function aes_cipher() returns always _SUCCESS and its callers
do not use the return value. So we can convert the return type to
void and get rid of another use of _SUCCESS.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 5bba57d18b5f..780019ce1b98 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -954,7 +954,7 @@ static void bitwise_xor(u8 *ina, u8 *inb, u8 *out)
 
 }
 
-static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
+static void aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 {
 	uint	qc_exists, a4_exists, i, j, payload_remainder,
 		num_blocks, payload_index;
@@ -1083,8 +1083,6 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 	bitwise_xor(aes_out, padded_buffer, chain_buffer);
 	for (j = 0; j < 8; j++)
 		pframe[payload_index++] = chain_buffer[j];
-
-	return _SUCCESS;
 }
 
 u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
-- 
2.38.1

