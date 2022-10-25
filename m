Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FA60CB90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiJYMMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiJYMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F1510B7AC;
        Tue, 25 Oct 2022 05:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68087618F8;
        Tue, 25 Oct 2022 12:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46757C433C1;
        Tue, 25 Oct 2022 12:12:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="osx4zi68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666699966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8qjzZkK8c3Es/HwytaaCio3kn0QdSSBQEAuIzcBPNc=;
        b=osx4zi68YC6Zf24Vq+JIB/bxSDK2ECgUM2SOmfWHBbcpuSXwDXaC4QH7biAzF2JzHha5iz
        hyxtd04490dnfuTNxHEukgNMfrABpX2OLzXO6uJqEM/E+L9dHGuGIus24lZkBEJkbw416V
        7JxVbj6DxUinba/HBGM2dhJA1KNLJK4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d7021f8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Oct 2022 12:12:46 +0000 (UTC)
Date:   Tue, 25 Oct 2022 14:12:42 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: cisco: do not assign -1 to unsigned char
Message-ID: <Y1fSuq4I9BBQ4o+J@zx2c4.com>
References: <20221024162843.535921-1-Jason@zx2c4.com>
 <6a1652ab408d4c5d8ba754f35680e792@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a1652ab408d4c5d8ba754f35680e792@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:11:44AM +0000, David Laight wrote:
> From: Jason A. Donenfeld
> > Sent: 24 October 2022 17:29
> > 
> > With char becoming unsigned by default, and with `char` alone being
> > ambiguous and based on architecture, we get a warning when assigning the
> > unchecked output of hex_to_bin() to that unsigned char. Mark `key` as a
> > `u8`, which matches the struct's type, and then check each call to
> > hex_to_bin() before casting.
> > 
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/net/wireless/cisco/airo.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> > index 10daef81c355..fb2c35bd73bb 100644
> > --- a/drivers/net/wireless/cisco/airo.c
> > +++ b/drivers/net/wireless/cisco/airo.c
> > @@ -5232,7 +5232,7 @@ static int get_wep_tx_idx(struct airo_info *ai)
> >  	return -1;
> >  }
> > 
> > -static int set_wep_key(struct airo_info *ai, u16 index, const char *key,
> > +static int set_wep_key(struct airo_info *ai, u16 index, const u8 *key,
> >  		       u16 keylen, int perm, int lock)
> >  {
> >  	static const unsigned char macaddr[ETH_ALEN] = { 0x01, 0, 0, 0, 0, 0 };
> > @@ -5283,7 +5283,7 @@ static void proc_wepkey_on_close(struct inode *inode, struct file *file)
> >  	struct net_device *dev = pde_data(inode);
> >  	struct airo_info *ai = dev->ml_priv;
> >  	int i, rc;
> > -	char key[16];
> > +	u8 key[16];
> >  	u16 index = 0;
> >  	int j = 0;
> > 
> > @@ -5311,12 +5311,22 @@ static void proc_wepkey_on_close(struct inode *inode, struct file *file)
> >  	}
> > 
> >  	for (i = 0; i < 16*3 && data->wbuffer[i+j]; i++) {
> > +		int val;
> > +
> > +		if (i % 3 == 2)
> > +			continue;
> > +
> > +		val = hex_to_bin(data->wbuffer[i+j]);
> > +		if (val < 0) {
> > +			airo_print_err(ai->dev->name, "WebKey passed invalid key hex");
> > +			return;
> > +		}
> >  		switch(i%3) {
> >  		case 0:
> > -			key[i/3] = hex_to_bin(data->wbuffer[i+j])<<4;
> > +			key[i/3] = (u8)val << 4;
> >  			break;
> >  		case 1:
> > -			key[i/3] |= hex_to_bin(data->wbuffer[i+j]);
> > +			key[i/3] |= (u8)val;
> >  			break;
> >  		}
> >  	}
> 
> That is about the crappiest loop I've seen.
> I was just going to point out that the (u8) casts aren't needed.
> Something like:
> 	for (i = 0, buf = data->wbuffer + j; i < 16; i++, buf += 3) {
> 		int val;
> 		if (!buf[0] || !buf[1])
> 			break;
> 		val = hex_to_bin(buf[0]) | hex_to_bin(buf[1]) << 8;
> 		if (val < 0) {
> 			airo_print_err(ai->dev->name, "WebKey passed invalid key hex");
> 			return;
> 		}
> 		key[i] = val;
> 		if (!buf[2])
> 			break;
> 	}
> 
> Although there should be a check for buf[2] being valid.
> Any I worry about exactly what happens if there aren't 16 full bytes.

buf[2] isn't checked. Presumably it's a space or something. Your <<8
also isn't right; this is a hex char. Anyway, I think I'd rather
minimize this delta and leave this patch as-is.

Jason
