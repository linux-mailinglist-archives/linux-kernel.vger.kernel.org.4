Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1A6C04AF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCSUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCSUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:11:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905DB1ACE3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:11:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so39193436edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679256711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svh5CkV4qACNpUCwXOfTX98jsnzrQxv/pZHbsNshCOc=;
        b=EVcbTdW5IYaNkMNpQnzNmrShhEP0qdg43W5Tt9P6S09645P8qIqkcaKgWiEQPN+xqw
         L4O7/xbXPEliBNoMtmsgRIejlV4OfW/sIXo3huqciB5YLIAQFuaUUFO3iTGr20U8GDMF
         VcSCiGEqvWIgD0ZYvI2MKzC6OW1vvORVcDbKZ7q1flHBZd1iZ3uA1TiXT6DmCzTlUpMA
         Jh3xePPHpiJCycwth3CMn9kt5xeS1Gtfn4rrceQ4FKcqu4e8bJSdZaUcTWNy9NZ570fE
         jjzD50GyQOVlvraQ32pDnAVADU+IXKM6sDQLIXuXh6XX8BxrXsQXe3Zh0LuP08weiN9W
         zl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679256711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svh5CkV4qACNpUCwXOfTX98jsnzrQxv/pZHbsNshCOc=;
        b=EtF679YbMdy9x97MHPqacqVGw8aQP/jxZ5PKMnKS60Y57WSDW9ZjUMX0RGD7Ycak2E
         TiwxiFVXJqQvFXKWFxkVaf0tur04MridlolcMFsMRTU/T+P9bfy9hREqZUdFnHz7Nj6c
         XhIbCFIyeWzcTFyQnT2pYVQWhQz7xn/HQ2dJcEL5bni9wsk4+b5CN2xu6uOpVG1nYCfb
         dgZ5aZkxbXo+S3hxrptickFqAxfGExShctRm9wTU/LEXBMKkwP504Nk9hQ0nguMgP4KR
         v2lpcLDKH6FofRzqSIonnpv0AaXmyMo7+NEMqAITt1LlZDFiJnsBfmtC6KmEWXIjpq80
         Dd/A==
X-Gm-Message-State: AO0yUKX5M82IPvckRvSPn8bBtwHtn/npyPqPiq48nfpiyiMsjPZgT8tX
        7cqnQQdZ4BFx6k8rNav2HLA=
X-Google-Smtp-Source: AK7set/whmvn0pqWy5DPK6yzol3eRDFiLnkL9GeN4rBtwkl+KdiB53Gky2xHCyG5dfIotQCTtD95iQ==
X-Received: by 2002:aa7:c2d7:0:b0:4bb:e80c:5667 with SMTP id m23-20020aa7c2d7000000b004bbe80c5667mr10227024edp.10.1679256710991;
        Sun, 19 Mar 2023 13:11:50 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004af6c5f1805sm3898695edb.52.2023.03.19.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 13:11:50 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, namcaov@gmail.com, hdegoede@redhat.com,
        straube.linux@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2] staging: rtl8723bs: use inline functions for dvobj_to_dev
Date:   Sun, 19 Mar 2023 22:11:34 +0200
Message-Id: <20230319201134.253839-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Convert `dvobj_to_dev` macro into a static inline function.
it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell
what type it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v2:
	edit commit message.
---
 drivers/staging/rtl8723bs/include/drv_types.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 82159e1c7f9b..ea6bb44c5e1d 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -305,7 +305,11 @@ struct sdio_data intf_data;
 };
 
 #define dvobj_to_pwrctl(dvobj) (&(dvobj->pwrctl_priv))
-#define pwrctl_to_dvobj(pwrctl) container_of(pwrctl, struct dvobj_priv, pwrctl_priv)
+
+static inline struct dvobj_priv *pwrctl_to_dvobj(struct pwrctrl_priv *pwrctl_priv)
+{
+	return container_of(pwrctl_priv, struct dvobj_priv, pwrctl_priv);
+}
 
 static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 {
-- 
2.34.1

