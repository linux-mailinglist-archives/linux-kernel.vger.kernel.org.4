Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3816E421D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDQIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjDQIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:08:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9924C21
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:08:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so14343099pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681718889; x=1684310889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr7bhkX+Epn2YWYx/+oT337obKjgENzwcgRHzhBp9VI=;
        b=bJXY+7hDuLaSpYXxwM/yztjf06sBYybcq8xuD8cBmDItLAyd9PmLi0XpAUmOy6xHv+
         dpbs4n5YrNyNLE6256NVjkOrdAV6ktoGBOmDZ9w7UHcKgAIC3bNX800RYlnF+U6pPF5d
         m21gfVGUIQGEEs5qowWSv8XTYGM8zmGWtv7OcI8aqDLWt1uQ5wboTfo0EHtda091FaMw
         6iUnxdRbHa9aD3jdgBxyNYqLNz1cG0soqrHKFcaTf2LvRmOHyJ/96GhZ3Rzurl4r7P1p
         jipg6Ig8ym6ndYHYqs4TO55xszkUOh8WKQYAKfRyxwSrUHA7J+aT64DOXYKx+0vk10q/
         DqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718889; x=1684310889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr7bhkX+Epn2YWYx/+oT337obKjgENzwcgRHzhBp9VI=;
        b=ZEICND6007Ybai55tJyxBDEjVGwl5Z4W6uTnxfuaDymvok8IW7Pt7AlS58gyT5dVD3
         TjPwgzlH+d68JS9HXBsXk/9fUOmawgqBiKNHNbNoqBdu3z5CEq5jmq83lhAGClZoh49n
         IGQ49eatHZ7+tkToHBw+ChNPzKarJ1zFnpmeCOUKZknkdS3OgPAUWMcu2B/tgIuPXgOP
         k+GM2YttZsVc3aXs1bLZUR9idHEmLLa2ZzzOykzlvJW408cTBGMPdNBa9F81YtwkkCyn
         S++uzEiC7X0eXdA8III590+VilzLXfFTUaU1yG75QinYHtcXM44+QaAVgdyyLO4DvGoc
         i8Dg==
X-Gm-Message-State: AAQBX9cxqgYKoWSKaDZTYE/L+QvdfgzS60c2t1zPdHcZv4bTXYmTv0Q7
        kqohMv3eqBvuFP7rK1dyPiVgsUJh2mTlBb3pYGa+TA==
X-Google-Smtp-Source: AKy350Y3sXXM1tDYSIZfPXRNb03tgaugGTrcsfNudlJlHZ3NSLoFefzqTDUv758I0MgQ0K4KVNT24g==
X-Received: by 2002:a17:902:db09:b0:19e:6cb9:4c8f with SMTP id m9-20020a170902db0900b0019e6cb94c8fmr15803413plx.41.1681718889687;
        Mon, 17 Apr 2023 01:08:09 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b0019a97a4324dsm7114135plb.5.2023.04.17.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:08:09 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH 1/2] bpf: support access variable length array of integer type
Date:   Mon, 17 Apr 2023 16:07:48 +0800
Message-Id: <20230417080749.39074-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230417080749.39074-1-zhoufeng.zf@bytedance.com>
References: <20230417080749.39074-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

After this commit:
bpf: Support variable length array in tracing programs (9c5f8a1008a1)
Trace programs can access variable length array, but for structure
type. This patch adds support for integer type.

Example:
Hook load_balance
struct sched_domain {
	...
	unsigned long span[];
}

The access: sd->span[0].

Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 027f9f8a3551..a0887ee44e89 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6157,11 +6157,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		if (off < moff)
 			goto error;
 
-		/* Only allow structure for now, can be relaxed for
-		 * other types later.
-		 */
+		/* allow structure and integer */
 		t = btf_type_skip_modifiers(btf, array_elem->type,
 					    NULL);
+
+		if (btf_type_is_int(t))
+			return WALK_SCALAR;
+
 		if (!btf_type_is_struct(t))
 			goto error;
 
-- 
2.20.1

