Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E165BBE9A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIRPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIRPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 11:16:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56AF5B8;
        Sun, 18 Sep 2022 08:16:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f23so9560731plr.6;
        Sun, 18 Sep 2022 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=b9sg2pbCYEJ+t1KhaLMA+JttLAxFc5yjDpZw1fgFqzE=;
        b=EvYhoKK3t753H/8E/SxENQV02D0UULdMP1dS9mhHd0WeNbPQVQq5DMcVHLfcv2O6Bq
         myxzOTNrCw2ARxCfN+RfDw2NzlZNWxj1o3GW5LzyorbAbjwYEK82qjznZn4YhG7BmTWh
         3Tj2ebQ/7inewPDqyi85aOV/8burub/raMGV7jzmf8fz8+d3bHvb4dgKKjpSKZlVlsBu
         AmEAVuTJnaFp7/cowv2xWG+s5FbJLQCXXSkNhUXcXp6pcsn37QwJgbWYeOPGkN+ikiQA
         Fc0eF1OpRyynRfewhUBtmjvW9ZUwZkWKCFZp27GZPtBv10MihptF9z5Jl8uKCa/z8840
         BELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=b9sg2pbCYEJ+t1KhaLMA+JttLAxFc5yjDpZw1fgFqzE=;
        b=kYYKvlrAaCSxL4px0lwRkvWm8pqwPNhAbSPEnCJdAyD44u/3US4gKhB0uZZP6hWGvD
         16rDz3SKHNilLce32GZc4XWnz6/6w2S/pIiPaqwuXl19s0ii+HyZ9vOljTdEAmH+7sLR
         6QY84mQrd/VKRnVVxsSKmvEv/u0zRIbYuoBMQY2MgXl5Q1KpbGBDKAMZ3/dzsc5FMEit
         c1Jf5+cuN+UI5ct3zQy9ad7T5IQV7DfD0QJ91hQt2BxnqjI92N6pWihFmkf1AjggspfK
         IJ7T1iqa0p3eA9qV9jN+Uj+uzabuALdR+XYtsmuRJNzTBgIe+ez0BuiHAqaUIjSnNd0+
         KuEw==
X-Gm-Message-State: ACrzQf3HN1WTzpe07GDjiXuURQq7pkufxpM+EqT38oCFlP/PGdAEBmwT
        dGkcqXopPd+jdw0FRcdXCcY=
X-Google-Smtp-Source: AMsMyM6ncJDo522AQAGmS8aarCcaPB1iqSqVJPkDqAERfsTYJndo9SY2sUXm0NGaKvelsPQl8qRtZA==
X-Received: by 2002:a17:902:efd2:b0:176:b888:2481 with SMTP id ja18-20020a170902efd200b00176b8882481mr8926216plb.144.1663514173984;
        Sun, 18 Sep 2022 08:16:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b0016dbdf7b97bsm18631929plx.266.2022.09.18.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:16:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     richard.henderson@linaro.org
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        akpm@linux-foundation.org, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, hannes@cmpxchg.org, catalin.marinas@arm.com,
        peterx@redhat.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linu-next] mm/fault: fix comparing pointer to 0
Date:   Sun, 18 Sep 2022 15:15:51 +0000
Message-Id: <20220918151550.210045-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Xu Panda <xu.panda@zte.com.cn>

Do not use assignment in if condition,
and using "!P" instead of comparing pointer to 0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 arch/alpha/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index ef427a6bdd1a..09d0d069059b 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -194,7 +194,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,

  no_context:
        /* Are we prepared to handle this fault as an exception?  */
-       if ((fixup = search_exception_tables(regs->pc)) != 0) {
+       fixup = search_exception_tables(regs->pc);
+       if (!fixup) {
                unsigned long newpc;
                newpc = fixup_exception(dpf_reg, fixup, regs->pc);
                regs->pc = newpc;
-- 
2.15.2

