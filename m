Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2309D6A8173
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCBLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCBLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:45:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9694428215;
        Thu,  2 Mar 2023 03:44:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f13so66425750edz.6;
        Thu, 02 Mar 2023 03:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgcX8EGXFFs2CYAQ3n8aThDVhsTDFrs3NdW4ctHY4fI=;
        b=k5pBQ8EP3iwiWTbhaShkulqMWgkrbM2hVwe1H6anDQtIVT6cg0EQaXQyxYcvHO9Lpi
         td2XNaPoaZBCfQrclY379j2IphVl46ic5NXrqpoVLQlMVLoBAyutC5jqpEcR8L2+aDM9
         fwm1bAUEWKvnQUgeHPmfuwm7IkNmrY9jt/EKHffZ29R7xjJCBzd2cOlzQl2jMz44JVPZ
         pspHtzNLAUwYSuji4TBsG3HzN+hlKQGnlkwzziFBfgN3ZauZ1MTXEw6EBcygPS+f0O/U
         wecSYNdT/fIb3J/AsWkOfOxGTghg1EfoPbYhmOAGR9xRw1+UKgtzuxJH+nZiXzRTVxIa
         0luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgcX8EGXFFs2CYAQ3n8aThDVhsTDFrs3NdW4ctHY4fI=;
        b=lYLjN7NTmAoBLpRPeGUBumMWi7oIfzvkPNsP22OMtqHqkP9MGBHUYKchFf5JhA/uCq
         D2Pr41JQZZyEfZBmFKhqqVu8yEv6WfNpiwrfKIIEc60niWcs0AWNiWPu4TnHM7RwsKmO
         sSwuzyj+T/WlbZs9agHFld9FbW5qd/DNFnTx2q8UXUyli0QRZY7U03K1vSI7C+hzsNbX
         NUGMR6q2MUzSUXtl7cd841Ssdr1AsfZPImQupxGKlvJY8419RCFNdjbQaN56wPqttiYF
         NOmSkqiBQGOaZUfwiuZq8Pl6lVzZo2TQuWazEJLYWa4ehUDj+ADFyv5gA2wtwTreFrLv
         EcLg==
X-Gm-Message-State: AO0yUKUmOitCfpy086XgIzh42ED8vRIryNxHsUN/FI8ZBrS54Etq/tb1
        ReYpKojmnm7Z2nL47SXamsPiL8hGe03G0M/yZQk=
X-Google-Smtp-Source: AK7set83guEjYuAZsftANPxCyT0o9Uw2I2z385IEElmR7QPacUY5T7mQ+QffNB0XvapGrhRYeX067o0bpbr2iVuW848=
X-Received: by 2002:a50:d0d1:0:b0:4bf:8bc6:7584 with SMTP id
 g17-20020a50d0d1000000b004bf8bc67584mr1621828edf.2.1677757487983; Thu, 02 Mar
 2023 03:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20230221170356.27923-1-iuliana.prodan@oss.nxp.com>
 <20230301184916.GA1326133@p14s> <20230301185606.GB1326133@p14s>
In-Reply-To: <20230301185606.GB1326133@p14s>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 2 Mar 2023 13:44:35 +0200
Message-ID: <CAEnQRZAN4YRZ3VQYXuEU57WdQs4tJQtXZKpWzSM-hS1c-_20vg@mail.gmail.com>
Subject: Re: [PATCH v5] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>
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

On Wed, Mar 1, 2023 at 9:11=E2=80=AFPM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Wed, Mar 01, 2023 at 11:49:16AM -0700, Mathieu Poirier wrote:
> > Hi Iuliana,
> >
> > On Tue, Feb 21, 2023 at 07:03:56PM +0200, Iuliana Prodan (OSS) wrote:
> > > From: Iuliana Prodan <iuliana.prodan@nxp.com>
> > >
> > > The IRAM is part of the HiFi DSP.
> > > According to hardware specification only 32-bits write are allowed
> > > otherwise we get a Kernel panic.
> > >
> > > Therefore add a custom memory copy and memset functions to deal with
> > > the above restriction.
> > >
> > > Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > ---
> > > Changes since v4
> > > - use GENMASK;
> > > - s/ioread32/readl;
> > > - s/iowrite32/writel;
> > > - use for loop with writel instead of __iowrite32_copy;
> > > - update multi-line comment format.
> > >
> >
> > This looks good now.  I will queue this on March 13th when 6.3-rc2 is o=
ut.
> >
>
> And out of curiosity, are the remote processors handled by imx_rproc.c al=
so have
> the same 32-bit write constraints?  If so, it would be nice to have a pat=
ch that
> fixes that as well.  In such a case, imx_dsp_rproc_memcpy() and
> imx_dsp_rproc_memset() should be renamed to something more generic and re=
-used
> in imx_rproc.c.

Paging Peng Fan.

imx_rproc handles M4/M7 cores.
imx_dsp_rproc handles HIFI4 DSP cores.

From what I experienced 32 bit read/writes are only mandatory for
certain memory areas
that fall inside the HIFI4 address spaces but this doesn't happen for
M4/M7 memory maps.

thanks,
Daniel.
