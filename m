Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE7640B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiLBRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiLBRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:00:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A6E0771
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:00:45 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s7so5160146plk.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyTIyEMVlwgZq2rM7w209h8Hdpm+1DB4EPixVA3vlTk=;
        b=NBPMQ7HPa2s9Qver+tuGkfT6bxv1SlXuw6uiM3kaBhKJHPSBgsH+PQDwJASmMKJ2rl
         YWuKuDvsDdYJbTJMa6dVw2CW01SWyZcpPHMiyVB1PqEy2KUGfpbRRXETfebtXrU7EWtl
         KBubpJZzol6K5o9dYwwk4XIaRkyghT8eYSbze69n7vXEIrAoFr2RYEozPjsZLa/myYpW
         X8yXcmNu8srGwbtl/NxAG12+PFtGRnruQSiyIzSz7vN7Tq1gFmOUR9cdSRaktkSd0zed
         tgxPrMbLzAU0o0xSAl2noZOkum80jNxC7yBru1mmuZ5XcURNfEa8ef3wH9OoWI8UqHir
         5Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyTIyEMVlwgZq2rM7w209h8Hdpm+1DB4EPixVA3vlTk=;
        b=2HAX+KiKJ4/zJxRbw+hOhPJBuSv9Ayn+YTlpvrgYWE72UJ4cPuoZNlXDqqZwtk36iT
         QzI2UAmqYBfeW7MlrN1/XGXz5aygFFkFy3OkUhWGb0anZa5zARmw0/bLbs9k7IdKUe3y
         jCgUg1a+GAR+cqtajEWuh2ktZ93sichcnACh1ldKBbTRaqLrGoIWuIKt3GWTDOCeXdN/
         bcNCWFSsNN8bGRyJXXy0wuTn56MWEPYhWChMtRp7maeFS8+jEETr2nmBY1n8pCe0lGDc
         SVxMYkdxI4oBxvy+jy7tyxY5+7KF9w2q08jEGKXpsI8l4gD2MlRisEAY5EnpZTh8TUVW
         56zQ==
X-Gm-Message-State: ANoB5pkdfANQ2cy2Omim5ft8TXCPpO2AbplABgIMLEtixC6pHR/dm1R/
        p20R8alLv6asPKeSveX33Zuh4jg3e4M9BoQy
X-Google-Smtp-Source: AA0mqf4FjagDx8emkOO+pyp69cANsJmhy9xKUNfvFjaXuSNOavu8/8gZbTw6JDM6pGH2jq14X1FOyg==
X-Received: by 2002:a17:90a:e28d:b0:219:26b6:e8d8 with SMTP id d13-20020a17090ae28d00b0021926b6e8d8mr32313389pjz.74.1670000444890;
        Fri, 02 Dec 2022 09:00:44 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:a85e:8886:e9cb:3b71])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b00177faf558b5sm5811939plf.250.2022.12.02.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:00:43 -0800 (PST)
Date:   Fri, 2 Dec 2022 10:00:42 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Levinsky, Ben" <ben.levinsky@amd.com>
Cc:     "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "bill.mills@linaro.com" <bill.mills@linaro.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] remoteproc: Introduce rproc_get_by_id API
Message-ID: <20221202170042.GA165812@p14s>
References: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
 <20221115153753.2065803-2-ben.levinsky@xilinx.com>
 <20221125180509.GA622847@p14s>
 <C981698C-5B9B-49B6-9EC2-CC7A0737B155@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C981698C-5B9B-49B6-9EC2-CC7A0737B155@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 09:39:33PM +0000, Levinsky, Ben wrote:
> Hi Mathieu,
> 
> Thank you for your review. Please see my reply inline.
> 
> Thanks
> Ben
> 
> ﻿On 11/25/22, 10:05 AM, "Mathieu Poirier" <mathieu.poirier@linaro.org> wrote:
> 
>     CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
>     Hi Ben,
> 
>     On Tue, Nov 15, 2022 at 07:37:53AM -0800, Ben Levinsky wrote:
>     > Allow users of remoteproc the ability to get a handle to an rproc by
>     > passing in node that has parent rproc device and an ID that matches
>     > an expected rproc struct's index field.
>     >
>     > This enables to get rproc structure for remoteproc drivers that manage
>     > more than 1 remote processor (e.g. TI and Xilinx R5 drivers).
>     >
>     > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
>     > ---
>     >  drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++++++++++-
>     >  include/linux/remoteproc.h           |  1 +
>     >  2 files changed, 64 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>     > index 775df165eb45..6f7058bcc80c 100644
>     > --- a/drivers/remoteproc/remoteproc_core.c
>     > +++ b/drivers/remoteproc/remoteproc_core.c
>     > @@ -40,6 +40,7 @@
>     >  #include <linux/virtio_ring.h>
>     >  #include <asm/byteorder.h>
>     >  #include <linux/platform_device.h>
>     > +#include <linux/of_platform.h>
>     >
>     >  #include "remoteproc_internal.h"
>     >
>     > @@ -2203,13 +2204,74 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>     >
>     >       return rproc;
>     >  }
>     > +
>     > +/**
>     > + * rproc_get_by_id() - find a remote processor by ID
>     > + * @phandle: phandle to the rproc
>     > + * @id: Index into rproc list that uniquely identifies the rproc struct
>     > + *
>     > + * Finds an rproc handle using the remote processor's index, and then
>     > + * return a handle to the rproc. Before returning, ensure that the
>     > + * parent node's driver is still loaded.
>     > + *
>     > + * This function increments the remote processor's refcount, so always
>     > + * use rproc_put() to decrement it back once rproc isn't needed anymore.
>     > + *
>     > + * Return: rproc handle on success, and NULL on failure
>     > + */
>     > +
>     > +struct rproc *rproc_get_by_id(phandle phandle, unsigned int id)
>     > +{
>     > +     struct rproc *rproc = NULL, *r;
>     > +     struct platform_device *parent_pdev;
>     > +     struct device_node *np;
>     > +
>     > +     np = of_find_node_by_phandle(phandle);
>     > +     if (!np)
>     > +             return NULL;
>     > +
>     > +     parent_pdev = of_find_device_by_node(np->parent);
>     > +     if (!parent_pdev) {
>     > +             dev_err(&parent_pdev->dev,
>     > +                     "no platform device for node %pOF\n", np);
>     > +             of_node_put(np);
>     > +             return NULL;
>     > +     }
>     > +
>     > +     /* prevent underlying implementation from being removed */
>     > +     if (!try_module_get(parent_pdev->dev.driver->owner)) {
>     > +             dev_err(&parent_pdev->dev, "can't get owner\n");
>     > +             of_node_put(np);
>     > +             return NULL;
>     > +     }
>     > +
>     > +     rcu_read_lock();
>     > +     list_for_each_entry_rcu(r, &rproc_list, node) {
>     > +             if (r->index == id) {
>     > +                     rproc = r;
>     > +                     get_device(&rproc->dev);
>     > +                     break;
>     > +             }
>     > +     }
> 
>     This won't work because several remote processors can be on the list.  If
>     another remote processor was discovered before the one @phandle is associated
>     with, the remote processor pertaining to that previous one will returned.
> 
> I didn't understand. From my point of view passing in the phandle of the child-platform device here will work because each child-platform will have its own entry in the remoteproc list.

You are correct, each child platform device will have its own entry in
@rproc_list.  The problem is that r->index may not match @id that is passed as a
parameter.  

> 
> Also " If    another remote processor was discovered before the one" Here this prevented from what I can see because the remoteproc_list is protected by a mutex_lock. See https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2288 for the mutex_lock. 
> 
> Additionally the calls to zynqmp_r5_add_rproc_core() are called sequentially so this also prevents the race condition.
> 
> I think I am missing something in your paragraph above. Can you expand on this issue?

As explained above, the issue is not about race conditions but the value of
r->index and @id.  

> 
>  Do you mean to say that if we use the cluster platform device you think using one of the existing APIs will work? For example rproc_get_by_child() or rproc_get_by_phandle() 
> 
> At https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923 " zynqmp_r5_add_rproc_core(&child_pdev->dev);" Here if we use cluster->dev this will work? To dig deeper into this for both the Xilinx and TI R5 remoteproc drivers, I think this proposed solution will create an issue in that for Split modes, the existing getter APIs will not be able to return one of the corresponding rproc instances because both cores will refer to the same platform-device structure. 
> 
> I can bring up the above in the community call.
> 
>     There is also an issue with rproc_put().
> 
> If passing the cluster platform device works for the above then rproc_put() should work correct? We can test this on our side as well. That being said I can bring this up in the community call 

Yes, using the cluster platform device will work with rproc_put(). 

> 
> 
>     I think your description of the problem is mostly correct.  The intermediate
>     devices created by the cascading entries for individual remote processors in the
>     device tree are causing an issue.  The "compatible" string for each remote
>     processor can't be handled by any platform drivers (as it should be), which
>     makes try_module_get() fail because r->dev.parent->driver is not bound to
>     anything.
> 
>     Looking at the code for Xilinx's R5F support that I just queued[1], the simplest
>     solution may be to pass @dev, which is in fact @cluster->dev, to
>     zynqmp_r5_add_rproc_core() rather than the device associated with the
>     intermediate platform device.
> 
>     That _should_ work.  It is hard for me to know for sure since I don't have a
>     platform that has dual core remote processor to test with.
> 
>     Get back to me with how that turned out and we'll go from there.
> 
>     Thanks,
>     Mathieu
> 
> 
> 
> 
>     [1]. https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923
> 
>     > +     rcu_read_unlock();
>     > +
>     > +     of_node_put(np);
>     > +
>     > +     return rproc;
>     > +}
>     > +EXPORT_SYMBOL(rproc_get_by_id);
>     >  #else
>     >  struct rproc *rproc_get_by_phandle(phandle phandle)
>     >  {
>     >       return NULL;
>     >  }
>     > -#endif
>     >  EXPORT_SYMBOL(rproc_get_by_phandle);
>     > +struct rproc *rproc_get_by_id(phandle phandle, unsigned int id)
>     > +{
>     > +     return NULL;
>     > +}
>     > +EXPORT_SYMBOL(rproc_get_by_id);
>     > +#endif
>     >
>     >  /**
>     >   * rproc_set_firmware() - assign a new firmware
>     > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>     > index 3cde845ba26e..10961fae0f77 100644
>     > --- a/include/linux/remoteproc.h
>     > +++ b/include/linux/remoteproc.h
>     > @@ -645,6 +645,7 @@ struct rproc_vdev {
>     >  };
>     >
>     >  struct rproc *rproc_get_by_phandle(phandle phandle);
>     > +struct rproc *rproc_get_by_id(phandle phandle, unsigned int id);
>     >  struct rproc *rproc_get_by_child(struct device *dev);
>     >
>     >  struct rproc *rproc_alloc(struct device *dev, const char *name,
>     > --
>     > 2.25.1
>     >
> 


