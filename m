Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB73A6BD2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjCPOvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCPOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:51:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81749AA70A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:51:43 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x1so1946216qtr.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678978302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCPQuLjvLejF5Bs9SISYbcocVLoSdH1EFnC28LHWJfA=;
        b=IuQIGEw66a482p1YniFxZvunqJqPMKdI3zvhvlAXGvUX0rYqCYHraV7TlilLeJteEd
         sRe2nwI+wbzGHGZj06Hymz2Du8IRlsU31IGLTtgA3q1rfSfK6ZgQt2eoI0VMz4E5OTDW
         KHBz1ms0jtfF1ax2r+vV+DE4bgvG+vU8XKJT39OdjnaKhlPSpZlBhDna6AH3/7UhEZAD
         R7AYtM7H9NzY+j0AX0uVEeIE0KaXhAfd7FFekpQctiYBS214Oicq6TiRU7TTNCmQZ6IH
         00snNUNm1t5acXSpGthanuHoSMLHO3RXzm0n0mMDf79a4+TKKrIfpPj0whDG2pY/Rf08
         6eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCPQuLjvLejF5Bs9SISYbcocVLoSdH1EFnC28LHWJfA=;
        b=QxNjCDZimmLZixoRY6cs/kfgqfiKEDBLk8S3s4KizYArIkEGavVIOwlwJ8ZmZ4Y7rn
         suYKjOM9JcdSZ0d4Yq3WCanGKMbODZQVSXDSqhzQTxmty4rE8WC/RJLh7olo8C/bOnXM
         fPzd94khYv4RVv1ohzr6MOTYLOVXwzV63F2gA/wO42g+jjVM8M+bJ/iGDpuq+HIm4MCR
         JMp9ncyQV9bd3An0IPLbnSiIuwVBz1DH7pYpsy+bkzu7JdlAkEPJOuOqpNVfQPU+DGds
         mI3H5rQH9Ps8r47fM7dec83A4Vw4kzXTheVIK61QMqybxPc2DucumTfZu34bNeE0O0iB
         gyVQ==
X-Gm-Message-State: AO0yUKW3UD8TPWH2X2TMLOOdBr6LbQbb2V6N+iFhcD/Qif29ODfSThu9
        wOTD1FQFjsuwKTfAPinSN4iY+Q==
X-Google-Smtp-Source: AK7set88m4FG8rPtIvz1v9Fu9IFGHjZ9TuiNU4Bs9nFGYtCQsOf32cxMsCgjrmcB9UIcXaEWUZm4pA==
X-Received: by 2002:a05:622a:1653:b0:3ba:1d8d:f6d0 with SMTP id y19-20020a05622a165300b003ba1d8df6d0mr6177955qtj.23.1678978301805;
        Thu, 16 Mar 2023 07:51:41 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n129-20020a37bd87000000b007456b2759efsm2844070qkf.28.2023.03.16.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:51:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/4] net: ipa: reg: include <linux/bug.h>
Date:   Thu, 16 Mar 2023 09:51:33 -0500
Message-Id: <20230316145136.1795469-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316145136.1795469-1-elder@linaro.org>
References: <20230316145136.1795469-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "reg.h" got created, it included calls to WARN() and WARN_ON().
Those macros are defined via <linux/bug.h>.  In addition, it uses
is_power_of_2(), which is defined in <linux/log2.h>.  Include those
files so IPA "reg.h" has access to all definitions it requires.

Meanwhile, <linux/bits.h> is included but nothing defined therein
is required directly in "reg.h", so get rid of that.

Fixes: 81772e444dbe ("net: ipa: start generalizing "ipa_reg"")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/reg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/reg.h b/drivers/net/ipa/reg.h
index 57b457f39b6e2..2ee07eebca677 100644
--- a/drivers/net/ipa/reg.h
+++ b/drivers/net/ipa/reg.h
@@ -6,7 +6,8 @@
 #define _REG_H_
 
 #include <linux/types.h>
-#include <linux/bits.h>
+#include <linux/log2.h>
+#include <linux/bug.h>
 
 /**
  * struct reg - A register descriptor
-- 
2.34.1

