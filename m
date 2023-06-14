Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F272FF90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbjFNNLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjFNNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:11:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7182681
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:10:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8cc04c278so6456385e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686748244; x=1689340244;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFFq5j77sDn2InWKb0H1DVJGVQdpSHE0KLKPy8uowMk=;
        b=FJWqvEB+liRvUSGg4suQJHRBt9zx2mU1PF+/o2NyeA57/W8dCmrOZlo1LE3Brw0XCo
         VhpRoksN20oaVg31nkaB4qMBWOhIEWckA08RBhgFf9ZZPM7S7Ml6z6cTzGyME81wpKTb
         ji0hzwD8tTITy3KTOdxrZ9niaWwG4/KQuM2+mvGEagVhgfL0EnrZLgQ3tOd9lqxbc2Pf
         01et9vyvtXXLfwTY8L4wAnT/q6kVPuUojQXUsmpTUtu99iEkoZCBIO2eppPabOlskIiq
         jtVubefgFAKO6i4AjpwccAcFIJ8lTjpyiyYEEf38tSo4jaHLvAkgUSnllaRsV4HQr9z4
         Ry3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748244; x=1689340244;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFFq5j77sDn2InWKb0H1DVJGVQdpSHE0KLKPy8uowMk=;
        b=ItoJxdMK1p1IGqqj3ZQObNCCkg5UwVW2tGe5twQjdMfHFq4dhcmtMqaZMxInwtOaQF
         ZvWTzkKsqM6qgSFjw95D3y7bie1a+8RLp2gLLa7Itj6FFQKc+98Y71c3wlbWkTDbDzqG
         KlLrKBCc2gvAZstSFpuULS8nHcXpTGNwEsdsEyPz2SSIr2kZ852r9hoU8QmrNea9s5dd
         0h8A54WveRl5IYw0UVM0JUAQA0EkXZyzDRfI2I+/kwO1PBXrfNNTlLN0q07oeocE1E1+
         6xXcbCu4PjzkOQPkufn5qNlIYlDehWc0m9G/h/+lVZ1KCcUoEw3Z8Ai90uZL/WVVxZuv
         jnrw==
X-Gm-Message-State: AC+VfDwjFYEHtSMqF+GSsFE22s4NBLV25UQpUldQaGa4BXDzUD4bMpgi
        YfRQtXJQIoPHpydr8VbQIeokiw==
X-Google-Smtp-Source: ACHHUZ5alFfG8bkCsfkBJRQwsTvwebl3lO/OS5tKLH5bUjG0lU/HSsioNKQfO6BDq8oFzTUSQrCDRA==
X-Received: by 2002:a05:600c:219a:b0:3f1:9b85:e305 with SMTP id e26-20020a05600c219a00b003f19b85e305mr11087507wme.34.1686748243717;
        Wed, 14 Jun 2023 06:10:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a7-20020a05600c224700b003f60a9ccd34sm17548661wmm.37.2023.06.14.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:10:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] typec: support Audio Accessory mode on FSA4480
Date:   Wed, 14 Jun 2023 15:10:38 +0200
Message-Id: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE68iWQC/x2Nyw7CIBAAf6Xh7CaAlqC/Ynqgy9Zu0gLhYTRN/
 13iceYwc4hCmamIx3CITG8uHEMHdRkEri68CNh3FlrqqzTqBjUmRii7HUcJLZWaye1Qv4kAwTX
 PETSiX4xX1t6N6KHZFYI5u4BrT4W2bV2mTAt//ufndJ4/XqsNDIkAAAA=
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XD/3mYEmJE71u+AKKnWBzHCv5TztrsBweX10e9VRWDI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkibxR08aUD8m1Mxxj+6F/lLAZRVGISBn6Mf+fIMx/
 IByvCimJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIm8UQAKCRB33NvayMhJ0VEmD/
 9WBazyfF+KO9M8JoyxbQ3scefX/4Je2YaRxVYUQox07p/1kKixwOlwnWK8eJ8ooC7cdd74YUn6YZ2q
 yyfd7E0+IPGNzDFXYfQUKTxHFPC9YFWRuekr61GkPtqNC/6MbrOBlXdTwiaiJ31iKvraWtmMZAXFyV
 Ku24eEtEW+53WbW+07ZDkcAZZxXuJEldjK59GlZkHxrN75CCEKsVaKR1WNVN/XWt4uqwcei2OuszZI
 kAIufqkCmDiXrYOc2Gp4kVa0WYo+2jUFu+RRPg7NXCLvC8+DDBOKpRykdwz13xUyFckH71Z7OrD0Gs
 kuotrcKO63NiuwXdk9zdUq4qCR707USgzTewP85IasH9+MfAvDywFa/AcedQUVLsosA0QOfLPPlsBN
 9cTMWn3t9ByXqq+ib9Ji8ymdyIQGCLV9xsfNaLJ7vcIdlCKpPyi/FnEL8IeKZn88VDB+if22PR/zuq
 hpjq/leI1C726Pec6aUjodRmZs4JR2tp1aKMXSn1ZlkRFiywkl2aUURYclzlxfLVcV1386SM38uacY
 8hn+KCAbrZkDwSrZG6YMkQZV+8RjZw8jIRFzAylB0FtpFyGHINoxsTHNxhtJdexcjnHnlWmNsWU0X+
 tSFjbBwl7dY8M3/MFP76yuzjiThT7vGxDVNG9Slr3Ad29i3vCoUKjFDbsORQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie enables Audio Accessory mode support on the FSA4480
USB Type-C Analog Audio Switch.

In order to get the proper MUX state, also let's make UCSI
call type_set_mode() on partner changes to propagate the
Accessory and USB modes.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      usb: typec: ucsi: call typec_set_mode on non-altmode partner change
      usb: typec: fsa4480: rework mux & switch setup to handle more states
      usb: typec: fsa4480: add support for Audio Accessory Mode

 drivers/usb/typec/mux/fsa4480.c | 126 +++++++++++++++++++++++++++++-----------
 drivers/usb/typec/ucsi/ucsi.c   |  17 ++++++
 2 files changed, 108 insertions(+), 35 deletions(-)
---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230614-topic-sm8550-upstream-type-c-audio-2ccdf6d18896

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

