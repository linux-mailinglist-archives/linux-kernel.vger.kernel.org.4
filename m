Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF706C7345
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjCWWpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjCWWpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:45:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39CF44B8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:45:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d8so108759pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679611535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkke7lO7zfECbcdNUQ9AlvqUsiQvQ5+YaugutlTNtBQ=;
        b=zIYsK8NxxtJbOXGPswHLWVUeMHQd4OFgrF1cyiq4Iuz8Y3bcwFnDXOL0o57KW6+JeC
         F0uoKvKGVgLCpN4WIpOZ4d3UJTF0l35NXDi+Jg8WJwDa0Ics0NJGyFDN30nHT6wmkA/P
         duow8DOw++TcAMQ/UkEKHRDlq4CphgUkeNSgaapwbQRBhD9lkcVbYZk+1k4LNHsNCAD3
         4ddhR3CevCTPn2inzJrl4QBj57bkOn9JDidQ3lW9KeHtR/cJGiT91380AQkvhTlQc6qL
         KxPnH3qELGNpPq0npNDrUa0M9vI9Pn9YwpACsa7xtOW5dq4wlqmBxWmFERVnxhHMRmHs
         X9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkke7lO7zfECbcdNUQ9AlvqUsiQvQ5+YaugutlTNtBQ=;
        b=0lW6WP0e4/NERxQsxFGTAeeGYIHKwXAmZQN9wV+8txkBWpiTFkW82NCgUwZ0yW+Qal
         kHEw7d2PS75SMWZ/MfISmDYoqawyhWFJjD4Ts+0ceyy7Dw84EJKaaODZWYsUCQfRDsyQ
         d7p06hzGwNxPFJ8vCUqjzdz53DwuSjneiNLR3sK1rre+FNejXozD8wN4440Ip5UalahN
         kdrLVWxfa0TzlQUlA/2zFSPv4s1wfDZuS7tuY3vqxiZAFJNm1b7QAwfPWH6/IYv+rwgd
         BuNUg9EoCzHL6GgN56D5b041c+0Vv4oRTBgxOI4hyCC1bomxet55/ICEGGtzG/fzqhP6
         qGLg==
X-Gm-Message-State: AAQBX9ckvMP4pFi6g8o9csV2GtIQKkTlfTLW18Rd1NqXeBOrwc5yWcGC
        2tvE4d3J6sxzNNA0gyBCDJrFdg==
X-Google-Smtp-Source: AKy350buOjOVDaQRGHLB+sBmZfv9Wb0zHrxC/aDpbwhkP6ilJkmBXq+Z9rXT6O8CRTczid6e/PZ/Pw==
X-Received: by 2002:a62:5254:0:b0:625:febb:bc25 with SMTP id g81-20020a625254000000b00625febbbc25mr881257pfb.11.1679611535254;
        Thu, 23 Mar 2023 15:45:35 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e403:39f9:7f9f:340b])
        by smtp.gmail.com with ESMTPSA id e15-20020a62ee0f000000b0058bacd6c4e8sm12302051pfi.207.2023.03.23.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:45:34 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:45:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tarak Reddy <tarak.reddy@amd.com>
Subject: Re: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
Message-ID: <20230323224532.GB2905636@p14s>
References: <20230322040933.924813-1-tanmay.shah@amd.com>
 <20230322040933.924813-3-tanmay.shah@amd.com>
 <20230322160537.GB2821487@p14s>
 <830db03c-ec6e-b4aa-834a-e67622e5a41f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <830db03c-ec6e-b4aa-834a-e67622e5a41f@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:34:57AM -0700, Tanmay Shah wrote:
> 
> On 3/22/23 9:05 AM, Mathieu Poirier wrote:
> > Hi Tanmay,
> > 
> > On Tue, Mar 21, 2023 at 09:09:36PM -0700, Tanmay Shah wrote:
> > > This patch enhances rproc_put() to support remoteproc clusters
> > > with multiple child nodes as in rproc_get_by_phandle().
> > > 
> > > Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > >   drivers/remoteproc/remoteproc_core.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index a3e7c8798381..e7e451012615 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -2560,6 +2560,19 @@ EXPORT_SYMBOL(rproc_free);
> > >   void rproc_put(struct rproc *rproc)
> > >   {
> > >   	module_put(rproc->dev.parent->driver->owner);
> > There is something wrong here - this should have been removed.
> 
> 
> Thanks Mathieu. Sure this needs to be fixed.
> 
> This is result of manually picking up patch from my side.
> 
> I will try to find better automated way to pick-up patches not available on
> mailing list.
>

That would certainly help avoid problems such as this one.

> 
> > 
> > > +	struct platform_device *cluster_pdev;
> > > +
> > > +	if (rproc->dev.parent) {
> > This condition is not needed, please remove.
> Ack.
> > 
> > > +		if (rproc->dev.parent->driver) {
> > > +			module_put(rproc->dev.parent->driver->owner);
> > > +		} else {
> > > +			cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
> > > +			if (cluster_pdev) {
> > > +				module_put(cluster_pdev->dev.driver->owner);
> > > +				put_device(&cluster_pdev->dev);
> 
> I am not sure if cluster_pdev->dev should be dropped here.
>

It needs to be done here.

> Should we drop it in platform driver after rproc_free() ?
> 
> > > +			}
> > > +		}
> > > +	}
> > Some in-lined documentation, the way I did in patch 1/2 would be appreciated.
> > Otherwize I think the above enhancement make sense.
> Ack I will document in next revision.
> > 
> > Thanks,
> > Mathieu
> > 
> > >   	put_device(&rproc->dev);
> 
> 
> Also, if we decide to drop cluster->dev here  then,
> 
> should we drop reference of rproc->dev before cluster->dev ?
> 
> 
> > >   }
> > >   EXPORT_SYMBOL(rproc_put);
> > > -- 
> > > 2.25.1
> > > 
