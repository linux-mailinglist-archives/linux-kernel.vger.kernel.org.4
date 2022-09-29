Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73C75EF7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiI2OsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiI2Or4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:47:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C3612C1CF;
        Thu, 29 Sep 2022 07:47:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c198so1632963pfc.13;
        Thu, 29 Sep 2022 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date;
        bh=6ALsB1tmXnl0zoWYg33TINCP8Bce0ftiM371Ppvanvs=;
        b=cQC7tvanffSaxayrUktJYUnwc0rmXBsQVqxKrIiFM3rRETJo1JcCxTE3BqaUi+hrze
         6lczO6t8f+If0GQYs6W5hy38Zr7AeaFxmIWYadZ3N5vmQertIVfFRehzWuyNXDBiIn0H
         c6RzH0zMKgWWuAUr2gogY6w9004AIKiuV6ulWQOWHu55ryiUYbH8xTpjGHnuHwTB3Tgu
         M+BoMtzmXdMg2LXl6oefMK99adW4NgphGH8Q3KkfUhlUCviAxgnroJjiQmvVLafmM66X
         9SDV5jUiykWk0z3v1YOkGnytzM3V/bJCssINScmREGp3kn9JNM66rWGiSf8rrRfRAxzs
         euow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6ALsB1tmXnl0zoWYg33TINCP8Bce0ftiM371Ppvanvs=;
        b=61BcyDWljchbJ+PkupmOZZIzsfiPlJ4U7BlLUSoL08ltqTwUdCt7bZQ2WXUtsUClc4
         9lp3rUV5PjXCuHkAIeXc4ECuFWo/XWDyNXkcmRPyN9VTxobqo7MA25ln4/xXrCkBOeUe
         Yzr07pZ9FBEnSaO9PMbhXFBFsP3mqyV4tVsO+X2rBaAkHCiDi7lGrbYhMGu5MP+oi3l2
         AyUbw2iuk2pdwtxJEuhkQd1tKkVOTgJM3Bjg/14DnQfVYUj89DLMZH862+FW50Du+LTW
         2R6i+KSlwi9J3pzGgzVT6NNZ3Ch4WyU+WZddKGNY2geRsKMVx1fK006J3IpMOqjNEQOj
         YB3w==
X-Gm-Message-State: ACrzQf3rFOgfF3QniAj9oW4EXxG4YZ8ygH2LGAiMCrcILD9+3m4yaLW2
        qMognCjqRIrDdsCdEWN/pFniarivEiCwczgv1BA=
X-Google-Smtp-Source: AMsMyM7FxCixLWliVwNlwSdex0xllaIp4Rfe7rtYJOZrlnLu5OztKXFvWf92Zrr0OS0digSeqHzRhA==
X-Received: by 2002:a63:6a47:0:b0:43c:a935:f0f with SMTP id f68-20020a636a47000000b0043ca9350f0fmr3304125pgc.95.1664462873185;
        Thu, 29 Sep 2022 07:47:53 -0700 (PDT)
Received: from smtpclient.apple (155137199074.ctinets.com. [155.137.199.74])
        by smtp.gmail.com with ESMTPSA id 194-20020a6217cb000000b0055820958928sm6250930pfx.29.2022.09.29.07.47.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:47:52 -0700 (PDT)
From:   Nick Chan <towinchenmi@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Message-Id: <45292E45-8CEB-4970-A087-0765DD96B0B5@gmail.com>
Date:   Thu, 29 Sep 2022 22:47:48 +0800
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>, towinchenmi@gmail.com
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Nick Chan <towinchenmi@gmail.com> # iPad Pro 9.7-inch (Wi-Fi)

