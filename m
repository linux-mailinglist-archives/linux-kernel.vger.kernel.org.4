Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9672C614
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjFLNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjFLNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:35:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90082135;
        Mon, 12 Jun 2023 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686576913; x=1718112913;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvEVUUkCwjwDifIKSTm1C10zpa7qKE3wn/SiwKbdQ+M=;
  b=P0RUWHPU0hr05SoDnCIGluTXViysK6iepT5f7uDwg7jbr0cTRZWjDOxH
   gCWUYIoSNycOqpLh0I6L0QanW84PCXdyelBwluVsLIuXXdfTEuoPqh5IP
   c/oqkvK/2dIIet3svY8+zeKLaYIEZQjbsUrscLyzKDseMCplySOa+Q0p5
   xWRnqV5YSYwFmZPxhbu/Bxchd+ZV0LSBzRK10yQKS2cI2Os9Xxjx9OVVH
   wFqDUG/haAPEERqHX7/7ewhNELRzXTbWx3yox80pVfcaeFTBCu9Z/lbbD
   VLp851dr6aht74wJN8JYs/ylSghm9PsOEZzCemDl9dFPdflke0pH+yBRM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421629476"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421629476"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 06:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741031113"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="741031113"
Received: from dkhokhri-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.166.252])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 06:34:00 -0700
Message-ID: <0642f96559182c76548990cac383fbb110f8d56b.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Allow multi-function sensor devices
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Jun 2023 06:34:00 -0700
In-Reply-To: <nycvar.YFH.7.76.2306120938360.5716@cbobk.fhfr.pm>
References: <20230528092427.42332-1-daniel.thompson@linaro.org>
         <nycvar.YFH.7.76.2306091742090.5716@cbobk.fhfr.pm>
         <51dfdee66713e470d9a925ac5a8f8ae1da644462.camel@linux.intel.com>
         <nycvar.YFH.7.76.2306120938360.5716@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-12 at 09:39 +0200, Jiri Kosina wrote:
> On Sun, 11 Jun 2023, srinivas pandruvada wrote:
> 
> > > > The Lenovo Yoga C630 has a combined keyboard and accelerometer
> > > > that 
> > > > interfaces via i2c-hid. Currently this laptop either has a
> > > > working 
> > > > keyboard (if CONFIG_HID_SENSOR_HUB is disabled) or a working 
> > > > accelerometer. only works on kernels. Put another way, most
> > > > distro 
> > > > kernels enable CONFIG_HID_SENSOR_HUB and therefore cannot work
> > > > on 
> > > > this device since the keyboard doesn't work!
> > > > 
> > > > Fix this by providing a richer connect mask during the probe.
> > > > With 
> > > > this change both keyboard and screen orientation sensors work 
> > > > correctly.
> > > > 
> > > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > 
> > > Srinivas, are you aware of any multi-function device that this
> > > patch 
> > > might break?
> > I tried two systems, one with ISH and another with external hub.
> > Didn't 
> > break anything. I don't have 5+ years old systems, to confirm if it
> > will 
> > break something on older systems with external hub.
> 
> Thanks a lot. Can I take the above as an equivalent of
> 
>         Acked-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
Sure. 
Acked-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>
> 
Thanks,
Srinivas




> ? :)
> 

