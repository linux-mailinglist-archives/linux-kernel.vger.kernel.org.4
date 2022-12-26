Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63865613A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiLZIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiLZIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:44:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B32700
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z10so9550041wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAasLS5piscKHmj2mkeiZECl/zgxp7yB65Ha7FfxjAc=;
        b=S/g5U5KbNJO2Sul16L8x7UQIrS1nwPDHZCJqliviGoCbAelu50KAZS5EDTDI2B1WET
         TZD/IxLEnU4suuSVPTGW/Pp7CO+apWw4N8vFTQVUV2VAuxcJSEad7cCx9CakEC75Zrsh
         Bg6DKhFlimPpanqAhoL5WVNrrfy525sZR0bgCTYRZ+ASQDrbFkfxLYX66nyGfQU01akV
         IPO6HobN7IHqzqSItuWDJa2arEL5YcqpxDTLO8K2qht84kZzdvsKhEjyXlBZP/MrYJ78
         AaP2KwxZCKIEMwLpsW1/Ube9WBplv3FVy9DQ/c5g0bxvnNqP/HQ2DzYmlpUkLgRoWxPF
         Diqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAasLS5piscKHmj2mkeiZECl/zgxp7yB65Ha7FfxjAc=;
        b=upd0bvBCBCswYOdDnSMCh3YrQwbcBBW+w/zGo3Wdwl0mmxLpJxR9ahaVnYSebTiFMB
         +kteyJ/T5PnKlZH8Y5pbrsK5YDZ/HjloXL7dWEHw2MQn4D2lKosm3Ez+mMIIXM+EA6wT
         7/Fm/TiP1PxSijlkZoLmd1h3KDq2joOoG9/g9KzcBCSGK5ofIW3j7G3aejLd+QLOTHzr
         p6E14YRmjgsehq61IhPAeTLVVevFpK0AAmmc56wV/kQ5ahqX6vfK+tg3wA/UI+EJH3bs
         ge5pLMiksLUWX8newLd4LWDbJSALJjQRDIS5kes0EMT3TCEn6FxPGFiKxRGlS44n5Zk/
         nxsw==
X-Gm-Message-State: AFqh2kqAcbrbOLCIHixY+hbpbg8C3bVUgFT/2u0CWJLtoNN8FQuLLuGM
        +BP4w7nEChZQ4UOb2EbyOT0=
X-Google-Smtp-Source: AMrXdXvviisHQb2mXnJZVBNdr+6iL8AQ80jBKLi2sJvWvpvs1vVzsBq7ECSgs7SC23AXa2Vx+sLZBA==
X-Received: by 2002:adf:a4c3:0:b0:242:7279:a56b with SMTP id h3-20020adfa4c3000000b002427279a56bmr11645451wrb.56.1672044271211;
        Mon, 26 Dec 2022 00:44:31 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm10593253wrs.82.2022.12.26.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 00:44:30 -0800 (PST)
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
Subject: [PATCH v3 3/5] m68k/mm/motorola: specify pmd_page() type
Date:   Mon, 26 Dec 2022 08:44:21 +0000
Message-Id: <4b59f47ff4cd89ff76a5b6edbef6e8e0b37046f1.1672043615.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672043615.git.lstoakes@gmail.com>
References: <cover.1672043615.git.lstoakes@gmail.com>
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

