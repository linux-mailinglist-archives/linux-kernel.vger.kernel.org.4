Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C16047A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiJSNnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiJSNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:42:18 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB5317D6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666171712; bh=p/AkUWQYNtmzcleDP4tnrKL/46ylIOjaifjptR55RKc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=fUQilEL6nfY0wIfMzM3z26IVauAmr7Mj4amG4xZz/OPmrt2Koe0e5DrcphIAK9tpx
         9JIp7/fJb274RVDHkz9JLpc3sioqhT0e08OJ44DzRWLXqLPMBMyDEefdjbabtR1z3g
         SOtIcVuxRsQnjWyL2y3MavFbQFlmJ1G7pG3rgyk8=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Wed, 19 Oct 2022 11:28:32 +0200 (CEST)
X-EA-Auth: BMqE3Pe/9FyIFIDYDtpEaU4AEAIIprZob7kZRTi3v5ckz3l3t0MvGzmwVZr6bw1WR8j2on1zF/edTwAMzQYr89ajSenuytzV
Date:   Wed, 19 Oct 2022 14:57:11 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Joe Perches <joe@perches.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH 4/4] staging: r8188eu: use htons macro instead of
 __constant_htons
Message-ID: <Y0/C788JWsOcv4lH@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666011479.git.drv@mailo.com>
 <595559852924cc1b58778659d2dbca8e263ee9d8.1666011479.git.drv@mailo.com>
 <49002a284dd29b8f784b52cb1527e687183ca175.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49002a284dd29b8f784b52cb1527e687183ca175.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:08:06PM -0700, Joe Perches wrote:
> On Mon, 2022-10-17 at 18:54 +0530, Deepak R Varma wrote:
> > Macro "htons" is more efficiant and clearer. It should be used for
> > constants instead of the __contast_htons macro. Resolves following
>
> typo: __constant_htons
>
> > checkpatch script complaint:
> > 	WARNING: __constant_htons should be htons
> []
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> []
> > @@ -612,14 +612,14 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
> >  	if (!priv->ethBrExtInfo.dhcp_bcst_disable) {
> >  		__be16 protocol = *((__be16 *)(skb->data + 2 * ETH_ALEN));
> >
> > -		if (protocol == __constant_htons(ETH_P_IP)) { /*  IP */
> > +		if (protocol == htons(ETH_P_IP)) { /*  IP */
> >  			struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
> >
> >  			if (iph->protocol == IPPROTO_UDP) { /*  UDP */
> >  				struct udphdr *udph = (struct udphdr *)((size_t)iph + (iph->ihl << 2));
> >
> > -				if ((udph->source == __constant_htons(CLIENT_PORT)) &&
> > -				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
> > +				if ((udph->source == htons(CLIENT_PORT)) &&
> > +				    (udph->dest == htons(SERVER_PORT))) { /*  DHCP request */
>
> OK, this bit seems fine
>
> >  					struct dhcpMessage *dhcph =
> >  						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
>
> IMO: this existing code however is ugly.
>      Casting a pointer to a size_t isn't great.
>
> Perhaps:
>
> 				struct dhcpMessage *dhcp;
>
> 				dhcp = (void *)udhp + sizeof(struct udphdr);
>
> in a separate patch.
>
> > 					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
>
> And dhcph->cookie already is a __be32 so the cast is pointless.
>
> drivers/staging/r8188eu/core/rtw_br_ext.c-598-  __be32 cookie;

Thank you Joe. I will include this code clean up as separates patches are resend
the patch set.

>
>


