Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF0F65D7C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbjADQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjADQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:00:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977B3752F;
        Wed,  4 Jan 2023 08:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672848021; x=1704384021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wUkahyYCePZjF9jvyYrlyn2wQDAaaljuEwG/x6ICOEU=;
  b=jIVf1uX8VM8SqyKUJy08CyYKxjCTxyD3NCKXlJELBqAbcuniKyFF75hO
   2nL7Zon3uqJhg+ahJ0ys/JOceFDs2omxJZtJDanwd2UInwrCcj//eyMmG
   8uwU0bD/zwQNLsfcIanKPVu5uZTuAvpFvF7oB/TIws6+vYnuIe5yn+hZM
   lgmk1dtEfms2V3i2sKB7vgBwGnVeUz4C+L8I5tiYt9hLtFmIMoGXHED+k
   0agTu6/KCVugPgdne4RmmFsFz8mPWkvB9rh/jaiPa7AosdT7w83mtUhDc
   bb7CkQx7goGnqjz6I0yWPBrRe2AeWQGn3LuMP25aZnJ4HjXr90sHF1YPu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="386396655"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="386396655"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:00:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900590914"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="900590914"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:59:55 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 32FFA2017A;
        Wed,  4 Jan 2023 17:59:53 +0200 (EET)
Date:   Wed, 4 Jan 2023 15:59:53 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Robert Mader <robert.mader@collabora.com>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: imx258: Parse and register properties
Message-ID: <Y7WieRzn4p9NCwsg@paasikivi.fi.intel.com>
References: <20230104122337.123055-1-robert.mader@collabora.com>
 <20230104141159.e2klapbpenslxqbx@uno.localdomain>
 <e55766f0-5090-abb5-dbd7-58230153a8ce@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55766f0-5090-abb5-dbd7-58230153a8ce@collabora.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Wed, Jan 04, 2023 at 03:14:50PM +0100, Robert Mader wrote:
> On 04.01.23 15:11, Jacopo Mondi wrote:
> > Hi Robert
> > 
> > On Wed, Jan 04, 2023 at 01:23:37PM +0100, Robert Mader wrote:
> > > Analogous to e.g. the imx219. This enables propagating
> > > V4L2_CID_CAMERA_ORIENTATION and V4L2_CID_CAMERA_SENSOR_ROTATION
> > > values.
> > > The motivation is to allow libcamera detect these values from the
> > > device tree and propagate them further to e.g. Pipewire.
> > > 
> > > While at it, reserve space for 3 additional controls even if
> > > v4l2_ctrl_new_fwnode_properties() can only register 2 of
> > > them, to fix the existing implementation which reserve space for 8
> > > controls but actually registers 9.
> > > 
> > > Changes in v2:
> > >   - Reserve 11 instead of 10 controls
> > >   - Change order of variable declaration
> > >   - Slightly extend description
> > This part should go below, after ---, as it shouldn't be part of the commit
> > message
> > 
> > The patch looks good
> > 
> > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Thanks! And ops, right, make sense. Should I spin a v3 for that or is it
> simple enough to fix when pulling?

I can fix it while applying the patch.

-- 
Regards,

Sakari Ailus
