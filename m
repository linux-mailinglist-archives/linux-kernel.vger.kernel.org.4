Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050CE5B59CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiILMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiILMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:00:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E828E2A966
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662984008; x=1694520008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RPWT9rKsWP9FM2ux9RvEk+SvbNcKtBbwIAIZlTXQpKE=;
  b=G6wmZWmChlM7wRXeJFBKgGU4Kr0U+R9ecrrQAztg8+9VR2ZMtSzGpIfu
   oyFjQNaZyIgMWzB7FUzXVB8B6gueCNwRq7EiGm+08xb5YZvIf0odaZNxi
   WIE7u2OORLccCBe3TXb7oKis54L7+J+6J1h5OEK/6lfL3FIHVlsZeTlNx
   xM8PH2QYwi1dt/TZLZ9bWXcMXA4pnh5gls/zBYjZXQdEdK3USrX1InbrT
   OrioUVYLG8QtAqnhk0utYX7bbydmcPL2r0YYadlZkWt2eOrtoNv22Df21
   wssX8PqnRj1u1SJILWhnPLwRsyenI7K+zJR9I6U1sWOzo26+s5YPBk3d4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="297847496"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="297847496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126482"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:05 -0700
Message-ID: <72cd1004-e952-b167-e08d-2b5623b638fd@linux.intel.com>
Date:   Mon, 12 Sep 2022 13:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/5] soundwire: bus: Don't re-enumerate before status
 is UNATTACHED
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
 <20220907085259.3602-4-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907085259.3602-4-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 10:52, Richard Fitzgerald wrote:
> Don't re-enumerate a peripheral on #0 until we have seen and
> handled an UNATTACHED notification for that peripheral.
> 
> Without this, it is possible for the UNATTACHED status to be missed
> and so the slave->status remains at ATTACHED. If slave->status never
> changes to UNATTACHED the child driver will never be notified of the
> UNATTACH, and the code in sdw_handle_slave_status() will skip the
> second part of enumeration because the slave->status has not changed.
> 
> This scenario can happen because PINGs are handled in a workqueue
> function which is working from a snapshot of an old PING, and there
> is no guarantee when this function will run.
> 
> A peripheral could report attached in the PING being handled by
> sdw_handle_slave_status(), but has since reverted to device #0 and is
> then found in the loop in sdw_program_device_num(). Previously the
> code would not have updated slave->status to UNATTACHED because it had
> not yet handled a PING where that peripheral had UNATTACHED.
> 
> This situation happens fairly frequently with multiple peripherals on
> a bus that are intentionally reset (for example after downloading
> firmware).
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1cc858b4107d..6e569a875a9b 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -773,6 +773,16 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  			if (sdw_compare_devid(slave, id) == 0) {
>  				found = true;
>  
> +				/*
> +				 * To prevent skipping state-machine stages don't
> +				 * program a device until we've seen it UNATTACH.
> +				 * Must return here because no other device on #0
> +				 * can be detected until this one has been
> +				 * assigned a device ID.
> +				 */
> +				if (slave->status != SDW_SLAVE_UNATTACHED)
> +					return 0;
> +
>  				/*
>  				 * Assign a new dev_num to this Slave and
>  				 * not mark it present. It will be marked
