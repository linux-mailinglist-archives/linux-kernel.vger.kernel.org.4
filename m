Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5860033F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 22:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJPUT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 16:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJPUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 16:19:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F12110B7D;
        Sun, 16 Oct 2022 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665951587; x=1697487587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogrbNGFB5M1vtQ3PovPvttcqw+9H+Rk3xaixx9kWB8E=;
  b=HUKPpGmDhbAEmmifEjW1M5WkhfyatMXcL9gdRllvOWQsj8Jhgy8Ru3WT
   mnwjsMke9noGX8MjO67bgjFVnP+tytsxZn8ALB4K3qEvEcfBDHU3kHSKe
   Im990R6EJDuwrcwA7BYLHjviKrERaaAmoq+M7AVCItBX2IqhBwIzap5x5
   WUvKgszjqFXnz7DoxUg3247eta0Ar1oDkhDv1Yw690ChxtOJo2OaC9Ge2
   Anb5xLc6KGXfCNdUpP5zSRMHSUqme/l9DuY/VDOMPsO8vpWZ8HAMHnkEE
   7GYb6xG8cH1BDbaQ80EDwLkPZa/DUcVvA43fRuBtnnFe+7AbjgB5GaabV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="391964306"
X-IronPort-AV: E=Sophos;i="5.95,189,1661842800"; 
   d="scan'208";a="391964306"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 13:19:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="770547497"
X-IronPort-AV: E=Sophos;i="5.95,189,1661842800"; 
   d="scan'208";a="770547497"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 13:19:42 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 159C4203BA;
        Sun, 16 Oct 2022 23:19:40 +0300 (EEST)
Date:   Sun, 16 Oct 2022 20:19:40 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
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
Subject: Re: [PATCH v2 4/5] media: i2c: ov5645: Return zero for s_stream(0)
Message-ID: <Y0xnXM+Iw5OkdKj6@paasikivi.fi.intel.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0pSYfw+VDxXv85b@pendragon.ideasonboard.com>
 <Y0snkMEp9WqGtzom@paasikivi.fi.intel.com>
 <Y0tA4cZBdwCOkaOs@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0tA4cZBdwCOkaOs@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sun, Oct 16, 2022 at 02:23:13AM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> On Sat, Oct 15, 2022 at 09:35:12PM +0000, Sakari Ailus wrote:
> > On Sat, Oct 15, 2022 at 09:25:37AM +0300, Laurent Pinchart wrote:
> > > On Fri, Oct 14, 2022 at 07:34:58PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > 
> > > > Always return zero while stopping the stream as the caller will ignore the
> > > > return value.
> > > > 
> > > > This patch drops checking the return value of ov5645_write_reg() and
> > > > continues further in the code path while stopping stream. The user anyway
> > > > gets an error message in case ov5645_write_reg() fails.
> > > 
> > > Continuing all the way to pm_runtime_put() is fine, but I don't think
> > > the function should return 0. It's not up to the driver to decide if a
> > > failure would be useful to signal to the caller or not.
> > 
> > If the function returns an error when disabling streaming, what is the
> > expected power state of the device after this?
> 
> That's up to us to decide :-)
> 
> > The contract between the caller and the callee is that the state is not
> > changed if there is an error.
> 
> For most APIs, but that's not universal.
> 
> > This is a special case as very few callers
> > check the return value for streamoff operation and those that do generally
> > just print something. I've never seen a caller trying to prevent streaming
> > off in this case, for instance.
> 
> I think the stream off call should proceed and try to power off the
> device even if an error occurs along the way, i.e. it shouldn't return
> upon the first detected error.
> 
> > Of course we could document that streaming off always counts as succeeded
> > (e.g. decreasing device's runtime PM usage_count) while it could return an
> > informational error code. But I wonder if anyone would ever benefit from
> > that somehow. :-)
> 
> I think it could be useful to propagate errors up to inform the user
> that something wrong happened. That would involve fixing lots of drivers
> along the call chain though, so there's no urgency for the ov5645 to do
> so, but isn't it better to propagate the error code instead of hiding
> the issue ?

I also don't think hiding the issue would be the best thing to do, but that
wouldn't likely be a big problem either.

How about printing a warning in the wrapper while returning zero to the
original caller? This would keep the API intact while still leaving a trace
on something failing. Of course the driver is also free to print whatever
messages it likes.

-- 
Regards,

Sakari Ailus
