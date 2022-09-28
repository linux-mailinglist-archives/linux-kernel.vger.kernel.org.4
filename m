Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0B5ED4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiI1GYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI1GYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:24:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C01CE143;
        Tue, 27 Sep 2022 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664346245; x=1695882245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7FLHSBXoiS06JuG6EqRx15SI9cmNTfHvEBkXB15O4aY=;
  b=EXd8FQ6MSpNbnpCzvEWsUdI8jRFvOlsqYHF0kFdFhclgUJqNUGg9C9hJ
   xOlLQx5wFrvil51upj9E4wtSNI+Ti11zlRYLaAQXpS96h15WskqWnzEOU
   PXGtJBURGoh6TjyTUHvd4lrsKcWbfbBtQmx+RjPw0ms9PnJzSTKA5sEIA
   eVE3jvCiAcB51/+MybXhSC1LlM34hMsutl+nq7tlLU7pOSYM+maq6+073
   rVy02To+xrbyrptJa5vncZ3U6jO/Jwt0/NTjLqqgfiocz0a6SCuDwpyJO
   yJuINlBjF1F1c8T97L6WJg06u1KwAd4n6fF0+pIu/u/hH/UeC8mKViRRj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281236265"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="281236265"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 23:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="764163919"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="764163919"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Sep 2022 23:23:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 28 Sep 2022 09:23:46 +0300
Date:   Wed, 28 Sep 2022 09:23:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     gregkh@linuxfoundation.org, quic_linyyuan@quicinc.com,
        quic_jackp@quicinc.com, saranya.gopal@intel.com, tiwai@suse.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] usb: typec: ucsi: Don't warn on probe deferral
Message-ID: <YzPocs9hMZBuQ3Pp@kuha.fi.intel.com>
References: <20220927134512.2651067-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927134512.2651067-1-waynec@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 09:45:12PM +0800, Wayne Chang wrote:
> Deferred probe is an expected return value for fwnode_usb_role_switch_get().
> Given that the driver deals with it properly, there's no need to output a
> warning that may potentially confuse users.
> 
> Signed-off-by: Wayne Chang <waynec@nvidia.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --
> V2 -> V3: remove the Fixes and Cc
> V1 -> V2: adjust the coding style for better reading format.
>  drivers/usb/typec/ucsi/ucsi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7f2624f42724..e961ebecd7df 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1069,11 +1069,9 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  
>  	cap->fwnode = ucsi_find_fwnode(con);
>  	con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
> -	if (IS_ERR(con->usb_role_sw)) {
> -		dev_err(ucsi->dev, "con%d: failed to get usb role switch\n",
> -			con->num);
> -		return PTR_ERR(con->usb_role_sw);
> -	}
> +	if (IS_ERR(con->usb_role_sw))
> +		return dev_err_probe(ucsi->dev, PTR_ERR(con->usb_role_sw),
> +			"con%d: failed to get usb role switch\n", con->num);
>  
>  	/* Delay other interactions with the con until registration is complete */
>  	mutex_lock(&con->lock);

thanks,

-- 
heikki
