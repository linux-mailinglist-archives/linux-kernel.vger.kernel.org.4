Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B028370CFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjEWAxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjEWAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:52:52 -0400
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB5C59D7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:46:15 -0700 (PDT)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so12214219276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684802600; x=1687394600;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bX87CylYnN+5c55ItUvtBMTDdL52LhDBMQG45ADuUIs=;
        b=bdogDu/LWKIXK0xhj/mHEXmPSLZDQ4wTkCFpl5MS9xXgMH/lrIKDBgMm2OVW0088Ob
         UUXOUas2bD7bxDVYmP+pP6qAeeNNcNNzpyrJngzal1hujSvkuKEu7+oTZMvffng5FsBp
         gwlthK4wI9AiO+Fdzy5ned4Ve4n2qyJlWIgHIhgxohsY1Qw8A0XJY+vCXRNI9cCOvTZk
         GipdqA6ZJmCkCppBtgmsiSQUIm6BRaEmUEy2YBmPt0Mrmuq/dUUS0r0t46hxsqR6HbX9
         qaAwcxK6iWLJ/y3GzsvNuhSXXmpx/eIa9uHJFpCvIlk4HbNQJ1mX497oATiIBKnqBGwO
         uixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684802600; x=1687394600;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bX87CylYnN+5c55ItUvtBMTDdL52LhDBMQG45ADuUIs=;
        b=TXqkts8VeLwBMo/5BeeLWFDXGYRoNDr21UY5u0a7ISSOemLRBHJVZMmdJbSBqQcEgb
         R6wyDq9PveU4rOIqCqzyXVtyyyBWuqLkts1Oeb+MJry2vPTfjGu4l5GumogqJC9XbLvO
         NYZX8gp/u5uQzXNBsGQK4AzH2ffptR+oN6hTJWh77MLOJ2lHmuN9gxsRPkEmLYlGjL8N
         SS4sLK1WqwIZQ3AGOCNmMukzeW5dtENQ6OMoEK6Fo8AWCsGrvKY1vvT6VOBi9ttUFGHK
         SQyKUAbks95PncRrVT73jwGmVDt7oX9HobgpPcby9LmML/GoTyisLCtJpWE5CittjBQ8
         PyZA==
X-Gm-Message-State: AC+VfDxNQAqqmMtAgn8zjdMiSfxIsOImzIfZMUB0Z3bbTRhwgACDj+Vv
        btCbKtHup5b6pvjnLcEY3EO2GIA=
X-Google-Smtp-Source: ACHHUZ7h2YrRQhx18dwlYMT7aHixdC7I8JgE0ax2zPvocyh8XVLX5phmGOcIHrUfvAqU9QnxAXjxEvs=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:3d33:90fe:6f02:afdd])
 (user=pcc job=sendgmr) by 2002:a25:d55:0:b0:ba8:9455:85b9 with SMTP id
 82-20020a250d55000000b00ba8945585b9mr5274091ybn.4.1684802600447; Mon, 22 May
 2023 17:43:20 -0700 (PDT)
Date:   Mon, 22 May 2023 17:43:09 -0700
In-Reply-To: <20230523004312.1807357-1-pcc@google.com>
Message-Id: <20230523004312.1807357-3-pcc@google.com>
Mime-Version: 1.0
References: <20230523004312.1807357-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v4 2/3] mm: Call arch_swap_restore() from unuse_pte()
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "=?UTF-8?q?Qun-wei=20Lin=20=28=E6=9E=97=E7=BE=A4=E5=B4=B4=29?=" 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "=?UTF-8?q?Chinwen=20Chang=20=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?=" 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "=?UTF-8?q?Kuan-Ying=20Lee=20=28=E6=9D=8E=E5=86=A0=E7=A9=8E=29?=" 
        <Kuan-Ying.Lee@mediatek.com>,
        "=?UTF-8?q?Casper=20Li=20=28=E6=9D=8E=E4=B8=AD=E6=A6=AE=29?=" 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to move away from requiring architectures to restore
metadata from swap in the set_pte_at() implementation, as this is not only
error-prone but adds complexity to the arch-specific code. This requires
us to call arch_swap_restore() before calling swap_free() whenever pages
are restored from swap. We are currently doing so everywhere except in
unuse_pte(); do so there as well.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I68276653e612d64cde271ce1b5a99ae05d6bbc4f
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/swapfile.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 274bbf797480..e9843fadecd6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1794,6 +1794,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto setpte;
 	}
 
+	/*
+	 * Some architectures may have to restore extra metadata to the page
+	 * when reading from swap. This metadata may be indexed by swap entry
+	 * so this must be called before swap_free().
+	 */
+	arch_swap_restore(entry, page_folio(page));
+
 	/* See do_swap_page() */
 	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
 	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
-- 
2.40.1.698.g37aff9b760-goog

