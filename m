Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E230C601576
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJQRd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJQRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:33:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6E1C432
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:33:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i3so11703291pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIkU7sOMlV3fHaINlwJ0KYw7btBtSLgw5mO+qXWoUOw=;
        b=Jmm7D6cRS6zPAgzomDFIyMJ+afNQc/L35rXtWrVxIPB0xDkGpo/668/Qb6CTzR8Mva
         Aaz6+IsQYV+dHpvRGVptFXcOCjR6wvfgHUaTCD/RLlNfbNy+lzEzvS4QI31Bwzo5R8z7
         r82nxp5MGpoWJBmk4hS6s0XWt7CQjHB0fjVD3G7Bs+RRndEmKVK/hY10sRG5dWuEPnhF
         dW+XfNlc4+OJbMcx7CbXOJmfRiyR8SoQxSEE9g2dXvmOLXI5diciaP0ed3hrULJC3feW
         vF21rTT9wpE7sPLKC4X4UITtaAyeZjNIqJ64Ulnj66EOWCEea2oCOG5hJqHeZkeB5dQt
         RtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIkU7sOMlV3fHaINlwJ0KYw7btBtSLgw5mO+qXWoUOw=;
        b=laOC9iBTK+hC3XFRzaCrILZg8SOXUIgf60/gDR2jhKEs1/zOj7zJ3xlLp0cAu+e+Lr
         epoiHCOORsCjPsAR0XQpANfEc2ldiUZcCTXJhdqHQUsFViQOoo98fkElOM/sMkMOAo1L
         IsVXyXDdE7ODDFA76c9TLu6Dgyv5MBmLFzDc8ITSr7/IY8C0FrT1qHky6TSosw8mWcXY
         TqpetNDK9qCFbuBEZ0+MMjxfaedphg6wBYbspgkXJnXZZU5HRlM4/biC+TcU1ub2jgNz
         vHR0BBaeg8WJdnct1iKeleEn/jmJaZQG5ldB7bbV+3qLE/qKMfYTEvahrxYX7eKIoh8m
         datw==
X-Gm-Message-State: ACrzQf0jy29OEazclfRyQ+d+rNNFbjdgVCrerQtInkCYFrpfmaP7iATt
        RKZUv+r7u5RAjBZlsRQ43RQOyw==
X-Google-Smtp-Source: AMsMyM5jyy2WbvbjPaz7HjAuqsssAiAvwynoMnTFyb4G8cBccuREHHhkw139+BtRk/gDYP8/CXZJWA==
X-Received: by 2002:a63:1609:0:b0:45c:7c1c:4e7d with SMTP id w9-20020a631609000000b0045c7c1c4e7dmr11482387pgl.265.1666028018299;
        Mon, 17 Oct 2022 10:33:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b00177fb862a87sm6985701plg.20.2022.10.17.10.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:33:37 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:33:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel later
Message-ID: <20221017173335.GA121862@p14s>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
 <20221014031037.1070424-7-peng.fan@oss.nxp.com>
 <20221014174903.GA4125124@p14s>
 <DU0PR04MB94179580E85C888CDAA8EAA788299@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94179580E85C888CDAA8EAA788299@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 03:13:16AM +0000, Peng Fan wrote:
> Hi Mathieu,
> 
> > Subject: Re: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel
> > later
> > 
> > On Fri, Oct 14, 2022 at 11:10:36AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > It is possible that when remote processor crash, the communication
> > > channel will be broken with garbage value in mailbox, such as when
> > > Linux is issuing a message through mailbox, remote processor crashes,
> > > we need free & rebuild the mailbox channels to make sure no garbage
> > > value in mailbox channels.
> > >
> > > So move the request/free to start/stop for managing remote procesosr
> > > in Linux, move to attach/detach for remote processor is out of control
> > > of Linux.
> > >
> > > Previous, we just request mbox when attach for CM4 boot early before
> > > Linux, but if mbox defer probe, remoteproc core will do resource
> > > cleanup and corrupt resource table for later probe.
> > >
> > > So move request mbox ealier and still keep mbox request when attach
> > > for self recovery case, but keep a check when request/free mbox.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 39
> > > ++++++++++++++++++++++++++++++++--
> > >  1 file changed, 37 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index 917e6db39572..1183de84a4c0
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -84,6 +84,8 @@ struct imx_rproc_mem {
> > >  #define ATT_CORE_MASK   0xffff
> > >  #define ATT_CORE(I)     BIT((I))
> > >
> > > +static int imx_rproc_xtr_mbox_init(struct rproc *rproc); static void
> > > +imx_rproc_free_mbox(struct rproc *rproc);
> > >  static int imx_rproc_detach_pd(struct rproc *rproc);
> > >
> > >  struct imx_rproc {
> > > @@ -357,6 +359,10 @@ static int imx_rproc_start(struct rproc *rproc)
> > >  	struct arm_smccc_res res;
> > >  	int ret;
> > >
> > > +	ret = imx_rproc_xtr_mbox_init(rproc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	switch (dcfg->method) {
> > >  	case IMX_RPROC_MMIO:
> > >  		ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
> > > dcfg->src_mask, @@ -407,6 +413,8 @@ static int imx_rproc_stop(struct
> > > rproc *rproc)
> > >
> > >  	if (ret)
> > >  		dev_err(dev, "Failed to stop remote core\n");
> > > +	else
> > > +		imx_rproc_free_mbox(rproc);
> > >
> > >  	return ret;
> > >  }
> > > @@ -592,6 +600,22 @@ static void imx_rproc_kick(struct rproc *rproc,
> > > int vqid)
> > >
> > >  static int imx_rproc_attach(struct rproc *rproc)  {
> > > +	return imx_rproc_xtr_mbox_init(rproc); }
> > > +
> > > +static int imx_rproc_detach(struct rproc *rproc) {
> > > +	struct imx_rproc *priv = rproc->priv;
> > > +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> > > +
> > > +	if (dcfg->method != IMX_RPROC_SCU_API)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	imx_rproc_free_mbox(rproc);
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -610,6 +634,7 @@ static struct resource_table
> > > *imx_rproc_get_loaded_rsc_table(struct rproc *rproc  static const struct
> > rproc_ops imx_rproc_ops = {
> > >  	.prepare	= imx_rproc_prepare,
> > >  	.attach		= imx_rproc_attach,
> > > +	.detach		= imx_rproc_detach,
> > >  	.start		= imx_rproc_start,
> > >  	.stop		= imx_rproc_stop,
> > >  	.kick		= imx_rproc_kick,
> > > @@ -720,6 +745,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc
> > *rproc)
> > >  	struct device *dev = priv->dev;
> > >  	struct mbox_client *cl;
> > >
> > > +	if (priv->tx_ch && priv->rx_ch)
> > > +		return 0;
> > > +
> > 
> > You did exactly the same things as in V6.  I asked you why this is needed and
> > all you did is point me to the code in _probe(), which I can read on my own.
> > 
> 
> Sorry for not wrote down clear.
> 
> > Again - why is this needed when we know it will be done in start() and
> > attach()?
> 
> start() and attach() not able to handle mbox defer probe. So I add

We are finally at the heart of the problem.  I had to go look at the
implementation of imx_rproc_xtr_mbox_init() to understand that it can return
-EPROBE_DEFER.  Had there been a comment in the code to highlight _why_ the if()
condition is needed, I would have understood right away and all this waste of
time avoided.

> the mbox requesting in probe to handle mbox defer probe, and add
> a check when requesting mbox channel in start/attach. During first
> time attach/start remote core, the imx_rproc_xtr_mbox_init just
> return, because channel requested in probe flow. 
> 
> Since mbox requested in probe, why still add it in start() and attach()?
> It is to support runtime stop and start(M4 is under control of Linux),
> to support runtime detach(only for i.MX8QM/QXP attach recovery,
> m4 out of control from linux) and attach.
> 
> Thanks,
> Peng.
> > 
> > 
> > >  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
> > >  		return 0;
> > >
> > > @@ -749,8 +777,15 @@ static void imx_rproc_free_mbox(struct rproc
> > > *rproc)  {
> > >  	struct imx_rproc *priv = rproc->priv;
> > >
> > > -	mbox_free_channel(priv->tx_ch);
> > > -	mbox_free_channel(priv->rx_ch);
> > > +	if (priv->tx_ch) {
> > > +		mbox_free_channel(priv->tx_ch);
> > > +		priv->tx_ch = NULL;
> > > +	}
> > > +
> > > +	if (priv->rx_ch) {
> > > +		mbox_free_channel(priv->rx_ch);
> > > +		priv->rx_ch = NULL;
> > > +	}
> > >  }
> > >
> > >  static void imx_rproc_put_scu(struct rproc *rproc)
> > > --
> > > 2.37.1
> > >
