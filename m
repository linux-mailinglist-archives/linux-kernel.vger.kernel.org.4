Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144A0731FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjFOSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFOSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:03:38 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E32C294D;
        Thu, 15 Jun 2023 11:03:37 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77a62a84855so330088639f.1;
        Thu, 15 Jun 2023 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686852217; x=1689444217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WO4wvoymcuMAWNuPabTIQ60hnmsXdbnj1sWoVRdUjgU=;
        b=Q8rKplw1MdaA++C3yfoH/jMHoQRAjJwQ/Fx4HqfOtImtfsD0cokp/bK9NubdEPN0S3
         lVi/CSVeKs3vS5C1pXcJIaY/eEvRTpDPNJuxiUSti98+ZkxRIRUPD8/divXb8MIGP+rr
         YRH3TbNOsP3yzMIxSvxmxx7kuKNn/5Gp7kYHq4H3TS+zjurXlBA0HtLYLkulajaLP/g7
         tQoaFNCtG+1k7hXKr9oZrz+GTJ65LC3WiQF7UBFJXweQfkZLRO/Sdxdk0+dmZce+QasM
         VvxUmTXjhISrfONox49AauPTTUEuu4/o50oMy78PZMl5fBTk/TbHRF92BJOUzl64ANRY
         +Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852217; x=1689444217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WO4wvoymcuMAWNuPabTIQ60hnmsXdbnj1sWoVRdUjgU=;
        b=SipQg2Pzaegni1V+L22+/8wEXSkDFz6i4Mj8s+D1raYW8bOri8VK7wjwYwepqhbpLd
         uQRAIG3L5DsApBzGZ+vxKZw4MRE4JigsrV48PqM24mPWKERcZjeOYVO5pIg9qC6Dq/7J
         V5rHG71DEbeIhNpSO0qVqqbSd56fzj7yAA8PrktsOBqI0QYuXjbqbuTgQjD4v7Th+WA5
         BUZ7L62OfFhrvazYjdYaatFCNGS3TQlbwahG+M5wE9ljwgtYajuvnohUolL8YAjLP0hk
         x4NNWDyz0EzEfRKfYcVYSEDOnG3lAMgHPIFJDwkSsxqkl0s7D+qGHO4I6ZL7WXZZ+jcw
         HfkA==
X-Gm-Message-State: AC+VfDw1O0bn2KK1YiyjN85EuBM7Wv9X9DXUwFl/RRnU1Ya4XU8PLdnK
        3kOF2bmECjfw35yd+Cloc8UvwqTnIgG3pQzw
X-Google-Smtp-Source: ACHHUZ59/nicEQ8v5WP2ZpZIKHBGFfLebrsnAQ2jypcowPozX9jQwhD4cPS4Xl6AA2WyhvdMm2Ms3A==
X-Received: by 2002:a6b:6d0f:0:b0:777:b531:eb57 with SMTP id a15-20020a6b6d0f000000b00777b531eb57mr263791iod.1.1686852216625;
        Thu, 15 Jun 2023 11:03:36 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id l30-20020a02cd9e000000b0041d8acd35b0sm5732433jap.3.2023.06.15.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:03:35 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Briscoe <albertsbriscoe@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] usb: gadget: function: printer: Replace strlcpy with strscpy
Date:   Thu, 15 Jun 2023 18:03:18 +0000
Message-ID: <20230615180318.400639-1-azeemshaikh38@gmail.com>
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
is used to check for truncation instead of PAGE_SIZE.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v2:
 * Use "< 1" instead of "== -E2BIG".
 * Update commit log to say PAGE_SIZE instead of sizeof(dest).

v1:
 * https://lore.kernel.org/all/20230613004341.3540325-1-azeemshaikh38@gmail.com/

 drivers/usb/gadget/function/f_printer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 28db3e336e7d..b91425611969 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1211,8 +1211,8 @@ static ssize_t f_printer_opts_pnp_string_show(struct config_item *item,
 	if (!opts->pnp_string)
 		goto unlock;
 
-	result = strlcpy(page, opts->pnp_string, PAGE_SIZE);
-	if (result >= PAGE_SIZE) {
+	result = strscpy(page, opts->pnp_string, PAGE_SIZE);
+	if (result < 1) {
 		result = PAGE_SIZE;
 	} else if (page[result - 1] != '\n' && result + 1 < PAGE_SIZE) {
 		page[result++] = '\n';
-- 
2.41.0.162.gfafddb0af9-goog


