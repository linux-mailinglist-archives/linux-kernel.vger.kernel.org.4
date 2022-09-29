Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA57B5F0126
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiI2XCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiI2XCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:02:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E541257AE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:02:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so6250035pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=nBs/S2R8K8Vm41VFxngxswIPmP4XVNv4OOqGm9AKdbw=;
        b=QiNKz8jIiGX8/YRKnH19tvCy4P2O509Zzytpg+9bIr1tyaTQ4Cu6r34hysfTBbGMms
         DGZRmfn+Tnlq4mKmufhGEn/y0FtqIUMJqwztIFD0YFNa4PgLi6E70CncPJYhJVdK3eHq
         9z8Jo0SLwXKvyE7ClTXKmHVhJud3ZTdBfA6ISrpsQgzlPhVOrDR2GQ0HJ9MAt91PXSM1
         UcW8k7CXifDKEBxji915uhebF7Q/34it3It8h0d4IRxZHa44tJWpUMpVoYDjaD2DM/5m
         NqfhKHEzepdt3ROr9Z2vuzkIn7/k2UMBrRan8qRAjQnOpeI+JpZglTA1s/0NavADJGxZ
         OXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nBs/S2R8K8Vm41VFxngxswIPmP4XVNv4OOqGm9AKdbw=;
        b=cyLBwPaCHqX3+Q2+GGUX1zoN+1+iPOWm3eKeBFIXy4yMy34YczMAoUBnvl6OyGAand
         wKKpk7GCarb4g3yXIS9InPWg6k640jySM/VwzRT7FZ62d5XAhUHkcfnMbXX+/Z2EdcaM
         zBMMoORZEt+e7sqANUdNZ1CjWVZgXzPL+yQ0NlDEBdRyyvYeww/Jm9GcIzli6oRsd3nK
         qUsFnf/oOUg5X0APSJhzwDR4LB/raCC1v29+VynVwB4UZSrBwt33R37J7LTMU75gxmhr
         d9lNTFk1LxdEBZsxLct/3axTHnkOsYv0JR/3Pc29ShZrxn235/hgoBNplRsqW8/s1gy8
         uoZw==
X-Gm-Message-State: ACrzQf1QNz6n9/IRcFfChJoa+sx8hjP9ID7YAMQYKitfbqgPkgRh8fdu
        SQiO7HYP+x39JWRTEXS6/oJ62A==
X-Google-Smtp-Source: AMsMyM6r0jONZyKwdLLYq9bt293lk2STD07nPwK8L3M4KqvIKhsoxj1tRJErbMAfUlV91itWZJehmg==
X-Received: by 2002:a17:903:181:b0:17a:606:6428 with SMTP id z1-20020a170903018100b0017a06066428mr5716407plg.157.1664492557496;
        Thu, 29 Sep 2022 16:02:37 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79579000000b0053dfef91b0bsm193619pfq.205.2022.09.29.16.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:02:35 -0700 (PDT)
Date:   Thu, 29 Sep 2022 17:02:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     Romain Naour <romain.naour@smile.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Md Danish Anwar <danishanwar@ti.com>,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        vigneshr@ti.com, robh@kernel.org
Subject: Re: [EXTERNAL] Re: [PATCH v5 2/6] remoteproc: pru: Add APIs to get
 and put the PRU cores
Message-ID: <20220929230233.GC3107608@p14s>
References: <20220712175949.GB2945984@p14s>
 <20220714172015.GA3106020@p14s>
 <20c544ef-40b3-dcbc-1f29-aac140725b57@ti.com>
 <7e7ed572-93fe-a9c8-f11e-d555e5113fd1@ti.com>
 <20220906192827.GA65147@p14s>
 <694da03a-e34d-1939-8b01-a75bc25495e0@ti.com>
 <992019ad-5c58-d420-8a18-a82228f8e086@smile.fr>
 <a0b99322-5886-6a56-74e4-e78dcb32ffa0@ti.com>
 <CANLsYkykPRn2Jj_5oSm4sLBx3rQnJozJ9cL=R1WUR7oXUF6jPA@mail.gmail.com>
 <5fa0c5f8-d32e-64a0-5692-b95d48fbd2cd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fa0c5f8-d32e-64a0-5692-b95d48fbd2cd@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:53:09PM +0530, Md Danish Anwar wrote:
> Hi Mathieu,
> 
> On 20/09/22 02:15, Mathieu Poirier wrote:
> > On Tue, 13 Sept 2022 at 05:40, Md Danish Anwar <a0501179@ti.com> wrote:
> >>
> >> Hi Mathieu,
> >>
> >> On 12/09/22 18:54, Romain Naour wrote:
> >>> Hi Danish, All,
> >>>
> >>> Le 07/09/2022 à 11:24, Md Danish Anwar a écrit :
> >>>> Hi Mathieu,
> >>>>
> >>>> On 07/09/22 00:58, Mathieu Poirier wrote:
> >>>>> On Fri, Sep 02, 2022 at 03:09:04PM +0530, Md Danish Anwar wrote:
> >>>>>> Hi Mathieu,
> >>>>>>
> >>>>>>
> >>>>>> On 15/07/22 11:52, Kishon Vijay Abraham I wrote:
> >>>>>>> +Danish
> >>>>>>>
> >>>>>>> Hi Mathieu,
> >>>>>>>
> >>>>>>> On 14/07/22 22:50, Mathieu Poirier wrote:
> >>>>>>>> On Tue, Jul 12, 2022 at 11:59:49AM -0600, Mathieu Poirier wrote:
> >>>>>>>>> Hi Puranjay,
> >>>>>>>
> >>>>>>> Removed Puranjay (as he is no longer with TI) and adding Danish.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>> Kishon
> >>>>>>>>>
> >>>>>>>>> On Tue, Jun 07, 2022 at 10:26:46AM +0530, Puranjay Mohan wrote:
> >>>>>>>>>> From: Tero Kristo <t-kristo@ti.com>
> >>>>>>>>>>
> >>>>>>>>>> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
> >>>>>>>>>> driver to allow client drivers to acquire and release the remoteproc
> >>>>>>>>>> device associated with a PRU core. The PRU cores are treated as
> >>>>>>>>>> resources with only one client owning it at a time.
> >>>>>>>>>>
> >>>>>>>>>> The pru_rproc_get() function returns the rproc handle corresponding
> >>>>>>>>>> to a PRU core identified by the device tree "ti,prus" property under
> >>>>>>>>>> the client node. The pru_rproc_put() is the complementary function
> >>>>>>>>>> to pru_rproc_get().
> >>>>>>>>>>
> >>>>>>>>>> Co-developed-by: Suman Anna <s-anna@ti.com>
> >>>>>>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
> >>>>>>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>>>>>>>>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> >>>>>>>>>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> >>>>>>>>>> Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
> >>>>>>>>>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> >>>>>>>>>> ---
> >>>>>>>>>>   drivers/remoteproc/pru_rproc.c | 138 +++++++++++++++++++++++++++++++--
> >>>>>>>>>>   include/linux/pruss.h          |  56 +++++++++++++
> >>>>>>>>>>   2 files changed, 189 insertions(+), 5 deletions(-)
> >>>>>>>>>>   create mode 100644 include/linux/pruss.h
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> >>>>>>>>>> index 1777a01fa84e..7a35b400287a 100644
> >>>>>>>>>> --- a/drivers/remoteproc/pru_rproc.c
> >>>>>>>>>> +++ b/drivers/remoteproc/pru_rproc.c
> >>>>>>>>>> @@ -2,12 +2,13 @@
> >>>>>>>>>>   /*
> >>>>>>>>>>    * PRU-ICSS remoteproc driver for various TI SoCs
> >>>>>>>>>>    *
> >>>>>>>>>> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
> >>>>>>>>>> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
> >>>>>>>>>>    *
> >>>>>>>>>>    * Author(s):
> >>>>>>>>>>    *   Suman Anna <s-anna@ti.com>
> >>>>>>>>>>    *   Andrew F. Davis <afd@ti.com>
> >>>>>>>>>>    *   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
> >>>>>>>>>> + *    Puranjay Mohan <p-mohan@ti.com>
> >>>>>>>>>>    */
> >>>>>>>>>>   #include <linux/bitops.h>
> >>>>>>>>>> @@ -16,6 +17,7 @@
> >>>>>>>>>>   #include <linux/module.h>
> >>>>>>>>>>   #include <linux/of_device.h>
> >>>>>>>>>>   #include <linux/of_irq.h>
> >>>>>>>>>> +#include <linux/pruss.h>
> >>>>>>>>>>   #include <linux/pruss_driver.h>
> >>>>>>>>>>   #include <linux/remoteproc.h>
> >>>>>>>>>> @@ -111,6 +113,8 @@ struct pru_private_data {
> >>>>>>>>>>    * @rproc: remoteproc pointer for this PRU core
> >>>>>>>>>>    * @data: PRU core specific data
> >>>>>>>>>>    * @mem_regions: data for each of the PRU memory regions
> >>>>>>>>>> + * @client_np: client device node
> >>>>>>>>>> + * @lock: mutex to protect client usage
> >>>>>>>>>>    * @fw_name: name of firmware image used during loading
> >>>>>>>>>>    * @mapped_irq: virtual interrupt numbers of created fw specific mapping
> >>>>>>>>>>    * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
> >>>>>>>>>> @@ -126,6 +130,8 @@ struct pru_rproc {
> >>>>>>>>>>        struct rproc *rproc;
> >>>>>>>>>>        const struct pru_private_data *data;
> >>>>>>>>>>        struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
> >>>>>>>>>> +      struct device_node *client_np;
> >>>>>>>>>> +      struct mutex lock; /* client access lock */
> >>>>>>>>>>        const char *fw_name;
> >>>>>>>>>>        unsigned int *mapped_irq;
> >>>>>>>>>>        struct pru_irq_rsc *pru_interrupt_map;
> >>>>>>>>>> @@ -146,6 +152,125 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
> >>>>>>>>>>        writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
> >>>>>>>>>>   }
> >>>>>>>>>> +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
> >>>>>>>>>> +{
> >>>>>>>>>> +      struct device_node *rproc_np = NULL;
> >>>>>>>>>> +      struct platform_device *pdev;
> >>>>>>>>>> +      struct rproc *rproc;
> >>>>>>>>>> +
> >>>>>>>>>> +      rproc_np = of_parse_phandle(np, "ti,prus", index);
> >>>>>>>>>> +      if (!rproc_np || !of_device_is_available(rproc_np))
> >>>>>>>>>> +              return ERR_PTR(-ENODEV);
> >>>>>>>>>> +
> >>>>>>>>>> +      pdev = of_find_device_by_node(rproc_np);
> >>>>>>>>>> +      of_node_put(rproc_np);
> >>>>>>>>>> +
> >>>>>>>>>> +      if (!pdev || !(&pdev->dev) || !((&pdev->dev)->driver))
> >>>>>>>>>> +              /* probably PRU not yet probed */
> >>>>>>>>>> +              return ERR_PTR(-EPROBE_DEFER);
> >>>>>>>>>> +
> >>>>>>>>>> +      /* make sure it is PRU rproc */
> >>>>>>>>>> +      if (!is_pru_rproc(&pdev->dev)) {
> >>>>>>>>>> +              put_device(&pdev->dev);
> >>>>>>>>>> +              return ERR_PTR(-ENODEV);
> >>>>>>>>>> +      }
> >>>>>>>>>> +
> >>>>>>>>>> +      rproc = platform_get_drvdata(pdev);
> >>>>>>>>>> +      put_device(&pdev->dev);
> >>>>>>>>>> +      if (!rproc)
> >>>>>>>>>> +              return ERR_PTR(-EPROBE_DEFER);
> >>>>>>>>>> +
> >>>>>>>>>> +      get_device(&rproc->dev);
> >>>>>>>>>> +
> >>>>>>>>>> +      return rproc;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +/**
> >>>>>>>>>> + * pru_rproc_get() - get the PRU rproc instance from a device node
> >>>>>>>>>> + * @np: the user/client device node
> >>>>>>>>>> + * @index: index to use for the ti,prus property
> >>>>>>>>>> + * @pru_id: optional pointer to return the PRU remoteproc processor id
> >>>>>>>>>> + *
> >>>>>>>>>> + * This function looks through a client device node's "ti,prus" property at
> >>>>>>>>>> + * index @index and returns the rproc handle for a valid PRU remote processor if
> >>>>>>>>>> + * found. The function allows only one user to own the PRU rproc resource at a
> >>>>>>>>>> + * time. Caller must call pru_rproc_put() when done with using the rproc, not
> >>>>>>>>>> + * required if the function returns a failure.
> >>>>>>>>>> + *
> >>>>>>>>>> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
> >>>>>>>>>> + * returned.
> >>>>>>>>>> + *
> >>>>>>>>>> + * Return: rproc handle on success, and an ERR_PTR on failure using one
> >>>>>>>>>> + * of the following error values
> >>>>>>>>>> + *    -ENODEV if device is not found
> >>>>>>>>>> + *    -EBUSY if PRU is already acquired by anyone
> >>>>>>>>>> + *    -EPROBE_DEFER is PRU device is not probed yet
> >>>>>>>>>> + */
> >>>>>>>>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> >>>>>>>>>> +                          enum pruss_pru_id *pru_id)
> >>>>>>>>>> +{
> >>>>>>>>>> +      struct rproc *rproc;
> >>>>>>>>>> +      struct pru_rproc *pru;
> >>>>>>>>>> +      struct device *dev;
> >>>>>>>>>> +
> >>>>>>>>>> +      try_module_get(THIS_MODULE);
> >>>>>>>>>
> >>>>>>>>> There should be a module_put() in pru_rproc_put()...
> >>>>>>>>
> >>>>>>>> ... and in the error path of this function.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> More comments to come tomorrow.  I'm especially worried about this API racing
> >>>>>>>>> with a remote processor being removed or detached.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Looking at what is done in wkup_m3_ipc_probe(), it should be possible to call
> >>>>>>>> rproc_get_by_handle() here and that would make sure the remote processor doesn't
> >>>>>>>> go away before the end of the function.
> >>>>>>>>
> >>>>>>>> More comments to come...
> >>>>>>
> >>>>>> It is possible to call rproc_get_by_handle() here instead of
> >>>>>> __pru_get_proc(), but that would not provide multiple functionality.
> >>>>>>
> >>>>>> The API rproc_get_by_handle() returns rproc handle on success, and NULL on
> >>>>>> failure where as __pru_get_proc() returns ERR_PTR on failure which provides
> >>>>>> multiple functionality and opportunity for us to distinguish between
> >>>>>> multiple errors.
> >>>>>>
> >>>>>> So we have these three options.
> >>>>>>
> >>>>>> 1. If we're using the API rproc_get_by_handle() and we want the multiple
> >>>>>> ERR_PTR on failure then we will need to change the API rproc_get_by_handle()
> >>>>>> and also all the functions that uses rproc_get_by_handle().
> >>>>>>
> >>>>>
> >>>>> Not optimal.
> >>>>>
> >>>>>> 2. Keep the API rproc_get_by_handle() as it is. That will restrict us from
> >>>>>> using multiple ERR_PTR on different kinds of error.
> >>>>>>
> >>>>>
> >>>>> Not optimal.
> >>>>>
> >>>>>> 3. Instead of using rproc_get_by_handle(), keep using __pru_get_proc(). This
> >>>>>> will make sure we have the proper ERR_PTR to retrun for different kinds of
> >>>>>> errors.
> >>>>>>
> >>>>>
> >>>>> Unacceptable for the reason I already stated.
> >>>>>
> >>>>>> Please let me know which option to continue with.
> >>>>>
> >>>>> I suggest building a wrapper that does everything you want around rproc_get_by_phandle().
> >>
> >> We can introduce a new API __rproc_get_by_phandle() similar to the API
> >> rproc_get_by_phandle(). The new API __rproc_get_by_phandle() will do all the
> >> functionality of getting the rproc. On success it will return rproc and on
> >> failure it will return the different ERR_PTR.
> >> If rproc is not probed yet, it will return ERR_PTR(-EPROBE_DEFER).
> >>
> >> This will make sure that we're getting different error codes for different
> >> errors from pru_rproc_get().
> >>
> >> The old API rproc_get_by_handle() will invoke the new API. On success the new
> >> API will return rproc and the old API will also return rproc. On failure the
> >> new API will return different error codes while the old API will preserve it's
> >> nature and return NULL.
> > 
> > I meant to create a wrapper around rproc_get_by_handle() that is local
> > to pru_rproc.c.  That way you can enact the behavior you want without
> > having to constrain others in this specific design.
> > 
> > Thanks,
> > Mathieu
> > 
> As The API rproc_get_by_phandle() returns null on failure, I am not able to
> create a wrapper around this API, which is local to pru_rproc.c to enact the
> different behaviors that I want. As the API is only returning null on failure
> but pru_rproc_get needs different error codes for different failures. We can
> create a wrapper but that won't be able to provide different error codes that
> we want in pru_rproc_get().

I took a closer look at __pru_rproc_get()...

Calling of_property_read_u32_index() instead of of_parse_phandle() should do the
primary sanetary check.  After that call rproc_get_by_phandle() and return
EPROBE_DEFER if it returns NULL.  If not then you have an rproc with a platform
device that you can check with is_pru_rproc() and return whatever error code you
want if it isn't to your liking.  

> 
> This is why I am suggesting to introduce new API [__rproc_get_by_phandle()]
> similar to rproc_get_by_handle(). The new API can return different error codes
> on different error. While the older API [rproc_get_by_handle()] will call the
> new API and on failure on new API the older API will just return null
> irrespective of the error code returned by the new API. Thus preserving it's
> original design.
> 
> This way we can enact the behavior that we want by calling the new API while
> the other APIs dependent on the older API, can still call
> rproc_get_by_phandle() without any change to the existing design.
> 
> We can have a little discussion to discuss this further on some IRC channel or
> meeting if it's possible.
> 
> Thanks,
> Danish
> 
> 
> >>
> >> The API __rproc_get_by_handle will look like this.
> >>
> >> struct rproc *__rproc_get_by_handle(phandle phandle)
> >> {
> >>         struct rproc *rproc = NULL, *r;
> >>         struct device_node *np;
> >>
> >>         np = of_find_node_by_phandle(phandle);
> >>         if (!np)
> >>                 return NULL;
> >>
> >>         rcu_read_lock();
> >>         list_for_each_entry_rcu(r, &rproc_list, node) {
> >>                 if (r->dev.parent && r->dev.parent->of_node == np) {
> >>                         /*prevent underlying implementation from being removed */
> >>                         if (!try_module_get(r->dev.parent->driver->owner)) {
> >>                                 dev_err(&r->dev, "can't get owner\n");
> >>                                 break;
> >>                         }
> >>
> >>                         rproc = r;
> >>                         get_device(&rproc->dev);
> >>                         break;
> >>                 }
> >>         }
> >>         rcu_read_unlock();
> >>
> >>         of_node_put(np);
> >>
> >>         if(!rproc)
> >>                 return ERR_PTR(-EPROBE_DEFER);
> >>
> >>         return rproc;
> >> }
> >>
> >> The API rproc_get_by_handle() will look like this.
> >>
> >> struct rproc *rproc_get_by_phandle(phandle phandle)
> >> {
> >>         struct rproc *rproc = NULL;
> >>
> >>         rproc = __rproc_get_by_handle(phandle);
> >>
> >>         if(!rproc || IS_ERR(rproc))
> >>                 return NULL;
> >>
> >>         return rproc;
> >> }
> >>
> >> This way in pru_rproc_get(), we'll get the rproc by phandle and we'll still
> >> return different error codes depending upon failure cases. We'll also be able
> >> to preserve the actual functionality of rproc_get_by_phandle() so that the
> >> other APIs using rproc_get_by_phandle() won't get affected.
> >>
> >> Please let me know if this looks good.
> >>
> >>>>>
> >>>>
> >>>> Sure, I'll do that. I'll share this change in v6 of this patch series.
> >>>
> >>> I'm able to test the TI prueth driver from the ti-linux-5.10.y tree [1] on a
> >>> AM5749 cpu (custom board). But I need a more recent kernel (at least 5.15) to
> >>> support other devices recently added to the Linux kernel (wifi6 module and an
> >>> ethernet switch). Also it would be nice if this driver is finally merged in the
> >>> Linux kernel.
> >>>
> >>> Maybe I can help to test this series but I noticed it only provide the driver
> >>> for TI AM654x cpus [2]. Can you also provide patches for basic EMAC support with
> >>> the TI AM574x too? (I don't need advanced features like frame timestamping, HSR
> >>> etc).
> >>>
> >>> Also, what about patches present in the ti-linux-kernel tree and not included
> >>> this this series? Especially patches that modify the kernel network stack [3]
> >>> (net/rpmsg: add support for new rpmsg sockets). Is this new socket protocol
> >>> really needed?
> >>>
> >>> Notice the patch adding the rpmsg sockets [3] already conflict with the upstream
> >>> kernel since the AF_MCTP definition now use the value temporarly used by
> >>> AF_RPMSG [4].
> >>>
> >>> Can you send an updated version of the complete series?
> >>>
> >>> Thanks!
> >>>
> >>> [1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/log/?h=ti-linux-5.10.y
> >>>
> >>> [2] https://lore.kernel.org/linux-remoteproc/20220406094358.7895-1-p-mohan@ti.com/
> >>>
> >>> [3]
> >>> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-5.10.y&id=f4b978a978c38149f712ddd137f12ed5fb914161
> >>>
> >>> [4]
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bc49d8169aa72295104f1558830c568efb946315
> >>>
> >>> Best regards,
> >>> Romain
> >>>
> >>>
> >>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Danish
> >>>>>>
> >>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Mathieu
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>> +      rproc = __pru_rproc_get(np, index);
> >>>>>>>>>> +      if (IS_ERR(rproc))
> >>>>>>>>>> +              return rproc;
> >>>>>>>>>> +
> >>>>>>>>>> +      pru = rproc->priv;
> >>>>>>>>>> +      dev = &rproc->dev;
> >>>>>>>>>> +
> >>>>>>>>>> +      mutex_lock(&pru->lock);
> >>>>>>>>>> +
> >>>>>>>>>> +      if (pru->client_np) {
> >>>>>>>>>> +              mutex_unlock(&pru->lock);
> >>>>>>>>>> +              put_device(dev);
> >>>>>>>>>> +              return ERR_PTR(-EBUSY);
> >>>>>>>>>> +      }
> >>>>>>>>>> +
> >>>>>>>>>> +      pru->client_np = np;
> >>>>>>>>>> +
> >>>>>>>>>> +      mutex_unlock(&pru->lock);
> >>>>>>>>>> +
> >>>>>>>>>> +      if (pru_id)
> >>>>>>>>>> +              *pru_id = pru->id;
> >>>>>>>>>> +
> >>>>>>>>>> +      return rproc;
> >>>>>>>>>> +}
> >>>>>>>>>> +EXPORT_SYMBOL_GPL(pru_rproc_get);
> >>>>>>>>>> +
> >>>>>>>>>> +/**
> >>>>>>>>>> + * pru_rproc_put() - release the PRU rproc resource
> >>>>>>>>>> + * @rproc: the rproc resource to release
> >>>>>>>>>> + *
> >>>>>>>>>> + * Releases the PRU rproc resource and makes it available to other
> >>>>>>>>>> + * users.
> >>>>>>>>>> + */
> >>>>>>>>>> +void pru_rproc_put(struct rproc *rproc)
> >>>>>>>>>> +{
> >>>>>>>>>> +      struct pru_rproc *pru;
> >>>>>>>>>> +
> >>>>>>>>>> +      if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.parent))
> >>>>>>>>>> +              return;
> >>>>>>>>>> +
> >>>>>>>>>> +      pru = rproc->priv;
> >>>>>>>>>> +
> >>>>>>>>>> +      mutex_lock(&pru->lock);
> >>>>>>>>>> +
> >>>>>>>>>> +      if (!pru->client_np) {
> >>>>>>>>>> +              mutex_unlock(&pru->lock);
> >>>>>>>>>> +              return;
> >>>>>>>>>> +      }
> >>>>>>>>>> +
> >>>>>>>>>> +      pru->client_np = NULL;
> >>>>>>>>>> +      mutex_unlock(&pru->lock);
> >>>>>>>>>> +
> >>>>>>>>>> +      put_device(&rproc->dev);
> >>>>>>>>>> +}
> >>>>>>>>>> +EXPORT_SYMBOL_GPL(pru_rproc_put);
> >>>>>>>>>> +
> >>>>>>>>>>   static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
> >>>>>>>>>>   {
> >>>>>>>>>>        return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
> >>>>>>>>>> @@ -438,7 +563,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
> >>>>>>>>>>        dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
> >>>>>>>>>>        dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
> >>>>>>>>>>        /* PRU1 has its local RAM addresses reversed */
> >>>>>>>>>> -      if (pru->id == 1)
> >>>>>>>>>> +      if (pru->id == PRUSS_PRU1)
> >>>>>>>>>>                swap(dram0, dram1);
> >>>>>>>>>>        shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
> >>>>>>>>>> @@ -747,14 +872,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
> >>>>>>>>>>        case RTU0_IRAM_ADDR_MASK:
> >>>>>>>>>>                fallthrough;
> >>>>>>>>>>        case PRU0_IRAM_ADDR_MASK:
> >>>>>>>>>> -              pru->id = 0;
> >>>>>>>>>> +              pru->id = PRUSS_PRU0;
> >>>>>>>>>>                break;
> >>>>>>>>>>        case TX_PRU1_IRAM_ADDR_MASK:
> >>>>>>>>>>                fallthrough;
> >>>>>>>>>>        case RTU1_IRAM_ADDR_MASK:
> >>>>>>>>>>                fallthrough;
> >>>>>>>>>>        case PRU1_IRAM_ADDR_MASK:
> >>>>>>>>>> -              pru->id = 1;
> >>>>>>>>>> +              pru->id = PRUSS_PRU1;
> >>>>>>>>>>                break;
> >>>>>>>>>>        default:
> >>>>>>>>>>                ret = -EINVAL;
> >>>>>>>>>> @@ -816,6 +941,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
> >>>>>>>>>>        pru->pruss = platform_get_drvdata(ppdev);
> >>>>>>>>>>        pru->rproc = rproc;
> >>>>>>>>>>        pru->fw_name = fw_name;
> >>>>>>>>>> +      pru->client_np = NULL;
> >>>>>>>>>> +      mutex_init(&pru->lock);
> >>>>>>>>>>        for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> >>>>>>>>>>                res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >>>>>>>>>> @@ -903,7 +1030,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
> >>>>>>>>>>   static struct platform_driver pru_rproc_driver = {
> >>>>>>>>>>        .driver = {
> >>>>>>>>>> -              .name   = "pru-rproc",
> >>>>>>>>>> +              .name   = PRU_RPROC_DRVNAME,
> >>>>>>>>>>                .of_match_table = pru_rproc_match,
> >>>>>>>>>>                .suppress_bind_attrs = true,
> >>>>>>>>>>        },
> >>>>>>>>>> @@ -915,5 +1042,6 @@ module_platform_driver(pru_rproc_driver);
> >>>>>>>>>>   MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
> >>>>>>>>>>   MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> >>>>>>>>>>   MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
> >>>>>>>>>> +MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
> >>>>>>>>>>   MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
> >>>>>>>>>>   MODULE_LICENSE("GPL v2");
> >>>>>>>>>> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> >>>>>>>>>> new file mode 100644
> >>>>>>>>>> index 000000000000..fdc719b43db0
> >>>>>>>>>> --- /dev/null
> >>>>>>>>>> +++ b/include/linux/pruss.h
> >>>>>>>>>> @@ -0,0 +1,56 @@
> >>>>>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>>>>>>>>> +/**
> >>>>>>>>>> + * PRU-ICSS Subsystem user interfaces
> >>>>>>>>>> + *
> >>>>>>>>>> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
> >>>>>>>>>> + *    Suman Anna <s-anna@ti.com>
> >>>>>>>>>> + */
> >>>>>>>>>> +
> >>>>>>>>>> +#ifndef __LINUX_PRUSS_H
> >>>>>>>>>> +#define __LINUX_PRUSS_H
> >>>>>>>>>> +
> >>>>>>>>>> +#include <linux/device.h>
> >>>>>>>>>> +#include <linux/types.h>
> >>>>>>>>>> +
> >>>>>>>>>> +#define PRU_RPROC_DRVNAME "pru-rproc"
> >>>>>>>>>> +
> >>>>>>>>>> +/*
> >>>>>>>>>> + * enum pruss_pru_id - PRU core identifiers
> >>>>>>>>>> + */
> >>>>>>>>>> +enum pruss_pru_id {
> >>>>>>>>>> +      PRUSS_PRU0 = 0,
> >>>>>>>>>> +      PRUSS_PRU1,
> >>>>>>>>>> +      PRUSS_NUM_PRUS,
> >>>>>>>>>> +};
> >>>>>>>>>> +
> >>>>>>>>>> +struct device_node;
> >>>>>>>>>> +
> >>>>>>>>>> +#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
> >>>>>>>>>> +
> >>>>>>>>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> >>>>>>>>>> +                          enum pruss_pru_id *pru_id);
> >>>>>>>>>> +void pru_rproc_put(struct rproc *rproc);
> >>>>>>>>>> +
> >>>>>>>>>> +#else
> >>>>>>>>>> +
> >>>>>>>>>> +static inline struct rproc *
> >>>>>>>>>> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
> >>>>>>>>>> +{
> >>>>>>>>>> +      return ERR_PTR(-EOPNOTSUPP);
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +static inline void pru_rproc_put(struct rproc *rproc) { }
> >>>>>>>>>> +
> >>>>>>>>>> +#endif /* CONFIG_PRU_REMOTEPROC */
> >>>>>>>>>> +
> >>>>>>>>>> +static inline bool is_pru_rproc(struct device *dev)
> >>>>>>>>>> +{
> >>>>>>>>>> +      const char *drv_name = dev_driver_string(dev);
> >>>>>>>>>> +
> >>>>>>>>>> +      if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
> >>>>>>>>>> +              return false;
> >>>>>>>>>> +
> >>>>>>>>>> +      return true;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +#endif /* __LINUX_PRUSS_H */
> >>>>>>>>>> --
> >>>>>>>>>> 2.17.1
> >>>>>>>>>>
> >>>>
> >>>
