Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA496E7622
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjDSJU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjDSJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:20:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D8765A9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:20:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b73203e0aso14703523b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681896053; x=1684488053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6j3fNAFXjpvBoTtgGD0M8hc4WjhauUm258DFePjQyw=;
        b=h3eMV3EsSX72f7O7hgzr0WV6+ecbdyXqfirfdt6Dq44ghMI+MWgX/qisWcnKFu9icY
         9uJjgRr9AXvqs3+YsAtOHZgn9PEctz3hn8qqUDbtDi2h+6u7Fs5q7Ef82yf/0LD4QMOs
         g9cRGGrEjjZJpkpbkvZxMbNHfU10VvjZClYzFQamPXLqx14V87rxncBYi1zqGUj1yqQv
         8Btur7MSGiP4o+vZB25aMIgcFx/6PPXw93WiWJwi3Sq+tMRewk9DhjmIzpkGIU6+ZMja
         pSItz/sP1WwsqPUz0vhTy2bn1E+Okus33elHUIVUFQn5NS+pdarsTA2HR6ApdrEJaIFG
         Y5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896053; x=1684488053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6j3fNAFXjpvBoTtgGD0M8hc4WjhauUm258DFePjQyw=;
        b=a0Cjx/JoSPHOedDSJSNMHaYns7o5jfaMzypqePFTFxg6KkzTHyB5y3gDgujn8VPpkw
         MTmRKLOJtz/te23xjAPVUmgGQkABB3KkBMFaMIPMZurJmOCRCvS80pY/SzGPnOYKLK//
         U+Mn+7V6WxS1J6xVf93SuXR9uU4s1QwcvgfsGmUjnSX2zrP8EzNryTyZ8aogFoedeYIB
         qKhG/VL//KCY5/MvQxsYMeqjjvad80hz220wa6zpjMkH1sQfu4su4K+haLTuBnsIJCE4
         /VxlCMzZ+LNQQD0UZY4KF0/+oadjAflxv7EzleWeWWNzt1G9eVuijFCo6VPhhX5xVxHU
         KVRQ==
X-Gm-Message-State: AAQBX9df73c6MppAmC6y3Qv/pQmjJyfBMVn4IKGM/qS93g1RKtERvifx
        yYDWQFHa7I+XKTCe7e3K9hcHjc3qgTc0XVUWKxQSFw==
X-Google-Smtp-Source: AKy350Zup6z/OvK/V81kQmeAGtxtx1sJEe/iiztZlP7XcnDtdpOL4uAZyNcACPlbOAkDeqn8h3atDA==
X-Received: by 2002:a17:903:294c:b0:1a6:846f:90cb with SMTP id li12-20020a170903294c00b001a6846f90cbmr1606364plb.11.1681896053424;
        Wed, 19 Apr 2023 02:20:53 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709028f9600b001a52cfc73acsm10932111plo.129.2023.04.19.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 02:20:52 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm, vmpressure: remove redundant check in vmpressure()
Date:   Wed, 19 Apr 2023 09:20:07 +0000
Message-Id: <20230419092007.186938-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three places, vmpressure_prio(), shrink_node_memcgs() and
shrink_node(), which invoke vmpressure(). But only shrink_node_memcgs()
sets tree to false and the memcg used in it is not NULL, so we don't
check it again in vmpressure().

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/vmpressure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index b52644771cc4..3e4251a55e56 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -284,7 +284,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		enum vmpressure_levels level;
 
 		/* For now, no users for root-level efficiency */
-		if (!memcg || mem_cgroup_is_root(memcg))
+		if (mem_cgroup_is_root(memcg))
 			return;
 
 		spin_lock(&vmpr->sr_lock);
-- 
2.25.1

