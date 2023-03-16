Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692086BDA19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCPU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCPU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:26:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0904B822;
        Thu, 16 Mar 2023 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678998381; x=1710534381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N/UV/JGFwalfx0oPNUccNM6ZJrQ5XofHq51SxDHotNo=;
  b=l7/NVFHKiFju+nCZgHvb8cKrfW4OXOAodpuI6aIaglKd8WfeHZwtTr9V
   g1xT6z2ch8sXcoYFAbV3JvwCBMnq0LzO1ZrnOmTVNya7izZSlcy7CGLFJ
   Ar3q2NaBlZBmLdcH++PpEfiHB1TOnc00y+MbIWpRaxBAa+bDmoXYh56mb
   YCkwi0yzKl+OZiWpw9tjX432XefEApWLiYHIIlSwgOfEl5KRrUrSCv/2a
   E0DYkFsf7iAx7dX0K6Nte2499PEYbBmVjGNydkN8m+rfb6aINgT797AXh
   8ia57Fg12/puUpB6CM5iGWDDotbWJ/cMlhtst0L5BnzZ7qkIgp1bUbD3Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424376014"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424376014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 13:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="803874716"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="803874716"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.182.83]) ([10.213.182.83])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 13:26:20 -0700
Message-ID: <b7a0b5c0-61a0-9843-09a6-3c4c606221be@intel.com>
Date:   Thu, 16 Mar 2023 13:26:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] ACPI: APEI: EINJ: Add CXL error types
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230314004611.48583-1-tony.luck@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230314004611.48583-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/23 5:46 PM, Tony Luck wrote:
> ACPI 6.5 added six new error types for CXL. See chapter 18
> table 18.30.
> 
> Add strings for the new types so that Linux will list them in the
> /sys/kernel/debug/apei/einj/available_error_types file.
> 
> It seems no other changes are needed. Linux already accepts
> the CXL codes (on a BIOS that advertises them).
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/acpi/apei/einj.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index b4373e575660..39bee5a067cc 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -584,6 +584,12 @@ static const char * const einj_error_type_string[] = {
>   	"0x00000200\tPlatform Correctable\n",
>   	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>   	"0x00000800\tPlatform Uncorrectable fatal\n",
> +	"0x00001000\tCXL.cache Protocol Correctable\n",
> +	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
> +	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> +	"0x00008000\tCXL.mem Protocol Correctable\n",
> +	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
> +	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
>   };
>   
>   static int available_error_type_show(struct seq_file *m, void *v)
