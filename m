Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651B46330C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiKUXj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiKUXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:39:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5426BB703B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:39:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x2so18447672edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=GjSP03i5E+KwTrECfe197N4xDzu4tuLBSVRRI01rBMQ=;
        b=QXSA76hdXZXcn9UdshKVDU0yThYtOyFkiR3HDr57mFWmwkVoXF42Qfg/fxQ1MBSfHt
         OgbMbxtiwf89wUzPWECvGrMi3CnI+eVy8cMo/4FPD7QgPniZnd5bh87yulpN58sxglBf
         Bv2CFxQDKHP0oWmjo9oW5IksJHWmQNl+8uKIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjSP03i5E+KwTrECfe197N4xDzu4tuLBSVRRI01rBMQ=;
        b=JqvQOb34zJWNGL5ID7vc1sXOc2CL4pOChVcieBAfM4aIuZ9e1GJR7jpbggtXhOREgH
         /Xim7PQ59OJMVyRXt95n6qfdSEz0aXOzrUXzhPuDmhxdvIqEeQ9cpkZOdZnfqXGV3s5R
         pUf4tfDYB4I0rbk908ZxowfsiQZCnNEQTJXnTttzixdm8Ae4mtqs327NR4v5sYtZa5sV
         EskHPP0mNAltGF0uWvoj3Gk69pf6abSDN92aPQcY5EtkoUhH3cT8eAdu8C6FHsykIoCb
         Ld6/PxxJf+RGcwcKivMnE+l86RWD7iDkjxI/OOtFUemAPWyhG4eMrSa1gKHZXpaAFiJx
         ynNw==
X-Gm-Message-State: ANoB5pn6Z/0FTD5o6xP9tHWrEeUZRpB/FKt5Awk/wmW7YHwN0YIqJnxc
        e6j3+nFMiqu1wQWx4YFKH6PAeA==
X-Google-Smtp-Source: AA0mqf6V5GFB4dXvA8p8kldaIpbW/jfD8piqrykZbR4GJ7Wn74QuOAC+rscqT0nkqo4HRwFv4yPJ7Q==
X-Received: by 2002:aa7:cb96:0:b0:461:bacd:c85d with SMTP id r22-20020aa7cb96000000b00461bacdc85dmr17914295edt.278.1669073955298;
        Mon, 21 Nov 2022 15:39:15 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f26-20020a17090631da00b007b27aefc578sm5411835ejf.126.2022.11.21.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:39:14 -0800 (PST)
Subject: [PATCH v1 0/1] pinctrl:mtk: Fix kexec() initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAA4MfGMC/w3LOw6AIAwA0KuYzjaBxoF4Gz6NNGI1gC7Gu8v4hvdC4yrcYJ1eqPxIk1MH7DxBzF
 43RknDQIbIWiI8+o6XaOy1oHeUDC0musXBGME3xlC9xjyO3qV83w9UtaZFYgAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 22 Nov 2022 00:38:54 +0100
Message-Id: <20221122-mtk-pinctrl-v1-0-bedf5655a3d2@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=bze2KnrOlEBNmpaBvmtcoShIvqWrNXhh8LxDvF3j3lA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjfAwPMbbIUgdoq6PrZ9H2Kcpi0lz+5E0bJsMoV/K5
 KgRiS/CJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3wMDwAKCRDRN9E+zzrEiLqID/
 9oBrfZhi/1JSkdEHdfWPAOktZbLqpryc8Q/EgZlPFLFD+zy5jkF4RdFcQhOe6bq5ebZ5bq20K6itfc
 ybvJV0ssS+Kx8tkWkBdYsbnVXvLMTtD3N441IoT1JVO4JMqMWZUkZJd3hKR4bJ6Spq2HPVF2qPB0C3
 TMrlYXwvPk2hwxkVBhmjUyEto3xk9Os0l6f2sNLVboDjMdgirx8mUk4D32Xnt1dMesNEdLShDLHCVg
 XVZzZDQzwaVq1vPFRNxBBL2LkTJISv5rbzhXOPoL4ngDWtmoxEkbSy7TCFlDluyQPE7uYUZlOtVbgY
 zvcFwLY6MGUcQin4BfqH6Zol8JvE5eEvFPnRU/dbo+Pbh+dlMq/TNorTEujBQnB0Gb75AmfLHrLiVI
 Xfj6r6/+NyWbXW+DsV1k33TMQGxr1nc0UiYdqb9fA13m8Cu/irMnxIno0iClxFO+9+C525N3aeJ97E
 xF9n6YBWFpSTDFxwGythbbSvhBB6wlpu5YmoDkCIB3zArLVMf1h1hMfAhZCYVEHWlYCZYP2zy+TjhN
 BbwGuJvHCTO4W6Ivn92WQr0GwaPeaae415K8Emt1rFUKpWf7w/eK1sR6LEdFfJ6PDfRQEsGWUhqrF1
 KzAVEGUjuMjr9BUY9atEy7DWYP7CmxnEXpvuiOjo1cD8yjEDSDyFuIHhINJQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use kexec to reboot a system, the hardware keeps its
old state.

This can be problematic for interrupt controllers.

Lets initialise the controller with a know state.

To: Sean Wang <sean.wang@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ross Zwisler <zwisler@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (1):
      pinctrl: meditatek: Startup with the IRQs disabled

 drivers/pinctrl/mediatek/mtk-eint.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
---
base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
change-id: 20221122-mtk-pinctrl-a82d0240c848

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
