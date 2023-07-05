Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50DA748E64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjGETyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjGETyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:54:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F86D121
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:54:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so117708531fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688586850; x=1691178850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iOuiLENnGJgQP5T14AdW9obiAm8decWJr19hpHUhp5E=;
        b=VdHMETYkW8xVaKhsxQ+THd1NrfRSQ0baSJNgb32UByQ2RG0yXNQpMpwdxL9KIw5F84
         LIWgmR6Op06Cn08s/3Tlv5LIkumgVMcsPyvMqKQRd/jarpXPRtGWn95XLQrz5U1kvNIS
         p33SNFXGHxTekiT35hxBgghdXLQUpJ7uCA6VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586850; x=1691178850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOuiLENnGJgQP5T14AdW9obiAm8decWJr19hpHUhp5E=;
        b=EUAFQXkO994Y49jYOmo+JhuZsLRP3IZUpCKn4Bhbwlb5SSdSYbpaKWSVzJysPjXLHH
         Qmz+gBCGgi5BO0ysNuV41/KoyRjDf+rDxKKxZAA6mM8nETJZJGWjloLX+lzPZ8zDf6TX
         MVOv4bPKcHmdNmZzKKl1Y78p6qCgy2t6zVDXxzeJF9wGfK5yIITAtsgbu/1ZUHbhCOt9
         YPJs/bK3H4fACI19FedrQnmSbkrYUsrcsvooPJ5n/RTXkhlbyViSGOnxCXW9qS/mK/PA
         yFJdFZ8RV8U7wzV45DgeCgVRA8Dkknf8GKAeKqOHDI3DbzE1NE4D/mLWvLUnAi0Jn9G3
         7gOQ==
X-Gm-Message-State: ABy/qLbbZbtQR04IaJK6NAXem8MKtpoeitrD1s73SuSFumNOxdKpYiv7
        53pwjEV2f8Ul/VSzu+TRL8RMAlY2m4fvX6vUXXX3omks
X-Google-Smtp-Source: APBJJlEXX1C7LXs8LeRpJdjC+PduizVXXgWUsMLweox4Y20tCzK8ddcJe//rIP4I3FyGzrv81s4m8A==
X-Received: by 2002:a2e:9b04:0:b0:2b6:de6d:9e22 with SMTP id u4-20020a2e9b04000000b002b6de6d9e22mr8147789lji.40.1688586850485;
        Wed, 05 Jul 2023 12:54:10 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e1-20020a2e9e01000000b002b47a15a2eesm6438606ljk.45.2023.07.05.12.54.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 12:54:09 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so5786677e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 12:54:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3607:b0:4f6:2317:f387 with SMTP id
 f7-20020a056512360700b004f62317f387mr12679lfs.35.1688586849377; Wed, 05 Jul
 2023 12:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230705122357.GA14855@www.linux-watchdog.org>
In-Reply-To: <20230705122357.GA14855@www.linux-watchdog.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jul 2023 12:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgu6wv3aMx-p-tapvZ4ui7SSzo3OX_tz7jA4rggCfsk-Q@mail.gmail.com>
Message-ID: <CAHk-=wgu6wv3aMx-p-tapvZ4ui7SSzo3OX_tz7jA4rggCfsk-Q@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v6.5 release cycle.
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 05:24, Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
>
>   git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-6.5-rc1

I think that machine is feeling a bit sick. I just get "Connection refused".

           Linus
