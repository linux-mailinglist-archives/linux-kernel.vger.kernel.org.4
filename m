Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0535F0F56
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiI3PyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiI3PyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:54:08 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE01B7DBF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:53:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id q11so1874558ilj.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fMrHOKaeUaGX1WccJwBEi7t3ptQ4X5xQo8DEkKDJKx8=;
        b=WwNujd1/o4dE97ROR6xIw8z+9qRrcf0pRUVuKQaCCI2ubAhNxIB5p3OwpVyrxYBlm0
         CxfIRr0YrgJtwLNB3ZOe1kgTY+KSLKmcxuNR0OlwJxa/MakrDxT3OgE7p3RnUKJ0r8wU
         /yf6d3Gc0/zOLE+pOzdXSh62L2jvy2nJCtsfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fMrHOKaeUaGX1WccJwBEi7t3ptQ4X5xQo8DEkKDJKx8=;
        b=H1uUirRZPjz9dBtE9u4wD4ymwLD1xG61yGjdRQ0THIh8Kaeo6alUtnXI0vWycpCVxx
         uavCeEVeNyvPxaOY4FPrLKd4W69/6ghNzLmiY5Bhd6AOcV8+4Z14/Y62+UV+ZV2PcVCK
         SLC8zUFe0Ja4z/NpewAnm8tkI8sGxeqP5A4M46IhGqDafVkTygyEtevBD2DXmy76IYdz
         +g48Qhd68Jy3Btr+6gLmp9obcglQNwuE4CVS7/EI8CZNbJzAvyaSFLbHV6UjOEMcqJjy
         CAfwDaf3533vpiqzOkB4QJ9aTQ2xmINadyElKlKmmtCwrvtr2TD4M7T1Crw4Ftp8e6iF
         A1pg==
X-Gm-Message-State: ACrzQf3aXjyJsFiT1D0YsV0e+f2EGDDqihyXXEv4zkIS+udMEEQKi4hR
        Qah/xu/QEu8sqn4iyPDVWgggp6Fvybj7+YWz
X-Google-Smtp-Source: AMsMyM5suooUEMx/Ek0ewz128cihtgfgGW1WYzKkHKGkbL2uqcFUfcevpwKwbldYMIR/iP8vapTArQ==
X-Received: by 2002:a05:6e02:1e06:b0:2f9:4efc:eb90 with SMTP id g6-20020a056e021e0600b002f94efceb90mr2352507ila.178.1664553231847;
        Fri, 30 Sep 2022 08:53:51 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id b26-20020a02a59a000000b0034c10bd52f5sm1057345jam.125.2022.09.30.08.53.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 08:53:50 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id z191so3581562iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:53:50 -0700 (PDT)
X-Received: by 2002:a05:6638:2046:b0:35a:ce4a:13a2 with SMTP id
 t6-20020a056638204600b0035ace4a13a2mr5059371jaj.164.1664553229811; Fri, 30
 Sep 2022 08:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220930073754.1391044-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220930153538.v5.3.I50d04dcbe735dda69995cf1078824d671501869e@changeid>
In-Reply-To: <20220930153538.v5.3.I50d04dcbe735dda69995cf1078824d671501869e@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Sep 2022 08:53:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WB5470LMC4w9sKzn+TxiD6keKKwJn3FqG_PS9T3ajreg@mail.gmail.com>
Message-ID: <CAD=FV=WB5470LMC4w9sKzn+TxiD6keKKwJn3FqG_PS9T3ajreg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: Add touchscreen and touchpad
 support for evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 30, 2022 at 12:38 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> Change touchpad and touchscreen node for evoker
> Touchpad: SA461D-1011
> Touchscreen: GT7986U
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
>
> (no changes since v1)

nit: for patman, add:

Series-changes: 5
- Touchscreen / trackpad patch new for v5.

...and then you won't get the confusing "no changes since v1" message.

>  .../boot/dts/qcom/sc7280-herobrine-evoker.dtsi  | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> index e78072159d54b..c26f19371c8bc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> @@ -23,16 +23,15 @@ ap_tp_i2c: &i2c0 {
>         status = "okay";
>         clock-frequency = <400000>;
>
> -       trackpad: trackpad@2c {
> -               compatible = "hid-over-i2c";
> -               reg = <0x2c>;
> +       trackpad: trackpad@15 {
> +               compatible = "elan,ekth3000";
> +               reg = <0x15>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&tp_int_odl>;
>
>                 interrupt-parent = <&tlmm>;
>                 interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>
> -               hid-descr-addr = <0x20>;
>                 vcc-supply = <&pp3300_z1>;
>
>                 wakeup-source;
> @@ -43,18 +42,16 @@ ts_i2c: &i2c13 {
>         status = "okay";
>         clock-frequency = <400000>;
>
> -       ap_ts: touchscreen@10 {
> -               compatible = "elan,ekth6915";
> -               reg = <0x10>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;

Why did you remove the pinctrl? Those should have stayed.


> +       touchscreen: touchscreen@5d {

nit: it's nice to keep the touchscreen label the same as the other
herobrine boards, so I'd keep this as:

ap_ts: touchscreen@5d {


> +               compatible = "goodix,gt7375p";
> +               reg = <0x5d>;
>
>                 interrupt-parent = <&tlmm>;
>                 interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
>
>                 reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
>
> -               vcc33-supply = <&ts_avdd>;
> +               vdd-supply = <&ts_avdd>;

What you have here is fine, but I've heard rumors that we might end up
needing to specify a different IO voltage rail. Right now the goodix
bindings / goodix driver don't handle that. ...anyway, no action items
for you right now but just a heads up.

-Doug
