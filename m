Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB8637919
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiKXMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKXMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:39:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52964C80C3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:39:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n20so4002239ejh.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kn8cPTGqZ4uCa1GsQbZrRXQU/yMANRDAbiv/dCX5os=;
        b=Hj46rWNvJRxg1GroRkU89OHTuqer7Eb/eAg4YimpMHBj2h+d/UCcnOyCFqil22oYw9
         OEdgbSxptgyupsxRiSAZxkCh0GsolyjalTGXib0chCHhcPCAGhUInR/iHMgdLor+cCcx
         K8BjrfvpGrlpQKZPpUKyqGjm/LYa+CeiYwlUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Kn8cPTGqZ4uCa1GsQbZrRXQU/yMANRDAbiv/dCX5os=;
        b=Hp7UUnLWfkSEG99tYZClwTUFV5H+qvLohZEgM7j+JwygovaBxP+i712XdqgeKaimPp
         t/mA/Z8475yMTpmwyThaFNdMQmH2flI1rcv0t1wM1hORKJc9XpTSprwizfr9jy4+q1Xp
         3KpMffOVN6GXK4s+60edMh63fpQbDw/CbMN3y65D4Xs0U1rBHwYKmkn6UISziN0Zqo+T
         ryIi+ZDHayoeMByDkwXnq37XUN0JRuVkYh1wOj5UcV44id/oyp0jcn0Zdqy4qUugyNrj
         FbnA7ewltz5nl/dqHW5Gei90QH0YwdTPBzrC5NN8vWJUV0z6NcoAPNi7Vm41XOTg2qti
         bAnA==
X-Gm-Message-State: ANoB5pnDOi2Z2uSACyPpwitAJpcYfxlbcdpEQk9Qv3K+fg3dhSFcMQl8
        8i10RYzoKtlAXi4FfIDKKZHj8A==
X-Google-Smtp-Source: AA0mqf623RZGwsZ9J3hGFYAJK31u0wdeJACzjHCyIoe4JaPPeOFessO9rW1vW//v//HSnivNjPLnlg==
X-Received: by 2002:a17:906:8616:b0:7ac:db70:3ab5 with SMTP id o22-20020a170906861600b007acdb703ab5mr27649182ejx.160.1669293571860;
        Thu, 24 Nov 2022 04:39:31 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:7b70:9ff8:7491:883a])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c991000000b004619f024864sm462866edt.81.2022.11.24.04.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:39:31 -0800 (PST)
Subject: [PATCH v3 0/2] earlycon: Let users set the clock frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAOplf2MC/3XNwQ7CIAwG4FcxnK0BNtzmyfcwHjrAQWSQgCMxy97d6tHoqfmbfn9XVmz2trDTbm
 XZVl98ihSa/Y5ph3Gy4A1lJrmUQsgG3vcYQIc79MqMHRdoUHWMwIjFwpgxakckLiHQ0vnySPn5eVAF
 jcvPriqAg7hxpVpsj2jEWbucZr/Mh5QndqWmKv9rSXrQvNG2H1pu+i+9bdsLk/BureoAAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 13:39:06 +0100
Message-Id: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CA65+puFORA/eIOxDRyQMsQ2fz/utcp6fbHKAK0k9Pw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjf2X2idEkn5/JVjX11Kv0lBmXZStXm54LeTka6w7c
 psNQaOqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY39l9gAKCRDRN9E+zzrEiJOND/
 wIOXy2PTlW9gnASfEAiKNUZDcSyA/apG4AjdWlrYo4KIrIiRFYf+U1LWq66/7xRX62rddtdlNFhmNB
 3850ZBi5UzMA3TZ91cNz6lyLPLrisQO3nX8UO4iRpt0YlUSKO7738wUkqpEFvvZviwOR/+OQGlp3PV
 J8N4zdV8tw85dDoyaS76+wAWrpYzskMP3gs/PHUJJdtDO8icUxeml6BSfakyNN/Cosryk7PP9REsHg
 tuRFK/BW1GNxphOn2i/1fZ/V7sqyBThI6ZlFH6ScURvLWp8MzFeQRf12Kxk4w4MfWZQ+NdeG2LXxCQ
 E88rcRKMd5Boc3+o8Nsw5zGRegyKpmg6GfJswjTYN3T5kKrdt/JjpKjaxNQXcZyoC/5aPkvd7xQbY/
 lCe3KjXwAuymHXq5TKI+WZPTcuH4JIe7OS18xGq5oZA51xEr2Baq+/yWNaSzbSgPfKu7+Wa+dnTuDH
 dB+MYFlo2dozJHxGBVDXAdsa+mD4BaQ5NhfKlgHZxJ99RAnRbkuLUI6ffjRCrvzOjZrZNKgF5Qedy1
 2eYhiwbqAY4/1aPuacvjZXGgBFoWUacQnfu9jT5PMuiKo8ww7a00QP/dLforMdycugMVVEFPDR1/f/
 uo+IE1VttqwY4qkYnZPcN4U1KRnNnMJIDnqxEo0vOaVe76kWwf4B6YTa7z0w==
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
Changes in v3:
- Revert patch to use kstrtouint for baudrate
- Parse the number not the ,number (Thanks Jiri :) )
- Add optional patch to increase the options size
- Link to v2: https://lore.kernel.org/r/20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org

Changes in v2:
- Add a patch to fix handling of baudrate
- Use kstrtouint instead of simple_strtoul
- Link to v1: https://lore.kernel.org/r/20221123-serial-clk-v1-0-1f0554a46ad1@chromium.org

---
Ricardo Ribalda (2):
      earlycon: Let users set the clock frequency
      earlycon: Increase options size

 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++-----
 drivers/tty/serial/earlycon.c                   |  9 ++++++++-
 include/linux/serial_core.h                     |  2 +-
 3 files changed, 16 insertions(+), 7 deletions(-)
---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221123-serial-clk-85db701ada57

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
