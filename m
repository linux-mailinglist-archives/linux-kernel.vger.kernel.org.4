Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23965B7B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjABWq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:46:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C5F9FDF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 14:46:25 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so21852817wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 14:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AtjE2laAJrZAoAMWshDqVzFKF504AUwZ6NedPp+9YuQ=;
        b=P5/6AyIJgcQNS6IYUPS34oUqK976qWEONc7RwLTazUhwO6g6TaMKbI0LbilkfcF83h
         VPPDp1eklbMvC51m3kpauXl1jG8MpTUUkSojAeIA8PRw0hWQr6A+8PlKRNWeA30zZlJr
         UPpnRRTZAAmL5CphI/WXDqehKD57xX1fE2b89UWgjbKayTKH3vq6HmTTCVXjBPKygqoK
         DgIpA8VxixIPmblaBUbIBSgzwZY/HyDhTtiuZ2UXazMeTUWNZMAW9x3L4wDPvxSVN4cY
         3J7RMbhHAePyVh1B/PqDH3o75/u6FRk7upJ74Dcf7ivHzppS9a4i8zvecTKHwMhyZt/z
         pzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtjE2laAJrZAoAMWshDqVzFKF504AUwZ6NedPp+9YuQ=;
        b=XPbxBgTRBxXXvckhAVp9Vlsa13iCFcMdDAnd/Xve4UYDCbe6U85G6SKWjguGCTsPz3
         rxt0punkKg2RSnDbbHX470LJKDKKuccMI/kU0mYSFUnb+wREG/noIY7aQcmpUy07U/Nx
         +FSm57M8a7UUfM5sNPhFsCHOtad0UAial2/X9wUTsCv25d3FsdzQVOaQhpDycYle1dwD
         GLVwATNeOCZ5odpdm79hCcTVswBsqnoPG2JhIiU42R3dCVWtV+GCqyGFMm7dYu8kE3XL
         5BnJPFm8ZBJNtHhOXl0moS6uSTj0OCFZaLuGEnXTNQf3rdOZJxRrtQ5bC4EWkTqy0Y9+
         NEpg==
X-Gm-Message-State: AFqh2kowC+F4rVasLl05hxq1KQDxqvFq8SIeEhfOiHkXvi4eoAI3etOY
        22ycyTgyQkqFQgiEQW88J3jKdnnvZ8oXJpH93iiYwA==
X-Google-Smtp-Source: AMrXdXtzp0g8dvonkcKIyjtQyCf0nDodsli8WXgpe/SYWHilPvgZt+uSgJjcbu29puuYehlYbW2bGlMBBB/d1lJqQJM=
X-Received: by 2002:a05:600c:4e44:b0:3d1:e2e9:573a with SMTP id
 e4-20020a05600c4e4400b003d1e2e9573amr2070525wmq.106.1672699584506; Mon, 02
 Jan 2023 14:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20220111033333.403448-1-peng.fan@oss.nxp.com> <20221221105508.3ukfhevdn2fv6aud@pengutronix.de>
In-Reply-To: <20221221105508.3ukfhevdn2fv6aud@pengutronix.de>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 2 Jan 2023 15:46:13 -0700
Message-ID: <CANLsYky2L6p7uAPzc_X6ka464LSJFzhRzm+oi5XCkR78Rs0D6w@mail.gmail.com>
Subject: Re: [PATCH V2] remoteproc: imx_rproc: use imx specific hook for find_loaded_rsc_table
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 at 03:55, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi,
>
> On 22-01-11, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > If there is a resource table device tree node, use the address as
> > the resource table address, otherwise use the address(where
> > .resource_table section loaded) inside the Cortex-M elf file.
> >
> > And there is an update in NXP SDK that Resource Domain Control(RDC)
> > enabled to protect TCM, linux not able to write the TCM space when
> > updating resource table status and cause kernel dump. So use the address
> > from device tree could avoid kernel dump.
> >
> > Note: NXP M4 SDK not check resource table update, so it does not matter
> > use whether resource table address specified in elf file or in device
> > tree. But to reflect the fact that if people specific resource table
> > address in device tree, it means people are aware and going to use it,
> > not the address specified in elf file.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Update commit message
>
> What is the status of this patch?
>

That one has obviously slipped through the cracks...  It boggles my
mind that nobody, i.e Peng, has reminded me of it, which raises
obvious doubts about the real necessity of the patch.

Marco - do you need this patch and if so, are you in a position to
provide a Tested-by?

> Regards,
>   Marco
>
> >
> >  drivers/remoteproc/imx_rproc.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 7a096f1891e6..0bd24c937a73 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -499,6 +499,17 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
> >       return (struct resource_table *)priv->rsc_table;
> >  }
> >
> > +static struct resource_table *
> > +imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
> > +{
> > +     struct imx_rproc *priv = rproc->priv;
> > +
> > +     if (priv->rsc_table)
> > +             return (struct resource_table *)priv->rsc_table;
> > +
> > +     return rproc_elf_find_loaded_rsc_table(rproc, fw);
> > +}
> > +
> >  static const struct rproc_ops imx_rproc_ops = {
> >       .prepare        = imx_rproc_prepare,
> >       .attach         = imx_rproc_attach,
> > @@ -508,7 +519,7 @@ static const struct rproc_ops imx_rproc_ops = {
> >       .da_to_va       = imx_rproc_da_to_va,
> >       .load           = rproc_elf_load_segments,
> >       .parse_fw       = imx_rproc_parse_fw,
> > -     .find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> > +     .find_loaded_rsc_table = imx_rproc_elf_find_loaded_rsc_table,
> >       .get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
> >       .sanity_check   = rproc_elf_sanity_check,
> >       .get_boot_addr  = rproc_elf_get_boot_addr,
> > --
> > 2.25.1
> >
> >
