Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B27747A84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGDXsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:48:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FFB2;
        Tue,  4 Jul 2023 16:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=djBxEq25qs+5OR8ZssEqtx77qeVop1kWx7fA/jsBTg8=; b=PSQDDrtOhDwEa8ppQeOf4ZBSCt
        AjUXlnqXC5ldJEDkXJKR9Q6k5u4DlxhC39fxcoZjtzTO/0Od2rgIiKh9qwfIL445Bc+/M9czbOorg
        6KTxYwo5rMo/cANp7tQTkiSK0ApkxazDQ04ebEzXemvP5cRlbiKQ1Y/crI1dnh+jfWoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qGpko-000apo-Bv; Wed, 05 Jul 2023 01:48:18 +0200
Date:   Wed, 5 Jul 2023 01:48:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     wei.fang@nxp.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: fec: recycle pages for transmitted XDP
 frames
Message-ID: <2e3d30c1-f885-42f5-91c5-878da079d8a9@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-3-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704082916.2135501-3-wei.fang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	/* Save skb pointer */
> -	txq->tx_skbuff[index] = skb;
> +	txq->tx_buf[index].skb = skb;

What about txq->tx_buf[index].type ?

> @@ -862,7 +860,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
>  	}
>  
>  	/* Save skb pointer */
> -	txq->tx_skbuff[index] = skb;
> +	txq->tx_buf[index].skb = skb;

here as well.

> +				/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> +				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;

Seems error prone. It would be safer to explicitly set it next to
assigning .skb/.xdp.

	  Andrew
