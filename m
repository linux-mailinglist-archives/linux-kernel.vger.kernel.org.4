Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F473F5E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjF0HoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjF0Hn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:43:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0ED10C9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:43:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5769957e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687851832; x=1690443832;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qht7SqGLbmJWzU5hnUhM0fN/sQoDQZIYVELEYjld22w=;
        b=ToU64NKGbR4QsZRo9+hl4zbyIbkqlm7DReyCHhFgL6QpyVntnjtwP+8681XRrbNByJ
         Tnlmtdc0sS2X5sXKrCNiWs+0evI34zlGixJt9aDKFnmXlWEi0BLwQHe+A2G8fHOfX/o8
         5pZO51cwl4mSF3WHn9PP4g8dmohFVEOqi/vhYXrKq08L07DDtvZqRR/ATFxZ3y2uY59k
         dQ+CpkM+GiIlZdt/pXvSPoQFCXh0p1+Vdyd7eyVDCtwSdywhXcZO0E2S32oDvv/RVxXU
         CXdsBWSg9SU0eaLHXRRU1YMZHDPZ7OdIUJaPvjucib/4zlshCNkbG0c8Dv9MZxHina1j
         xnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687851832; x=1690443832;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qht7SqGLbmJWzU5hnUhM0fN/sQoDQZIYVELEYjld22w=;
        b=iNx2nB2EDNfH/lnACbsPbn7/0Kdhcb8lXPWBySLJonjQuAinSXE5/Y0S602WSu2QtG
         5dLBodR9q4GiMZvKXMedfN61JuZwtSWWBpYsXQYiCELQJUskxBXhoxFLiwIIGgEvkAlC
         RP5b3vyQBr8f96lmp8noea+HqU+CLRUoGXTn1/3uBMluF/Mqy1wWNBa36zI8Ol/OMAEl
         EF0CwIEcgvtemKFpGm/8K1Y0/aXAaAzgY/uNKpLP5P08IUUiwwdUrb1zq0is7nAeIYXW
         lu/HTQzzzrEhxIJSvKJbL54jp/5PB/fH8GTD1eqe1A+H4XCCxXHuVp9NRrDoLzSSk4G+
         mZhA==
X-Gm-Message-State: AC+VfDyMRBZfiDf9xBHDMx1Bk+yLfCAvj1F71U/qpiL1bYxiOsfhJnHy
        v9yvOt+V7aueXNWc6jlIMUYnXA==
X-Google-Smtp-Source: ACHHUZ4kfY2DPQ+asW4P38+Dgd5ePOe+T6M/G2eRs9P+TOc/20kSiDtl9r+C7hrsfXlu57oG2I4QeQ==
X-Received: by 2002:a05:6512:1142:b0:4fa:5255:4fa3 with SMTP id m2-20020a056512114200b004fa52554fa3mr3830323lfg.5.1687851832503;
        Tue, 27 Jun 2023 00:43:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cec9:2929:7a19:7afa? ([2a01:e0a:982:cbb0:cec9:2929:7a19:7afa])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c240d00b003f7f2a1484csm9835606wmp.5.2023.06.27.00.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:43:52 -0700 (PDT)
Message-ID: <709fbed2-a7cf-d2fa-da4e-5d417b7130d4@linaro.org>
Date:   Tue, 27 Jun 2023 09:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Tanure <tanure@linux.com>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626-viewless-marrow-17838c2172f6@wendy>
 <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 08:13, Xianwei Zhao wrote:
> Hi Conor,
>      Thanks for you reply.
> On 2023/6/26 18:02, Conor Dooley wrote:
> 
> 
>  > [ EXTERNAL EMAIL ]
>  >
>  > Hey,
>  >
>  > On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
>  >> T7 is an advanced application processor designed for smart display.
>  >>
>  >> Add the new T7 SoC/board device tree bindings.
>  >>
>  >> Add basic support for the T7 based Amlogic AN400 board, which describes
>  >> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>  >> booting up into the serial console.
>  >
>  > Lucas has already sent patches for the T7 SoC & is at v5:
>  > https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-tanure@linux.com/
>  >
>  > There's been a bit of discussion there, and there serial stuff in
>  > particular is different in his series (it doesn't use always-on for
>  > examples).
>  > Could you please go and take a look at his series?
>  >
>  > Cheers,
>  > Conor.
>  >
> AN400 is the reference board designed by Amlogic, which is different from Khadas VIM4.

Please coordinate with Lucas so a single bindings & dtsi patches are submitted,
in any case only a single one will be reviewed and merged.
You can rebase your AN400 dts on top of his VIM4 initial patchset.

Thanks,
Neil

> And T7 serial is the same as S4, so I follow S4 serial.
> 
>  >>
>  >> Xianwei Zhao (2):
>  >>    dt-bindings: arm: amlogic: add T7 based AN400 bindings
>  >>    arm64: dts: add support for T7 based Amlogic AN400
>  >>
>  >>   .../devicetree/bindings/arm/amlogic.yaml      |   6 +
>  >>   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  >>   .../dts/amlogic/amlogic-t7-a311d2-an400.dts   |  30 ++++
>  >>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 156 ++++++++++++++++++
>  >>   4 files changed, 193 insertions(+)
>  >> create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
>  >> create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>  >>
>  >>
>  >> base-commit: 057889cb4244096ea5abcbe76ffd4d311c3078fe
>  >> --
>  >> 2.37.1
>  >>
>  >>
>  >> _______________________________________________
>  >> linux-amlogic mailing list
>  >> linux-amlogic@lists.infradead.org
>  >> http://lists.infradead.org/mailman/listinfo/linux-amlogic

