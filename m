Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13BF609052
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJVWy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJVWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:54:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB3EA9E8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:54:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 187so5075766iov.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORhdzvQEaSdepN8FuCdBMVAeS8RbuY3+hyzMb2MUCmU=;
        b=ptlBFuNh0CJbHnMl5CumWjpfc0nWpUgZ4XEP1PmmV/ultNfezZtEFUw7AChzN+ItNN
         wxEVFv3i5yU5MRYSKVoAKRNGW9NsHkN91PypPczHUDGNBpbnQYWVGd4DQarAaKRct5Zh
         SXtKFv2vz0OyM38mOkzvjBaQ1YUiiwyu6dX03MkUFhy4eCefs738RJYGJkr9IKXVUYl0
         kzk9RkuHNjMyk2fqwU1XuygbijL8iQjQfJobb0nqFrAS1fcVrHdycK7q8+Vh+QIUy59q
         dT5/vSbHWu/2AWcbwjnHdqekTl6Kg9CVbPWNEVFJLVsZObJZSLv1UEzxJ4ZcPsr2NuTI
         RrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORhdzvQEaSdepN8FuCdBMVAeS8RbuY3+hyzMb2MUCmU=;
        b=cKRTqnRlOWQotHjIkY7VUOmVHfGg4KoqwCF46xCGnNoQRTrq0FZNaGTK71TY9Ge2eg
         gUAJTqrHTcdY7imfNHoDYjUjRPe4ApKIt2T8cU1gL3GThYqTO2d3H+0k5wJ44hrNFGs6
         b6I/I60jxS6ZeLXRjk+obIxiN++SynPGwAkLCFCuMBpql2fifoPEQ9RHd9WSWdphg9WG
         4YqjsZ752548QyfgohZIEJQQu/u2UVGHLG9Hrs390h6V7TWOyrGx3AwQ28EP9guUTh1j
         I+RFPlA9LpRg+7FiUrhRo9ZNqERYgt7bFaXXu3LD7YVghJznCM9LE3it3nrs0OxStcoq
         VpJA==
X-Gm-Message-State: ACrzQf3JoKsx9gXJKXXr2Tf6POGIFVt/rjCTKleRU213Rju9dzZXip3H
        GF0/K7EQZM9rbEQFTJ9d5iRlf+Ulwfs=
X-Google-Smtp-Source: AMsMyM6LZYOGHckuR/62UDILXyIoTy88xXcHeQ42CxC1naP5vKcUWFWGnCcc+yiuY/MCRfxUz+hpmg==
X-Received: by 2002:a05:6638:378d:b0:363:b8c7:13cc with SMTP id w13-20020a056638378d00b00363b8c713ccmr19383480jal.114.1666479249763;
        Sat, 22 Oct 2022 15:54:09 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y19-20020a056e02119300b002ffcf2e2e05sm534189ili.58.2022.10.22.15.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 15:54:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] vmlinux.lds.h: place optional header space in BOUNDED_SECTION
Date:   Sat, 22 Oct 2022 16:53:51 -0600
Message-Id: <20221022225351.1406492-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221022225351.1406492-1-jim.cromie@gmail.com>
References: <20221022225351.1406492-1-jim.cromie@gmail.com>
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

Extend recently added BOUNDED_SECTION(_name) macro by adding a
KEEP(*(.gnu.linkonce.##_name)) before the KEEP(*(_name)).

This does nothing by itself, vmlinux is the same before and after this
patch.  But if a developer adds a .gnu.linkonce.foo record, that
record is placed in the front of the section, where it can be used as
a header for the table.

The intent is to create an up-link to another organizing struct, from
where related tables can be referenced.  And since every item in a
table has a known offset from its header, that same offset can be used
to fetch records from the related tables.

By itself, this doesnt gain much, unless maybe the pattern of access
is to scan 1 or 2 fields in each fat record, but with 2 16 bit .map*
fields added, we could de-duplicate 2 related tables.

The use case here is struct _ddebug, which has 3 pointers (function,
file, module) with substantial repetition; respectively 53%, 90%, and
the module column is fully recoverable after dynamic_debug_init()
splits the table into a linked list of "module" chunks.

On a DYNAMIC_DEBUG=y kernel with 5k pr_debugs, the memory savings
should be ~100 KiB.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
? does this need a new name ?  HEADERED_SECTION ?
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9f6352171f88..b3ca56ac163f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -195,11 +195,13 @@
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _s_, _e_)		\
 	_s_##_label_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
 	KEEP(*(_sec_))							\
 	_e_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _s_, _e_)		\
 	_label_##_s_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
 	KEEP(*(_sec_))							\
 	_label_##_e_ = .;
 
-- 
2.37.3

