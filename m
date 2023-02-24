Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379FB6A1CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBXNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:17:22 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E805EEFA;
        Fri, 24 Feb 2023 05:17:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id fd25so7076420pfb.1;
        Fri, 24 Feb 2023 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qYxoWPSADwk2ctvIlv0tQaBOl/ue0eeRxizjAWjDaII=;
        b=as25OEHfghOe0GQ4ZQp14Unllm7YNJtGgiueV9sjuMtmtDOPJtCSvPfS4kgPtSPhZw
         M58fGnKbreJfBhmKDA1wZxodjgYtkryPA+HxmuWZPv3Iz3UfllHqDdLWbK7aZYY+PsDv
         iAkS1gKBwi9zN7cnYbwJ+Gw0n9RDyHv9JKPu5+XGRzvplfxFCoUUyhk8i5xc1NPqRhHq
         xStiCB8k0htHlHiMijbPOGnzEa+jiRNPD8Jqoj94WYhJTsKmTwOkm14sikdnHPDSK/0F
         NS4kFYft3sXTT/IT6+NDmu/YRyoOqd9S2nSPtUewyXNwCbLxls/ydr9/bbNL9Bxjajvg
         00NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYxoWPSADwk2ctvIlv0tQaBOl/ue0eeRxizjAWjDaII=;
        b=XUkNgroOQf0U6HaIowXVQvBiR0BgL2k3fLcy8bTJHJQgZp65Mub3CeYa74/5BrvOJh
         6EMfk6S6Z1/0GbBu7ekC3OubMa4ru5LvrHBkFtUrdQHt3s8dZy6/LhX0buXRscqYwJsf
         ybt9Go30f/UTepk2sr6oP73umsLVP/GmqxVZy0TBM9bJgZrD6wFG4Pk/ltx7pM3KBmiM
         A2oQNJaXvk0F+ywBNkdCTf0iWCddQ9QY7wSG72NGi1B8C2Arg+O+R5LX80niM/raXz4F
         dQ4efxxtv5MGArdaq683NygIoGRlmMCO2fR1N9E8+6e7IETnyuPIx+9aJ+CdrXNr8wlt
         yypA==
X-Gm-Message-State: AO0yUKVLWUjZQh423pRXFzgKSv22qg7SWnR7fAni6BTmfMB6GfRb5/tr
        5YRfhQwyEausvDIf5pqz+OnPdirmEKBG3hJSRDXzNDBDigntpfTn
X-Google-Smtp-Source: AK7set/zyX3pyRijOb6XfW7vKqQFHHcKpADURXXdbQxxacT8uz5rH1REmL+utcRTAi2ODG6MspHyz3HG280gGeNBm3A=
X-Received: by 2002:a63:3e41:0:b0:4df:6f34:48f8 with SMTP id
 l62-20020a633e41000000b004df6f3448f8mr3027644pga.8.1677244637812; Fri, 24 Feb
 2023 05:17:17 -0800 (PST)
MIME-Version: 1.0
References: <CAD-N9QX5i5toj8cs7DxBjYWtRGf3ZRnfTAf809sFW6iX0Ktfmw@mail.gmail.com>
 <20230224130235.4028566-1-void0red@gmail.com> <Y/i33HL2e9UwUpd8@kroah.com>
In-Reply-To: <Y/i33HL2e9UwUpd8@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 24 Feb 2023 21:14:30 +0800
Message-ID: <CAD-N9QVTxUSiCnprnXw=i4NVWbKFg2dZrkB0rqV2E4jzPeXAeA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: replace kzalloc with devm_kzalloc in
 mv_udc_probe and add a check for this allocation.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     void0red <void0red@gmail.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, eriri <1527030098@qq.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 9:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 24, 2023 at 09:02:35PM +0800, void0red wrote:
> > From: Kang Chen <void0red@gmail.com>
> >
> > This driver uses the unified memory management api, so replace
> > kzalloc with devm_kzalloc to avoid a memory leak and add a check
> > for this allocation.
> >
> > Reported-by: eriri <1527030098@qq.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081
> >
> > Signed-off-by: Kang Chen <void0red@gmail.com>

Please remember to send a v2 patch. Otherwise, gregkh's bot will
notify you that this is an already-sent patch.

> > ---
> >  drivers/usb/gadget/udc/mv_udc_core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> > index b397f3a84..08474c08d 100644
> > --- a/drivers/usb/gadget/udc/mv_udc_core.c
> > +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> > @@ -2229,7 +2229,11 @@ static int mv_udc_probe(struct platform_device *pdev)
> >       INIT_LIST_HEAD(&udc->status_req->queue);
> >
> >       /* allocate a small amount of memory to get valid address */
> > -     udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
> > +     udc->status_req->req.buf = devm_kzalloc(&pdev->dev, 8, GFP_KERNEL);
> > +     if (!udc->status_req->req.buf) {
> > +             retval = -ENOMEM;
> > +             goto err_destroy_dma;
> > +     }
> >       udc->status_req->req.dma = DMA_ADDR_INVALID;
> >
> >       udc->resume_state = USB_STATE_NOTATTACHED;
> > --
> > 2.34.1
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
