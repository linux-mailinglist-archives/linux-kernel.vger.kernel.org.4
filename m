Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE17461C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGCSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGCSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:05:41 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B84B3;
        Mon,  3 Jul 2023 11:05:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-345a76c3a2eso19728145ab.2;
        Mon, 03 Jul 2023 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688407540; x=1690999540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xc58Ur2dGlcRpxmurRMRf+D6DXpC7t63Ku8gr49XadE=;
        b=f4wKtFMUv6J14dYTXrMSx0k6E7jglxt1xK14WAUWV0b766oNc+aKi21PdDxpQyIdTC
         XQfOAupMbERsYSknauHVLAiX/TL2AvSrVaBVhbahw1zF2Rzbqt1xyAUe4D+eBzSzzBsg
         a2QrwJhpHUnezr1uheh08eT5Q0rEBk7fVNW2VMeUIqPPfQdNUd4rUvfJBzR60zTnvhX+
         BsawhnL9a/3RudGMp4bM9bjibdQKHTTjdrbIEaKoxTcdw9PYQtvdrkeQIfQUAzIvw4tp
         yTIoRC5EUgwO9jERqZrPG2gXH7cDgkiMu4v9fsWBHxs6C+NK0nEXF5Az5ibbTMcV9Ppy
         DYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407540; x=1690999540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xc58Ur2dGlcRpxmurRMRf+D6DXpC7t63Ku8gr49XadE=;
        b=ZKLfD0hAqASVnTdmNV2B63B+BlfK3WCSdOiMSeXvBrkp6U7x54Q0cKD5a6z8obl/Pp
         4wS/VFmvB5lyIVGw4M8KKr25+y1wl855oiPIC232zdM0R6A0nX+x17aqto5O6Ko26USz
         c1SpJcpRcnQEriZALZXogrQRkwF9DJne9UofgnOykt02WIoxdBQFY9sS2+BRuUdO9OcS
         PkBj40ZwNlsWI6mhAiKI3h0fvvzJHhP4ZfpQPo6ElMVbxP8AnLJwPFWiTrXxikquQa2E
         vi54t2f5egADPfLQijXTG6/dlq7x0YH2YEhmhsqR8AKf47m7IOtBC+oIqeNWXN+K14PG
         z6Ag==
X-Gm-Message-State: ABy/qLY5MpxDbmVF6XtZaXkqHWsOQnzPgI05JPInKjM8l3jzN9QU7fmn
        h3ihIZ3erbpady5ADDerJfXF9Rsolr2HsizB
X-Google-Smtp-Source: APBJJlG26HFbuy6WLJJH3/OP3LWrbSl1RRU6w5AVIoR4xY3vw00eAhSCy/nKt20FFKarLU2DB9SjqQ==
X-Received: by 2002:a92:d9d0:0:b0:345:aee1:eaeb with SMTP id n16-20020a92d9d0000000b00345aee1eaebmr9743039ilq.11.1688407539649;
        Mon, 03 Jul 2023 11:05:39 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c050000000b0042b35c7b8c5sm1419054jam.61.2023.07.03.11.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:05:39 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: Replace strlcpy with strscpy
Date:   Mon,  3 Jul 2023 18:05:28 +0000
Message-ID: <20230703180528.3709258-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 lib/kobject_uevent.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..e5497fa0a2d2 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -254,8 +254,8 @@ static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
 	int buffer_size = sizeof(env->buf) - env->buflen;
 	int len;
 
-	len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
-	if (len >= buffer_size) {
+	len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
+	if (len < 0) {
 		pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
 			buffer_size, len);
 		return -ENOMEM;
-- 
2.41.0.255.g8b1d071c50-goog


