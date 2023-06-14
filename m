Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777BC730150
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjFNOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjFNOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:10:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD942172E;
        Wed, 14 Jun 2023 07:10:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77af8476cd4so178208339f.1;
        Wed, 14 Jun 2023 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686751837; x=1689343837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EFqDBymjnrg4NwoYw1AsL6XQWFNl4ijxcr5nw5uo7uk=;
        b=ba5b1E41ZzmCWgWj9xvmsDXT2POHtJ9sY0iAOt8dpCd3s0cy7MsEeLqQYcAFiTKcRt
         NGU0atLJNmknPaU0J473UyjDr3L0NuS+odp8e09X0ZkrFN6hVOddqu6hyyHLr8SNaYch
         E+UQj/At7e5Gq8KKprV9j1NHTt8D6Zfg5e/lPWqrcskJh+kgJKtlu2HTQfV8G7S+k+d8
         x3SZSE+K8lITcqn3bb6irFAgRZSu1ylEjg4gRtrV/UwcNSR4WNccVtJCQpY7WSBPz7yx
         +KItyWh1AeJ2EXrGO1MWG+A9lXJm7/c2T5xMh6IP1lSG2S6fGlKvKVSFH3KtSoBGxjSb
         kF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686751837; x=1689343837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFqDBymjnrg4NwoYw1AsL6XQWFNl4ijxcr5nw5uo7uk=;
        b=U+8aQ+kH4L4TVQKmgatNZPCRADc8KudWxlJGxCZ4ACOgMGeIXlfCoGaXl4ZNMb5p5d
         e0lpIn7I6YiU/RBw/9MT6GbTIT7nWW4PkKyl0vsoEf1uhES/rLAIwU3G59chGpbqSFUe
         6qMlKtK4mOT9zT2DgDld+Ge0AjQm4B24ZVDBZkoF5f1fiwDKgv4c7gZl9YLyAIkpUfqJ
         6VOq3nHl+aH6/5JuleoGRtmcvOGDPaXhroBmDPII85Jgx7kZYih2D1Bwr2idHQQc4JsP
         u+JaKByxaEEEA3aUjlszmpJ09qfcqiuV6oTE6YOKLkdX5nyk1zxsSb2hAOlM2DM8YngA
         7TKw==
X-Gm-Message-State: AC+VfDzhKbcqWSAHD6xKYwpfi+jqy8+p4QUhTmFRZ71Kks/oikJQRBOY
        /FAsijN5b12O/MyMpznRZs0=
X-Google-Smtp-Source: ACHHUZ5zK/g6fDr+RnGrZbMo8d+eU2180CD7C5X9hGOJw+qoskZPQtquR9ZL2faCz8ghJrM7LfsVxg==
X-Received: by 2002:a6b:5b10:0:b0:774:7f35:657a with SMTP id v16-20020a6b5b10000000b007747f35657amr13534215ioh.10.1686751836997;
        Wed, 14 Jun 2023 07:10:36 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id eq14-20020a0566384e2e00b0041631393ac9sm5062790jab.18.2023.06.14.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:10:36 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
Date:   Wed, 14 Jun 2023 14:10:26 +0000
Message-ID: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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
v1: https://lore.kernel.org/all/20230613004402.3540432-1-azeemshaikh38@gmail.com/

Changes from v1 - uses "< 0" instead of "== -E2BIG".

 drivers/usb/usbip/stub_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index e8c3131a8543..97043b4df275 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -174,8 +174,7 @@ static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
 		return -EINVAL;
 
 	/* busid needs to include \0 termination */
-	len = strlcpy(busid, buf + 4, BUSID_SIZE);
-	if (sizeof(busid) <= len)
+	if (strscpy(busid, buf + 4, BUSID_SIZE) < 0)
 		return -EINVAL;
 
 	if (!strncmp(buf, "add ", 4)) {
-- 
2.41.0.162.gfafddb0af9-goog


