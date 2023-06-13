Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD572D687
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbjFMAns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjFMAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:43:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E1E7A;
        Mon, 12 Jun 2023 17:43:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77acb944bdfso313120239f.0;
        Mon, 12 Jun 2023 17:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686617024; x=1689209024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUjTXpZGWUl8aPCIqnXmDVJiFmEW7gMN7vp18gmwoYo=;
        b=IXpe7Emrl6ko4LD7DQoZAwv8z0/KdLITExfmWAAXsA+D25C04eyN8asLgKPw0QqTfy
         sbei46gpq/X8JWoloCKU7vFBGj5+IoPn9Rz3Z8R/0fdIHlSLqXNik/g+VPAmrEu+5AbB
         6gJaFwKYe4TiOcbpftpt7Ypd9DtTxGTZAHDLEqUY7Mv67eCMoLIVBy9pjfWgifdggQgf
         t/vUE67hyFRErw1hAc0o7OU3DPWaNlwfdvH3cy/m95/Po20ZkyrDTbJkcrbyA4KZjsQy
         /M9vU9XR4ArJegue/6zVWkk7mdyKDsbCdlRbMzzEw67/PSfwCN43R09lMxj0LCIrbAF1
         RD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686617024; x=1689209024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUjTXpZGWUl8aPCIqnXmDVJiFmEW7gMN7vp18gmwoYo=;
        b=gs4TyjkBxVn6UJ68GkD9DzG61MlWHajcAcI4i41c0lz46q3ZiCh1UPwTTLx3fwiNiR
         uA4NRmmWiaxTT0s7fo7ZLD0K9W2Og+ePl8f8Cukd2NE3yRiolBaxQWUNp8Dnhb6U0EjY
         OD+OsWOtlJvzf62u2JfRrtpm2aKiBLgk6AjSt1LAuY6/eWTMHZmIrcqYx9PkxJzXlNmZ
         0ghz6NQxjZ8UNrc60AauG0R0GVV0BVTU7VAGjDMcGfkGmBmvrHktZW/SkKxn7tw5pETN
         92kys7sYsehCrCY7hJNNH8zEzTlZX2IBAL3szoDpPYYFdu/J3G97NDGjwOrWXPWm4lgj
         9JCQ==
X-Gm-Message-State: AC+VfDyQXW9TckVFeC7Cbs2c9AbQR0l6J/PgLvxyi8SIKL5gArLq6zU8
        5cOfB2nLRD6LNef80XgmDDs=
X-Google-Smtp-Source: ACHHUZ7i6GSt2jdKr3j5yG/4NXkXwOGZEJuQD6eDvRYDUL6sL1IEo1hSDkdoL5M6ydeOg6lrivBmyQ==
X-Received: by 2002:a5e:c64d:0:b0:777:b464:6ff9 with SMTP id s13-20020a5ec64d000000b00777b4646ff9mr8880457ioo.21.1686617024076;
        Mon, 12 Jun 2023 17:43:44 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id o11-20020a056638124b00b0041643b78cbesm3118861jas.120.2023.06.12.17.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 17:43:43 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Briscoe <albertsbriscoe@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH] usb: gadget: function: printer: Replace strlcpy with strscpy
Date:   Tue, 13 Jun 2023 00:43:41 +0000
Message-ID: <20230613004341.3540325-1-azeemshaikh38@gmail.com>
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

Direct replacement is safe here since return value of -E2BIG
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/usb/gadget/function/f_printer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 28db3e336e7d..10dc7c55c25f 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1211,8 +1211,8 @@ static ssize_t f_printer_opts_pnp_string_show(struct config_item *item,
 	if (!opts->pnp_string)
 		goto unlock;
 
-	result = strlcpy(page, opts->pnp_string, PAGE_SIZE);
-	if (result >= PAGE_SIZE) {
+	result = strscpy(page, opts->pnp_string, PAGE_SIZE);
+	if (result == -E2BIG) {
 		result = PAGE_SIZE;
 	} else if (page[result - 1] != '\n' && result + 1 < PAGE_SIZE) {
 		page[result++] = '\n';
-- 
2.41.0.162.gfafddb0af9-goog


