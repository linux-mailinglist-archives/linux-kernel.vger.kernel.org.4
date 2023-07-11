Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E148C74F838
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGKTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGKTDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:03:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5399E54
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:03:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso62611885e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689102188; x=1691694188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCeP3Zg/H4JeLn+58VLEJaihO4ZmKL3A+bfNY674m9U=;
        b=K9F0TplCkUm8fXIoJ2MdfGFgKs5mxm0bkXhSASe7hPQkg7CTAEb8GdkmjugUjLLPod
         E+lMTYnadSLxD5dYjTyXWrJNkMamrFsGGCUATKHn53mnw87G/LzSLvve6mPwH3jSUknI
         I+C1UeXV6w3umiG2ShEXG5dClaEOMHiPJISAYBDTWEPCLuOeRfkHTDL41yCI57/9i3FW
         DVnMRwn8cGjwaV8yGVb4aPJ3JOkzVNFqzJSKg1/2eAmKXPyd9G4siKDUH8cwBxppqgP4
         84Kcjf7EM+2Ggse2wEsduUDqyyV2sj94GOlTMKR0Ko1FrZsgUtUfA2omODGQWxKRSJko
         3T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689102188; x=1691694188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCeP3Zg/H4JeLn+58VLEJaihO4ZmKL3A+bfNY674m9U=;
        b=IYSiUoBOh3bXkGMXjbXnhMhRL7M3RWVFRmcakbQmacFu6RxbkAhsEWKjZ4ors7nRIv
         x35MfKV9T/IfdWkuXy6fBnjKDPG/KssTYAlLdnjhERhrE88Ih3G988/NNtTtIgsqtxKj
         C9Z3kFa1JwaEIhRx2hfL4bdSl5moGU2+wGItCcQMxGCPOJhE9n02IDiN3XoAiSTU0CWg
         a/CIO/3kREc5Q8SKBrYG+4VLRHu+cUytR9mQEg8gTL99mOa6Jwqj6ew5FLn4me+3YIIp
         3QPHU0lPbBLHHSx+LqsfX4++akd995Uf3cG029wC/W7GSQHv0A5GdIcXXrGI83UsSAH4
         V41Q==
X-Gm-Message-State: ABy/qLZn7GFd+sbk3Y/elFtCgqAoWrmr2rtcbmPrrAs7OrSI0cdDLSqN
        30f14JlVRrPcmScYUJyD4yg=
X-Google-Smtp-Source: APBJJlGLa9K9eE0tYsTODgWjZkTcPim5nA9Apx+yB+CXJ+4vr5wpBL/QiTp73GJUEV2dLU0j3M4bhw==
X-Received: by 2002:a05:600c:452:b0:3fc:7d2:e0c0 with SMTP id s18-20020a05600c045200b003fc07d2e0c0mr9490361wmb.27.1689102188318;
        Tue, 11 Jul 2023 12:03:08 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003fbb618f7adsm3201286wmi.15.2023.07.11.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:03:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mans Rullgard <mans@mansr.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/3] clocksource: sun5i: remove duplication of code and data
Date:   Tue, 11 Jul 2023 21:03:06 +0200
Message-ID: <8282256.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20230630201800.16501-2-mans@mansr.com>
References: <20230630201800.16501-1-mans@mansr.com>
 <20230630201800.16501-2-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 30. junij 2023 ob 22:01:26 CEST je Mans Rullgard napisal(a):
> Move the clocksource and clock_event_device structs into the main
> struct sun5i_timer, and update the code for the new layout.  This
> removes a lot of duplication of both code and data.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


