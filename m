Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA80760F7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiJ0Mrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiJ0Mr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:47:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A252FCB;
        Thu, 27 Oct 2022 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666874847; x=1698410847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4i12he+deeRnF8xkAn6beuOyKTTgyW/CZlwDz1jI4YI=;
  b=Xs9QnggXj1KoyEYuFylQkJhFhmK6t0dDBskNUXjHDUOvm2g3P/rx+xp8
   asLLOEYGifKNGqntofx6gWfyJLu+qBeVfSkLSgN3km4FEcSQd39hKWFra
   PTUSz5qQbiR/ri9jQErZAXGmXdoOQA26vJbSM3oD0VgJH1qtR+CUFXqRT
   KElQnQtuDVkrAfEkhj95aGZUdOwQRJKVYMZso3NPeq2tqqqTG+qLal3Jc
   HZyqvcybkUfxG/NSA1wkWEiR/cuatVaWKtAQcpEhCCrYeqQ5DKaqwa5OD
   NT8PZrErMAspwPPIZPxwLcgvw1CzPuzio6Uz6zlPvo+JFpb0xHRV/avSS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309908133"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="309908133"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 05:47:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="757686035"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="757686035"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 05:47:21 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 796102026C;
        Thu, 27 Oct 2022 15:47:19 +0300 (EEST)
Date:   Thu, 27 Oct 2022 12:47:19 +0000
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
Message-ID: <Y1p91+XxPCB9NWwh@paasikivi.fi.intel.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com>
 <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Oct 27, 2022 at 01:01:52PM +0100, Lad, Prabhakar wrote:
> Hi Sakari,
> 
> On Thu, Oct 27, 2022 at 12:20 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Prabhakar,
> >
> > One more comment.
> >
> > On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > >
> > >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > >
> > > +     pm_runtime_set_active(dev);
> > > +     pm_runtime_get_noresume(dev);
> > > +     pm_runtime_enable(dev);
> >
> > You won't gain anything by eanbling runtime PM here. Just move it to the
> > end of the function before the rest of the calls. Error handling becomes
> > more simple.
> >
> If I move the above calls below I get the below warning:
> 
> [    2.633386] ov5645 0-003c: Runtime PM usage count underflow!
> 
> This is because of the last patch which moves ov5645_entity_init_cfg()
> before registering the subdev. ov5645_entity_init_cfg() calls s_ctrl
> due to which we are seeing the above message. Please let me know how
> to proceed on this.

Ah. Yes, this is a problem with the usage pattern of
pm_runtime_get_if_in_use(). But please don't change that.

You can still move enabling runtime PM later in the function.

-- 
Kind regards,

Sakari Ailus
