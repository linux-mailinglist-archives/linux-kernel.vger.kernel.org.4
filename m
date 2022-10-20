Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964D3605657
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJTEfn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Oct 2022 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJTEfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:35:41 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D849A285
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:35:38 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id DFA19407D0;
        Thu, 20 Oct 2022 04:35:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id B0C8E1D;
        Thu, 20 Oct 2022 04:35:19 +0000 (UTC)
Message-ID: <8617109bdc3e192b98e5c3b21ba871501a87f6d9.camel@perches.com>
Subject: Re: [PATCH] staging: r8188eu: replace IEs with ies
From:   Joe Perches <joe@perches.com>
To:     Jacob Bai <jacob.bai.au@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 19 Oct 2022 21:35:32 -0700
In-Reply-To: <20221018105409.18331-1-jacob.bai.au@gmail.com>
References: <20221018105409.18331-1-jacob.bai.au@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: rfok4zuziardpanwcbjbbbnbgsr55e4y
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B0C8E1D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+5Om/jhcTLg7XsLvbFgngGLJbNoCiU3VE=
X-HE-Tag: 1666240519-612510
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-18 at 21:54 +1100, Jacob Bai wrote:
> Replace wlan_bssid_ex struct member IEs to ies.
> CamelCase issue found by checkpatch.

Please try to avoid changing code merely to appease checkpatch.

What is the value of the last s?
When is a specific index of the IEs array actually used?

Mere renaming may be removing useful markings.

(removing a lot of the rename blocks)

> diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
[]
> @@ -239,7 +239,7 @@ struct wlan_bssid_ex {
>  	unsigned char SupportedRates[NDIS_802_11_LENGTH_RATES_EX];
>  	struct wlan_phy_info	PhyInfo;
>  	u32  IELength;
> -	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and
> +	u8  ies[MAX_IE_SZ];	/* timestamp, beacon interval, and
>  				 * capability information) */
>  } __packed;
[]
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
[]
> @@ -104,11 +104,11 @@ static char *translate_scan(struct adapter *padapter,
>  
>  			if (pnetwork->network.Reserved[0] == 2) {/*  Probe Request */
>  				/*	Verifying the P2P IE */
> -				if (rtw_get_p2p_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &p2pielen))
> +				if (rtw_get_p2p_ie(pnetwork->network.ies, pnetwork->network.IELength, NULL, &p2pielen))
>  					blnGotP2PIE = true;
>  			} else {/*  Beacon or Probe Respones */
>  				/*	Verifying the P2P IE */
> -				if (rtw_get_p2p_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &p2pielen))
> +				if (rtw_get_p2p_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &p2pielen))

For instance, these consistent 12 and "- 12" uses may be better as some
alternate array.

>  					blnGotP2PIE = true;
>  			}
>  		}
> @@ -131,7 +131,7 @@ static char *translate_scan(struct adapter *padapter,
>  	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
>  
>  	/* parsing HT_CAP_IE */
> -	p = rtw_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength - 12);
> +	p = rtw_get_ie(&pnetwork->network.ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength - 12);
>  
>  	if (p && ht_ielen > 0) {
>  		struct ieee80211_ht_cap *pht_capie;

etc...

Also this may be removing similarities between a few other realtek
staging drivers

$ git grep  "\[MAX_IE_SZ\]"
drivers/staging/r8188eu/include/wlan_bssdef.h:  u8  IEs[MAX_IE_SZ];     /* timestamp, beacon interval, and
drivers/staging/rtl8712/wlan_bssdef.h:  u8 IEs[MAX_IE_SZ];
drivers/staging/rtl8723bs/include/wlan_bssdef.h:        u8  ies[MAX_IE_SZ];     /* timestamp, beacon interval, and capability information) */

