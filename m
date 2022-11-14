Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6276273B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiKNAF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiKNAFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:05:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC190DE86
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668384295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuiiwLAN7I1THL57m13Ion7pO7eyRCignS0WdOlLecg=;
        b=IPXcjSQYbS+MXcWY1MD4DN+6sgEkg6BCqxpeBaVMeL9sDu/uIUcuktc8NwMnHRow+CW1Mk
        ivyM40Ohz9HZsWmuT4JktuB5vuMe969auy3VIvqbGowb2XzRsr5uShpsWcWJ9rsXCbTrtN
        ArJObzZ32htRj5OKERlDPXLQvzvFzeo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-Ce3JMMc4Ph2Xyi0NjQBi4w-1; Sun, 13 Nov 2022 19:04:54 -0500
X-MC-Unique: Ce3JMMc4Ph2Xyi0NjQBi4w-1
Received: by mail-qv1-f72.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so7572669qva.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuiiwLAN7I1THL57m13Ion7pO7eyRCignS0WdOlLecg=;
        b=lWBVSMuGjPve9Kuxd0OcuuJD7UTd8iS7B37RgpVQ1irDyZTNrSAA7nIZg5KXqc/ijW
         cAQYcALvOUNl+ObPJ31TEn/7QEcUAkGclVhRx7uQwqylRTdFqW+RvILZ8aWMK77mGj7D
         gHJIRB6/NJReH5oKvqrvQTSAerKtUDht8r2xO6CFf9Fx9la+En58/q+b5yoyValhVzOT
         mlt8BsCwQLFLAJ2Vke+NVB9PiYjh3KzSNbAQ5APIhei+tFDbALEuYXXhrho2TJGo16bL
         1MrFcec/IAHpUR9EETi5zKDP8O0oawKr9FpwnfDLvaoehuia3KO+uDhdiHgZo/rsY8tZ
         cbAw==
X-Gm-Message-State: ANoB5pmONyNiOlP5ADFsUz4VDPr3sct0t+gYw9Nj7PVBTfMpf+TidsVE
        1VGffgI+qJd8RqIwDeq/lULNWAv4sNO+CGsgcctAUIi18QhGgmtmgH5zboJTRI4C0py9CsWVg9V
        hR+n7AWVviZFwUOMOE3o6+/yHSe/FyWA+VZef3FM4rqzg7QDZkpnlR1wVw7eLUDxLLBpuX5go9A
        ==
X-Received: by 2002:ae9:e302:0:b0:6fa:6cb1:8965 with SMTP id v2-20020ae9e302000000b006fa6cb18965mr9424185qkf.541.1668384293245;
        Sun, 13 Nov 2022 16:04:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5V1BslIfV280V95tlOvqubbpsxPQtv1YGg6N+bmjUfNbr1J4Ku+Hat5/cU0tUkSD60e2vKIw==
X-Received: by 2002:ae9:e302:0:b0:6fa:6cb1:8965 with SMTP id v2-20020ae9e302000000b006fa6cb18965mr9424139qkf.541.1668384292663;
        Sun, 13 Nov 2022 16:04:52 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id cb5-20020a05622a1f8500b0039cc0fbdb61sm4870380qtb.53.2022.11.13.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 16:04:52 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v3 2/2] mm/uffd: Sanity check write bit for uffd-wp protected ptes
Date:   Sun, 13 Nov 2022 19:04:47 -0500
Message-Id: <20221114000447.1681003-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114000447.1681003-1-peterx@redhat.com>
References: <20221114000447.1681003-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add one sanity check for CONFIG_DEBUG_VM on the write bit in whatever
chance we have when walking through the pgtables.  It can bring the error
earlier even before the app notices the data was corrupted on the snapshot.
Also it helps us to identify this is a wrong pgtable setup, so hopefully a
great information to have for debugging too.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5059799bebe3..63bdbb0f989e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -291,7 +291,23 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_UFFD_WP;
+	bool wp = pte_flags(pte) & _PAGE_UFFD_WP;
+
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * Having write bit for wr-protect-marked present ptes is fatal,
+	 * because it means the uffd-wp bit will be ignored and write will
+	 * just go through.
+	 *
+	 * Use any chance of pgtable walking to verify this (e.g., when
+	 * page swapped out or being migrated for all purposes). It means
+	 * something is already wrong.  Tell the admin even before the
+	 * process crashes. We also nail it with wrong pgtable setup.
+	 */
+	WARN_ON_ONCE(wp && pte_write(pte));
+#endif
+
+	return wp;
 }
 
 static inline pte_t pte_mkuffd_wp(pte_t pte)
-- 
2.37.3

