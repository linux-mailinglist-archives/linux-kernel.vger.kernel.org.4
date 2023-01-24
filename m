Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB3678D43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjAXBWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjAXBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:22:16 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01B1B74B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:15 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x4so10219478pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4yYO75/EwQZJYH40lk5sQ9ghbUufbuHyMXdhMR3QCQ=;
        b=Szcl6AW6otWDqobuZJtGwtF7glIsetJ71TVMtKHGZGZCFaMHizeHwXV0GBU46ckXD8
         AN03PI7hEuIMhWD4c1RA5sz5Wtm0fMxgKre5TWnzTXjzlDSiM160wux/hWv/nzN1CHUP
         R4EnE3slgjF0R/6ei4HCL+ijvHGjHIqm07siw61r2CmMthT9q78b3av8tIsayCUVJdIX
         Wn9VAjNm+k2HfFN9Obbc/ey33I9I4xxPmyFz5bNRWXizKCXMsohhMOA5Zi4XFNzY/717
         gPoldZwss7g2sYCp+RKJRKbjpWnwlpDf34GjSqD+FxKsv2ctHsqvnkUUIpjvVyeOlSps
         j9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4yYO75/EwQZJYH40lk5sQ9ghbUufbuHyMXdhMR3QCQ=;
        b=vRPmEQ12zCeaQDzQg05y0AcRTZKU44WvXp1Qv0k4e3XNKlqKNhVTwfpljkb3HCoQZt
         UTVn6Jm3R/Kp1TvLwbju4SLPOjexwh+glqqa5KblsbOMwQgUMr8Clsz4zMwkjyZU1I4n
         llBgTbN3RjZnUgBKxbWy5+FioXyD3PR385/iVsfCSBX1q4ppmCsqMLTj0h72wsI3GLet
         /J1TTtnBTxvabR8xljWm1aSmLYwPJjmHtgSPdQWt3eFS0HFxUzgGD+2KS0pB4V4dgqUE
         dd8Vq7uhI/UCPgqcQSXGCTg+h4pMZQFncm8FvqUUC2TjD8F5q9EmtqUEPaopBT20kEeB
         zXng==
X-Gm-Message-State: AFqh2kpAczKVUSrl+LHTPREkx8yh5zW/lJm41Ua/HndV1Na2WqysDhy2
        D/UcO/saQFSrHaFl0x1621rJfEVYgCE=
X-Google-Smtp-Source: AMrXdXvHdIldO2gQfEASMMQES9OCx71pQy0FZT6R+4tjFAeePnD43v8oa4X1PBOCFGYQ88pQyytS3w==
X-Received: by 2002:a62:e911:0:b0:578:ac9f:79a9 with SMTP id j17-20020a62e911000000b00578ac9f79a9mr23724189pfh.15.1674523335209;
        Mon, 23 Jan 2023 17:22:15 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id 68-20020a620547000000b005825b8e0540sm213335pff.204.2023.01.23.17.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:14 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
Date:   Mon, 23 Jan 2023 17:22:05 -0800
Message-Id: <20230124012210.13963-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124012210.13963-1-vishal.moola@gmail.com>
References: <20230124012210.13963-1-vishal.moola@gmail.com>
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

folio_estimated_mapcount() takes in a folio and calls page_mapcount() on
the first page of that folio.

This is necessary for folio conversions where we only care about either the
entire_mapcount of a large folio, or the mapcount of a not large folio.

This is in contrast to folio_mapcount() which calculates the total
number of the times a folio and its subpages are mapped.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9db257f09b3..543c360f7ecc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -875,6 +875,11 @@ static inline int page_mapcount(struct page *page)
 	return mapcount;
 }
 
+static inline int folio_estimated_mapcount(struct folio *folio)
+{
+	return page_mapcount(folio_page(folio, 0));
+}
+
 int folio_total_mapcount(struct folio *folio);
 
 /**
-- 
2.38.1

