Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584D6685EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBAFCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:02:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ECA3B3DD;
        Tue, 31 Jan 2023 21:02:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D7B260DCC;
        Wed,  1 Feb 2023 05:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C61C433D2;
        Wed,  1 Feb 2023 05:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675227740;
        bh=iaknZJR8YagHqnSa2Z/Ot6UlzkXpuXetE2JWHZW1tm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMK++tKeLj0J5+Bt0fYYd2PhcffpS5G0meHhqMvBBdOJ+eozAMilTWNqUSfgJehfg
         tRZWZl/M3HWKzQm9YoAwOR2Ow3+IZ3StZvIBYCtZf9jji2y2tgc15cWJezr16Dwrg2
         QXnR4wwYTO31s3Y9paIECB49ClmhXIkQf9BHD3ls=
Date:   Wed, 1 Feb 2023 06:02:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Message-ID: <Y9nyWVNtfBEny66w@kroah.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131234302.3997223-5-jithu.joseph@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:43:01PM -0800, Jithu Joseph wrote:
> Array BIST test (for a particlular core) is triggered by writing
> to MSR_ARRAY_BIST from one sibling of the core.
> 
> This will initiate a test for all supported arrays on that
> CPU. Array BIST test may be aborted before completing all the
> arrays in the event of an interrupt or other reasons.
> In this case, kernel will restart the test from that point
> onwards. Array test will also be aborted when the test fails,
> in which case the test is stopped immediately without further
> retry.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     | 12 ++++
>  drivers/platform/x86/intel/ifs/runtest.c | 92 ++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 07423bc4e368..b1a997e39216 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -127,6 +127,7 @@
>  #include <linux/device.h>
>  #include <linux/miscdevice.h>
>  
> +#define MSR_ARRAY_BIST				0x00000105
>  #define MSR_COPY_SCAN_HASHES			0x000002c2
>  #define MSR_SCAN_HASHES_STATUS			0x000002c3
>  #define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
> @@ -194,6 +195,17 @@ union ifs_status {
>  	};
>  };
>  
> +/* MSR_ARRAY_BIST bit fields */
> +union ifs_array {
> +	u64	data;
> +	struct {
> +		u32	array_bitmask		:32;
> +		u32	array_bank		:16;
> +		u32	rsvd			:15;
> +		u32	ctrl_result		:1;

This isn't going to work well over time, just mask the bits you want off
properly, don't rely on the compiler to lay them out like this.

Note, we have bitmask and bitfield operations, please use them.

thanks,

greg k-h
