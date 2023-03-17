Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B8E6BE4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCQJAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjCQJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:00:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2E75A66;
        Fri, 17 Mar 2023 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679043560; x=1710579560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oCf58mkw6z/UOzQVLyw0X8P6tYofIqYaH4g4wKjkx1o=;
  b=ThjOUWVXVmPxW81IORjcKAuXlbrgRPV4i+7WVUxfa627uy4t8Sx+nnfn
   1fbpivZWneLd6OeOhUVogEMtgC1Ecq20hVCYEtROjJ0BCNH0j5UbhT50N
   xZ8EIIL73B3ukcDfqObRHUv3rqq1K7WVLpP4lq2Rp1QpMQTzmRc/8QdKs
   /ovzxIbteZ2wxSSmp8exBLUfo4IPmnUeJaKdnRRbjbu7eydVbguIxcTa/
   UP/oAI6+zFukDEtAHAfuHF7t+TOYaFToeXWmdcm/SfGKOHJIalsxwQRfz
   0piJBgyMOm23V6WdKa4bOKBjLmTSjXjKg9FCOhnPD0EHpWHGV3bVOEWq0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340578764"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="340578764"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 01:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="710425033"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="710425033"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 01:58:38 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 000E211F7FC;
        Fri, 17 Mar 2023 10:58:34 +0200 (EET)
Date:   Fri, 17 Mar 2023 10:58:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Message-ID: <ZBQrulUBX1rYD9EN@kekkonen.localdomain>
References: <ZAb2G7kqsEvrBhpG@kekkonen.localdomain>
 <DM6PR11MB4316B4F865472CA998E696FC8DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
 <4c3ba301-6241-f2f4-f139-b4f4a0cd6223@redhat.com>
 <DM6PR11MB43166ADFA7D0775BA2C223C78DB59@DM6PR11MB4316.namprd11.prod.outlook.com>
 <e12fe65e-0b1f-a058-75e6-fa3e0a292c5b@redhat.com>
 <DM6PR11MB4316B02E112305F411B1A5158DB59@DM6PR11MB4316.namprd11.prod.outlook.com>
 <bb608934-23a6-213b-ab28-5dd66afd88e5@redhat.com>
 <MN2PR11MB43183F350CB575F94B1F05748DBC9@MN2PR11MB4318.namprd11.prod.outlook.com>
 <346c376e-01ed-267e-b1c8-ee42c345d03f@redhat.com>
 <DM6PR11MB4316F0F7B7A0F52FA5DF03BE8DBD9@DM6PR11MB4316.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4316F0F7B7A0F52FA5DF03BE8DBD9@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Fri, Mar 17, 2023 at 07:30:19AM +0000, Wu, Wentong wrote:
> 
> 
> > -----Original Message-----
> > From: Hans de Goede <hdegoede@redhat.com>
> > Sent: Thursday, March 16, 2023 5:04 PM
> > 
> > Hi,
> > 
> > On 3/16/23 03:58, Wu, Wentong wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Hans de Goede <hdegoede@redhat.com>
> > >> Sent: Thursday, March 9, 2023 11:24 PM
> > >>
> > >> <re-added the previous Cc list, which I dropped because of the large
> > >> attachments>
> > >>
> > >> Hi Wentong,
> > >>
> > >> On 3/9/23 15:29, Wu, Wentong wrote:
> > >>> Hi Hans,
> > >>>
> > >>> Thanks
> > >>>
> > >>> And AFAICT, there is no IVSC device on your Dell Latitude 9420 where
> > >>> the
> > >> platform is based on TGL instead of ADL, and I have never heard IVSC
> > >> runs on TGL,  if no IVSC, INT3472 will control sensor's power.
> > >>> And I will double confirm with people who know dell product well tomorrow.
> > >>
> > >> Ah, I was under the impression that there was an IVSC there because:
> > >>
> > >> 1. The sensor driver for the used sensor (tries to) poke the IVSC 2.
> > >> Things did not work without building the IVSC drivers, but that might
> > >>    be due to a dependency on the LCJA GPIO expander instead
> > >
> > > Below is your dmesg log, the required SPI controller for IVSC isn't here.
> > >
> > > [   35.538114] ljca 2-6:1.0: acked sem wait timed out ret:0 timeout:20 ack:0
> > > [   35.538129] ljca 2-6:1.0: MNG_ENUM_SPI failed ret:-110 len:7 num:0
> > > [   35.538621] ljca 2-6:1.0: LJCA USB device init success
> > > [   35.538776] usbcore: registered new interface driver ljca
> > >
> > > Also I checked your SSDT, there is no IVSC device and the sensor
> > > device depends on
> > > INT3472 instead of IVSC device as on my setup.
> > 
> > Ack.
> > 
> > >> But you might very well be right, that would also explain the "intel vsc not
> > ready"
> > >> messages in dmesg.
> > >>
> > >> If with the IVSC case the IVSC controls the power to the sensor too,
> > >> then another option might be to model the I2C-switch + the
> > >> power-control as a powerdown GPIO for the sensor, which most sensor
> > drivers already try to use.
> > >> The advantage of doing this would be that GPIO lookups can reference
> > >> the GPIO provider + consumer by device-name so then we don't need to
> > >> have both devices instantiated at the time of
> > >> adding the GPIO lookup.   And in that case we could e.g. add the lookup
> > >> before registering the I2C controller.
> > >
> > > Can we add IVSC device to acpi_honor_dep_ids, so that when everything
> > > is done during mei_ace probe, acpi_dev_clear_dependencies can make sensor
> > start probe?
> > 
> > Does the sensor ACPI device node have an ACPI _DEP on the IVSC device ?
> 
> Yes,
> 
> > 
> > If yes, then yes we can add the IVSC device to acpi_honor_dep_id and make
> > mei_ace probe call acpi_dev_clear_dependencies().
> 
> But I prefer the powerdown gpio model, because we have to follow the commands
> sequences as below which is required by firmware, runtime pm is hard to achieve this.

How so?

I don't insist on the runtime PM based solution but I'd rather not have
changes to virtually all sensor drivers --- this is an external chip to
them.

> +	/* switch camera sensor ownership to host */
> +	ret = ace_set_camera_owner(ACE_CAMERA_HOST);
> +	if (ret)
> +		goto error;
> +
> +	/* switch CSI-2 link to host */
> +	ret = csi_set_link_owner(CSI_LINK_HOST, callback, context);
> +	if (ret)
> +		goto release_camera;
> +
> +	/* configure CSI-2 link */
> +	ret = csi_set_link_cfg(nr_of_lanes, link_freq);
> +	if (ret)
> +		goto release_csi;

-- 
Kind regards,

Sakari Ailus
