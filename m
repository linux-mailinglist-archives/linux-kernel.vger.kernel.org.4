Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23196DE92E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDLBzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLBzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:55:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F9140E3;
        Tue, 11 Apr 2023 18:55:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso8491009pjt.4;
        Tue, 11 Apr 2023 18:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681264515;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkvWNkk1D4zYagSfBASBmBTtHIblQqU2LylpaSD7Fu0=;
        b=d3exat8iufnqZQMftlidwS/KzkfSzFEd4frI1pTlUJK6dmAApy5q8QnhpVCcH2NmJf
         Lskbq5bUFr++T78H2Fq7aWrE21WkfBVV47beBDzh22JqOLGFgyNkSSB4LCoUxYPwuZo8
         UI5YT9/ksJhXJhFvFN3FMVwr5n1VYL7PPGIAUVXQ/7lS+4n4SMxzU3/ie2BRBT9RE1CS
         cWsUwwqszQXIZKfAjlg5o94URfnRMIk1caZ+MwpkRa5Gk6q7d6Oiq14w9doDTxhyexLm
         gEvfE5akhJNElOJR+5UCFZ4X1yIiAfsI4EEn7MwXxVv0OWPBbaBJOSRELZ1APB5wwIHC
         Bz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681264515;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkvWNkk1D4zYagSfBASBmBTtHIblQqU2LylpaSD7Fu0=;
        b=3gdm1oxD4C67rmMy00a2Cl4K9JKO89vO4NpLYOpkOEvai6cqqVptW0VaZmD8JcKVNP
         o2d7b7lUwNE7lofTyu9tHCF3/hfhRTtu7jUPrWwq+A178WqWlNZCvh2aa4hnkWLYs6EZ
         fmiuPEZAVw8S4cEQGGW8LSgONJcg0k9Y0ZjsEI3CnBp78h5HyXvxqSBnfAh99HyL72+t
         BASti7/zKraeweaS3Gyx3VEWOovPBo6GsasPNCO2tpXT+oiSjO2ygUd3SmdN1+gXKgZ3
         Sdowych3/mQL2e7vvIa9IUhRHkVtvYSDt6LH9im6ILrEHQOHfVliEqF/g+CUmCah6lrT
         rWzQ==
X-Gm-Message-State: AAQBX9fGWpE6T6+4vLmVtrKuPX4KIO0ywTUJFqenZWF50e9cpnD/VcRF
        Rz8YHcd0LXvd1AzrsxhCAP4=
X-Google-Smtp-Source: AKy350b7gD3T6X+AVV7rB26/Uk5yhOyuv+RWB2wbyKhB7INGSTKioLGeM6O4q56vb57y+EzZ3t06pg==
X-Received: by 2002:a17:902:d48a:b0:1a5:2757:d40a with SMTP id c10-20020a170902d48a00b001a52757d40amr6243932plg.49.1681264514738;
        Tue, 11 Apr 2023 18:55:14 -0700 (PDT)
Received: from localhost.localdomain ([154.220.3.115])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090270c900b0019b089bc8d7sm8061293plt.78.2023.04.11.18.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Apr 2023 18:55:14 -0700 (PDT)
From:   zhouzhouyi@gmail.com
To:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] rcu/torture replace wait_event with wait_event_interruptible
Date:   Wed, 12 Apr 2023 09:54:43 +0800
Message-Id: <1681264483-5208-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
if kfree_loops is too big. Replace wait_event with wait_event_interruptible
to avoid false positive.

Tested in the PPC VM of Open Source Lab of Oregon State University.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>                
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008..b37eec94957c 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
 static int
 kfree_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
+	wait_event_interruptible(shutdown_wq,
 		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
-- 
2.34.1

