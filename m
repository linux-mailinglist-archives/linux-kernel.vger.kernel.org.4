Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BBC5F88D3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJICUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJICT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:19:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6511834C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:19:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h12so1562676pjk.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsbh45Fv58HEehSJMVvF1reAzOnYH1CPjnbjNiOuTbI=;
        b=IY6o+u/pLMZi4wFmcw5uqJB+plYJlGXOYXMKUIx/I6RempySqHXX4p8H6FrdpKXqaY
         l+TJqDQ6k81QwdzrhfHZC1XS9uG/K+ZOBuByePD6fGnX0gesRFBP6ejOcXwvZMfSpvHv
         4/ip8yokki7OdNv7mE7FVla8cC5EjnDnIFkn+4FjWsvVxUt/q7oeOmYxV9yK3HoEsrr2
         QMNddGvJ41qITpkE4W4hGrma43Y50VfVHoGv/dJK6Fck/N9/V4EmxYTzPZY2iYbHT65H
         B+Jf4usU0Akcf4NJ90Hj7EDMltRqDJtYOfPwZB5g7Gs0BdCe2CbXcEAQK0VPN88B+5U5
         fNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsbh45Fv58HEehSJMVvF1reAzOnYH1CPjnbjNiOuTbI=;
        b=Jw6m+5yD8QQuf79sBf766tqKFJwctS3WAA1ymW9BFLRasc9iQOyOHlTKhivyjZUjzW
         nX5TB/u8zbsiCCSIevHWUXPEZ7jktzPNexLy9qQaAtnmfme93QXd+rjsTOOqBX9fBeOv
         qrajeVrl4ojwitXW4Roshb5hjMYlNq3ScrcMn5wO0DNcRpJuJUxYVeS2XNBvAyYce517
         vUnYlBJb0QDGYW8anzNCFK7yu64JSdTOIYWK0KZQgxgy8m9DsGgpk9G838oAFs0cu0SY
         AmlKucFoJr/rlgjVHGaSggthJOccvWA/I1zfK6La4crah6D0z8ViwIBvnRS14XPZ1iOA
         1HPg==
X-Gm-Message-State: ACrzQf2H2GLPFQZVemopj0cnVQ5zxhLCa5adXv9V6gCpV2Kku9mqtb2r
        DR4v/GyCKmTrIk8UNvYL2gcOVxZpFw0=
X-Google-Smtp-Source: AMsMyM4AdT30BWpujVN2SmQYYAaqiC5g0djHrVWOrn0yrmMCpf0aIs13MpEVvw54B513wvnFdGFNaw==
X-Received: by 2002:a17:902:9048:b0:17f:93a5:4638 with SMTP id w8-20020a170902904800b0017f93a54638mr12217181plz.108.1665281997076;
        Sat, 08 Oct 2022 19:19:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id jb12-20020a170903258c00b0017e9b820a1asm3967799plb.100.2022.10.08.19.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 19:19:56 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v2 1/5] ksm: abstract the function try_to_get_old_rmap_item
Date:   Sun,  9 Oct 2022 02:19:50 +0000
Message-Id: <20221009021950.315263-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009021816.315205-1-xu.xin16@zte.com.cn>
References: <20221009021816.315205-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

A new function try_to_get_old_rmap_item is abstracted from
get_next_rmap_item. This function will be reused by the subsequent
patches about counting ksm_zero_pages.

The patch improves the readability and reusability of KSM code.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/ksm.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c19fcca9bc03..13c60f1071d8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2187,23 +2187,36 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 }
 
-static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
-					    struct ksm_rmap_item **rmap_list,
-					    unsigned long addr)
+static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
+					 struct ksm_rmap_item **rmap_list)
 {
-	struct ksm_rmap_item *rmap_item;
-
 	while (*rmap_list) {
-		rmap_item = *rmap_list;
+		struct ksm_rmap_item *rmap_item = *rmap_list;
 		if ((rmap_item->address & PAGE_MASK) == addr)
 			return rmap_item;
 		if (rmap_item->address > addr)
 			break;
 		*rmap_list = rmap_item->rmap_list;
+		/* Running here indicates it's vma has been UNMERGEABLE */
 		remove_rmap_item_from_tree(rmap_item);
 		free_rmap_item(rmap_item);
 	}
 
+	return NULL;
+}
+
+static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
+					    struct ksm_rmap_item **rmap_list,
+					    unsigned long addr)
+{
+	struct ksm_rmap_item *rmap_item;
+
+	/* lookup if we have a old rmap_item matching the addr*/
+	rmap_item = try_to_get_old_rmap_item(addr, rmap_list);
+	if (rmap_item)
+		return rmap_item;
+
+	/* Need to allocate a new rmap_item */
 	rmap_item = alloc_rmap_item();
 	if (rmap_item) {
 		/* It has already been zeroed */
-- 
2.25.1

