Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C9563F93C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLAUic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiLAUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:38:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB31A13E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669927105; x=1701463105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2enUtKIc8eJ6XSYCeVwSSEPFKwqA1PlfLZhjpcLXjdg=;
  b=Eur0E7lxec+bQJmbfHIeWu89Ycvyk+TsqnBB3VWAcGC5Q1OaQsgFPJhW
   gnHSU3Q50a2zhFLUGloaEYIaWOJBj895myBKLBzWCAjMD7b1AjK4rBsIR
   Wc4ZveZ2MSvsKyhTS+5XcQbnc7VobWCLSOOdUP28WW3JInbQMPJOwZmgs
   ZL9dziaV/kTjLJi2N6KRti9s/dbBVTBKK730vY4u1/a8qf2XMyrMIlY4W
   DLKsFqeKewK6M4+EHPzpYFCeWZAbNn/XZJF3IMUN2b5AAH+pTsBBl7/3e
   dLhAxBMltN8shdwYtytZ4G6tU09988/6OTbeOfdEuV1yz2yoAZB25mynI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314498395"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="314498395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644781670"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="644781670"
Received: from twcarol-mobl.amr.corp.intel.com (HELO [10.212.10.40]) ([10.212.10.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:07 -0800
Message-ID: <002826da-f22f-9ce2-1688-345fe4e3c7ed@linux.intel.com>
Date:   Thu, 1 Dec 2022 12:31:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] soundwire: Remove redundant zeroing of page registers
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20221201140813.4062146-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221201140813.4062146-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/22 08:08, Richard Fitzgerald wrote:
> Writing zero to the page registers after each message transaction can add
> up to a lot of overhead for codecs that need to transfer large amount of
> data - for example a firmware download.
> 
> There's no spec reason I can see for this zeroing. The page registers are
> only used for a paged address. The bus code uses a non-paged address for
> registers in page 0. It always writes the page registers at the start of
> a paged transaction.
> 
> If this zeroing was a workaround for anything, let me know and I will
> re-implement the zeroing as a quirk that can be enabled only when it is
> necessary.

It's a feature, not a bug :-)

The page registers have to be zeroed out so that any bus-management
command hits the page0 instead of using a value that was set by codec
driver for vendor-specific configurations.

The implementation is far from optimal though, and indeed if we have
long transactions that are not interrupted by anything else we could
avoid resetting the page registers.

I tried to implement a 'lazy approach' some time back, but at the time I
didn't see any benefits due to the limited number of configurations.

I can't remember where the code is, but the initial enhancement was
listed here: https://github.com/thesofproject/linux/issues/2881

> 
> Richard Fitzgerald (2):
>   soundwire: bus: Don't zero page registers after every transaction
>   soundwire: bus: Remove unused reset_page_addr() callback
> 
>  drivers/soundwire/bus.c             | 23 -----------------------
>  drivers/soundwire/cadence_master.c  | 14 --------------
>  drivers/soundwire/cadence_master.h  |  3 ---
>  drivers/soundwire/intel_auxdevice.c |  1 -
>  include/linux/soundwire/sdw.h       |  3 ---
>  5 files changed, 44 deletions(-)
> 
