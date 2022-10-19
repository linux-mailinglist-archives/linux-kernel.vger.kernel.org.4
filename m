Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6F2603994
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJSGIR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Oct 2022 02:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJSGIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:08:14 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC76583F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:08:13 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id B05CFA054E;
        Wed, 19 Oct 2022 06:08:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id E84DB2002D;
        Wed, 19 Oct 2022 06:07:54 +0000 (UTC)
Message-ID: <49002a284dd29b8f784b52cb1527e687183ca175.camel@perches.com>
Subject: Re: [PATCH 4/4] staging: r8188eu: use htons macro instead of
 __constant_htons
From:   Joe Perches <joe@perches.com>
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Date:   Tue, 18 Oct 2022 23:08:06 -0700
In-Reply-To: <595559852924cc1b58778659d2dbca8e263ee9d8.1666011479.git.drv@mailo.com>
References: <cover.1666011479.git.drv@mailo.com>
         <595559852924cc1b58778659d2dbca8e263ee9d8.1666011479.git.drv@mailo.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: i8uc1r887uq5cmy39ehk47npqnomphsr
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E84DB2002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/kSBruECZdtofFGtexfl+pATe3DPBkCf0=
X-HE-Tag: 1666159674-263680
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 18:54 +0530, Deepak R Varma wrote:
> Macro "htons" is more efficiant and clearer. It should be used for
> constants instead of the __contast_htons macro. Resolves following

typo: __constant_htons

> checkpatch script complaint:
> 	WARNING: __constant_htons should be htons
[]
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
[]
> @@ -612,14 +612,14 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>  	if (!priv->ethBrExtInfo.dhcp_bcst_disable) {
>  		__be16 protocol = *((__be16 *)(skb->data + 2 * ETH_ALEN));
> 
> -		if (protocol == __constant_htons(ETH_P_IP)) { /*  IP */
> +		if (protocol == htons(ETH_P_IP)) { /*  IP */
>  			struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
> 
>  			if (iph->protocol == IPPROTO_UDP) { /*  UDP */
>  				struct udphdr *udph = (struct udphdr *)((size_t)iph + (iph->ihl << 2));
> 
> -				if ((udph->source == __constant_htons(CLIENT_PORT)) &&
> -				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
> +				if ((udph->source == htons(CLIENT_PORT)) &&
> +				    (udph->dest == htons(SERVER_PORT))) { /*  DHCP request */

OK, this bit seems fine

>  					struct dhcpMessage *dhcph =
>  						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));

IMO: this existing code however is ugly.
     Casting a pointer to a size_t isn't great.

Perhaps:

				struct dhcpMessage *dhcp;

				dhcp = (void *)udhp + sizeof(struct udphdr);

in a separate patch.

> 					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);

And dhcph->cookie already is a __be32 so the cast is pointless.

drivers/staging/r8188eu/core/rtw_br_ext.c-598-  __be32 cookie;

