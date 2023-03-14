Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8927D6B8E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCNJU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCNJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:20:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21430B14;
        Tue, 14 Mar 2023 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678785641; x=1710321641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mLvnK+DivJJpoN+i4G8HJOIyRCTMZ9TQIo7CHZGkQas=;
  b=e6FjFuSq2A6NqZkwvXKuLpY4+T5HshHlJeJ34UCZUXHkQAWJ9hfdLq0u
   ilWfaBDWsCuk5OxcU1ZWu6ftboXkbeqDMTaS3o4w8YILGRQw4vO6uycoa
   qZHwfMo9JpxYOszEf7gfp5R2PzIp7Zd81V2yNfj3s3bm0uLwbifr3UWt5
   uEbJWy6LSzuOaJ6Jjl+NuQa+/GdnzWuaHno10jFF4LmKRhA0Nrx0j3mHS
   U5TPpwsUaYYLnpVCU+myYdGyKYzAPw4gGAdmHrbfkOYvOf2n230Afh6o8
   sBqtMX3qL0zSZbjmmTvt7y05isZhNk6rMoRoUreuTkZkdN9FQg9pLJEBF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338916971"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="338916971"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 02:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822291855"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="822291855"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Mar 2023 02:20:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Mar 2023 11:20:35 +0200
Date:   Tue, 14 Mar 2023 11:20:35 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH 1/4] usb: typec: tcpm: fix cc role at port reset
Message-ID: <ZBA8Y/dbozOk2df7@kuha.fi.intel.com>
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-2-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313025843.17162-2-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:58:40AM +0800, Frank Wang wrote:
> In the current implementation, the tcpm set CC1/CC2 role to open when
> it do port reset would cause the VBUS removed by the Type-C partner.
> 
> The Figure 4-20 in the TCPCI 2.0 specification show that the CC1/CC2
> role should set to 01b (Rp) or 10b (Rd) at Power On or Reset stage
> in DRP initialization and connection detection.
> 
> So set CC1/CC2 to Rd to fix it.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a0d943d785800..66de02a56f512 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4851,7 +4851,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case PORT_RESET:
>  		tcpm_reset_port(port);
> -		tcpm_set_cc(port, TYPEC_CC_OPEN);
> +		tcpm_set_cc(port, TYPEC_CC_RD);
>  		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>  			       PD_T_ERROR_RECOVERY);
>  		break;

Will this work if the port is for example source only?

thanks,

-- 
heikki
