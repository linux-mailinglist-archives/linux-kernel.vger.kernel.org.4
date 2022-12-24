Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31D6559E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 12:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiLXLN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 06:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLXLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 06:13:25 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50EDEE3A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:13:22 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c124so7552823ybb.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+T3Wi0FxR+aQY00oUGjtUElYaHTEjFLNV0YO6IaCnFM=;
        b=h9NJv1kP89kJ0GRcE9rjnc9YCWp4VMHvr8ipvZd7g47/fBlTBStvfj/laeLc8/ZWsD
         V6IcD9VA8qRhL8mwoqQFlpnQhyQOCp9+Ws/f3jdZ7EBR5d9sgBPouZdU2KD3q21J+0Ae
         6HlcYgtwZ2/C6xwPx0oxIwZBOEpIzx/BoHBHi4gGWiBHsrTZNCPFZX0CVmHLdjni4zOv
         9S6Yo1COwWNOdWNDzkk2x7pzyhodJw3hQ16bGBrlDncDmJTzpU0C8cVxWqR7Jylxy2Aw
         MkQL35cKpcdk3hkQUBrQafmtADcPfeiUWQFqYOFB2We6o9Ip3h8DaryqoqP075yi1+AZ
         f+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+T3Wi0FxR+aQY00oUGjtUElYaHTEjFLNV0YO6IaCnFM=;
        b=ieEc8N37FvydZO+NyBkcb8Dn2V3layPuyTsQhmnMjkI4UysILvQ54gKnPXdUxdcgLo
         Kz8wU4QH4s308rAw8B03Ez9/tiFBL3HV1FBik9+7qkamdSjhdnaDE512gdKlIgPxy4Gt
         Ll5D6+3C67r0uJ6aR2TjEp2Lm1qV8yl850tDrc1Ql2Xqj6hazKE3KNFtjMjRENF5D+fj
         EEG3t+JzEkb8PSQSeEDaJzjJ59Lko/Assonksv2ZX6DqKJDO23G1iIuaxNvnHZrlGbea
         MuHgd2oSp15Yt9sm07YCCsdHDDagHGb/MDnz9HJS2jilcCrN4RLCon8H+h1wVwzl89uj
         Zvbw==
X-Gm-Message-State: AFqh2kp5/3sKvLrXRbGbOz6rwsrFJvRyUzBY/0W2jtYTupGb2xly4p3N
        OcIGIaxoNwvsfpwdvm2lJzfOkcHuHDB87TkDAc60FQ==
X-Google-Smtp-Source: AMrXdXsdBrBzp3zIBNfzByhXKd6O3hYee5f3EPjHDp6AKPkLSeGQkpzTN0Cw8ffKmOR7kJb9uytDzpFHXF6QEkIqiDA=
X-Received: by 2002:a25:aa0d:0:b0:76d:bea0:8a05 with SMTP id
 s13-20020a25aa0d000000b0076dbea08a05mr391174ybi.153.1671880401925; Sat, 24
 Dec 2022 03:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20221223233200.26089-1-quic_wcheng@quicinc.com> <20221223233200.26089-9-quic_wcheng@quicinc.com>
In-Reply-To: <20221223233200.26089-9-quic_wcheng@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 24 Dec 2022 13:13:11 +0200
Message-ID: <CAA8EJppsK=L69AaBgj=MzWp-ess3NSn=gPYf8-3QtJVqEVqGzw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/14] usb: dwc3: Add DT parameter to specify maximum
 number of interrupters
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2022 at 01:33, Wesley Cheng <quic_wcheng@quicinc.com> wrote:
>
> Allow for the DWC3 host driver to pass along a XHCI property that defines
> how many interrupters to allocate.  This is in relation for the number of
> event rings that can be potentially used by other processors within the
> system.
>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 12 ++++++++++++
>  drivers/usb/dwc3/core.h |  2 ++
>  drivers/usb/dwc3/host.c |  5 ++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 476b63618511..67d6f0ae81d2 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1446,6 +1446,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>         u8                      tx_thr_num_pkt_prd = 0;
>         u8                      tx_max_burst_prd = 0;
>         u8                      tx_fifo_resize_max_num;
> +       u8                      num_hc_interrupters;
>         const char              *usb_psy_name;
>         int                     ret;
>
> @@ -1468,6 +1469,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>          */
>         tx_fifo_resize_max_num = 6;
>
> +       /* default to a single XHCI interrupter */
> +       num_hc_interrupters = 1;
> +
>         dwc->maximum_speed = usb_get_maximum_speed(dev);
>         dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
>         dwc->dr_mode = usb_get_dr_mode(dev);
> @@ -1511,6 +1515,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>                                 &tx_thr_num_pkt_prd);
>         device_property_read_u8(dev, "snps,tx-max-burst-prd",
>                                 &tx_max_burst_prd);
> +       device_property_read_u8(dev, "snps,num-hc-interrupters",
> +                               &num_hc_interrupters);

bindings change?

> +       /* DWC3 core allowed to have a max of 8 interrupters */
> +       if (num_hc_interrupters > 8)
> +               num_hc_interrupters = 8;
> +
>         dwc->do_fifo_resize = device_property_read_bool(dev,
>                                                         "tx-fifo-resize");
>         if (dwc->do_fifo_resize)
> @@ -1589,6 +1599,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>         dwc->imod_interval = 0;
>
>         dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
> +
> +       dwc->num_hc_interrupters = num_hc_interrupters;
>  }
>
>  /* check whether the core supports IMOD */
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8f9959ba9fd4..09037299da53 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1050,6 +1050,7 @@ struct dwc3_scratchpad_array {
>   * @tx_max_burst_prd: max periodic ESS transmit burst size
>   * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
>   * @clear_stall_protocol: endpoint number that requires a delayed status phase
> + * @num_hc_interrupters: number of host controller interrupters
>   * @hsphy_interface: "utmi" or "ulpi"
>   * @connected: true when we're connected to a host, false otherwise
>   * @softconnect: true when gadget connect is called, false when disconnect runs
> @@ -1275,6 +1276,7 @@ struct dwc3 {
>         u8                      tx_max_burst_prd;
>         u8                      tx_fifo_resize_max_num;
>         u8                      clear_stall_protocol;
> +       u8                      num_hc_interrupters;
>
>         const char              *hsphy_interface;
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f6f13e7f1ba1..52a284fdd704 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -66,7 +66,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
>
>  int dwc3_host_init(struct dwc3 *dwc)
>  {
> -       struct property_entry   props[4];
> +       struct property_entry   props[5];
>         struct platform_device  *xhci;
>         int                     ret, irq;
>         int                     prop_idx = 0;
> @@ -112,6 +112,9 @@ int dwc3_host_init(struct dwc3 *dwc)
>         if (DWC3_VER_IS_WITHIN(DWC3, ANY, 300A))
>                 props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
>
> +       props[prop_idx++] = PROPERTY_ENTRY_U8("num-hc-interrupters",
> +                                                               dwc->num_hc_interrupters);
> +
>         if (prop_idx) {
>                 ret = device_create_managed_software_node(&xhci->dev, props, NULL);
>                 if (ret) {



-- 
With best wishes
Dmitry
