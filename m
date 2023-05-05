Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307C6F7FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjEEJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjEEJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:24:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24DD19419
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:24:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55a1462f9f6so13757437b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683278664; x=1685870664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FK82kPhBQfwfGm8HI7fyDC8VoWXm1AFyz6LGL+3R3sw=;
        b=akT7mIcVV2kXxkHe6uDCT5SflyjEOh4RvrGbk00dVX8SdBk20aobdKrgnzI/v38X+D
         FbU6nOKBu2nuZlqOUFXOBiPNHc9H1LOiz6C9bwI42VsMqkSyEVd7RRGC7I3B+zuoo3kr
         40jJvtbc175hwsRKMxIYLzMEAmBnd/hsbTCfQRO7Nc2wjuecWi+DvUfipsqe09vnAdFL
         Up6sBYJcd74L+pI7/6XdG9vMdf4yBt1buzBe0RHL3dNOa34SuONqkqTscn0In2a98UVa
         WfRpVMEcANPpDWRtHtfiVKnUUhE5pCKrNi1Gyhr3E6caFRnauwqAHxdWhE+L2++SWl4u
         lvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683278664; x=1685870664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FK82kPhBQfwfGm8HI7fyDC8VoWXm1AFyz6LGL+3R3sw=;
        b=Ix6q9mJTLbAUfL8iDxk4UC0jxoz7RvEQcVKKRSff6LeHVwxwmQRgE757K2JC+XojLI
         rAIcV4q+TGNAwDNQ0swm0PifHrOEIu03rMyYWBh6gemnU7xoRcMvXQhvciLf5JyLcJZz
         +rvUVc7gSeCopsiOmP78SyRM/9jUDGVDAr3uP082FS1/Monf22Qc8TWdYA7vqgz/7Wp6
         eV5Ouuo+55VbUgsRrpsuC9l5Jb8HTIfjUvCBaqKdEMp2h8RTh5fvlL9WnJDh+C0rNG52
         gAp6PRRUgPekiEOOxZ9D9j6qQwUNwS5BHcaOTL0ibqY0SRAVsnTKlZhN8nHPiqW9HtTd
         UHzg==
X-Gm-Message-State: AC+VfDzgVow3GfZUQ9dTt5n3WdnDffW0Vu2R4kUuEORXAhYdBSw/Qb6q
        1cdK9x2AjgTxD8YEvmTru30X96uIeMzpf2xpShsvCETCnr4dtnlX
X-Google-Smtp-Source: ACHHUZ4n6gTzLIoweHXd005P5Sl/ssdga0SDHi/+ZDFM+IlhH4HHtCEn3CZk9uwywTgKenT20gzKH9mheylDBUxNpHQ=
X-Received: by 2002:a81:6b43:0:b0:55d:8abe:21a7 with SMTP id
 g64-20020a816b43000000b0055d8abe21a7mr845672ywc.48.1683278664094; Fri, 05 May
 2023 02:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683183860.git.quic_varada@quicinc.com> <0ac9037a184bf95d4532f37cdd91007af58942ed.1683183860.git.quic_varada@quicinc.com>
In-Reply-To: <0ac9037a184bf95d4532f37cdd91007af58942ed.1683183860.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 5 May 2023 12:24:13 +0300
Message-ID: <CAA8EJprLG_-bw16PtPm9gLFWqCqMes45VP9wEeJA4KEv8reGAg@mail.gmail.com>
Subject: Re: [PATCH v10 9/9] arm64: dts: qcom: ipq9574: Enable USB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 at 11:24, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Turn on USB related nodes
> Provide vdd info
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v10:
>         - Provide vdd info
>
>  Changes in v5:
>         - Move "host" mode specification to board dts
>         - Due to dependency with earlier patches board dts
>           filename changed ipq9574-al02-c7.dts -> ipq9574-rdp433.dts
>
>  Changes in v2:
>         - Fix node placement and coding style
>         - "ok" -> "okay"
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 1f5d14f..18d642c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -70,6 +70,10 @@
>         };
>  };
>
> +&dwc_0 {

If the node alias was usb_0_dwc3, it would have been next to the main
usb_0 node. Could you please fix the alias.

> +       dr_mode = "host";
> +};
> +
>  &pcie1_phy {
>         status = "okay";
>  };
> @@ -122,6 +126,21 @@
>         clock-frequency = <32000>;
>  };
>
> +&usb_0_qmpphy {
> +       vdda-pll-supply = <&mp5496_l2>;
> +       vdda-phy-supply = <&fixed_0p925>;
> +
> +       status = "okay";
> +};
> +
> +&usb_0_qusbphy {
> +       vdd-supply = <&fixed_0p925>;
> +       vdda-pll-supply = <&mp5496_l2>;
> +       vdda-phy-dpdm-supply = <&fixed_3p3>;
> +
> +       status = "okay";
> +};
> +
>  &tlmm {

If sorted alphabetically, 'u' comes after 't', so these two chunks are
out of order and should be fixed.

>
>         pcie_1_pin: pcie-1-state {
> @@ -188,6 +207,10 @@
>         };
>  };
>
> +&usb3 {
> +       status = "okay";
> +};
> +
>  &xo_board_clk {
>         clock-frequency = <24000000>;
>  };
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
