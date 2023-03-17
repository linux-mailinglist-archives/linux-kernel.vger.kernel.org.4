Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9076BE80A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCQL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:27:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AADF199D5;
        Fri, 17 Mar 2023 04:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679052438; x=1710588438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXEH4raOHe9XIYNL/oWXWLkQeWwzTTJBZIKfeP18xtk=;
  b=gI1+9dHmc2vdSWCtxW/+g7P/+WW3RH8PZ3QyzS1yd4yUFz1M2MRxbTbv
   BTH6CllwlIHp7HpQ1L7LG4KmRwd0WfpO3z2LAvJfx90mdqa06A6Q5CM+G
   BA8anuYzixCDjdvwtjEwcKCILky7BkjmjzR8UHE1C3zWqYm2RAYhvkStV
   /42cW6ZJ8wu3UVnG1SYgBKVmkH4+cRao6EH5c1TcGcbINtqNPhMSSF+eQ
   nslCTBs5U3k6ULH2AzmC+myGdKfQx2v5EuIApFb+GKvs7z2+EaLvvohrE
   cgDnqaJALBD93XVwv3jvbZArL++GxxMuFxZdh1SIWxbdO7Or+xNiwrMST
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424511529"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424511529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823638782"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823638782"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2023 04:27:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 17 Mar 2023 13:27:13 +0200
Date:   Fri, 17 Mar 2023 13:27:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH v2] usb: typec: tcpm: fix multiple times discover svids
 error
Message-ID: <ZBROkdOFAP4GPPU6@kuha.fi.intel.com>
References: <20230316081149.24519-1-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316081149.24519-1-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:11:49PM +0800, Frank Wang wrote:
> PD3.0 Spec 6.4.4.3.2 say that only Responder supports 12 or more SVIDs,
> the Discover SVIDs Command Shall be executed multiple times until a
> Discover SVIDs VDO is returned ending either with a SVID value of
> 0x0000 in the last part of the last VDO or with a VDO containing two
> SVIDs with values of 0x0000.
> 
> In the current implementation, if the last VDO does not find that the
> Discover SVIDs Command would be executed multiple times even if the
> Responder SVIDs are less than 12, and we found some odd dockers just
> meet this case. So fix it.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 66de02a56f512..a3ae2c79f3540 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1515,7 +1515,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
>  		pmdata->svids[pmdata->nsvids++] = svid;
>  		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
>  	}
> -	return true;
> +
> +	/*
> +	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
> +	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
> +	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
> +	 * SVIDs Command Shall be executed multiple times until a Discover
> +	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
> +	 * the last part of the last VDO or with a VDO containing two SVIDs
> +	 * with values of 0x0000.
> +	 *
> +	 * However, some odd dockers support SVIDs less than 12 but without
> +	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
> +	 * request and return false here.
> +	 */
> +	return cnt == 7;
>  abort:
>  	tcpm_log(port, "SVID_DISCOVERY_MAX(%d) too low!", SVID_DISCOVERY_MAX);
>  	return false;

This is OK by men, but let's wait for Guenter.

thanks,

-- 
heikki
