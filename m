Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53370E5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjEWTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEWTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:37:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DEAE43
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684870620; x=1716406620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIDV6MM067Jxy1Em6Dzjmp3FnQwt9XSOxCVomJpmKhs=;
  b=L/dgtE3zO+ENmQmUtjF2Tju4+cPzT9EX3gtYuXi5iSBQ4JdHmi+xR9Cu
   F/8HcmN71XY6KTIvoKLqD3uLwsB2z5ssCZXE6FvQOc1/dYk8T/eV3tIqN
   SFoISTciAsrfkP8BGiDIRQGa8FYqWXz4134S9ehmQ1yf0rumhOd8iWukw
   /73kejMmvRJGGv9YIy4ZCpEknYN745OS3R2d8BilADUTimSBWSOzfT7q6
   Wuu9rpSmNZ1J0JC95P1oBJej74feEBTavo2r8vMQ/X/8m+PSw2ap1ZNC/
   LjsGOvlp/fIIIBmSOmgLJpJu6zthd9YjEVJ5U89lvMmKiVfiW7Qa4/BFO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416801024"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="416801024"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 12:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="698187849"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="698187849"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 12:36:54 -0700
Message-ID: <c8010d93-b02e-4d13-e0ae-b265151fc155@linux.intel.com>
Date:   Tue, 23 May 2023 14:36:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: rt5682: Use a maple tree based register cache
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230419-asoc-rt5682-maple-v1-1-ed40369c9099@kernel.org>
 <1ce6bb84-3140-3953-e995-00eb7b16f386@linux.intel.com>
 <73925372-33dc-46ac-9d01-a43f10988d28@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <73925372-33dc-46ac-9d01-a43f10988d28@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 14:28, Mark Brown wrote:
> On Tue, May 23, 2023 at 02:24:53PM -0500, Pierre-Louis Bossart wrote:
> 
>> Wondering if this is the root cause of the regression we're seeing in
>> [1] on a Chromebook with rt5682 in SoundWire mode?
> 
>> I don't see any other changes to this codec driver and the first problem
>> detected seemed to happen when we did an upstream merge last week.
>> Unfortunately the last merge was on April 24 (sof-dev-rebase-20230424)
>> which is just the day before this commit was added...
> 
> Try a revert?

I can try, unfortunately that device is not directly testable with a
simple PR test so it'll take time.

I was just hoping that someone smarter than me had an explanation on the
locking issue. We only use interrupt threads and workqueues, not sure
why sleeping is an issue.
