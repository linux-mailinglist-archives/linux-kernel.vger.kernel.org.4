Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BD6B6D56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCMCK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCMCKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:10:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5580528EBC;
        Sun, 12 Mar 2023 19:10:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z11so6737098pfh.4;
        Sun, 12 Mar 2023 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678673454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es90dgM/38pbbMOCnBftwhrp+O+7jxbqs7ks6Dr8wdE=;
        b=VgilPI+yzP4fqqGo4u+F4viBOj5a5exaQ1WcJB6Q2gzG9voQteIwZoVoM70lbBmkaK
         PdnLkaoubTBDBPpgrSpP7uuBSXSKwMjT47jmSCsna4AoIo+QnrS8PoUQJV7lIE79QzFS
         k69e+OfA51HfJcpNljb34SmIUVvZ9XtK8CX1HQFhTrYNHIrpgPFcPODsE0BgAT7keHvK
         rjjVcatWdmaVB8eO2Ewti+MqRpyG8voW6NxmF4DTD5MlsN0nBdm1gcTXkCj3M1ir7XCW
         lZj1fyS04/US3IfNiuKiC4yLQPCs168pqHAYqcJUy15NJJa9ickIYj2puoQ72qZi2lmo
         5spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678673454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es90dgM/38pbbMOCnBftwhrp+O+7jxbqs7ks6Dr8wdE=;
        b=4YtjgFkCWEvz9R64/FZMrTa01oCZTEgVz66v0kWDJ4QW9uNlOVk+ia1eJKAeuJ9Xp9
         tj1kqdetQumrvqquFf5lLuhBZQtXgizcnetfkjI568BwVpqy4KOny+tljJyk8sEfaqvo
         KBwl5BYgk5rpb65yexBUGRM1oRVMR1WUM1jSetp7St4SMYaA379EjNKwHiKtK2AWXkEx
         bf/YXnJg5JVHn0AvpnFxBneahpWGawYxlEqAhxr9k0yimL++Jt3a2qHIOiEan2BpqQr5
         lYIwabfBDqpxb2akneRRJkccbFi0Q35w7OVNB4u7HhOiA6gLwD81FKSB0PjSckxRVhD4
         Xmpg==
X-Gm-Message-State: AO0yUKU1HpmcKuP4BD8/es22i9a4b3FuGotYmyD3tS03GcfLinWYjO4w
        OzbKn+OsaPd7IsRrYC6BPzjkUUanJ1/G8AunnY8=
X-Google-Smtp-Source: AK7set+/8dQSCJVdJgAdJ+Clg6WwA7GZNKo+t8onyBfkmr7i3E0vhl4O2qwIk5lGYfo/Wm2DdmStpzc5FKf9GmgIjhM=
X-Received: by 2002:a62:1d96:0:b0:61c:67d2:a332 with SMTP id
 d144-20020a621d96000000b0061c67d2a332mr2897579pfd.3.1678673453637; Sun, 12
 Mar 2023 19:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230310163420.7582-1-quic_kriskura@quicinc.com> <20230310163420.7582-4-quic_kriskura@quicinc.com>
In-Reply-To: <20230310163420.7582-4-quic_kriskura@quicinc.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 13 Mar 2023 10:07:50 +0800
Message-ID: <CAD-N9QVT7qaiUbmPapZc5+6XXDVTPeXG4HD4p-n8WSi9FK2CbQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] usb: dwc3: core: Skip setting event buffers for host
 only controllers
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:40=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> On some SoC's like SA8295P where the teritiary controller is host-only
> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
> Trying to setup them up during core_init leads to a crash.
>
> For DRD/Peripheral supported controllers, event buffer setup is done
> again in gadget_pullup. Skip setup or cleanup of event buffers if
> controller is host-only capable.
>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 076c0f8a4441..1ca9fa40a66e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -840,7 +840,11 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
>
>  static void dwc3_core_exit(struct dwc3 *dwc)
>  {
> -       dwc3_event_buffers_cleanup(dwc);
> +       unsigned int    hw_mode;
> +
> +       hw_mode =3D DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +       if (hw_mode !=3D DWC3_GHWPARAMS0_MODE_HOST)
> +               dwc3_event_buffers_cleanup(dwc);

quick question about dwc3_event_buffers_cleanup, there are other
similar sites calling this function.

C symbol: dwc3_event_buffers_cleanup

  File   Function                   Line
0 core.h <global>                   1546 void
dwc3_event_buffers_cleanup(struct dwc3 *dwc);
1 core.c __dwc3_set_mode             152 dwc3_event_buffers_cleanup(dwc);
2 core.c dwc3_event_buffers_cleanup  522 void
dwc3_event_buffers_cleanup(struct dwc3 *dwc)
3 core.c dwc3_core_exit              842 dwc3_event_buffers_cleanup(dwc);
4 core.c dwc3_probe                 1936 dwc3_event_buffers_cleanup(dwc);
5 drd.c  dwc3_otg_update             363 dwc3_event_buffers_cleanup(dwc);
6 drd.c  dwc3_drd_exit               607 dwc3_event_buffers_cleanup(dwc);

For 1, 5, and 6, any need to take care of this situation?

>
>         usb_phy_set_suspend(dwc->usb2_phy, 1);
>         usb_phy_set_suspend(dwc->usb3_phy, 1);
> @@ -1177,10 +1181,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
>         if (ret < 0)
>                 goto err3;
>
> -       ret =3D dwc3_event_buffers_setup(dwc);
> -       if (ret) {
> -               dev_err(dwc->dev, "failed to setup event buffers\n");
> -               goto err4;
> +       if (hw_mode !=3D DWC3_GHWPARAMS0_MODE_HOST) {
> +               ret =3D dwc3_event_buffers_setup(dwc);
> +               if (ret) {
> +                       dev_err(dwc->dev, "failed to setup event buffers\=
n");
> +                       goto err4;
> +               }
>         }
>
>         /*
> @@ -2008,7 +2014,9 @@ static int dwc3_probe(struct platform_device *pdev)
>
>  err5:
>         dwc3_debugfs_exit(dwc);
> -       dwc3_event_buffers_cleanup(dwc);
> +
> +       if (hw_mode !=3D DWC3_GHWPARAMS0_MODE_HOST)
> +               dwc3_event_buffers_cleanup(dwc);
>
>         usb_phy_set_suspend(dwc->usb2_phy, 1);
>         usb_phy_set_suspend(dwc->usb3_phy, 1);
> --
> 2.39.0
>
