Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C706A5C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjB1PfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjB1PfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:35:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40849B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:34:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so6123738wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VovafcFJLMznSEhxqQIdAu3aaQwbT+Bc2OZyFm12W78=;
        b=WZ+G9FgvRzOs0BBt44O6rLhuByH3MhNVRxr4YKxR/8amo0bAYoqG0ykytWpccXhw60
         e+9StVOtX7C25Y1g66RS3VdT+xYkJUBnayPR2wie5UIbSih6EYUr+3o1mdjVtD1erb4H
         saXAvuAk+ophZ4vU76/KAMEEftnGncUPTJyrP5zLOH7/x9N5VLybGCxLnKRhpXdNV5JF
         YONBsBp0uu9fT7nB/muYvkMOljnTo0krwIHdH8LEnRwAsDA+hOgxVlg/+gPKYj7VcwEN
         RchaU14LiIRsx81ttLTf01674djXvLvqo/4JYKDsotYsgV2YXDLmHUxpNzenDJjqeSct
         yQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VovafcFJLMznSEhxqQIdAu3aaQwbT+Bc2OZyFm12W78=;
        b=HpXzMP7gVq+157uXIcwVhsSZIeVDrwHHVaUof+KXEnOWd4yR/7efrRcxPYfZjVHuXP
         NOxGaoraJ/wtlYvb6eHpdWCgYmmBl8Na1QT/77zHsWt+qY8tTfXgxbOa78TRb8RIjHKG
         ofJlefhvw++UQOEpU0qs6j9gXjgbN01Ev1TdhRb+wPGjKUvFSAruSGncEIUKDp0l3KUy
         6xUMZcdyqPlbZIbQoQGbwqnYpjuOWImoK6V2LcYyBgKtjLxhnkBm74822wM+iXdrnrOj
         3HmWMBoifJdO8QLwMmZSeYW/lKBWeTODM5EMpZ+PG2nSxTwzm3IhiM/vbQdZb7E1KWa0
         7yyQ==
X-Gm-Message-State: AO0yUKUlc56t+JF/7DWwHc6rnD1KgyjQNxUnafk5qUU1x1YxHa7w9i1X
        7WHMXlWvQ6sfJOuHjMmc6FttYy46dw==
X-Google-Smtp-Source: AK7set8Ro7ZiI/xltPWObUrgVANiNpX8Db2KxTFQ5yXno4t67inuPrSp/x1WU1c4bUmqaOlCNHcZ6g==
X-Received: by 2002:a05:600c:cc5:b0:3eb:2de9:8af1 with SMTP id fk5-20020a05600c0cc500b003eb2de98af1mr2576923wmb.32.1677598480689;
        Tue, 28 Feb 2023 07:34:40 -0800 (PST)
Received: from p183 ([46.53.249.64])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003e0238d9101sm14586218wmb.31.2023.02.28.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:34:40 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:34:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: uninline kstrdup()
Message-ID: <Y/4fDlbIhTLNLFHz@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc inlines kstrdup into kstrdup_const() but it can very efficiently
tail call into it instead:

	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-84 (-84)
	Function                                     old     new   delta
	kstrdup_const                                119      35     -84

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 mm/util.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/util.c
+++ b/mm/util.c
@@ -49,6 +49,7 @@ EXPORT_SYMBOL(kfree_const);
  *
  * Return: newly allocated copy of @s or %NULL in case of error
  */
+noinline
 char *kstrdup(const char *s, gfp_t gfp)
 {
 	size_t len;
