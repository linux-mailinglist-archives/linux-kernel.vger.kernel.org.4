Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CE2667264
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjALMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjALMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:39:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F754916B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so16487106wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+sEQZiZPtD8IDLax3ZkLozlH0r133zDHTBg3+ltWkU=;
        b=QKJzp51RE7FmnOadSsbRoJ7T4xdwUBOw03HY8z70vgTVPVLNHCoIFSesIgA8ZXoQXu
         DXau/md+pdbQC3lwijeFmKrVxER5fNP4tvR1WUFPdbX8YbJMw3zbIQWlSwHm205onFK2
         zecFj/HEjVJSPymdYiBV6pR4bvOKEL8uXxUY427GP6Vxx2nlNeqGVIyOqDOqKyXCE/ZD
         04hms/oMfd8ByUB1v1CDKGnHd0Egud9vxVqOZCyoXb9p75c8CPuUZFq4jwgmQArhklZW
         fVtSwyFuchUS8v7AmifnvsR7xt7cVtIlxKo8E2gnWg3Y15Nmd4wFgvMXgP1iyuujVUJM
         uZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+sEQZiZPtD8IDLax3ZkLozlH0r133zDHTBg3+ltWkU=;
        b=WNqqZRyyoKbuMJ3SN0SfRyakwsQ+Ezj/5rX8Cma2vhz1Awr//Ysh1HcpDLq99xjmSz
         ZCKsSz1EINpQ+yVzh2qgOZwY6JXbo1l3K330Z9VNit/OlY1xXlcUoUvo3hYvJEIVbt+g
         eWklRHMol+Y0NxVxTaJrGEb3GoOvCQ3u+zh/m5Ewsh1xd2UXe2aSMVbavRTi74FDKZ94
         9dB6tITKs6OON7WpSVFwGl1JwMZ7rOjnhqFqPn5eO4nNgNtCZrnvOC4jHfJUEat/EE4t
         hq+4pNhfhYiL+ZL+LYw7Mqe9u8Uzy2pJ268rr9V0BpF9pOcjgwgNHurLXISUwnB7OaAU
         ex8w==
X-Gm-Message-State: AFqh2koKAEOWNI1TGXyCh6XiktF3o8cCBeAyfgwGXCjwhAHMj7jtoemZ
        Ih98qZACPsl/4ylbl1/KO34=
X-Google-Smtp-Source: AMrXdXuga+4agHWmvil69VTYVfojsiKttDuyI2ieDX77LMFBsEML16n8N+X8tNz7Ssxdk0yhVPgyyA==
X-Received: by 2002:a05:600c:4f07:b0:3da:1bb0:4d78 with SMTP id l7-20020a05600c4f0700b003da1bb04d78mr991649wmq.14.1673527193584;
        Thu, 12 Jan 2023 04:39:53 -0800 (PST)
Received: from lucifer.home (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.googlemail.com with ESMTPSA id q1-20020a1ce901000000b003b3307fb98fsm20890797wmc.24.2023.01.12.04.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:39:52 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 3/5] m68k/mm/motorola: specify pmd_page() type
Date:   Thu, 12 Jan 2023 12:39:30 +0000
Message-Id: <ad6be2821bbd6af10966b3704568ff458b270d9c.1673526881.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673526881.git.lstoakes@gmail.com>
References: <cover.1673526881.git.lstoakes@gmail.com>
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

Failing to specify a specific type here breaks anything that relies on the type
being explicitly known, such as page_folio().

Make explicit the type of null pointer returned here.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/m68k/include/asm/motorola_pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 7ac3d64c6b33..562b54e09850 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -124,7 +124,7 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
  * expects pmd_page() to exists, only to then DCE it all. Provide a dummy to
  * make the compiler happy.
  */
-#define pmd_page(pmd)		NULL
+#define pmd_page(pmd)		((struct page *)NULL)
 
 
 #define pud_none(pud)		(!pud_val(pud))
-- 
2.39.0

