Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C17393CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFVAee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFVAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0B71710
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 209B261702
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF99C433C8;
        Thu, 22 Jun 2023 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687394070;
        bh=AiZo/yWVr6AaszhH++L2NsU42IKDuEpbVQ7bGj7ECf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vAorBcPFmLvJTgk2RkidGZUjcsqiRPLMtFSoPBlyahiZDWeOO6gojp2QwLG8RMcW1
         fSdHDXu+oCcr3PMFKXtBDl2gDTDJVZXjJeKxUEqYuXipK1Pc7xlEXWyX5B3OOKSljV
         t2iZEiz1qV0qI8FWEeIFvnC6GJpHu4jeqa44M7URp72oXtP92tP3x1K1XU2vERtEpb
         INrVQx7HTI7Kme9INelS5Bvbb79anLy3CoZUNiqhBIOMbLzH4FBUTPw3dxHZbSfTnl
         J6aC7wab7Z3jhSUBFGG6FtyEntEX+kBgn/eYcHHYUmd6IZZ6vCje5bheOVJOFZtoyM
         yb9Td4DcPhCtQ==
Date:   Wed, 21 Jun 2023 17:34:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     carlos.fernandez@technica-engineering.de
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Message-ID: <20230621173429.18348fc8@kernel.org>
In-Reply-To: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
References: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few nit picks and questions, when you repost please make sure to CC 
Sabrina Dubroca <sd@queasysnail.net>

On Tue, 20 Jun 2023 11:13:01 +0200
carlos.fernandez@technica-engineering.de wrote:
> -static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
> +static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
> +			      struct macsec_rxh_data *rxd)
>  {
> +	struct macsec_dev *macsec_device;
>  	sci_t sci;
>  
> -	if (sci_present)
> +	if (sci_present) {
>  		memcpy(&sci, hdr->secure_channel_id,
> -		       sizeof(hdr->secure_channel_id));
> -	else
> +			sizeof(hdr->secure_channel_id));

the alignment of sizeof() was correct, don't change it

> +	} else if (0 == (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) {

Just
	} else if (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC)) {

> +		list_for_each_entry_rcu(macsec_device, &rxd->secys, secys) {
> +			struct macsec_rx_sc *rx_sc;
> +			struct macsec_secy *secy = &macsec_device->secy;

You should reorder these two declaration, networking likes local
variable declaration lines longest to shortest.

> +			for_each_rxsc(secy, rx_sc) {
> +				rx_sc = rx_sc ? macsec_rxsc_get(rx_sc) : NULL;
> +				if (rx_sc && rx_sc->active)
> +					return rx_sc->sci;
> +			}

I haven't looked in detail but are you possibly returning rx_sc->sci
here just to ...

> +		}
> +		/* If not found, use MAC in hdr as default*/
>  		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> -
> +	} else {
> +		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> +	}
>  	return sci;
>  }
>  
> @@ -1150,11 +1165,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
>  
>  	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
>  	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
> -	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
>  
>  	rcu_read_lock();
>  	rxd = macsec_data_rcu(skb->dev);
>  
> +	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
> +
>  	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
>  		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);

... look up the rx_sc based on the sci? 
-- 
pw-bot: cr
