Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F972DDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbjFMJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjFMJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:28:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2CE52;
        Tue, 13 Jun 2023 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686648487; x=1718184487;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+94BmlOXXK9BhgybLoQlXD+SsDGq3jQslMKS/rV+7YI=;
  b=j8vOGpsuuH5cNj5ryiTBbaavIVd3RgLgPGbu2veeIROEg5ObgtXfAxwI
   AW+x+9zvEJRRIB5Qob6FXyUUzmwTDTOS6wPCQT+Z/4r+846KGawl8KSSS
   wAtb1qWXQjZDVrECrwP9/6ypA4tvkBaFXF4cHJ5dIFXiugGs3b6LvUBYG
   0LTpfd7FuJGYcjvZeAXRx5Hnegiskf6sdYz/P2ZaJJ4t1ME49DVwSWQwG
   XmwBwd6AM51FlhLjKd9MMhkv4/V3LKu7b3RiZLnS5ssKcY6wFNTzIEuxR
   6dkAeChLhPemDAEUVPbbab5shLCHiOvQw+pPR4VRn8AUcJmh6FqYpTIlp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444654230"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="444654230"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="856017131"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="856017131"
Received: from abujor-mobl.ger.corp.intel.com ([10.249.44.113])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:28:03 -0700
Date:   Tue, 13 Jun 2023 12:28:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@intel.com, pali@kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking
 on error path
In-Reply-To: <20230612090250.1417940-1-michal.wilczynski@intel.com>
Message-ID: <27dfd35-1d9d-b52f-ee7-1a5b9b25794@linux.intel.com>
References: <20230612090250.1417940-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1811702421-1686643242=:2099"
Content-ID: <902feaef-9eb8-167d-8b1b-9a28d1c936b8@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1811702421-1686643242=:2099
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e391539-a58-2e42-2fc3-bb836f9ca96@linux.intel.com>

On Mon, 12 Jun 2023, Michal Wilczynski wrote:

> Currently rbtn_add() in case of failure is leaking resources. Fix this
> by adding a proper rollback. While at it, remove unnecessary assignment
> of NULL to device->driver_data and unnecessary whitespace, plus add a
> break for the default case in a switch.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/dell/dell-rbtn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> index aa0e6c907494..e9b3f9c3ab7d 100644
> --- a/drivers/platform/x86/dell/dell-rbtn.c
> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> @@ -420,10 +420,12 @@ static int rbtn_add(struct acpi_device *device)
>  		break;
>  	default:
>  		ret = -EINVAL;
> +		break;
>  	}
> +	if (ret)
> +		rbtn_acquire(device, false);
>  
>  	return ret;
> -
>  }
>  
>  static void rbtn_remove(struct acpi_device *device)
> @@ -442,7 +444,6 @@ static void rbtn_remove(struct acpi_device *device)
>  	}
>  
>  	rbtn_acquire(device, false);
> -	device->driver_data = NULL;
>  }
>  
>  static void rbtn_notify(struct acpi_device *device, u32 event)

I'm a bit worried the stable people might not like "these while at it 
parts". Those changes too are all good but unrelated to the actual fix so 
they should appear in their own patches.

-- 
 i.
--8323329-1811702421-1686643242=:2099--
