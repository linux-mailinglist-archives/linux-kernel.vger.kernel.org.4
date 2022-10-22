Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32719609051
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJVWyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJVWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:54:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99E80F77
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:54:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b79so5099999iof.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORhdzvQEaSdepN8FuCdBMVAeS8RbuY3+hyzMb2MUCmU=;
        b=cmegG/cQDs9JlhTYb5B/1Yps85vDQaZe03tGZYWlnQUdwwlRGUTFrOs5tyvcOTGvEM
         c6V+nXWdwsbn4a5bPYs99R6i792gXqvKN7u1Ehni4ivH4PEkkUmA8XKcP+tzRru7LdLU
         sRkoyXnem6Msk2BBa9c56OlWsevI160fSBVhWuQEAyLQixWEkdz/rEo7PXJzzF9v2yOy
         z1sd9A+cyB7ikWu2SB1rJC+bcqGFwBndlh4SKlNui9krsVp7KwZ7sJeD823B94NXEkeg
         TCXvNxfAUP/iU6qv5oxr0n9tauN7rU4mYby6QhNT6EIf9zc4+7BpgODEBfuqeO1dP45U
         zUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORhdzvQEaSdepN8FuCdBMVAeS8RbuY3+hyzMb2MUCmU=;
        b=ymBkUSpSKrd+VN0eMmLSBDaqe2bwtlEE+daHDv1/nRwuslimNUB7R7/T7AT36mt7Op
         aEN21Ee9+x8z8On7UVQPCIIX9V9NuG31ulSbPXFRFxCO3y/ZudK7GG0C7NQETvPh3ydz
         WQ5cyw20N8TjKgXoJS450NzHZ8i4IRaBzpsDglqmcnArgch0ZKadl6DncvUFrGEDL4CI
         gH8n4WDTCs/tqhAg0mWDIZcZiBfJ3++Kj8dVkBgm5rNEO5JIqAV9eiwjj2CdUz6lvpx4
         LL+JCWEuVZGTLfrgGb1H5wQEK4zWTlBQz+K7ge0o6ThgX0TPWh+BQ+y4MncnnsZ+8YT+
         w2sg==
X-Gm-Message-State: ACrzQf1NjMFIK5NKR91CftdoZuzhF8Qxuj0x2Bds1Xi/iMbBYU54pvXV
        j6kcSVm9PZjrCJ+2thWYtR4swgzTe8c=
X-Google-Smtp-Source: AMsMyM66MKZKPBiSW21ttvdHgWgCjqGGvcoRwzHjguU0+YNF1b6g6A3rjfKRqhOXuUIXWCdSTK4UJA==
X-Received: by 2002:a05:6638:16ce:b0:363:b8b5:8d6b with SMTP id g14-20020a05663816ce00b00363b8b58d6bmr19093815jat.194.1666479240444;
        Sat, 22 Oct 2022 15:54:00 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y19-20020a056e02119300b002ffcf2e2e05sm534189ili.58.2022.10.22.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 15:53:59 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] vmlinux.lds.h: add a KEEP .gnu.linkonce.##_name into BOUNDED_SECTION
Date:   Sat, 22 Oct 2022 16:53:50 -0600
Message-Id: <20221022225351.1406492-3-jim.cromie@gmail.com>
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

