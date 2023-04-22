Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3D6EBA93
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDVRLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24C2114;
        Sat, 22 Apr 2023 10:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7796D60FD9;
        Sat, 22 Apr 2023 17:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6260DC433EF;
        Sat, 22 Apr 2023 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682183476;
        bh=d5MuaR1JRioQHDw3XuZZYEHioNjDA9XHHu9n6PJ9rk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dx+y/sGVYXCCEcXIJHXbymWBShgrkxjTYza9SvUbjPvBes0aZ+HGHdb4jBtOVMDmu
         1S6rJC0Xj7wam4ry81nXIAWqbIAGmECa/XT/Wm9GKs7LvDmZyWpVsP7OEhvHqU/hrw
         PiI6Vsgnn7GEh10OQ2GgvrbBMqgj99tJGdIDUm3UNU9C6VeAC6unOGkC1/pt2BU3Qq
         fwFDkEvpRLX3taxE6ljUcCaDiVCFi0QVGf8UvE/OOqVg7wwJVaT+fGr3Aw4wpG0mHu
         PC7yH4pgilX7iYCtf0hG9N6HiGoTMuX/oL+kTBfGzBXk2OkJA49SN0cQx69zGJxt1F
         tpzdvigMUrIsg==
Date:   Sat, 22 Apr 2023 18:26:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: accel: kionix-kx022a: Warn on failed
 matches and assume compatibility
Message-ID: <20230422182652.3f4d3342@jic23-huawei>
In-Reply-To: <6caba41c-3db2-90c4-e1f7-2392162e2b0a@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
        <b6cb3d48ab9e4177b924b18e27487f8ef763dfd6.1682019544.git.mehdi.djait.k@gmail.com>
        <6caba41c-3db2-90c4-e1f7-2392162e2b0a@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 06:44:28 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 4/20/23 23:22, Mehdi Djait wrote:
> > Avoid error returns on a failure to match and instead just warn with
> > assumption that we have a correct dt-binding telling us that
> > some new device with a different ID is backwards compatible.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> > v2:
> > - no changes, this patch is introduced in the v2
> > 
> >   drivers/iio/accel/kionix-kx022a.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index f98393d74666..70530005cad3 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -1038,9 +1038,7 @@ int kx022a_probe_internal(struct device *dev)
> >   		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> >   
> >   	if (chip_id != KX022A_ID) {
> > -		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> > -		return -EINVAL;
> > -	}
> > +		dev_warn(dev, "unsupported device 0x%x\n", chip_id);  
> 
> Just a 'nit' - no need to re-spin the series for this if there is no 
> other changes requested.
> 
> Maybe a slightly better wording here would be "unknown device"? If I am 
> not mistaken the code proceeds because device is assumed to be supported.
> 
> Jonathan, do you think this change is worth backporting? If yes, then we 
> might need a Fixes tag.

We haven't backported similar cases as far as I know. 
It's fine to request it explicitly gets picked up for stable if we decide
we care later.

I'll tidy up above if I take this version..

Jonathan

> 
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> >   
> >   	irq = fwnode_irq_get_byname(fwnode, "INT1");
> >   	if (irq > 0) {  
> 

