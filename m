Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8695BBA24
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIQTjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIQTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 15:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F60286CC
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663443544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pn+iLPOX92b5x8QXcBf6zM8CJkq15W50QIZ7ofVQySI=;
        b=YwuwKZeXS7RGsSsmlXMUFMilhc2r2MObrSOKZ4JwMOTmSH2M36/Px93OFXOkXbKqw8hW45
        mDCPCSJh7a0rOMEvX93BrH4OYv5uEXpbUDCafxFwsN4XED/i61RAlHOgSkZXxZ4AKt6Ygs
        AkA1tx2sz99QcP5/ClA98SHNm+IcbF0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-OI6r2PnhPrCWySsXvwKWdQ-1; Sat, 17 Sep 2022 15:39:02 -0400
X-MC-Unique: OI6r2PnhPrCWySsXvwKWdQ-1
Received: by mail-ed1-f69.google.com with SMTP id y9-20020a056402270900b00451dfbbc9b2so12785788edd.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 12:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pn+iLPOX92b5x8QXcBf6zM8CJkq15W50QIZ7ofVQySI=;
        b=Ko++l3r3v1BPhDX95UJ+KIm6ILCHKKgVmjCEc+09FLmER+ur/XeY8zOdUZbh1+OhZ9
         tXJm/HOcZxoQ7ATqjCwghsxj6s4iUtepwY4ic16CLBajZvcVtHFBe83/E2UtcyUIxGMM
         5PpimfIg0V86tnM9RUn8IYJKdcHFWYyJ/SVaQmtIRSmEgQvhywNgBRukaIiQzOp1lAWX
         h1c0DAbRJiUjtHTdap8whAS0TDMRTKLjQEePBJKs1MunkDLaGNqf2sBeS5M3bJIJ9luN
         UW6S+SZevlAhfiOntlc0pdrvxplMwMamEVb6Db2wL3yH+vkUY1ggTnWfzyVWeFef5wCC
         lCjw==
X-Gm-Message-State: ACrzQf3FnU2vqcAHgd/rr9Yo5R7kjSBzakgJgjU/jSFBJ90hMN1Sf5ZJ
        jDkOg6YNYc1+Vo1VJreBuRSXAXW8fxBV226YZ5D9ajVWjJXTCaiLOSkH5Q/DOZPAHoENx4NjxBf
        uKIVFfQKT4rdc4h9l12LU8qtd
X-Received: by 2002:a17:907:a049:b0:77c:1f27:1b28 with SMTP id gz9-20020a170907a04900b0077c1f271b28mr8125404ejc.20.1663443541367;
        Sat, 17 Sep 2022 12:39:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6nm3DKzCudD7urgfuCW5ZPmx6NzwELOaO85/nt28Ojofl73dxdJEuexl8Sr73Fon0uyzMz+A==
X-Received: by 2002:a17:907:a049:b0:77c:1f27:1b28 with SMTP id gz9-20020a170907a04900b0077c1f271b28mr8125396ejc.20.1663443541199;
        Sat, 17 Sep 2022 12:39:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906094100b0076f1d939128sm10008877ejd.54.2022.09.17.12.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 12:39:00 -0700 (PDT)
Message-ID: <516a1ca5-a26c-c8d7-918e-d433852db2ae@redhat.com>
Date:   Sat, 17 Sep 2022 21:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/2] staging: rtl8723bs: Insert blank line after
 declarations
Content-Language: en-US
To:     Kang Minchul <tegongkang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220917181620.3237192-1-tegongkang@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220917181620.3237192-1-tegongkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/17/22 20:16, Kang Minchul wrote:
> This patch fixes checkpatch warning as follows:
> 
>   WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index ad6fb6c3d1f0..dade4d07662b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -245,6 +245,7 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
>  {
>  	u32 cnt = 0;
>  	union recv_frame *pending_frame;
> +
>  	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
>  		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
>  		cnt++;
> @@ -397,6 +398,7 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
>  
>  	if (prxattrib->encrypt > 0) {
>  		u8 *iv = precv_frame->u.hdr.rx_data+prxattrib->hdrlen;
> +
>  		prxattrib->key_index = (((iv[3])>>6)&0x3);
>  
>  		if (prxattrib->key_index > WEP_KEYS) {
> @@ -882,6 +884,7 @@ static signed int sta2ap_data_frame(struct adapter *adapter, union recv_frame *p
>  		}
>  	} else {
>  		u8 *myhwaddr = myid(&adapter->eeprompriv);
> +
>  		if (memcmp(pattrib->ra, myhwaddr, ETH_ALEN)) {
>  			ret = RTW_RX_HANDLED;
>  			goto exit;
> @@ -1125,6 +1128,7 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
>  	psta = rtw_get_stainfo(pstapriv, psta_addr);
>  	if (!psta) {
>  		u8 type = GetFrameType(pfhdr->rx_data);
> +
>  		if (type != WIFI_DATA_TYPE) {
>  			psta = rtw_get_bcmc_stainfo(padapter);
>  			pdefrag_q = &psta->sta_recvpriv.defrag_q;
> @@ -1207,6 +1211,7 @@ static signed int validate_recv_mgnt_frame(struct adapter *padapter, union recv_
>  	{
>  		/* for rx pkt statistics */
>  		struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(precv_frame->u.hdr.rx_data));
> +
>  		if (psta) {
>  			psta->sta_stats.rx_mgnt_pkts++;
>  			if (GetFrameSubType(precv_frame->u.hdr.rx_data) == WIFI_BEACON)
> @@ -1480,6 +1485,7 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
>  		retval = validate_recv_data_frame(adapter, precv_frame);
>  		if (retval == _FAIL) {
>  			struct recv_priv *precvpriv = &adapter->recvpriv;
> +
>  			precvpriv->rx_drop++;
>  		} else if (retval == _SUCCESS) {
>  #ifdef DBG_RX_DUMP_EAP

