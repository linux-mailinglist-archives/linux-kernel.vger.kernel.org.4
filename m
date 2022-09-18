Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3945BBEA5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIRP3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 11:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIRP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 11:29:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C12BFF;
        Sun, 18 Sep 2022 08:29:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so24686158pgb.4;
        Sun, 18 Sep 2022 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TN0OyYcBSqh1c3Y1Ehd90+XmF+WxSWuLtqr+UXBMFGg=;
        b=gpJ+ylYzn/p3qA9ejBo4y2SQBnkcksJI7EoNYl/gCQloUdRnwb5waaE4n8iIcGuxK2
         behFXYB/CeSZSooC6t9zAUpFzW/ISejtvx8WOIEwNf6R6Z6n3rZxiuPRu+2hAeGxG+bq
         II9priBn25S/y8kxbS6f9XXLUVN18MHTVEBEysbb+W9+nyL1G/ud3WPuiJvCoVmIgedj
         ZCpCBRCZKHhyvpIcHvTG+GD4dLNch4qKbRYT40dSldGjo1XppBqTyxf2CZ6pdTuv+eUG
         nUrO4Gdd2DypBjQfXGbvMbQR/HRjAzTq3yrKNreZ8as/hZSaLWMhwfz4GcYFktu+gOIm
         PSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TN0OyYcBSqh1c3Y1Ehd90+XmF+WxSWuLtqr+UXBMFGg=;
        b=IwjywYdK92yjzzsFZcspupPLei1iBRTYNBfRqsNldgBiyiVH8S9IPLFtrRq3VLVS71
         Cb0FOlji2wvEWAwTFJiYoz0YeKRcHtAu/bXeSw/HZ9hZnu/9IHN5BhGt0qk2cDXtowf5
         4nARu2vzqUHwqXALT8sPsxQNaxP9SvE24jusUqS3pWaEcnKIn93a4w2EDA9fzCWhL5kF
         r0sfnSQy3cGAryQ0G6mAdh15quZtbTfcaJAMTvmrF1WtKIdHqfsL9HIS7LAWBA80SP1C
         +OybAvC0Md/TDqPsMe06e3HKPXz4DGjMDSUhrBXnN64q1aWkB8cEPvWAA3gBeN8uLnoq
         vucQ==
X-Gm-Message-State: ACrzQf0J6NaVBlhro+wYSallf4irRutntXBMQINPBWE82HomBJHghmNg
        ewYlpw2H8e6roesbD1cyeJs=
X-Google-Smtp-Source: AMsMyM7DcaQahqkuWOyEfbv2Gljmuxk4Tu7j6J+gRD4X7/+sv6eHJfgoCCMSQnnySCwMWfSrLlAQyQ==
X-Received: by 2002:a05:6a00:1248:b0:548:2e34:65e1 with SMTP id u8-20020a056a00124800b005482e3465e1mr14305759pfi.82.1663514959519;
        Sun, 18 Sep 2022 08:29:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b001768bd49e4esm18718126plb.37.2022.09.18.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:29:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     richard.henderson@linaro.org
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        akpm@linux-foundation.org, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, hannes@cmpxchg.org, catalin.marinas@arm.com,
        peterx@redhat.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linu-next V2] mm/fault: fix comparing pointer to 0
Date:   Sun, 18 Sep 2022 15:29:12 +0000
Message-Id: <20220918152912.210112-1-xu.panda@zte.com.cn>
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
and comparing pointer whith NULL instead of comparing pointer to 0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 arch/alpha/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index ef427a6bdd1a..bb3fe2949313 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -194,7 +194,8 @@ do_page_fault(unsigned long address, unsigned long
mmcsr,

  no_context:
        /* Are we prepared to handle this fault as an exception?  */
-       if ((fixup = search_exception_tables(regs->pc)) != 0) {
+       fixup = search_exception_tables(regs->pc);
+       if (fixup != NULL) {
                unsigned long newpc;
                newpc = fixup_exception(dpf_reg, fixup, regs->pc);
                regs->pc = newpc;
-- 
2.15.2

