Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2946C0374
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjCSRZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5041025C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679246680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WYm22h0FZEjzDnur0SvUWRtWO3WPGs/nZ3mlQqCc8gk=;
        b=CPKyCROQbtXfnQgKDw46LYwzOdrRVD0M0XnIIoFt4uYmN0Lukv2x+umNmetGv2v5Wfe3gs
        x845rX8EhP6UbK0p9SrmwDhIE3WSlwl39jIog0+BL8s7ZBC8ruH9KkStQxcwoS4Fp5vZcn
        j+KS7QnbQMWFg2g5x4areZPpfsI/E6U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-M01EA0viPJWWZSscXASXnA-1; Sun, 19 Mar 2023 13:24:38 -0400
X-MC-Unique: M01EA0viPJWWZSscXASXnA-1
Received: by mail-qt1-f197.google.com with SMTP id ga17-20020a05622a591100b003bfdf586476so5558462qtb.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679246678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYm22h0FZEjzDnur0SvUWRtWO3WPGs/nZ3mlQqCc8gk=;
        b=H7bPzhOPDzCAv2OOdrBT+9XQRgOJDfn2p08nXFE5svcf5AmVAANkHTVJWjcVtDWhdo
         iB3A2OYdOM74ZTkpsrDc1N61Duym6dsknJNEcz1vHayRpdhsmpYfXRSVGC/fGnGuzX1B
         j513/4fmVNRPyPMMv1QBpBlRxvmI0/JWDMGJJgxZhg2IyGZmpputhmJmiyU3RvfLHPIc
         /KgUiva0PTb8UZJWhWZPpMD3IHO4KTS8xnCMDicpSzUgXOZaZG5nUt8sA+Qjoj+78ImK
         BkYl5ebOVdij9TceJEzMUyYmztmlxqMiOlNbGt3wd9Bbs96J0LPE1EnFa2Ah+YXiep/S
         i/uA==
X-Gm-Message-State: AO0yUKUsV3ur9WJyqIpWYJTKRHf+Gl3LOw6QRN6tDW/geqhPBi6pIdOv
        8kZ4GKr2Pzf0ulcHP1tyj4k+KwBv+bSR8l2ReoUc7pMXErdNbtbT+weie3hoYqTu/U0BWh5TUuN
        MqEMo5GMM4oOt2GgkXY7/6U8Z
X-Received: by 2002:ac8:7f8c:0:b0:3bf:dc2e:ce5d with SMTP id z12-20020ac87f8c000000b003bfdc2ece5dmr22196963qtj.4.1679246678268;
        Sun, 19 Mar 2023 10:24:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Yug+NOU+/B0nf5Ys4tKHcVGq8qmgqxjRscDDR3teSxftfURGyZtdjxvhppM9zckFSgDcZLQ==
X-Received: by 2002:ac8:7f8c:0:b0:3bf:dc2e:ce5d with SMTP id z12-20020ac87f8c000000b003bfdc2ece5dmr22196945qtj.4.1679246678019;
        Sun, 19 Mar 2023 10:24:38 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l5-20020ac87245000000b003d3b9f79b4asm4926103qtp.68.2023.03.19.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 10:24:37 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: cxgb3: remove unused fl_to_qset function
Date:   Sun, 19 Mar 2023 13:24:33 -0400
Message-Id: <20230319172433.1708161-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/net/ethernet/chelsio/cxgb3/sge.c:169:32: error: unused function
  'fl_to_qset' [-Werror,-Wunused-function]
static inline struct sge_qset *fl_to_qset(const struct sge_fl *q, int qidx)
                               ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/chelsio/cxgb3/sge.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index 62dfbdd33365..efa7f401529e 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -166,11 +166,6 @@ static u8 flit_desc_map[] = {
 #endif
 };
 
-static inline struct sge_qset *fl_to_qset(const struct sge_fl *q, int qidx)
-{
-	return container_of(q, struct sge_qset, fl[qidx]);
-}
-
 static inline struct sge_qset *rspq_to_qset(const struct sge_rspq *q)
 {
 	return container_of(q, struct sge_qset, rspq);
-- 
2.27.0

