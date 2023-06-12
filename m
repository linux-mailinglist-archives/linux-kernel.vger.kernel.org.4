Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5772B702
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjFLEyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjFLEx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:53:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2110710FE;
        Sun, 11 Jun 2023 21:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686545633; x=1718081633;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7NVGgppUsr4ihy99XycTwP945ERD2p7hEVN1hnMYho=;
  b=e/XD9W8J+SZeK1vgtv7AldZG2BMlykF/J8t0RJvRqMV1xrFqKqOXpIa1
   dlarxpwdaBoGPCQmvcNV+UITmeRlnZBd8Fqu3Uo21iy90T8IGBfhO3/xF
   zt0SOE9m9sf14q5MjOpks4NM7UAUyN6OJDUgFDpKu+MceCiwNrT+lB59E
   Te9Q+4/84XhQbgb/UcKSFWtszZi0Ir7vdZg8Gu8uBaptqWtMTRiAAHISR
   WFLPYnPFYS8Zz4kJBRg2f1MlR41KYqHq6RmCvosIgQ/+OiL4OD5x1a3OA
   eTnvE/GCb8rlt5/SvZevD3tzUmXK+kfLp2fu+/w8sUPx2dCYbnDBnOqDq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="337579166"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="337579166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 21:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="885272721"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="885272721"
Received: from btakahas-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.231.182])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 21:53:52 -0700
Message-ID: <51dfdee66713e470d9a925ac5a8f8ae1da644462.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Allow multi-function sensor devices
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 11 Jun 2023 21:53:51 -0700
In-Reply-To: <nycvar.YFH.7.76.2306091742090.5716@cbobk.fhfr.pm>
References: <20230528092427.42332-1-daniel.thompson@linaro.org>
         <nycvar.YFH.7.76.2306091742090.5716@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-09 at 17:43 +0200, Jiri Kosina wrote:
> On Sun, 28 May 2023, Daniel Thompson wrote:
> 
> > The Lenovo Yoga C630 has a combined keyboard and accelerometer that
> > interfaces via i2c-hid. Currently this laptop either has a working
> > keyboard (if CONFIG_HID_SENSOR_HUB is disabled) or a working
> > accelerometer.
> > only works on kernels. Put another way, most distro kernels enable
> > CONFIG_HID_SENSOR_HUB and therefore cannot work on this device
> > since the
> > keyboard doesn't work!
> > 
> > Fix this by providing a richer connect mask during the probe. With
> > this
> > change both keyboard and screen orientation sensors work correctly.
> > 
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Srinivas, are you aware of any multi-function device that this patch
> might 
> break?
I tried two systems, one with ISH and another with external hub.
Didn't break anything.
I don't have 5+ years old systems, to confirm if it will break
something on older systems with external hub.

Thanks,
Srinivas

> 
> Thanks,
> 

