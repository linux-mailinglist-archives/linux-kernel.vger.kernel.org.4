Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC06138EE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiJaOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJaOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:25:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936116260;
        Mon, 31 Oct 2022 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667226343; x=1698762343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lZSalSSwi49EzYHTba+DNGAOjjgmfsm6XxBlo4aUqfg=;
  b=XmutTOasqiv6i0LnIDmDQ7tI4tAlGeJSEDQHyQCLjcXP4puTkLIV8pVV
   lhisU+OB59wKoyyVRssDUiFa3lhib6gXTkSO1SD1fjmGS6ChZbhgFV80/
   eKeCvg8tB/+OkOGRHjr3xgPeApNRSwcokKAcAPzo8017TfPlXIlc9/B0x
   N0JeiU0RslTlf/dQp4H77+Z99p/8aYjdi5IxeXxC5LGrR2kiuT5SlEum9
   R9qBHIKiM+QsualrpsNJwbomKD7OT4YFh8S68Ff88PG0rWQpWm/La3wlt
   DZnz0+FUbDzakmt8BCjhkVA875UqIRVkRTSm2qtD0kIeAaf3UpvmLbxu1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="309995139"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="309995139"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 07:25:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="636064988"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="636064988"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 07:25:39 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 8C37B20210;
        Mon, 31 Oct 2022 16:25:37 +0200 (EET)
Date:   Mon, 31 Oct 2022 14:25:37 +0000
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
Message-ID: <Y1/a4QUQpykhuXwh@paasikivi.fi.intel.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com>
 <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
 <Y1p91+XxPCB9NWwh@paasikivi.fi.intel.com>
 <CA+V-a8uhYymEVg7jdLVGNLsVD3=O1mk-_NVERu00W+gsv-7QXg@mail.gmail.com>
 <Y1rQBmXj71C1RrwB@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1rQBmXj71C1RrwB@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Oct 27, 2022 at 06:37:58PM +0000, Sakari Ailus wrote:
> Hi Prabhakar,
> 
> On Thu, Oct 27, 2022 at 05:32:07PM +0100, Lad, Prabhakar wrote:
> > Hi Sakari,
> > 
> > On Thu, Oct 27, 2022 at 1:47 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > On Thu, Oct 27, 2022 at 01:01:52PM +0100, Lad, Prabhakar wrote:
> > > > Hi Sakari,
> > > >
> > > > On Thu, Oct 27, 2022 at 12:20 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Prabhakar,
> > > > >
> > > > > One more comment.
> > > > >
> > > > > On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > > > > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > > > > >
> > > > > >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > > > > >
> > > > > > +     pm_runtime_set_active(dev);
> > > > > > +     pm_runtime_get_noresume(dev);
> > > > > > +     pm_runtime_enable(dev);
> > > > >
> > > > > You won't gain anything by eanbling runtime PM here. Just move it to the
> > > > > end of the function before the rest of the calls. Error handling becomes
> > > > > more simple.
> > > > >
> > > > If I move the above calls below I get the below warning:
> > > >
> > > > [    2.633386] ov5645 0-003c: Runtime PM usage count underflow!
> > > >
> > > > This is because of the last patch which moves ov5645_entity_init_cfg()
> > > > before registering the subdev. ov5645_entity_init_cfg() calls s_ctrl
> > > > due to which we are seeing the above message. Please let me know how
> > > > to proceed on this.
> > >
> > > Ah. Yes, this is a problem with the usage pattern of
> > > pm_runtime_get_if_in_use(). But please don't change that.
> > >
> > > You can still move enabling runtime PM later in the function.
> > >
> > Agreed, the final version looks like below:
> > 
> >     pm_runtime_set_active(dev);
> >     pm_runtime_get_noresume(dev);
> > 
> 
> You'll have to enable runtime PM here, before pm_runtime_get_if_in_use()
> gets called.
> 
> I'll see if it could be made to work in a sensible way when runtime PM
> isn't enabled yet.

There are various ways how runtime PM interface functions generally work,
and generally return an error when runtime PM is disabled. Incrementing the
usage_count when runtime PM is disabled would make
pm_runtime_get_if_in_use() very special and not match what the rest would
do. Therefore I think it's best to keep this in the driver. After all, mo
other driver needs this in the media tree, which is the major user of the
function.

-- 
Kind regards,

Sakari Ailus
