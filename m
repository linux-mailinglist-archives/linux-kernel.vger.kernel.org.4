Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9976C02D9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCSPis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72C2069B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679240275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+XIPLHs3kS1RfXeK+ON9SElHE9AkUNrNvAKZY1Ht/Lw=;
        b=dBDflwxi5hYLsrZQLh1mcADmvth94nJ872alBNOVS32xYdRohR/CjOUTzbV7fwSBq72Sdd
        WgjxlpiUQvZGJF0v2Bk8hB3c0QbgcZsZiFKldRCHCP0TauqLjxRURrdcMGz2cTgwtjvWWO
        ZzxO/MsH400lilZ9dvP0BzbT/mG7Mok=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-WAo37s8hNaa2u_lcqeBGbg-1; Sun, 19 Mar 2023 11:37:53 -0400
X-MC-Unique: WAo37s8hNaa2u_lcqeBGbg-1
Received: by mail-qt1-f198.google.com with SMTP id c11-20020ac85a8b000000b003bfdd43ac76so5393920qtc.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679240273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XIPLHs3kS1RfXeK+ON9SElHE9AkUNrNvAKZY1Ht/Lw=;
        b=4tIV3ZZnlc33ce8puQvGlSHazq3jcjPlXpDo2gw0MkcmcyrYo7GXJDih+XYNwzsoDG
         mv67JykMjoaes0UpQocnvUdwvWFTKhqT+Uesv/4K+lq0gV9oNzYapUt6TOFBM9M75GDw
         lII2il/FBvxJYO/lSfkVtWS7W6MDYdXcKT/oFfuHlUOB/Hb701+VL4+m8zopNDWjvpnQ
         C2k3DcMSaSGOGErewQAemvJsGWquon0GSNdcR+jzfYIf1cfdy9fBYXQ+lxZggNVv/Cn4
         XTZMwkSO4jfuWiHmgqWrZBNs4IomoQ27Tu0CHySLz9K4E8j8aJ5/AWaWMd5x9wq0YpFL
         CNmw==
X-Gm-Message-State: AO0yUKWEbC2gI16nzVwuTkR+3erqhktwmV8DwoPYojES32Be7Dor8pbq
        kydqzPOjo32rIL91v5H+p9B/xoEyGQZG/E5R2AWeVQG5t6PG0a8f5arjCzfYJG79hzvpRpX9PEu
        79vRSvbOn+MtGrsXnfWr5SE5V
X-Received: by 2002:a05:622a:34d:b0:3d0:7bdf:42c4 with SMTP id r13-20020a05622a034d00b003d07bdf42c4mr21989110qtw.59.1679240273164;
        Sun, 19 Mar 2023 08:37:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set/BlpAZdEhiIGBHLKI8KfO5y+gSjhpmxCIlxlV78XjP/E7ZdJLDSyE0FY32cU8FWAt7rGqAbQ==
X-Received: by 2002:a05:622a:34d:b0:3d0:7bdf:42c4 with SMTP id r13-20020a05622a034d00b003d07bdf42c4mr21989096qtw.59.1679240272931;
        Sun, 19 Mar 2023 08:37:52 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o188-20020a375ac5000000b007460093cccdsm5625801qkb.25.2023.03.19.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:37:52 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     qiang.zhao@nxp.com, leoyang.li@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: fsl: qe: remove unused qe_ic_from_irq function
Date:   Sun, 19 Mar 2023 11:37:49 -0400
Message-Id: <20230319153749.1705822-1-trix@redhat.com>
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
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
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

