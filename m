Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046326A482F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjB0Rhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjB0RhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:12 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E843241FC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c039f859so154165257b3.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycuncMhySgAqKB0JKjWQ87T3vvxMS9R2K+oLMhIEJ8Y=;
        b=jatZw+vavHEldR/zWx4fIqW8wAPU7kuskm2fNsdTmUbEoYYRUK1QgmfSQwty0F7vyh
         In/5k0Ybu4OL/7+U8XoT4kd5dwj6nkMsSYSfl49SjuU4fWHkZmC7EvE/NA5jUKV5mijt
         tEPaHMFzYqt7Ecgvi/GqjzXDl7rzKrsdjxUTz3IPQXQFpGFBi+tum9hpbaiwuAQcs7YP
         AcTg6xqgjkoCojGsNiAv0DLTEBbzq13kS5i64Oy3wTmze25CUcKHKdl0RIiSjO/ZdJhS
         rd+Ro59v2yktpIygy3VtQ7oiDpWrjQ+HLII3XoEVuOsktTglELO3PMbQ5C9t6zyu7z8h
         3t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycuncMhySgAqKB0JKjWQ87T3vvxMS9R2K+oLMhIEJ8Y=;
        b=SdqssnPkY4Kj/eENE6VbijM6COf8LIdVX/AwTSWn3R3yYiQsYQyOqETc/hLf+c9UgB
         fPNICW7fYZSekB9EpGrwxFyd4i4EQdzq0nPj79EjA/hbgoaCMPH4yctatiA3cYn3vjEh
         X9hO3YwJ7c6DJMDAImxKebFyE/bK/WmMSrv6CFbOSYLc/0nibipIfJbxpPz2+oT3lFyk
         qpXlQFx296k5+5zaJIebwZGKOtWvOo+9DcU9OHEelpGuRzLYEsA3fjDEuE704Gw3k4Ru
         D93Ay1zvxDy6SdqjqG8AZLjWYOkeCQ5lZ6dIdK2vz455Fw7invYQ71xrhTB0Q7D8yOuG
         JvCA==
X-Gm-Message-State: AO0yUKU+B/ElbbK253s5XAM/Igw0uvplkvslzUAMsXM2AHQ/tHpkU5M1
        Y4x6bmTNNKf1NOCPzuA4Cp/mUsYuOsw=
X-Google-Smtp-Source: AK7set+sQnwo5grHRclokRwp0C+SftMLAAuN7gXfh+MOPKXwAKaiWwA4Ongifn/fr7bxEOF3Yk7Tuxt7Hwo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a81:af1f:0:b0:52f:1c40:b1f9 with SMTP id
 n31-20020a81af1f000000b0052f1c40b1f9mr10776885ywh.7.1677519418452; Mon, 27
 Feb 2023 09:36:58 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:08 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-10-surenb@google.com>
Subject: [PATCH v4 09/33] mm: introduce CONFIG_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration variable will be used to build the support for VMA
locking during page fault handling.

This is enabled on supported architectures with SMP and MMU set.

The architecture support is needed since the page fault handler is called
from the architecture's page faulting code which needs modifications to
handle faults under VMA lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index ca98b2072df5..2e4a7e61768a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1211,6 +1211,18 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config ARCH_SUPPORTS_PER_VMA_LOCK
+       def_bool n
+
+config PER_VMA_LOCK
+	def_bool y
+	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
+	help
+	  Allow per-vma locking during page fault handling.
+
+	  This feature allows locking each virtual memory area separately when
+	  handling page faults instead of taking mmap_lock.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.39.2.722.g9855ee24e9-goog

