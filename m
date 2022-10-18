Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F160318B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJRR0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:26:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B586ABD4A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666113965; x=1697649965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LSNpDELmghCpJxoRxEfeo1nnKFOQrGzqCjXSQCEcT4Q=;
  b=oBuazWyyn2GazGY/upmv4SMTWW0vmk+g65v7yob9ziWOTRY7UreG7SPU
   /FyRrLcFY6ysLrDkYNRqIIeZizTovVeOnwfEP9Ak2b+OCtyZPiIo4sea5
   QOdwmN0kUJ88/72TDOZAhPbvn65Rx/4bHMQGig3D8Xo2GuWCEIxkV1zy/
   jXOwR8KcmLP9SHA+SgPMCW9HEdDJ4RlA5Zk1c+SwDTMhXy0dvSRT1Agym
   RLQLUzVJMtkvVAKYxqZxe48zzqevLUONXgBrkgz3Q9zQCFHotrt46le6F
   s2Qg4lz5aQ14oCMe/Jc/IWMqbT1yWx15VZdn5guGhwwbyTNXR4Of7v/cB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307838573"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307838573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 10:26:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="579897654"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="579897654"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.6.93])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 10:26:04 -0700
Date:   Tue, 18 Oct 2022 10:26:03 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rts5208: Replace instances of udelay by
 usleep_range
Message-ID: <Y07hq98H0Qx18AcB@aschofie-mobl2>
References: <Y07OcqPNjSihOByt@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07OcqPNjSihOByt@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:04:02PM +0000, Tanjuate Brunostar wrote:
> Replace the use of udelay by usleep_range as suggested by checkpatch:
> 
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> +               udelay(30);
> 
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> +               udelay(50);
> 

Hi Tanjuate,

I'd expect the commit log here to tell me why this is preferable, and
why this is safe to do - basically your summary of what you found
when you considered the checkpatch error report and then read
timers-howto.rst.  Including that this was found my Checkpatch is
good, but that's basically a footnote to the log message, not the
main point.

Having said all that, I see GregKH response and that is typical
for this change. This type of change, needs to be actually tested,
so it's not a good cleanup unless you have the device or some other 
convincing proof that what you are doing is safe.

Outreachy advice:  when you see a checkpatch error, and are
wondering how its fix will be received, search the Outreachy
mail archive for it. This one, I find repeated instances of
the change being NAK'd because the submitter cannot test it.

Alison

> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
> 
> v2: changed the max values of the usleep_rage instances as they cannot
> be equal to the min values as suggested by checkpatch
> 
>  drivers/staging/rts5208/ms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> index 14449f8afad5..a9724ca5eccf 100644
> --- a/drivers/staging/rts5208/ms.c
> +++ b/drivers/staging/rts5208/ms.c
> @@ -3235,7 +3235,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
>  			return STATUS_FAIL;
>  		}
>  
> -		udelay(30);
> +		usleep_range(30, 31);
>  
>  		rtsx_init_cmd(chip);
>  
> @@ -4157,7 +4157,7 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  #ifdef MG_SET_ICV_SLOW
>  	for (i = 0; i < 2; i++) {
> -		udelay(50);
> +		usleep_range(50, 51);
>  
>  		rtsx_init_cmd(chip);
>  
> -- 
> 2.34.1
> 
> 
