Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A537117AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbjEYTwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbjEYTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:52:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22119E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:51:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-973bf581759so151576866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685044312; x=1687636312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aoD/n1LUOMZuC7QwFFlSHT9qZ41E43vFB9Zm2dcYyWo=;
        b=sPQmUv1Je1bmEo6XULN86x/XoD8yjy6k+RNMxZdKV8yI9Z674EhsXNZ+JcS4t+bpFj
         VufFm7o/0qJYzxgh5yU5Htg6Z9gpr3aGWVcCw9u5jIwdqSyZyHuwbxyXnvYQxWo8S4vb
         d6rLuO/sGFE3D2mUM8kWPbL3oaq9ArHU/U1fsu8rmlZ84dDveBPXsBBcwbtffSoRPJ43
         MmZBnp8OmPpeaHm1WuyuVG98rucKHEsasNNDKZLTdeFR3wyuN0gn0DGINxK0aTaJoxTD
         xU9y+0J4fNBYoBIaATdT2VDif5UD6Cp1HTs/2hA/Ew9g1mzZOhoeSvxfuB5WT1WPYwQj
         6UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685044312; x=1687636312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoD/n1LUOMZuC7QwFFlSHT9qZ41E43vFB9Zm2dcYyWo=;
        b=PlR4PYqTkio6abd6eo+tIYf0SdyNQtRwCRlKEagJ/NpcaXC4GvBrTRNWwOfQ1ltbRC
         Uiyiwd88aARopqOMmJpRybF+LtUkiC2O7OXClZQcYJnJA0MUnI8Mn0E7EBof8+hH65b/
         ZNnJ+vh6sUgTzdnhKL+pOxPxe3QeeO/bK3eNkYG3smItU2zQjMMErjdC4jTPSDr30rM1
         br3+HcWz6jep79Wn52oo3awlhjgipSYEO7rkLk9EfFy7sckd8vxFBNTpQDrFyO2ycjtk
         c5RvM6dyOfoFuXE9n1tX3PZxcxi1z3D18anZks3/7tikG6aUNE9qH3bZJ9mTUmqx3mA2
         kZlw==
X-Gm-Message-State: AC+VfDxm+elk8aedXbHydXoZxZwHccrO8wFXTxC7/hev0iPmXC1WWVR2
        lsfzLPHyma4YlcTZxVN9ZsEeGinW02PPZ7ZcME4=
X-Google-Smtp-Source: ACHHUZ65q4evaGSOSEF/09uQoh6l5DEscOWbzXzS8I/99s1jYQLlQ89FPR8wLnKgWZYOq2oWLVwvNQ==
X-Received: by 2002:a05:600c:230d:b0:3f6:ae3:5948 with SMTP id 13-20020a05600c230d00b003f60ae35948mr2883855wmo.33.1685042356717;
        Thu, 25 May 2023 12:19:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003f50e88ffc1sm6675515wmr.0.2023.05.25.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 12:19:15 -0700 (PDT)
Date:   Thu, 25 May 2023 22:19:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     andy.shevchenko@gmail.com,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl:sunplus: Add check for kmalloc
Message-ID: <9f937bde-c908-4941-b65c-e4c303d3acae@kili.mountain>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
 <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:05:49PM +0200, Christophe JAILLET wrote:
> Le 23/05/2023 à 21:37, andy.shevchenko@gmail.com a écrit :
> > Tue, May 23, 2023 at 05:39:51PM +0000, Wells Lu 呂芳騰 kirjoitti:
> > > > > Fix Smatch static checker warning:
> > > > > potential null dereference 'configs'. (kmalloc returns null)
> > 
> > ...
> > 
> > > > >   			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> > > > > +			if (!configs)
> > > > 
> > > > > +				return -ENOMEM;
> > > > 
> > > > "Fixing" by adding a memory leak is not probably a good approach.
> > > 
> > > Do you mean I need to free all memory which are allocated in this subroutine before
> > > return -ENOMEM?
> > 
> > This is my understanding of the code. But as I said... (see below)
> > 
> > ...
> > 
> > > > >   			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> > > > > +			if (!configs)
> > > > > +				return -ENOMEM;
> > > > 
> > > > Ditto.
> > 
> > ...
> > 
> > > > It might be that I'm mistaken. In this case please add an explanation why in the commit
> > > > message.
> > 
> > ^^^
> > 
> 
> Hmmm, not so sure.
> 
> Should be looked at more carefully, but
>   dt_to_map_one_config		(in /drivers/pinctrl/devicetree.c)
>     .dt_node_to_map
>       --> sppctl_dt_node_to_map
> 
> Should dt_to_map_one_config() fail, pinctrl_dt_free_maps() is called
> (see https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/devicetree.c#L281)

Thanks for this call tree, I don't have this file enabled in my build
so it's not easy for me to find how sppctl_dt_node_to_map() was called.

drivers/pinctrl/devicetree.c
   160                  dev_err(p->dev, "pctldev %s doesn't support DT\n",
   161                          dev_name(pctldev->dev));
   162                  return -ENODEV;
   163          }
   164          ret = ops->dt_node_to_map(pctldev, np_config, &map, &num_maps);
                                                              ^^^^
"map" isn't stored anywhere so it will be leaked.  I guess kmemleak
already figured this out.

   165          if (ret < 0)
   166                  return ret;
   167          else if (num_maps == 0) {
   168                  /*

> 
> pinctrl_dt_free_maps() calls dt_free_map(), which calls .dt_free_map, so
> pinctrl_utils_free_map()
> (see https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/sunplus/sppctl.c#L978)
> 
> Finally the needed kfree seem to be called from here.
> (see https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/pinctrl-utils.c#L119)
> 
> 
> *This should obviously be double checked*, but looks safe to me.
> 
> 
> BUT, in the same function, the of_get_parent() should be undone in case of
> error, as done at the end of the function, in the normal path.
> This one seems to be missing, should a memory allocation error occur.
> 

Yes.  There are some missing calls to of_node_put(parent); in
sppctl_dt_node_to_map().

regards,
dan carpenter

