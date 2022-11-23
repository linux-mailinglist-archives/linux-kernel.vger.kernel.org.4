Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE04636E63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKWXaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKWXaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:30:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5044E42188
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:30:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt23so582091ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6LMA2Q7Sd9YoQJrsC7M8vf0UTTXg6tg8Z/ivyNNtlI=;
        b=QVxOmbx5W8N8oI+CO+EoZM5UX+bfTXZuciRAEqxOAzgxuIIgnZlDZYUUdIgMv3XE/I
         pTnqe1fF5y/5zFy1RTKMy4pUmEVgUpwwWc5lupEmInFXY4okiXwTQzAU5HBfT8/CpW2s
         DdJ3850XAGqqoKuElIY93w8ZRcUw0UIHUJnrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6LMA2Q7Sd9YoQJrsC7M8vf0UTTXg6tg8Z/ivyNNtlI=;
        b=BKNppwDEncwwKueWdeLx+jiXRWvAdDtRW8P1pGe+MZ0ggfJ4kOyEllOjW2sKH31i/T
         4P5E/x+ox6FjhvcOePJkyZEPLNyAo9Oe9gUVJdBFmPI7mpscc895AhHZUyvdwVutkfTM
         pjTtgismXr4WJ20/xVHW5ixB+rpGIXL9pMZ8LIVX20pJpQYFLy+c073I4dx2fQJohA6B
         ZaYr0RRs6l7LSiXz7MpEAFyQyzAzX27wFJ8fmGS5sPAXnWPM52KsPNuza/pvKzB7wn/b
         WrofePakPebu+HYjTjAr6j+KkeX7+mZptuPGjMpiFanJXNyt7mhSC69AMb3/L+H7AIU8
         +OrA==
X-Gm-Message-State: ANoB5pmlGp3KgOJ0XSAgj2DSOO/IThFqshCcv3zT2y+z1pUZEGO3evuB
        aVOxIAhH70YlhOSX7y/7VUZOjw==
X-Google-Smtp-Source: AA0mqf6kJ1NiWMAw3V9kaPUJq2zIuJ/jntNiapgSvLSd4MHybETVGPrvoYm/b0CtQsiQdVir2dWh0A==
X-Received: by 2002:a17:906:583:b0:78d:9e18:b8f7 with SMTP id 3-20020a170906058300b0078d9e18b8f7mr24815322ejn.657.1669246204918;
        Wed, 23 Nov 2022 15:30:04 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7db45000000b004618a89d273sm1846799edt.36.2022.11.23.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 15:30:04 -0800 (PST)
Subject: [PATCH v1 0/1] earlycon: Let users set the clock frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAPKsfmMC/xXLQQqAIBBA0avIrBvQCTG6zahDSmKg1Ea6e7Z88P+ALi1Lh10NaPLknq86YRYFIX
 E9BHOcBtJExtCKf88FQzlxs9E7bTiydTAHz13QN64hzaXepbzvB8BUHNhhAAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 00:29:54 +0100
Message-Id: <20221123-serial-clk-v1-0-1f0554a46ad1@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=r9k7xumMZXx17RDnVJJ/c5a94RiKP7pRkdNoriPB6QA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjfqz1/bqULfgCPpUe/L4Qm9HvuKY5iLwBbVLJxZKJ
 6vAd/dOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY36s9QAKCRDRN9E+zzrEiF/CEA
 CN6DO9jgh+m217z2h8lcawj1UjCSXYgyRRv8D//iWT0qGc4cAiFiloU4VE+EaRNmp0rC1R7pqrn6i6
 YJOVgRQniXL4PcGwWfQ+yGm3EVm1WxsLaGdZLU+6XDr4+Ayf3q1OERxNuzBBRz32vyesSxZ64GpzDq
 ngOxbprvJaTq3iyL21jOFXDJlMb9jiDphDvKCQzEFzsmOsAEMvGAFKGU0mJAZK98N4LOFvJXVU+q8+
 s5fCoXLW+PiNyCTrE89NzCBxNLl2Fdqw000Z2jPN5ShLlLYKyhlpyQFsx6ZL1NkfrPY48wwFf5XPJQ
 U9ffifURgtsXcI6gK2M1sku2Ju280pt9js4xhv477MGBACQoqJCDcQpUH/HHkU4S0B7a0dUir4wMp2
 NK/XxW+VrApVA3aZ/morg1NFLDSwPpXoZ4wtLhqbfhehXeAXSDPaz3reNM66cdzFcuSuAukr7lVduB
 P/z3vGhzCkkxpnM8s2DnSee5CijAvq1+Dj3nRWm9HG7bBP+4EwxM7Zr7Y+MrFboNDU5mb46DeFpYUQ
 uL4y20T5RiFhhFyH/cme6qI/7nKA6GZXrbRAkYXh1ORTlFTAlO/B1864FCl7tif/ZLYvxJFeXaafzA
 nHLSYKUk3IY9Hi5pLd1HVpgtrqCCKBJVRgwnnLnaolzAWyAqvHNl2mHhP3jw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms, namely AMD Picasso, use non standard uart clocks (48M),
witch makes it impossible to use with earlycon.
    
Let the user select its own frequency.

To: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (1):
      earlycon: Let users set the clock frequency

 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++-----
 drivers/tty/serial/earlycon.c                   |  7 ++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)
---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221123-serial-clk-85db701ada57

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
