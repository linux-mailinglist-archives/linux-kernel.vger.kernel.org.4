Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6F5EEF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiI2Hdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiI2Hdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:33:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7CB137E49
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:33:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m4so770490wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=atACqxLtygvoatmuSiOUnja6i+2u6x+rxoy2apBcCBk=;
        b=hsOEJmFhBKFbH0GhXrJKHUxne+LtxAIa76tyBJcZVLXdKpf4nNr26PhlcBT0DRGqsm
         u4nuyhxyohof8xdQKBda/RvQmhKqfjCx8qM5PEasl4ZvbvmxGbni5+mHouFrF/43VcRM
         pSBwbvxUWK4SSh9wc+kYLKRJUXOx4r1Nb3x51OvHtGu+/6qrLq3Ug5Vebf5RDlo+FDcU
         LHybNFRvEDSCPfiDF0nKF+DPjqPto6PRCqG7jkfKwHgg3dgAISMTNaYA+qTCvDg9zqQG
         CF0s8xmsf/Tbm4azqMxygMUlqueRh71Bd8kORz1GFVoFS69QrqS4/VZdBmHwIj0bEbLq
         ClDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=atACqxLtygvoatmuSiOUnja6i+2u6x+rxoy2apBcCBk=;
        b=hqgiJAuazcKjkAhCGrPeFiRAvcmce9ZcHpEsjTtstnnJzHbsr/gyhP6GBYf8yxhXkX
         OauCv5NGZme90y8gkYqc/ozkhSf8hiu0+YX2+DA+JpoO+fKuN1y5TmsppKzJFfZDR68I
         K9MXz6s4pxyrKFv01neXDMzjgWAJ8Rqbz304hW3Jtx8FtkJdZbkx/2Cs3AKvaL3dIp0X
         kYjYpsyAnwksLTQQixsaFi3G5udUIEdoNyKMAVc8dfO1S42bLMtgpdY7eL+qyInsrYFT
         SG/meqotJOLN/42XrMQFMNeQ1Ji4y2z1jUFVTj4yv4OB4V2TkMK8ooPnUeDBOzUd7itS
         GXIw==
X-Gm-Message-State: ACrzQf2FPnDs5owN8oJjuqaf28OebNFfvi07FdTjUrAWlNyRm76x6Ae2
        oGVc/HIE13UR9Ik3uhCy2Be0Iw==
X-Google-Smtp-Source: AMsMyM6sIk+geTplcvfjy0CSHqROztZRtQXufyAJK/PvCo/0f+wQZHMLaRAfjTq5ogK56olIr125cA==
X-Received: by 2002:a5d:4c4c:0:b0:22c:cb1f:f7dc with SMTP id n12-20020a5d4c4c000000b0022ccb1ff7dcmr1077874wrt.504.1664436811363;
        Thu, 29 Sep 2022 00:33:31 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id u4-20020adff884000000b0022a2dbc80fdsm5950328wrp.10.2022.09.29.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:33:30 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:33:27 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH RFT 0/5] crypto: rockchip: add crypto offloader V2
Message-ID: <YzVKR0DjpXT/bB8J@Red>
References: <20220927080048.3151911-1-clabbe@baylibre.com>
 <YzNsgjPFwVEDo4E4@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzNsgjPFwVEDo4E4@aurel32.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Sep 27, 2022 at 11:34:58PM +0200, Aurelien Jarno a écrit :
> On 2022-09-27 08:00, Corentin Labbe wrote:
> > Hello
> > 
> > Rockchip rk3568 and rk3588 have a common crypto offloader IP different
> > than rk3228 one.
> > I started to work the driver for this IP on a rk3588 based board, but this SoC
> > is still not upstream.
> > So it is why I send this serie asking for test since I own no rk3568 and
> > I need to be sure datasheet is right.
> 
> I did a quick test, and it doesn't seem to work. I get:
> 
> rk3588-crypto fe380000.crypto: DMA timeout
> rk3588-crypto fe380000.crypto: DMA timeout
> 
> That's on an ODROID-M1 board, so with the set of patches I sent
> yesterday to support it.

Thanks for testing it, probably I did something wrong because I got a successfull test by someone on #linux-rockchip.
But I dont know on which board it is, and it was on my debug tree, so probably cleaned something wrong before sending the patchs.

If I sent you a link to my tree, could you retry ?

Regards
