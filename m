Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8262708A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjERVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjERVK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:10:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25BE19B;
        Thu, 18 May 2023 14:10:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so244133a12.1;
        Thu, 18 May 2023 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684444255; x=1687036255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI4smLlSJQa1VUvNaW8lamLC6dslVSxDe/wJI7MniGI=;
        b=hItu/BGU0+PVAlYm6Nh0rvKnuIveJYvyGEWRQPr/b+IEZ7iGXUmd9aQ8W3FdDfGtQS
         rxxqgy+leUxEePBq4hRv8BBi0qwDkWlso61yVgclPuPFdEiRH0om8VivCurHbvla2KTf
         60wIUBu2UBHHOuAMZ7jW2vv6VuopgHCahmO/6tjyfxklEteVhDfAkb8PpvQ2FfqqDzhA
         TC4qnVOsgwlroXwo7Z4ZgcQHYJnuwXgGI8vb8I/RchoWnUzcrDur6H83h//qg8WqV1HM
         vDm+bClF98Er2njckzbBlfLDPhY6oHEaLXGKUyYydc8qJxMuf1owB5Ygq6ofSfIsHR/1
         kFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684444255; x=1687036255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI4smLlSJQa1VUvNaW8lamLC6dslVSxDe/wJI7MniGI=;
        b=ZfA4h1JftliNYC0jKUGl2j+SjyFfUWIxjpvfozKSt3A+Xez3Ep8ZRlfBzDwZtOFk8P
         odz/OX4nP81UQ8/eLR/GFT3LQDFIdy8FO3VlBq7c20TycHZWNg8+nXuQkVI9lknBVFRu
         rErpWAPeqxNfsncBI4EOpOmIpVFEEuYwPALea4DJG5A6AXj2sFKh2SRIBsklZ54VA51e
         d2fSpkPumzAFt0leey8i6Ta0Nqr20VdT4Yi6VzCPXqsmh1QBBK8/pmdQg9kkqGfJ1cpy
         Yq5U/60eu1/DcgN097SSG5Dln8+Bt9Uk+aCla3Q56xR9qGZSZdal3ubVj0Jp7oS6mjth
         zbjw==
X-Gm-Message-State: AC+VfDzAjVyVtr5kLCIo9dUR5y9mhzivbWnytKSXa1QOSf1k3QnSvZum
        E3Vj0Vg8qsGQ73TiZy3Ukzc=
X-Google-Smtp-Source: ACHHUZ6DRTl8lUvOL7gbwUgr1bTmPBUj3TbeE9SqccluLW00wGjdEREweB6x3b1roF7SFmjuLSEFVQ==
X-Received: by 2002:a05:6402:274e:b0:510:e8dc:f2a7 with SMTP id z14-20020a056402274e00b00510e8dcf2a7mr3498982edd.7.1684444255247;
        Thu, 18 May 2023 14:10:55 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id dy1-20020a05640231e100b0050bc4600d38sm960823edb.79.2023.05.18.14.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:10:54 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, wens@csie.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andre.przywara@arm.com,
        Ludwig Kormann <ludwig.kormann@ict42.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] arm: dts: sunxi: Add ICnova A20 ADB4006 board support
Date:   Thu, 18 May 2023 23:10:53 +0200
Message-ID: <1850875.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20230510111528.2155582-1-ludwig.kormann@ict42.de>
References: <20230510111528.2155582-1-ludwig.kormann@ict42.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 13:15:26 CEST je Ludwig Kormann napisal(a):
> Add board support for ICnova A20 SomPi compute module on
> ICnova ADB4006 development board.
> 
> I rebased the series on v6.4-rc1, I'm also using a new
> mail address because of bouncing issues.
> 
> v4:
> - rebase on v6.4-rc1
> 
> v3:
> - drop stray blank lines at end of files
> - separate patch for bindings
> - update licensing to "GPL-2.0 OR MIT"
> - fix typo: ICNova -> ICnova
> 
> v2:
> - use short licensing header
> - remove deprecated elements from led nodes
> - disable csi power supply
> - add missing pins in usbphy node
> - split dts into SoM dtsi and carrier board dts
> 
> v1 of this patch was sent to the uboot mailing list [1].
> 
> [1] https://lists.denx.de/pipermail/u-boot/2023-April/514605.html
> 
> Ludwig Kormann (2):
>   dt-bindings: arm: sunxi: add ICnova A20 ADB4006 binding
>   arm: dts: sunxi: Add ICnova A20 ADB4006 board
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   6 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  62 ++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
> 
> 

Applied, thanks!

Best regards,
Jernej



