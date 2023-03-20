Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E66C126A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCTMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCTMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445D10270
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679316726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j7ASg0gkUTJq52inUxEUZw0nsEnRgkwG95p6EniSL+I=;
        b=YGm1e4bSGa8erIxWS7RUjjs26BqC6yopIftZCoK/jqxIokbQvbWRbNO5l2BA8ECM8Rej4F
        7zZHW9EJ5DptCvn+0ZmyHjpPgljP49vvRMNkyJFHtFjKRr2Za9tGccrk7vhpkoOv/uwGn2
        9T8w0DseRip3kUyvKqxSOe61wKptkIk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-mWtl6aMjO4GiTpnSa3xcAw-1; Mon, 20 Mar 2023 08:52:05 -0400
X-MC-Unique: mWtl6aMjO4GiTpnSa3xcAw-1
Received: by mail-qt1-f200.google.com with SMTP id fz25-20020a05622a5a9900b003d6c5910689so6761860qtb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679316725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7ASg0gkUTJq52inUxEUZw0nsEnRgkwG95p6EniSL+I=;
        b=Y4e9+CyeUNP9HM917RWMVcExdaMGhWR5Ure3WrPr+hLfqA309j+vUdG6aquqtNNrqn
         E3Dcm0Y/pYhWFSn5zyJNwIb6uJ1gCz+q+JkuBDNFYFEjL3YP1MeP0Goiy7SKJUEaI0ES
         4gyM0CnOKdvew4JZjnTCAS8jk7w2isZykl0DuFdTWgG9KY6kAuc8l5+rR/4i1xpShcnT
         brmLlIbVNeXtUUD4LjeaXfykQVzkvOYwmg9tDxxC1JSSkaeqByMOVDC5fUao4LOuSxaj
         J8pK9uggj2HdsBlSA9KmMBwuUorAgnN7h1MC2ExhlFxIfK6SwjMzPkn6uDfkkMFf6g4g
         jo8g==
X-Gm-Message-State: AO0yUKXFTbCj6x2V0V11lIX4e7d871+iYMatHn+4KlLt+cInN1ABDtRL
        EtPon9rw4TloSZZeIFUclDpnf5UZFVCtAl5LSn87hjBgfjWET013qLkZqMM9mR1b58ICi6ad5Q5
        svv4uYIJtk0tD2bKxJ77bYNVY
X-Received: by 2002:a05:6214:29c1:b0:5ac:239a:9200 with SMTP id gh1-20020a05621429c100b005ac239a9200mr36792346qvb.9.1679316725189;
        Mon, 20 Mar 2023 05:52:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set/mIgQ9WLkpN/lX38TAKIMzAXzxhdDQGgmTFJDrdCZybZKyAGo36og/nqUn3oQNrEhjhBPFaw==
X-Received: by 2002:a05:6214:29c1:b0:5ac:239a:9200 with SMTP id gh1-20020a05621429c100b005ac239a9200mr36792313qvb.9.1679316724937;
        Mon, 20 Mar 2023 05:52:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r132-20020a37448a000000b007466432a559sm5038056qka.86.2023.03.20.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 05:52:04 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     qiang.zhao@nxp.com, leoyang.li@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] soc: fsl: qe: remove unused qe_ic_from_irq function
Date:   Mon, 20 Mar 2023 08:52:02 -0400
Message-Id: <20230320125202.1721775-1-trix@redhat.com>
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
drivers/soc/fsl/qe/qe_ic.c:235:29: error: unused function
  'qe_ic_from_irq' [-Werror,-Wunused-function]
static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
                            ^
The use of this function was removed with
commit d7c2878cfcfa ("soc: fsl: qe: remove unused qe_ic_set_* functions")

This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: Add to commit log when the use was removed.

---
 drivers/soc/fsl/qe/qe_ic.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index bbae3d39c7be..c0b4f865fba9 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -232,11 +232,6 @@ static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
 	iowrite32be(value, base + (reg >> 2));
 }
 
-static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
-{
-	return irq_get_chip_data(virq);
-}
-
 static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
 {
 	return irq_data_get_irq_chip_data(d);
-- 
2.27.0

