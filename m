Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771566C3CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCUVc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUVc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:32:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDA58485
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:32:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w4so9394998plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679434373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzHxTn/xBhnpdgy8S5E8M4unosxnUcsaF4INeWuGSNM=;
        b=kxyTO4v7cC+7AJfDMMODMO/Ytb5E95ibpucDviLwkUuXDhCSN5gCydR3ahhruangOc
         DViOKaJQUNBhP5v1Um9hVcsrbGIMno2OjwUCKR3JEYx4LGJJ8eT1OoeVbibpgjS4zsnR
         vMPaHiyBlZ3YEAx4buv3XVKaY6lYABPmnMxxt/x2ZB9D2hAxPjs8ZkPInbfN6ShFXmlO
         Q2d56ojjw2xhKUcppHYjGNUrOu1ehGvSv9rll3kccRJG1XY5PNZD3/xG7W7o8UPF8Xs2
         UxiyQ+9As6JD7CUVqEMWGViPRwjg4geklBa0yu2evkg8aKC9nIvlYxDN8TJUDPN1iyFL
         YTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzHxTn/xBhnpdgy8S5E8M4unosxnUcsaF4INeWuGSNM=;
        b=4CFFj63S8osn4l9oFZfpJyAWD36+G9kuf6GvkKeqmFQmmHRiGo6HI6RjZHNhFRgk6z
         eQNuYTTjlvLWLnW8J/aLcGSo9IzYt3TdoyHDn12Hpv3YKQjC7iEOiWLcQW0esG3NOpJA
         n+/+TCioftntGnSBzxBZ261GDMYC5e26pOosLlJqM/fNT2w6OuBfyO+SbC6VD8mYVoxv
         rbPofgPOsuIZ/yRG0rvGMcC3Ni6o+M74SV29iywPJ4om/LTmBBcUQLIYRslvO5QFzbdN
         7w1EQQtS6NMYf5ZbxTENvb2SzfiZqEKM5bHRyVN5anfUMA1e0wYXBmq7ZzQR5vUrt7LQ
         lStw==
X-Gm-Message-State: AO0yUKWA/LdtESFih+IT+ljN1qHm9DX1cKP4eyCMBq7jsS/E41W7IJz+
        xopInK23BJADSP/KLzZFQiItYw==
X-Google-Smtp-Source: AK7set+bYfttSbCp8Gd0XqK/tsJh4Hz36v//vxiF2sH/A3Ougn4M9ogwYRnxlnTuwek7ZhDq9iXwXw==
X-Received: by 2002:a05:6a20:dc9d:b0:da:f525:e629 with SMTP id ky29-20020a056a20dc9d00b000daf525e629mr1939980pzb.53.1679434373294;
        Tue, 21 Mar 2023 14:32:53 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8a45:c131:e8ed:3f53])
        by smtp.gmail.com with ESMTPSA id n1-20020aa78a41000000b0062604b7552fsm8728060pfa.63.2023.03.21.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:32:52 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:32:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        patrice.chotard@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, arnaud.pouliquen@st.com,
        hongxing.zhu@nxp.com, peng.fan@nxp.com, shengjiu.wang@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] remoteproc: stm32: Call of_node_put() on iteration
 error
Message-ID: <20230321213250.GB2782856@p14s>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
 <20230320221826.2728078-2-mathieu.poirier@linaro.org>
 <e3644e19-7453-440b-00dc-781104ca83cf@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3644e19-7453-440b-00dc-781104ca83cf@foss.st.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:00:03AM +0100, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> On 3/20/23 23:18, Mathieu Poirier wrote:
> > Function of_phandle_iterator_next() calls of_node_put() on the last
> > device_node it iterated over, but when the loop exits prematurely it has
> > to be called explicitly> 
> > Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/stm32_rproc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> > index 7d782ed9e589..23c1690b8d73 100644
> > --- a/drivers/remoteproc/stm32_rproc.c
> > +++ b/drivers/remoteproc/stm32_rproc.c
> > @@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rproc *rproc)
> >  	while (of_phandle_iterator_next(&it) == 0) {
> >  		rmem = of_reserved_mem_lookup(it.node);
> >  		if (!rmem) {
> > +			of_node_put(it.node);
> >  			dev_err(dev, "unable to acquire memory-region\n");
> >  			return -EINVAL;
> >  		}
> >  
> >  		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
> > +			of_node_put(it.node);
> >  			dev_err(dev, "memory region not valid %pa\n",
> >  				&rmem->base);
> >  			return -EINVAL;
> > @@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rproc *rproc)
> >  							   it.node->name);
> >  		}
> >  
> > -		if (!mem)
> > +		if (!mem) {
> > +			of_node_put(it.node);
> >  			return -ENOMEM;
> > +		}
> 
> Good catch!
> 
> Looking in code I don't see that we call of_node_put() when we release the
> carveouts. 
> Please tell me if I'm wrong but look to me that we should also call of_node_put()
> in mem->release() op, in drivers. 
>

Are you referring to entry->release(), which for stm32 is
stm32_rproc_mem_release(), in rproc_resource_cleanup()?

If so then no, it is not needed since of_phandle_iterator_next() calls
of_node_put() on the previous device_node with each iteration.

Otherwise I fail to understand the question and will ask you to clarify.

> This one remains valid.
> reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> 

Ok

> Thanks,
> Arnaud
> 
> 
> >  
> >  		rproc_add_carveout(rproc, mem);
> >  		index++;
