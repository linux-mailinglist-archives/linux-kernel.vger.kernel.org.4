Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD160EFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ0GMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiJ0GMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:12:23 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8E15F317
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VRlppOXqTERUsMfJJp57WhabYcrLNxxlFHPbP6x0mek=;
  b=bR49g5cgS+CzcNm9iTkkSHFS/h4c+5RfaXX8zGEXYZQLysFoeZqXw+gV
   XDpoznlf9Kww6gmBVFnBIkQ2s9uYODTV6X0qOrpaVEmnogSFLU/2lc/o/
   soyI9+nHSjwmcfkvB5BgyyyEe4k77Tc2QyPeNeYFKbfvlfzX3ZtAvy8PG
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,215,1661810400"; 
   d="scan'208";a="35679348"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 08:12:14 +0200
Date:   Thu, 27 Oct 2022 08:12:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Emily Peri <eperi1024@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Replace ternary statement with min
 function
In-Reply-To: <Y1neXqVYZ8mq8jH+@marshmallow>
Message-ID: <alpine.DEB.2.22.394.2210270811540.2792@hadrien>
References: <Y1neXqVYZ8mq8jH+@marshmallow>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Oct 2022, Emily Peri wrote:

> Ternary statements that pick the min of two values can be replaced by
> the built-in min() function. This improves readability, since its quicker
> to understand min(x, y) than x < y ? x : y. Issue found by coccicheck.

It looks like a nice change, but I get a compiler error afer the patch,

julia

>
> Signed-off-by: Emily Peri <eperi1024@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 6aeb169c6ebf..0cf7d9f82b83 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -1551,7 +1551,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
>
>  		wps_ie = rtw_get_wps_ie(buf, ielen, NULL, &wps_ielen);
>  		if (wps_ie && wps_ielen > 0) {
> -			padapter->securitypriv.wps_ie_len = wps_ielen < MAX_WPS_IE_LEN ? wps_ielen : MAX_WPS_IE_LEN;
> +			padapter->securitypriv.wps_ie_len = min(wps_ielen, MAX_WPS_IE_LEN);
>  			memcpy(padapter->securitypriv.wps_ie, wps_ie, padapter->securitypriv.wps_ie_len);
>  			set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
>  		} else {
> --
> 2.34.1
>
>
>
