Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1E6B8E85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCNJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCNJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:22:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3A233FC;
        Tue, 14 Mar 2023 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678785738; x=1710321738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=669AdwOG4a24zmUH38pGEUS6+rjOIvBAa8LuWIw2i1k=;
  b=P6rPTQuAMaa949xDZJlJSrIb+1qWkkXo6hPg7IQbcYcSfOWXZsFL6UO3
   NzrC7ny6BrTgL9Ec9+h2SMKy+FwwXJNkDs3Gq3nWabMBkqR5+Tc+R8uh8
   TWBEL9arpaUi5QcKbpQkN+rsqkXPP3Cc5rizA12GMOS2qH+zGZvttarW8
   BZoVcaBDWyzGi8YChyPzcO7x+n9nkE/MoBdwERx+u6MVjZ5YOBnwV3yEh
   3i+Wfy0MyUgumDkiIQHVq8XHk4CMz3/OnPuYZ9mgy9GXj5mjvKZKhQl4x
   QCHzqr0KtlZH4vtXbRZbNINhEovY3q99gphrGCJEZHDb84Fvaj9Aqt33K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338917167"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="338917167"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 02:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822292265"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="822292265"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Mar 2023 02:22:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Mar 2023 11:22:13 +0200
Date:   Tue, 14 Mar 2023 11:22:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH 2/4] usb: typec: tcpm: fix multiple times discover svids
 error
Message-ID: <ZBA8xWmNDSDhUys2@kuha.fi.intel.com>
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-3-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313025843.17162-3-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:58:41AM +0800, Frank Wang wrote:
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
> index 66de02a56f512..2962f7c261976 100644
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
> +	return cnt == 7 ? true : false;

        return cnt == 7


thanks,

-- 
heikki
