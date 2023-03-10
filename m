Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C766B55B9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCJXgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCJXf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:35:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EB142DCF;
        Fri, 10 Mar 2023 15:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678491356; x=1710027356;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7p2aJBqq4hOXPvY+L/qEBFntAfiZRLNDaMpI1a8A1yw=;
  b=HqkeX3NYo6BxUlFn2TzJ2aD1opPrAKhOerm8mh4f0HCtEW2KQhlVpglG
   NMBDCVlfE8+MMPdzRmG9e15u27gyMgADeZq0YLyPaigHDrs1NXEMNPFPn
   j/gI+Rop8H55mHoJlv1e1PEF6DGOM9B3QZwvYENe4SeheA7dIRgk6fzoc
   AIJ+zMVlivcyLZjzbabe1rD6Vpz3623vDMWlHSFeMEdGpf6IB5HEelM7y
   CS2QWnXniveHlkUHHq6vbmchlb9sRQEiVQNKlvo8RXMoWYSgEJffPi6QP
   RvzV1vDMJkBJjsE62dl0C9kJ/IFixNS5jo5MN5gaNlbmZIXR7Lh7V1CDR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316499255"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="316499255"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 15:35:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="1007298354"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="1007298354"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 15:35:55 -0800
Message-ID: <fe7b41aa975128bd44d351911b0faa17b837033c.camel@linux.intel.com>
Subject: Re: BUG: hid-sensor-ids code includes binary data in device name
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Even Xu <even.xu@intel.com>
Cc:     Jonathan.Cameron@huawei.com, jkosina@suse.cz,
        todd.e.brandt@intel.com
Date:   Fri, 10 Mar 2023 15:35:55 -0800
In-Reply-To: <424882ed2a79a641f88b5f2d1ed5a5d3d4fe98d9.camel@gmx.net>
References: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
         <317ce138f63b9317ac7be1949a68db5117c19b92.camel@linux.intel.com>
         <424882ed2a79a641f88b5f2d1ed5a5d3d4fe98d9.camel@gmx.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-10 at 15:35 +0100, Philipp Jungkamp wrote:
> Hello,
> 
> on v3 of the patchset I had this comment on the 'real_usage'
> initialization:
> 
> > > -	char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
> > > +	char real_usage[HID_SENSOR_USAGE_LENGTH];
> > >  	struct platform_device *custom_pdev;
> > >  	const char *dev_name;
> > >  	char *c;
> > > 
> > > -	/* copy real usage id */
> > > -	memcpy(real_usage, known_sensor_luid[index], 4);
> > > +	memcpy(real_usage, match->luid, 4);
> > > +	real_usage[4] = '\0';
> > 
> > Why the change in approach for setting the NULL character?
> > Doesn't seem relevant to main purpose of this patch.
> 
> Based on the comment, I changed that in the final v4 revision to:
> 
> > -       char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
> > +       char real_usage[HID_SENSOR_USAGE_LENGTH];
> >         struct platform_device *custom_pdev;
> >         const char *dev_name;
> >         char *c;
> >  
> > -       /* copy real usage id */
> > -       memcpy(real_usage, known_sensor_luid[index], 4);
> > +       memcpy(real_usage, match->luid, 4);
> 
> I ommitted the line adding the null terminator to the string but kept
> that I didn't initialize the 'real_usage' as { 0 } anymore. The
> string
> now misses the null terminator which leads to the broken utf-8.
> 
> The simple fix is to reintroduce the 0 initialization in
> hid_sensor_register_platform_device. E.g.
> 
> -	char real_usage[HID_SENSOR_USAGE_LENGTH];
> +	char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
> 

I didn't realize that the issue was a buffer overrun. I tested the
kernel built with this simple fix and it works ok now. i.e. this patch
is is all that's needed:

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-
custom.c
index 3e3f89e01d81..d85398721659 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -940,7 +940,7 @@ hid_sensor_register_platform_device(struct
platform_device *pdev,
                                    struct hid_sensor_hub_device
*hsdev,
                                    const struct
hid_sensor_custom_match *match)
 {
-       char real_usage[HID_SENSOR_USAGE_LENGTH];
+       char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
        struct platform_device *custom_pdev;
        const char *dev_name;
        char *c;

> Where do I need to submit a patch for this? And on which tree should
> I
> base the patch?
> 

The change is so small it shouldn't require any rebasing. Just send the
patch to these emails (from MAINTAINERS):

HID SENSOR HUB DRIVERS
M:  Jiri Kosina <jikos@kernel.org>
M:  Jonathan Cameron <jic23@kernel.org>
M:  Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
L:  linux-input@vger.kernel.org
L:  linux-iio@vger.kernel.org

> I'm sorry for the problems my patch caused.
> 

No problem. It actually made sleepgraph better because it exposed a bug
in the ftrace processing code. I wasn't properly handling the corner
case where ftrace had binary data in it.

> Regards,
> Philipp Jungkamp
> 
> On Fri, 2023-03-10 at 01:51 -0800, srinivas pandruvada wrote:
> > +Even
> > 
> > On Thu, 2023-03-09 at 15:33 -0800, Todd Brandt wrote:
> > > Hi all, I've run into an issue in 6.3.0-rc1 that causes problems
> > > with
> > > ftrace and I've bisected it to this commit:
> > > 
> > > commit 98c062e8245199fa9121141a0bf1035dc45ae90e (HEAD,
> > > refs/bisect/bad)
> > > Author: Philipp Jungkamp p.jungkamp@gmx.net
> > > Date:   Fri Nov 25 00:38:38 2022 +0100
> > > 
> > >     HID: hid-sensor-custom: Allow more custom iio sensors
> > > 
> > >     The known LUID table for established/known custom HID sensors
> > > was
> > >     limited to sensors with "INTEL" as manufacturer. But some
> > > vendors
> > > such
> > >     as Lenovo also include fairly standard iio sensors (e.g.
> > > ambient
> > > light)
> > >     in their custom sensors.
> > > 
> > >     Expand the known custom sensors table by a tag used for the
> > > platform
> > >     device name and match sensors based on the LUID as well as
> > > optionally
> > >     on model and manufacturer properties.
> > > 
> > >     Signed-off-by: Philipp Jungkamp p.jungkamp@gmx.net
> > >     Reviewed-by: Jonathan Cameron Jonathan.Cameron@huawei.com
> > >     Acked-by: Srinivas Pandruvada
> > > srinivas.pandruvada@linux.intel.com
> > >     Signed-off-by: Jiri Kosina jkosina@suse.cz
> > > 
> > > You're using raw data as part of the devname in the "real_usage"
> > > string, but it includes chars other than ASCII, and those chars
> > > end
> > > up being printed out in the ftrace log which is meant to be ASCII
> > > only.
> > > 
> > > -       /* HID-SENSOR-INT-REAL_USAGE_ID */
> > > -       dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s",
> > > real_usage);
> > > +       /* HID-SENSOR-TAG-REAL_USAGE_ID */
> > > +       dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
> > > +                            match->tag, real_usage);
> > > 
> > > My sleepgraph tool started to crash because it read these lines
> > > from
> > > ftrace:
> > > 
> > > device_pm_callback_start: platform HID-SENSOR-INT-020b?.39.auto,
> > > parent: 001F:8087:0AC2.0003, [suspend]
> > > device_pm_callback_end: platform HID-SENSOR-INT-020b?.39.auto,
> > > err=0
> > > 
> > 
> > Here tag is:
> > .tag = "INT",
> > .luid = "020B000000000000",
> > 
> > 
> > The LUID is still a string. Probably too long for a dev_name.
> > 
> > Even,
> > 
> > Please check.
> > 
> > Thanks.
> > Srinivas
> > 
> > 
> > > The "HID-SENSOR-INT-020b?.39.auto" string includes a binary char
> > > that
> > > kills
> > > python3 code that loops through an ascii file as such:
> > > 
> > >   File "/usr/bin/sleepgraph", line 5579, in executeSuspend
> > >     for line in fp:
> > >   File "/usr/lib/python3.10/codecs.py", line 322, in decode
> > >     (result, consumed) = self._buffer_decode(data, self.errors,
> > > final)
> > > UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff in
> > > position
> > > 1568: invalid start byte
> > > 
> > > I've updated sleepgraph to handle random non-ascii chars, but
> > > other
> > > tools
> > > may suffer the same fate. Can you rewrite this to ensure that no
> > > binary
> > > chars make it into the devname?
> > > 
> 
> 

