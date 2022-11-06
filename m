Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB961E11F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKFI6Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Nov 2022 03:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKFI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:58:23 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6095
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:58:21 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 708D0140844;
        Sun,  6 Nov 2022 08:58:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 5567E20027;
        Sun,  6 Nov 2022 08:57:23 +0000 (UTC)
Message-ID: <6ca906bd81be7c6700068a5c9ba7354e14280619.camel@perches.com>
Subject: Re: [PATCH] staging: r8188eu: convert three functions to bool
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sun, 06 Nov 2022 01:58:17 -0700
In-Reply-To: <20221105093916.8255-1-straube.linux@gmail.com>
References: <20221105093916.8255-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5567E20027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 4uxoeo1dq3egrbjd7hcj7d3iyewk3jjk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/LEMc4sjU2B1G35nYKmk26Yld9KNJFg/I=
X-HE-Tag: 1667725043-59702
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-11-05 at 10:39 +0100, Michael Straube wrote:
> The functions
> 
> is_client_associated_to_ap()
> is_client_associated_to_ibss()
> is_IBSS_empty()
> 
> return boolean values. Convert their return type to bool and replace
> _FAIL, which is defined as 0, with false. Another step to get rid of
> _SUCCESS / _FAIL.

yay.

> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
[]
> +bool is_client_associated_to_ap(struct adapter *padapter)
>  {
>  	struct mlme_ext_priv	*pmlmeext;
>  	struct mlme_ext_info	*pmlmeinfo;
>  
>  	if (!padapter)
> -		return _FAIL;
> +		return false;
>  
>  	pmlmeext = &padapter->mlmeextpriv;
>  	pmlmeinfo = &pmlmeext->mlmext_info;
>  
>  	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE))
>  		return true;
> -	else
> -		return _FAIL;
> +
> +	return false;

instead of

	if (foo)
		return true;
	return false;

These could be:

	return (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) &&
	       ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE);

> +bool is_client_associated_to_ibss(struct adapter *padapter)
>  {
>  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  
>  	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE))
>  		return true;
> -	else
> -		return _FAIL;
> +
> +	return false;

and

	return (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) &&
	       ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE);


