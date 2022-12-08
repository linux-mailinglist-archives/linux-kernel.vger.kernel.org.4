Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839946477CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLHVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLHVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:15:37 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0865299535
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:15:34 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z18so1751624ils.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vo2LhIprix4nPFm79ZLoEPHJE8Gv//Kv1Whgajliur4=;
        b=b/XQkPvENTzTKnE5/SKF2lu+ZJ1+EzwW1IMkxcKiND23ZnFh83vvA/7QLeTzAybTKt
         4Jfn5m2ltBh/RHLbXOKfRwg2RhPH2dAqzGIxfcolDrgXEoPN7748a5lMLb+NRLvl7XOI
         pAMiunTX1qlDhEEecj9h/RqWOySd+bmJTzkhdEqT25h+jVROcx9RXgWIlHTYVqUCuIyT
         1YCGVuO+Kd5HDYPLHGKzBxk+LE4NpTCwin7TcvkYdxdfEF5fUbs39Hj6K1ZfP65RGaQ8
         Bx+QwPzrScqFGf+tiTShjDfoiYK8gyb95okqqENosGqBAYX7jAFDuq5/qfd5O/orIEGw
         5JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vo2LhIprix4nPFm79ZLoEPHJE8Gv//Kv1Whgajliur4=;
        b=4DvjbgO64efwn027JKl9i95YZlj2bFU/VniP/tg0Ox4yrat/v6ZDDlYj0EcVZBrsc6
         6AhNGSNMP0L+jF/r1SnDgxSu4BwEIod5pBT1O1wV51+KJUmFJ59bgxQp+XpeQWZQOE2K
         jyKLfYeVs4NWHZMKNdOiiBR7MoC/Pv+7Z0zGz0hfUcNuAyINQC80RIPVVZgMaXgOLekz
         qzPnDjt/pVnJYE5OrPs/nlnuTPTqgBvm8NdXry82kkqMVVVGBvnoyxpX7KwqxKOvxSst
         kzEMEcbSnreKkcNa4+nEK5GZ+6u/CzsXfE2WrpuvWTI9Mc/i7EY6RlzqBP4Ee7muGnXO
         4zHQ==
X-Gm-Message-State: ANoB5pkeYhKf9A2n77MClQEcRgidk/eSO3VFWh0bkstbXU8DfdKV5flh
        e0H5yiOXLJkskZgIDurw/AgD1Q==
X-Google-Smtp-Source: AA0mqf5raTEAOm+UJumrfXYJZijNJWluLCrf9xluHb1TyZP/FP+qHMQUmC9a/d2QyfTRK5V3ThCq0Q==
X-Received: by 2002:a92:1307:0:b0:303:248d:9ca with SMTP id 7-20020a921307000000b00303248d09camr1992752ilt.6.1670534133215;
        Thu, 08 Dec 2022 13:15:33 -0800 (PST)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id k5-20020a92c245000000b002e85e8b8d1dsm1099821ilo.5.2022.12.08.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:15:32 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andersson@kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     elder@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: enable IPA v4.7 support
Date:   Thu,  8 Dec 2022 15:15:27 -0600
Message-Id: <20221208211529.757669-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The first patch in this series adds "qcom,sm6350-ipa" as a possible
IPA compatible string, for the Qualcomm SM6350 SoC.  That SoC uses
IPA v4.7

The second patch in this series adds code that enables support for
IPA v4.7.  DTS updates that make use of these will be merged later.

					-Alex

Alex Elder (1):
  net: ipa: add IPA v4.7 support

Luca Weiss (1):
  dt-bindings: net: qcom,ipa: Add SM6350 compatible

 .../devicetree/bindings/net/qcom,ipa.yaml     |   1 +
 drivers/net/ipa/Makefile                      |   2 +-
 drivers/net/ipa/data/ipa_data-v4.7.c          | 405 ++++++++++++++
 drivers/net/ipa/ipa_data.h                    |   1 +
 drivers/net/ipa/ipa_main.c                    |   4 +
 drivers/net/ipa/ipa_reg.c                     |   2 +
 drivers/net/ipa/ipa_reg.h                     |   1 +
 drivers/net/ipa/ipa_version.h                 |   1 +
 drivers/net/ipa/reg/ipa_reg-v4.7.c            | 507 ++++++++++++++++++
 9 files changed, 923 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ipa/data/ipa_data-v4.7.c
 create mode 100644 drivers/net/ipa/reg/ipa_reg-v4.7.c

-- 
2.34.1

