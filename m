Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87976576EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiL1NbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1NbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:31:07 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE844F5A0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:31:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qk9so38400440ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTKU4hQGZwLZEDf90fSvXtHVV3p1bqrikxtaOtl5vtE=;
        b=Yy1xhtDXG9AhlZlv064T+ZQxYh/c8mnOIxeBnyRVgba9qntOTId0ot+bIZTm4j/Ho1
         cTrE72G92KDbT82M59QKgah6OOPkkgQJwgKyKy4BZwObg/EiLes0TgBbVi1ngyVKCnx/
         Qzsgru8zEGqlTHxVHlvdByTZb/QMb3ujV48NxTCt4OaFrYNGfBHdIEAYudskuBkkp5XJ
         ARG/hVotqKK0WmQhEBxTjKyVcA5zQTDRQ+ehFJjDmCnHyw4f+tnmhrshnWnf5LEbO3FQ
         pK1JaOjv+tt0rAVpDw8H+U5LxEtJ7T0EpuH11/CbQabC0EfJNRx6Agrv2Nljz5BKDTKe
         dikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTKU4hQGZwLZEDf90fSvXtHVV3p1bqrikxtaOtl5vtE=;
        b=NrvIsgvWd3StXSEZR0npbWgDNsfCsg5Pm4EC6aR5PSmeP3f+SXdm0d2KkcgzIfkhIS
         L4jBzhermkGJXn0h0V0UcYLv0HgIFKiKseOp6GPW1aHfXFUqhZs1+U/pEN0dSTRw1pd3
         tIlj3YolbncYza/MWQ9cYsM3UnNy67gBAupn2CxIXbmeDBcQpNd/BOTbutvhoTiOFs/K
         O+VM/1i1BCxHSEbO65IzZSwfJTsRH3MP23AJK2EXDgoJQZZgEg1BpE35rJACD0QRuDTU
         K3wEyJL8G59nDJm9J+5xSO6om0NDJUeE8zuOd7Q9bzAJQA8rEI64qOrq6/xkN4Us6aWJ
         JxHw==
X-Gm-Message-State: AFqh2kr+slU5e3YXqdXdQnlH82vVWvK9ouxQpaiS78B8+Phh2j+fQUeF
        zQz9qjRvI0WF+VSq+ugqBzP62A==
X-Google-Smtp-Source: AMrXdXsLqVKQxE3F2S7zJjROiP8PY+36IsJxF97o7BGhtvcebsFiGgfCtrvYh/8//j/3GChOIlR+vg==
X-Received: by 2002:a17:907:170a:b0:7c0:daa3:b4ab with SMTP id le10-20020a170907170a00b007c0daa3b4abmr22669862ejc.40.1672234261338;
        Wed, 28 Dec 2022 05:31:01 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-85f6-04b5-1651-3b6c.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:85f6:4b5:1651:3b6c])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906094f00b007add28659b0sm7541393ejd.140.2022.12.28.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 05:31:00 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        agross@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v4 0/2 RESEND] Fix pm8941-misc extcon interrupt dependency assumptions
Date:   Wed, 28 Dec 2022 13:30:56 +0000
Message-Id: <20221228133058.213886-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RESEND December 2022:

Hey Chanwoo could you please pick this up ?

RESEND September 2022:
- I thought I resent these at the start of this month, can't find them
  in linux-msm I think I just sent them to myself.

  No change since July 17th

V4:
- Added suggested extra log text from Marjin to extcon patch

V3:
- Adds a cover-letter since we are now doing two patches a dt-bindings fix and
  platform_get_irq_byname_optional fix.
- Add Review-by -> Rob Herring, Marijn Suijten
- Add additional patch to negate warning when one of usb_id or usb_vbus
  is not declared in the platform DTS. 

Bryan O'Donoghue (2):
  dt-bindings: pm8941-misc: Fix usb_id and usb_vbus definitions
  extcon: qcom-spmi: Switch to platform_get_irq_byname_optional

 .../devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 12 ++++++++----
 drivers/extcon/extcon-qcom-spmi-misc.c               |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.34.1

