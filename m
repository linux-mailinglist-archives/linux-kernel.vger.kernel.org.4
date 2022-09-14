Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E508F5B89CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiINOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiINOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:02:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071DEBE2F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663164083; x=1694700083;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ZkjhW8tYB33c37H77+5rPYilo73ulNmSfNoXGnr1LME=;
  b=OhZ7DAQdO+IB+b44CgXxfqc/N6f/GmNIdEXVjtY4Q3MuScpxuEq4pj1h
   fsTubwdNejLYXwqjQ2pwrMviqqv2wZ/yMSNR2/o1Ne30f4S/ZMgufUun7
   LbcBzGrErUy3hzthHp+MiFEGDETY7zpMyD6NhCtYzAMzosPOe1nZIQ4qe
   Vuwb1qsHvTBw1b5TeJGGm06g9v+kC8u4Qu5EXZTNQYXFYZkP9WFncuAbL
   yQyfG+XjIteYSKLmm8Erk25BrjTCU+xwV21GSfT/SWZKqNHTVzej7hd+i
   do2cbeU7DVwR6IdUNcoNiZ7qGv/AmIxihfNcd1t3eamU6qf24Fqj33pvE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278821704"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278821704"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:00:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="705968865"
Received: from blaesing-mobl.ger.corp.intel.com (HELO [10.249.45.209]) ([10.249.45.209])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:00:54 -0700
Message-ID: <81fb961f-2629-fece-112b-4277d9e45d6c@linux.intel.com>
Date:   Wed, 14 Sep 2022 16:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 0/5] soundwire: Fixes for spurious and missing UNATTACH
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <20220914120949.747951-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/22 14:09, Richard Fitzgerald wrote:
> The bus and cadence code has several bugs that cause UNATTACH notifications
> to either be sent spuriously or to be missed.
> 
> These can be seen occasionally with a single peripheral on the bus, but are
> much more frequent with multiple peripherals, where several peripherals
> could change state and report in consecutive PINGs.
> 
> The root of all of these bugs seems to be a code design flaw that assumed
> every PING status change would be handled separately. However, PINGs are
> handled by a workqueue function and there is no guarantee when that function
> will be scheduled to run or how much CPU time it will receive. PINGs will
> continue while the work function is handling a snapshot of a previous PING
> so the code must take account that (a) status could change during the
> work function and (b) there can be a backlog of changes before the IRQ work
> function runs again.
> 
> Tested with 4 peripherals on 1 bus, and 8 peripherals on 2 buses.

I added my Reviewed-by tags for the last patches, there's only one typo
which could be dealt with a follow-up patch if that's easier

Thanks again for this contribution, much appreciated.

> CHANGES SINCE V2:
> #4 Add a comment explaining why INTMASK isn't cleared when going around
>    the update_status loop.
> 
> #5 Leave the existing error handling in sdw_program_device_num(),
>    instead of suppressing the error return.
>    Add a comment in sdw_handle_slave_status() explaining why the error
>    is ignored.
>    Re-word the explanation of why sdw_handle_slave_status() must only return
>    early if it programmed a device ID.
> 
> Richard Fitzgerald (4):
>   soundwire: bus: Don't lose unattach notifications
>   soundwire: bus: Don't re-enumerate before status is UNATTACHED
>   soundwire: cadence: Fix lost ATTACHED interrupts when enumerating
>   soundwire: bus: Don't exit early if no device IDs were programmed
> 
> Simon Trimmer (1):
>   soundwire: cadence: fix updating slave status when a bus has multiple
>     peripherals
> 
>  drivers/soundwire/bus.c            | 44 +++++++++++++---
>  drivers/soundwire/cadence_master.c | 80 ++++++++++++++++--------------
>  2 files changed, 80 insertions(+), 44 deletions(-)
> 
