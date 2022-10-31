Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D89613257
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJaJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:15:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27746D2E8;
        Mon, 31 Oct 2022 02:15:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so27675034ejb.13;
        Mon, 31 Oct 2022 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7TwjvYNuBTQx7bSJpCvwsU7T5xZI7GJ6V6t+msfW3s=;
        b=YtoDP2wWwbUmxTRehDOaGIGN1GnNV3a0NFQs7iFRYgfhjfaihmwLGTLxzQnbzQGXU5
         EGaVEfJdwOPHRFbCjyT0wTdi9NbmUSrq3AbPOak0QFhG+KA/S7sG/tBbM1Q7tGoBFNBN
         V2YYvqTfLDIWoMx8r6oGP2Tb9cZ2F5AiF/ra9Fkb9AAU6Nu3OfTjkmSlp20L0PFHSVqf
         VaaINVD9CLuqnVeb1ov8fZ8nPWh5NQf8baw2TxRobi68SeSfb8oY1Ot30YxLR3j1uBUz
         s5mT+ca9et0ZA6v1W3u/TUqDjebHMnbZTraWZzrzIfIeQ/jmZtNHUveRBQN+SoDak3Nb
         +DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7TwjvYNuBTQx7bSJpCvwsU7T5xZI7GJ6V6t+msfW3s=;
        b=z8ZBgOP0nJnH8th5K5H8Ta9E1An8rdZgpakx/Y0CGP/vRfE+G6fSgdUUxMJ2z+RIFU
         Akn7By0wkMKcyD4p6BrV6R51TsdrLoThEEVVPAPG78eqso+TvBHqPAftRCbb5ycC3rxQ
         mszQt1Ij6nWVNrOUBm054Zg3Z56jzVUKVYfxK8kof+UfM6Xsmv3wKfP/RvqI5NvdSpWI
         pyeiqbuUkdN1UsSg42MyUfqHRVibBkfwbhT7nqMGY0Ajxup7jZWVafYmhUcIkq7Tmc00
         63uDwrj3kkbSBhytMtDD4ncmMV5RC0AY8HgJ5S9rq5t5EgWl0WyqOlvs7CpaPvBorYGE
         CAQg==
X-Gm-Message-State: ACrzQf1OXuVWJONHIvfzE046YI+bgf3qpk/MCQEm7WBCvOSOKeDqPdnQ
        cYwHWMIQP/LEKy4ku+U/fEMMQSTapoc=
X-Google-Smtp-Source: AMsMyM4ojgBpWutM2rjCIsSZc3d6j1JKupNDLVQUYOV2wnNM6eKqbV1rt+t2ysp1MYsBQrg1TZjcEg==
X-Received: by 2002:a17:907:2e01:b0:78d:f24b:7330 with SMTP id ig1-20020a1709072e0100b0078df24b7330mr11763582ejc.604.1667207722748;
        Mon, 31 Oct 2022 02:15:22 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm2741662ejb.134.2022.10.31.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:15:22 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 18/43] media: sun6i-csi: Add capture state using vsync for page flip
Date:   Mon, 31 Oct 2022 10:15:21 +0100
Message-ID: <4778394.31r3eYUQgx@kista>
In-Reply-To: <20220826183240.604834-19-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com> <20220826183240.604834-19-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 26. avgust 2022 ob 20:32:15 CET je Paul Kocialkowski napisal(a):
> The current implementation requires up to 3 buffers to properly
> implement page flipping without losing frames: one is configured
> before the video stream is started, one just after that and page
> flipping is synchronized to the frame done interrupt. The comment in
> the code mentions that "CSI will lookup the next dma buffer for next
> frame before the current frame done IRQ triggered".
> 
> Based on observations of the CSI unit behavior, it seems that the
> buffer DMA address is sampled when the frame scan begins (in addition
> to starting the stream), which corresponds to the vblank interrupt
> that hits just before the frame-done interrupt of the previous frame.
> 
> As a result, the address configured at the frame done interrupt is not
> actually used for the next frame but for the one after that.
> 
> This proposal changes the page flipping sync point to the vsync
> interrupt, which allows the DMA address to be sampled for the next
> frame instead and allows operating with only two buffers.
> 
> In addition to the change in the sync point, the code is refactored
> to introduce a notion of state that clarifies tracking of the buffers
> with tidy functions.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


