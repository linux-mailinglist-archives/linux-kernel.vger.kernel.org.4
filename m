Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475DD6E0B30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDMKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDMKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:13:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8EA274;
        Thu, 13 Apr 2023 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681380796; x=1712916796;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y2p7uHhPve+flW59Wsu7r+5LlMQiFU9e3rtiNru5Mh4=;
  b=SHcelyjm5xPpk30TZFDFs1lUiO5ycpjgIprYr8XqoFnR3y2zpzwLuYRa
   n23xDo2AozPbrRRJMBQFvLyJbZ8NZUhBmBnJDq0ZQw+Bm0Xopx6fhKwh4
   Pk6S0hUFH5wZL5u/YJwkdR1FgmWNCVLMxwX9yCFR1WrHBDuX4DRAcyt5X
   M8w4cS8+x5HxJs4IeS210Z0tOsC8gquoruMTRVjDgX+jKH5mEBcb1nLg9
   jabjrrIogZsBOdnhKWU+BR9F1VRxIO8BWLFzVn0knMbNTbDc18uFS3EPg
   pr3U6R+iKNMII8d30wQyPTJEKG809E0e0TKy8PZQGFjBSUo+XDrIFqPo/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="371996260"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="371996260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 03:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753949910"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="753949910"
Received: from pkudryav-mobl1.ger.corp.intel.com ([10.252.45.220])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 03:13:11 -0700
Date:   Thu, 13 Apr 2023 13:13:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/pmt: Ignore uninitialized entries
In-Reply-To: <20230413012922.1521377-1-david.e.box@linux.intel.com>
Message-ID: <84f5952a-b64d-c3c8-d80-b9d59fe1ed40@linux.intel.com>
References: <20230413012922.1521377-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-53251890-1681380792=:1987"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-53251890-1681380792=:1987
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 12 Apr 2023, David E. Box wrote:

> On Intel Xeon, unused PMT regions will have uninitialized discovery headers
> containing all 0xF. Instead of returning an error, just skip the region.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmt/telemetry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
> index 71cdef42084a..39cbc87cc28a 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -78,7 +78,7 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
>  	 * reserved for future use. They have zero size. Do not fail
>  	 * probe for these. Just ignore them.
>  	 */
> -	if (header->size == 0)
> +	if (header->size == 0 || header->access_type == 0xF)
>  		return 1;
>  
>  	return 0;

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-53251890-1681380792=:1987--
