Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3E69B6D4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBRAbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBRAaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:09 -0500
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F606B30E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:24 -0800 (PST)
Received: by mail-ua1-x94a.google.com with SMTP id x2-20020ab03802000000b0060d5bfd73b5so939645uav.16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf03eS1BobxnoyUk+0ZYrZ8zRMgrel2ztMkHa50OYSI=;
        b=n5krxTWva4Sf4Vsvk57VrejZS7qh83I29bbOukhXhjxnbyiLVwsIU1jYSB+TyjblCL
         MilLcyhHjSUyY+1YLmOg+OnBETPCIOw/L4b8Fi1wC+MKnO4VLbaVIbLLSIpqvEF5fKek
         S7PVzlegxhgRs1TdpdgnswFYQr0DAofh6bzKR/4aYfTbY2USEybj9EjCijALtRxrpFmY
         oRt8kPX/U/3EtMyNyG9s3xqsF3Jx65+txOMviZr70m7fuLxiVCeDc004dBLqVT+P2gLb
         aZ2Lhu7IFeKdLx2Du68oGZvPZtxzFiuZ9OH+JAdOUn2J1T26W3LFbmXb5sUZtm1q1FgI
         +6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf03eS1BobxnoyUk+0ZYrZ8zRMgrel2ztMkHa50OYSI=;
        b=SnaMBtiKGN2ANxXr/9z/eR0zlhMrtyddzCaFLYP8QdJrALxCJbhIhmYN67y2Rfmmhh
         ogRgLVT1PGQ52OkZnWU1ww/C2d1e2wLI7GJeltWpG3pK1tLJXQ8NDASKebT2x1kyykYt
         ankOLa4gPsfrr8nRVJ2qNg3xwW9TbqnhaO520tAESkV/fpfiEW68BBDzMsZFjx1Ffuwh
         v0LmWstW6vYAY6J30lhvyrIUHk41btfHNx+agnC+Fr2qge4eaas9+ARCYvmHEUqiYd/f
         covEkFUUWmsb3suqCrt5+FBw7u/73bJJnuYO2tBMUaMVQVszU0NOC1DFd81z+Qe8bEZh
         iRVQ==
X-Gm-Message-State: AO0yUKXzI1IYAhT4szge27jnIfl0HYwNw4jEN2Qy1pYyuGApg42S5zO8
        zU7uG42k4UqgOjRlDX81FasMKc9qNR0MzE5G
X-Google-Smtp-Source: AK7set/xeVdMk4/mlhl6jkXC1OYI04ENP7/RQfinMSut9jH5SSiIHmeo9doCVF6zrjX21weL0A1G0FvBpBxmEp3t
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:356b:b0:415:48ce:8597 with
 SMTP id bh11-20020a056102356b00b0041548ce8597mr942711vsb.8.1676680155862;
 Fri, 17 Feb 2023 16:29:15 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:05 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-33-jthoughton@google.com>
Subject: [PATCH v2 32/46] hugetlb: add for_each_hgm_shift
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

This is a helper macro to loop through all the usable page sizes for a
high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
loop, in descending order, through the page sizes that HugeTLB supports
for this architecture. It always includes PAGE_SIZE.

This is done by looping through the hstates; however, there is no
hstate for PAGE_SIZE. To handle this case, the loop intentionally goes
out of bounds, and the out-of-bounds pointer is mapped to PAGE_SIZE.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e20df8f6216e..667e82b7a0ff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7941,6 +7941,24 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
 	return vma && (vma->vm_flags & VM_HUGETLB_HGM);
 }
+/* Should only be used by the for_each_hgm_shift macro. */
+static unsigned int __shift_for_hstate(struct hstate *h)
+{
+	/* If h is out of bounds, we have reached the end, so give PAGE_SIZE */
+	if (h >= &hstates[hugetlb_max_hstate])
+		return PAGE_SHIFT;
+	return huge_page_shift(h);
+}
+
+/*
+ * Intentionally go out of bounds. An out-of-bounds hstate will be converted to
+ * PAGE_SIZE.
+ */
+#define for_each_hgm_shift(hstate, tmp_h, shift) \
+	for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
+			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
+			       (tmp_h)++)
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
-- 
2.39.2.637.g21b0678d19-goog

