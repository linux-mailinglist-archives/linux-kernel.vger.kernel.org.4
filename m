Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0523F656138
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLZIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiLZIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:44:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D1273
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t15so736535wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF0czWG0z2T4oq6TY2ZkLRE6dWmClGYr0kuRjGhgjlc=;
        b=crtUviAZFraW9aio2bfSjtkziz8WjnRNOQeWdAf0u2+zEXl0h09SG/WZwfa7gQsQ27
         MwBMstJNcTGsxcyJdwiO/Cq/2RqaP0u6mT63Pr1kzywS9NS7F8l8vL++QkSVm05GBW/A
         o3WkDnb1eo7yJdm2vlfjRGLtVEmWExsY2rVqRLTB9KTprJPLVYnmvBYbZZLCACvPaerO
         b846AD5/3y/3sn0Z5ARghvOHSUmt6rfwK3q7eHBcAvpK2O4KPd1C+i4YKQafJAyq5BRd
         oi2X9EKu9iK6vqcKKjmRUKnAdCGgDZS4XwuBp8xzbbEbr/sKvLXkSAYyxPEKHk7x2Rdb
         sp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF0czWG0z2T4oq6TY2ZkLRE6dWmClGYr0kuRjGhgjlc=;
        b=SLF28UAgj09NhiIqG1CamS1gRfSHgqWlRt7H6uOaVO61X/uiO47SXbso6Lewe8iMGH
         wb9rbwfTvSyS+TqvergXM0vYva4t0grr23+6TgXFHxHjlyFrCp+ueu/ZtQkh2t7f2Ij2
         wTBEAdXQxtaYX3RNUnwu5HR8UtR2s3+BbhRiKO1iG4UJlGnVR24YN0U7DWlC2kIXQuKu
         NHK5NOIFzKT9YZgVLHHviAuxA2opz8STBVs9a89fpRgQ/dBTZAvw0R93lbsz5yvCuZkt
         X20BhpInJo0sjmG2phjdwyZlT/n6MhIeVe4t9k8fCfh2sX3BHJVVX53Eq1ZODw7oh96I
         OdGw==
X-Gm-Message-State: AFqh2kpIFheTKbY4TGDiujAFopiAoN1B5tD3Ga/udB5snidwTxDsF2bW
        pULTEk86PoyrYBP1ADUVQhs=
X-Google-Smtp-Source: AMrXdXvHrmDIUZtGPHoYbQh76pYeg6Gpq29Q4e+53IIvzHC+4BgsPCw3M80xOdXVeczWzxE2psz1eA==
X-Received: by 2002:a5d:50c9:0:b0:236:770a:665a with SMTP id f9-20020a5d50c9000000b00236770a665amr9743724wrt.66.1672044268718;
        Mon, 26 Dec 2022 00:44:28 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm10593253wrs.82.2022.12.26.00.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 00:44:28 -0800 (PST)
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
Subject: [PATCH v3 1/5] mm: pagevec: add folio_batch_reinit()
Date:   Mon, 26 Dec 2022 08:44:19 +0000
Message-Id: <b75d577d0994229f142bcca8ff330c4c587389dd.1672043615.git.lstoakes@gmail.com>
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

This performs the same task as pagevec_reinit(), only modifying a folio
batch rather than a pagevec.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/pagevec.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 215eb6c3bdc9..2a6f61a0c10a 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -103,6 +103,11 @@ static inline void folio_batch_init(struct folio_batch *fbatch)
 	fbatch->percpu_pvec_drained = false;
 }
 
+static inline void folio_batch_reinit(struct folio_batch *fbatch)
+{
+	fbatch->nr = 0;
+}
+
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
 {
 	return fbatch->nr;
-- 
2.39.0

