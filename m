Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41BC68BF23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjBFOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBFOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFA27D56
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675691917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=clH41W/lVoNcFLsG24Ai/QiAFITnKECHLPzrN7ce1sU=;
        b=D0gJJhDS6YwAvuqQx+Fe8FhRhts+IgIgvx01NN1EgqFrZpTD4xwzIyD7WfbfS73JzdpGfp
        BcDFC7Td64cSo2NSOfZwRq+bV1QNg/E+xn0kg/N/Li/Pz23Ck8XkB7c4HiWTxcuAKwslhc
        ibqxk2XX9m2nhzNM/oBSIoOfw54Ygeg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-394-O690J8q5OnK8G51RWab6hg-1; Mon, 06 Feb 2023 08:58:36 -0500
X-MC-Unique: O690J8q5OnK8G51RWab6hg-1
Received: by mail-qt1-f198.google.com with SMTP id n1-20020ac85a01000000b003ba2a2c50f9so890415qta.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clH41W/lVoNcFLsG24Ai/QiAFITnKECHLPzrN7ce1sU=;
        b=4R1gXTahCTiLWSjnJkTFGpWnw2ny6dqiBVwl/NC93BYLwIG8uKRNyG37L6hkaSWJl0
         ECUGytPoZyd7cylHI2Z7VpGNn6WE3GEKpYdXuGgT46PAgvg1irZhN1gTySJfgYpw20qA
         lOeCErTzzJYW5jz+5eXmNVwWcU/jWtffXIjP9SkUQdE4waDvkfKCdQg4b1nORzAG9DSc
         4si2ll4VskDrDb0KdbRomY2tHlaa77E4YloHGFPbQq0cvAdMoEMT5CxQ3QrOeGTnXqVY
         Xq4IxsxX5c8Gt9rvJtcdMOvldgP17VwRL5tPr4/YhJTe9+a8cD+TNJVlIYowfBWdWPoa
         4Sdg==
X-Gm-Message-State: AO0yUKVnRPOYWyMozIB25BScnEfpMcgsnqR9aHB6IokIeUjiIjbbbHP5
        Upv3ETARJ3w7bIyhbH8UgMNL08O+SbZl3zU9VZ0bNca4Mf/RrT2FLzodINeupgqcY2lwvmFLWtq
        Ma71eQypE9k0BVDP05UFL3lmN
X-Received: by 2002:a05:622a:1206:b0:3b8:2844:b7e1 with SMTP id y6-20020a05622a120600b003b82844b7e1mr37449743qtx.46.1675691916416;
        Mon, 06 Feb 2023 05:58:36 -0800 (PST)
X-Google-Smtp-Source: AK7set+bmn86RLnryVfY1MFIzgFbcCymjIAPX9Fd5RuvLyYIiTy98IQst+YMd976FBo820Tfz/pXeA==
X-Received: by 2002:a05:622a:1206:b0:3b8:2844:b7e1 with SMTP id y6-20020a05622a120600b003b82844b7e1mr37449726qtx.46.1675691916237;
        Mon, 06 Feb 2023 05:58:36 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o6-20020ac85546000000b003b2ea9b76d0sm7238344qtr.34.2023.02.06.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:58:35 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: qcom: pmic_glink: remove redundant calculation of svid
Date:   Mon,  6 Feb 2023 05:58:31 -0800
Message-Id: <20230206135831.1794583-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/soc/qcom/pmic_glink_altmode.c:223:13: error: variable ‘svid’ set but not used [-Werror=unused-but-set-variable]
  223 |         u16 svid;

From reviewing the code, the setting of alt_port->svid does the same calculation.
Both are not needed.  For debuggablity, keep the setting of local svid.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 71f861b8cb51..4d7895bdeaf2 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -248,7 +248,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
 
 	alt_port = &altmode->ports[port];
 	alt_port->orientation = pmic_glink_altmode_orientation(orientation);
-	alt_port->svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
+	alt_port->svid = svid;
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-- 
2.26.3

