Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BBE5F83EF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJHHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJHHHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:07:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314A4BC60E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:07:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so6469472pjk.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egU+pR1mu0fbwNOlCXxgUzq7eQbUYmzREvrHjyDBDLQ=;
        b=GCLrh81Q8BMsf/xFgK/vL+6CrEoKNCw9UdiEuxw25yIGphTObD36x0dLFYVlVR7GOV
         mR32kmjJyEpYA2B4oaSUD9R2Iiy3c4MDfBsxxaGqEh/FawOGokUamFhme8kAN/eBb7WA
         isgPT/9okXWWL6sPCfZ8/Amnd1dgR0wAj1gyXZs2bBvCiLxRn4PixDSpqtfPJI2zuk0h
         lfvvAbMexpk+H6PLk75/+tSMKmcMzMxzFi6wbWA/adtSNCPYFFtgJIe7m00u49YMjVD9
         QNrbLWYxIab29YLMFZ8QU8U04+0JTr+Z85icPXZ3OQKQHMlys82pWCbEZwixUjtwrMnf
         YMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egU+pR1mu0fbwNOlCXxgUzq7eQbUYmzREvrHjyDBDLQ=;
        b=lw3CZwsFS7Qze8LgICQqeOQ1Al5sZC26wdQ8mzaMiig1BEDlPywmtV6mdnjZNTA3bZ
         aa3Pa17vC3LNMDrSDRR7IRUmu+TQs0lqXXgO74W3A8Hrz33FAAY5AwyMkRt5wNbIVWPE
         +jBieghNbtgnaVCyEbRXkp+rzZ8H0/rCUtcmZWKXWwzabKSCBcVwvcwwDdir2XVQBKMZ
         Z1Dx3rl06RIyFy+7iopv2MVkY3tKFQpqe7V1r0Z5V8dBuAhRBj+c7FyI3wg6wa12MosC
         PrhjavhLBtMOpRmwk3WLrDi3QTB6mU5CnY1OmCInqho5P8t/+zhPa7TDhfg8Fq7J+mQ+
         XYzg==
X-Gm-Message-State: ACrzQf1UqNYyvuNHOJbgpPIUgaRnZSwdfTX/Icjh6uAU/L6/jEhhtIwn
        Ot8JUuw/UoG/ymXZkPu381g=
X-Google-Smtp-Source: AMsMyM580/WE7K2J+FERsSfMBW9Alh5kTunQhUorLRTAyVYTY4npo87/H8JMIX2EgmHypeztFjSsig==
X-Received: by 2002:a17:902:dad2:b0:17f:8290:fce0 with SMTP id q18-20020a170902dad200b0017f8290fce0mr8449772plx.168.1665212827179;
        Sat, 08 Oct 2022 00:07:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79ad4000000b00562a5f29ac1sm2772054pfp.100.2022.10.08.00.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:07:06 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 5/5] ksm: add zero_pages_sharing documentation
Date:   Sat,  8 Oct 2022 07:07:01 +0000
Message-Id: <20221008070701.308747-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221008070156.308465-1-xu.xin16@zte.com.cn>
References: <20221008070156.308465-1-xu.xin16@zte.com.cn>
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

When enabling use_zero_pages, pages_sharing cannot represent how
much memory saved indeed. zero_pages_sharing + pages_sharing does.
add the description of zero_pages_sharing.

Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/mm/ksm.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index fb6ba2002a4b..484665aa7418 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -162,7 +162,7 @@ The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
 pages_shared
         how many shared pages are being used
 pages_sharing
-        how many more sites are sharing them i.e. how much saved
+        how many more sites are sharing them
 pages_unshared
         how many pages unique but repeatedly checked for merging
 pages_volatile
@@ -173,6 +173,14 @@ stable_node_chains
         the number of KSM pages that hit the ``max_page_sharing`` limit
 stable_node_dups
         number of duplicated KSM pages
+zero_pages_sharing
+        how many empty pages are sharing kernel zero page(s) instead of
+        with each other as it would happen normally. only effective when
+        enabling ``use_zero_pages`` knob.
+
+If ``use_zero_pages`` is 0, only ``pages_sharing`` can represents how
+much saved. Otherwise, ``pages_sharing`` + ``zero_pages_sharing``
+represents how much saved actually.
 
 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
-- 
2.25.1

