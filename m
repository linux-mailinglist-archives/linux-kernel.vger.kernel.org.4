Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1359B61504D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKARO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKAROY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:14:24 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F42632
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FUb8dsII9LrVUU01XvTNyCWT+TBKRL7CN/lN3uy92k4=;
  b=ae+6XUsLnWJFbVqcNQ6xp6OM30OG8EqRqZkIOItFSJgNRt0gb04jQKru
   eLhH0a7BexlvFGlcdTe5IVXBSkyNU53WPjtKoy82uVUzV7zd9jYjM6xT8
   AS/rQbfhkXV/HcI61RGG31b/eaBNEua+9VAL+gy6MUvGPTOEut8quhm3Y
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,231,1661810400"; 
   d="scan'208";a="72525300"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 18:14:02 +0100
Date:   Tue, 1 Nov 2022 18:14:01 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unwanted variable
 implementation
In-Reply-To: <Y2FPOON3UcqqAQFy@ubunlion>
Message-ID: <alpine.DEB.2.22.394.2211011811400.2834@hadrien>
References: <Y2FPOON3UcqqAQFy@ubunlion>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2022, Deepak R Varma wrote:

> Local variables intended as the function return value are
> initialized but their value does not change during function
> execution. The initial value assigned to the variable is simply
> returned to the caller. This makes the variable declaration
> unnecessary and the initial value can be directly returned.

I think it would be better to make an argument for each case as to why the
change is correct, and no more interesting return value is needed.  For
example, looking at the code in
drivers/staging/r8188eu/hal/rtl8188eu_xmit.c, it seems that the variable
pull was used in a more interesting way previously, but some previous
patches removed the relevant code.

julia

>
> The patch is produced using the following coccicheck options:
>    COCCI=./scripts/coccinelle/misc/returnvar.cocci
>    M=driver/staging/r8188eu/
>    MODE=patch
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
>  drivers/staging/r8188eu/core/rtw_recv.c      | 3 +--
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>  4 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index 24eb8dce9bfe..9eaf345e6a00 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -1020,7 +1020,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
>  int rtw_sta_flush(struct adapter *padapter)
>  {
>  	struct list_head *phead, *plist;
> -	int ret = 0;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> @@ -1028,7 +1027,7 @@ int rtw_sta_flush(struct adapter *padapter)
>  	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>
>  	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
> -		return ret;
> +		return 0;
>
>  	spin_lock_bh(&pstapriv->asoc_list_lock);
>  	phead = &pstapriv->asoc_list;
> @@ -1051,7 +1050,7 @@ int rtw_sta_flush(struct adapter *padapter)
>
>  	associated_clients_update(padapter, true);
>
> -	return ret;
> +	return 0;
>  }
>
>  /* called > TSR LEVEL for USB or SDIO Interface*/
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 4b68a543f68b..94f85cd7038d 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -1415,7 +1415,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
>
>  	struct recv_priv *precvpriv = &padapter->recvpriv;
>  	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
> -	int	ret = _SUCCESS;
>
>  	nr_subframes = 0;
>
> @@ -1513,7 +1512,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
>  	prframe->len = 0;
>  	rtw_free_recvframe(prframe, pfree_recv_queue);/* free this recv_frame */
>
> -	return ret;
> +	return _SUCCESS;
>  }
>
>  static bool check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
> diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
> index 8e4a5acc0b18..6d1f56d1f9d7 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
> @@ -149,7 +149,6 @@ static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
>
>  static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
>  {
> -	int	pull = 0;
>  	uint	qsel;
>  	u8 data_rate, pwr_status, offset;
>  	struct adapter		*adapt = pxmitframe->padapter;
> @@ -295,7 +294,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
>  	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);
>
>  	rtl8188eu_cal_txdesc_chksum(ptxdesc);
> -	return pull;
> +	return 0;
>  }
>
>  /* for non-agg data frame or  management frame */
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 8516e253bb03..59a97c5fb80c 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -2979,8 +2979,6 @@ static int rtw_p2p_set(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
> -
>  	if (!memcmp(extra, "enable =", 7)) {
>  		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
>  	} else if (!memcmp(extra, "setDN =", 6)) {
> @@ -3027,7 +3025,7 @@ static int rtw_p2p_set(struct net_device *dev,
>  		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
>  	}
>
> -	return ret;
> +	return 0;
>  }
>
>  static int rtw_p2p_get2(struct net_device *dev,
> --
> 2.34.1
>
>
>
>
>
