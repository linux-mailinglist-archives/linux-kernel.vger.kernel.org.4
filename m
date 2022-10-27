Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B02610097
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiJ0Spy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiJ0Spm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:45:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B75BCDF;
        Thu, 27 Oct 2022 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666896341; x=1698432341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPia0m1f9qEjXnqMsbXsyWcftpr+mF2VBdbIQw7izUc=;
  b=jnl8WsScImiWyVnSCq/XF6TEh1SJSPtKx4EyQUskaVoXivu610urI6Lx
   sj8QAEOBGLBP1EDlu3UAp/YGYk8EsOJ1G2f9gSYxabETxGmP/AhxRGCu/
   JJBn26UPIv2a3eKOJ92/cKD2qDWdgpBZnMrLiDsmQIoROeW8oQjNj10v6
   8X/nH0uRyIx7bYLRSFHWy/yNgrvsmX+VATcKnSu5eCHHZ8qkv7PKc4FQp
   6Eoan81RuNW8kjIz+E1L8cY1pg84Ld9c8J0jwUvNOafvb2BPLGPKPHOZ9
   82V/LOmnhIBC9mWHBNHe4qDx5clwK02IXMFNs/QuL1ntgOKOcp+/LcTji
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="372523478"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="372523478"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 11:45:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="663727626"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="663727626"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 11:45:35 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 9547020210;
        Thu, 27 Oct 2022 21:37:58 +0300 (EEST)
Date:   Thu, 27 Oct 2022 18:37:58 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 2/5] media: i2c: ov5645: Use runtime PM
Message-ID: <Y1rQBmXj71C1RrwB@paasikivi.fi.intel.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com>
 <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
 <Y1p91+XxPCB9NWwh@paasikivi.fi.intel.com>
 <CA+V-a8uhYymEVg7jdLVGNLsVD3=O1mk-_NVERu00W+gsv-7QXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8uhYymEVg7jdLVGNLsVD3=O1mk-_NVERu00W+gsv-7QXg@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Oct 27, 2022 at 05:32:07PM +0100, Lad, Prabhakar wrote:
> Hi Sakari,
> 
> On Thu, Oct 27, 2022 at 1:47 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Thu, Oct 27, 2022 at 01:01:52PM +0100, Lad, Prabhakar wrote:
> > > Hi Sakari,
> > >
> > > On Thu, Oct 27, 2022 at 12:20 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Prabhakar,
> > > >
> > > > One more comment.
> > > >
> > > > On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > > > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > > > >
> > > > >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > > > >
> > > > > +     pm_runtime_set_active(dev);
> > > > > +     pm_runtime_get_noresume(dev);
> > > > > +     pm_runtime_enable(dev);
> > > >
> > > > You won't gain anything by eanbling runtime PM here. Just move it to the
> > > > end of the function before the rest of the calls. Error handling becomes
> > > > more simple.
> > > >
> > > If I move the above calls below I get the below warning:
> > >
> > > [    2.633386] ov5645 0-003c: Runtime PM usage count underflow!
> > >
> > > This is because of the last patch which moves ov5645_entity_init_cfg()
> > > before registering the subdev. ov5645_entity_init_cfg() calls s_ctrl
> > > due to which we are seeing the above message. Please let me know how
> > > to proceed on this.
> >
> > Ah. Yes, this is a problem with the usage pattern of
> > pm_runtime_get_if_in_use(). But please don't change that.
> >
> > You can still move enabling runtime PM later in the function.
> >
> Agreed, the final version looks like below:
> 
>     pm_runtime_set_active(dev);
>     pm_runtime_get_noresume(dev);
> 

You'll have to enable runtime PM here, before pm_runtime_get_if_in_use()
gets called.

I'll see if it could be made to work in a sensible way when runtime PM
isn't enabled yet.

>     ov5645_entity_init_cfg(&ov5645->sd, NULL);
> 
>     ret = v4l2_async_register_subdev(&ov5645->sd);
>     if (ret < 0) {
>         dev_err(dev, "could not register v4l2 device\n");
>         goto err_pm_runtime;
>     }
> 
>     pm_runtime_set_autosuspend_delay(dev, 1000);
>     pm_runtime_use_autosuspend(dev);
>     pm_runtime_enable(dev);

-- 
Kind regards,

Sakari Ailus
