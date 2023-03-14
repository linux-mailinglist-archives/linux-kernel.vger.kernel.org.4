Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445D6B9C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCNRC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCNRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:02:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96419A72B7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:02:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x13so17461115edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678813343;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mp/3OWy1+y0oHAVYkTTzfHc7MJx/ilObMWuX4i33Kk=;
        b=GBjOF4DhF++AnKprSkfl6OdjZHJMIf83Eoar1Ui5osd0g7OBLqdjXLXVbA39jZsRtB
         btR+38Qofs8nqB+SWtZ/1LfpN4kodGPw0lzdGj4xb6x8Nvt+syxqpG6FICoU2hf8AXLR
         SB9jBnazPzFzqDA19YuJMiXzTfZ1FuzemC2RzaBVV4Tc3wtPrQ/lcf4dxq6wIS4Hb2qZ
         mBq2iv7rFtSNxssIN+4HR6H+gIYxqEQoLnNiczSuFuNJKAhyiaoEfqCM4otOIbI26wB0
         xFLPcu+/544LgDpz/ho+HgYOWAWQVK5lPo5Ur6eq6tAz0LslpWvMh98Wqvg4aowGwMvK
         BQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678813343;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mp/3OWy1+y0oHAVYkTTzfHc7MJx/ilObMWuX4i33Kk=;
        b=RVdvLAlFtKsiPy7wm8handRG+Bd4sP2oBWpyqEtKO6iypzM58drt/a3Dux2U4WlBYa
         pJV2PcYf/QNPhb2uT8viQiFXnr9KcInh/S4hmZLBql1caH4COUaq5ClUjJxzSbDo+QEI
         GmyiNqkzsLsO+eeH1VsbJmwHl8habD28+mbhnZFvFv4L6S1CCAXtbXie35ip11KYhQ1O
         t8vJTn1zjo4/ZxV6bIdofKqfD18D1Md+eMgJrkpqBULeH64yUOULTMdjRGAY0/tUpcho
         CLN5Y4MNwEPlPLZ4SwEiUiJSVUxgw5GgPzL+d6n4M5C3pFS8dRlKxnbED60ogunSpi+n
         Zbhg==
X-Gm-Message-State: AO0yUKWsXxNHikW49uX+YPDd3+k2V/+zakvBeZLy9TFoCiCWTKUElX/1
        i/IwJlhUVnfLtCa5+mKmxUbGK/BJzw==
X-Google-Smtp-Source: AK7set/Hy4k6drNRG1rMrPUJBhy8I5Gqe6QKk0iSjp8hBjm6vwpIDHPu7dMWY3LPzhWGZm8rhWNjXg==
X-Received: by 2002:a17:906:4447:b0:8e6:d08d:f5e8 with SMTP id i7-20020a170906444700b008e6d08df5e8mr3145334ejp.11.1678813343022;
        Tue, 14 Mar 2023 10:02:23 -0700 (PDT)
Received: from p183 ([46.53.253.24])
        by smtp.gmail.com with ESMTPSA id a2-20020a509b42000000b004e48f8df7e2sm1297251edj.72.2023.03.14.10.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 10:02:22 -0700 (PDT)
Date:   Tue, 14 Mar 2023 20:02:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: document some de-facto PT_* ABI quirks
Message-ID: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
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

Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
segment headers are slightly different.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/ELF/ELF.rst |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

new file mode 100644
--- /dev/null
+++ b/Documentation/ELF/ELF.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Definitions
+===========
+
+"First" program header is the one with the smallest offset in the file:
+e_phoff. "Last" program header is the one with the biggest offset:
+e_phoff + (e_phnum - 1) * sizeof(Elf_Phdr).
+
+PT_INTERP
+=========
+
+First PT_INTERP program header is used to locate the filename of ELF
+interpreter. Other PT_INTERP headers are ignored (since Linux 2.4.11).
+
+PT_GNU_STACK
+============
+
+Last PT_GNU_STACK program header defines userspace stack executability
+(since Linux 2.6.6). Other PT_GNU_STACK headers are ignored.
+
+PT_GNU_PROPERTY
+===============
+
+ELF interpreter's last PT_GNU_PROPERTY program header is used (since
+Linux 5.8). If interpreter doesn't have one, then the last PT_GNU_PROPERTY
+program header of an executable is used. Other PT_GNU_PROPERTY headers
+are ignored.
