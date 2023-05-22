Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193070B96C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjEVJwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjEVJwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:52:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CF391
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:52:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d426e63baso2665253b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1684749169; x=1687341169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NppiYUjLfZGAuzUVZ8J+F3/te0H7WwC9yNWRHxqdAXU=;
        b=mAHXhjnr4B10Di+HRXfOvHd45RH1ZC09M2i5WRiSBgtjO1iMvJbys9NM7W/AsSE3Tf
         aNzA/ntPMdNMpF9baZBpdG+WGvf3d3LHjeGVj8FC53cvq4OayvPxKsyVFEJs6ynw0r+Z
         Ipz3a9Xb0xy3+SGT7XoswuCsUz2YDYSwTZeuY9geRJKeEZIz7V91Dpr3ruuDuXH0oi0h
         NpOKVdG9nLLXup+8gM28O/BgZ2GOTDRIedKyPuGXDKcsagJFgU9D2Zxe5zT+kl5jzZKn
         fYBaJ/ZIjtxbGjjF3EuQcJTBbAXvT963tZNucsj7Y9FEjX4HPt9NdBqyHWvwYXztyor2
         95Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684749169; x=1687341169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NppiYUjLfZGAuzUVZ8J+F3/te0H7WwC9yNWRHxqdAXU=;
        b=N6SeBBeM745SKP6Shsz0u41ddDFQK6MTKhQSlJtzCxZU3WeRF2D2CmkqFgEpBmKLkt
         vb8+oWA5Oh/+lBEtj2Z/cHA2Yaie7454SWfagayWknzgYtcWzMFpqZtj69rtegAOFQWT
         J7uzFk/ZWH6oyIIUENdxUd53+dNxCXDR0Ro+N/pxi2erZgd2o0c0ksjHxHrS4ujA5Q8r
         ADEjmSkcNJWQZWXCMFfv41bfmzs/7hEi/3NwUN6BMTwfK1xrEYTuZ7KD63XNWdvIFBFI
         t/ac615lv0wFiLh6d2Q555zeDl7Xq7aSyCyHwScrBLUcYu3vzMEBdka2i9A1QNybQSPD
         GxvA==
X-Gm-Message-State: AC+VfDwCj8BlmzkC+VNoM092tN46CUq6KaqONbv9eHMTwumPTNpGQfBq
        8wQKNbmndIsP0cVgCbjEPapAew==
X-Google-Smtp-Source: ACHHUZ7JON/kn+ekTRbm3k/02XmjgrVHpK0FcvWSBnlhuNYr7F73PYn4tXmf+NZKD/1edIAMWZGMsw==
X-Received: by 2002:a05:6a20:3d24:b0:10b:a9ca:97ca with SMTP id y36-20020a056a203d2400b0010ba9ca97camr2700220pzi.51.1684749168821;
        Mon, 22 May 2023 02:52:48 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id g37-20020a632025000000b0051b9e82d6d6sm4089267pgg.40.2023.05.22.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 02:52:48 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@kernel.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] mm/memcontrol: fix typo in comment
Date:   Mon, 22 May 2023 09:52:32 +0000
Message-Id: <20230522095233.4246-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'then' with 'than'.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..ee78d3870edd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6896,7 +6896,7 @@ static unsigned long effective_protection(unsigned long usage,
 	protected = min(usage, setting);
 	/*
 	 * If all cgroups at this level combined claim and use more
-	 * protection then what the parent affords them, distribute
+	 * protection than what the parent affords them, distribute
 	 * shares in proportion to utilization.
 	 *
 	 * We are using actual utilization rather than the statically
-- 
2.25.1

