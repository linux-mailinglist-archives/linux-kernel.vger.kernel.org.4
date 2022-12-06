Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82192643E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiLFIXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiLFIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:23:32 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C174E0CA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:23:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m18so2798587eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prCQtfkXiXUFthb6LYkJWfY3HXStmoXr0+/HjWbCyz0=;
        b=JrVx3iPysg800oCJWLVYcDNz7hkKSNtuDJftJPjm6/k3iZm+sz4Yf/1Zwp5cUqGGn4
         wJA6bNv/vNcBBVcjE2dyq+UptgTgCv4CBiNFOuJUv6q6yGjUt3F+doWeG/JmHgVJV1Sd
         VVivSjDMRmrO2YKHj9Ziz0/fr1rWuNdBeJHoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prCQtfkXiXUFthb6LYkJWfY3HXStmoXr0+/HjWbCyz0=;
        b=RlfeJQmoCn6Ww8WCTXhazytfdcbKIPtHOdmdkj/aqh/aBkgMVT0a6v32RXEolXxZbZ
         dkA5S2oVxjgCIt3awlNVpHlXSwufKYIMow2esUxBkdYZyuxB4orfDEGFN0uthCLPhdXy
         c+VLJjr2xxRWGVoKHgVDgfPPQmpxWakNkGbBipBKKEos1ETlfysV48CtWc601hGd9JK8
         VGwZBDNmslm1CTzRfkTVvTDO2Kzx7It2FMEHI8zdNkoGXc8iy0H4NjXh7wLk5u7d52Wg
         yrqS23+zViSmtH7mMIwpsKZrpIZd7ai83siiVlYAfGJG/rfH8snqihvJtzpBh7mYz2sF
         l/Rw==
X-Gm-Message-State: ANoB5pknaKLW5sMRkjmEWIJIDsRdufjaCY9m7ln0RbBih/Lijr174XoP
        VnryjA7+ov0iWO6Kwshlx9HfmA==
X-Google-Smtp-Source: AA0mqf6BOeWRJxcXzWUebEcxeC9M3QjXKFOivjb6mpU2zat+AYcCtVTmXpG5xsKZWUfMYR+JWJNE9A==
X-Received: by 2002:a17:906:8d7:b0:7c0:efba:b39c with SMTP id o23-20020a17090608d700b007c0efbab39cmr7708644eje.209.1670315009696;
        Tue, 06 Dec 2022 00:23:29 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id cb26-20020a0564020b7a00b0046ba536ce52sm685803edb.95.2022.12.06.00.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:23:29 -0800 (PST)
Message-ID: <9b773679-7995-7260-a54f-74f12e09d3d6@rasmusvillemoes.dk>
Date:   Tue, 6 Dec 2022 09:23:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] net: fec: properly guard irq coalesce setup
Content-Language: en-US, da
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Greg Ungerer <gregungerer@westnet.com.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205204604.869853-1-linux@rasmusvillemoes.dk>
 <2661485.mvXUDI8C0e@steina-w>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <2661485.mvXUDI8C0e@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 07.16, Alexander Stein wrote:
> Am Montag, 5. Dezember 2022, 21:46:04 CET schrieb Rasmus Villemoes:
>> Prior to the Fixes: commit, the initialization code went through the
>> same fec_enet_set_coalesce() function as used by ethtool, and that
>> function correctly checks whether the current variant has support for
>> irq coalescing.
>>
>> Now that the initialization code instead calls fec_enet_itr_coal_set()
>> directly, that call needs to be guarded by a check for the
>> FEC_QUIRK_HAS_COALESCE bit.
>>
>> Fixes: df727d4547de (net: fec: don't reset irq coalesce settings to defaults
>> on "ip link up") Reported-by: Greg Ungerer <gregungerer@westnet.com.au>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  drivers/net/ethernet/freescale/fec_main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c index
>> 2ca2b61b451f..23e1a94b9ce4 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -1220,7 +1220,8 @@ fec_restart(struct net_device *ndev)
>>  		writel(0, fep->hwp + FEC_IMASK);
>>
>>  	/* Init the interrupt coalescing */
>> -	fec_enet_itr_coal_set(ndev);
>> +	if (fep->quirks & FEC_QUIRK_HAS_COALESCE)
>> +		fec_enet_itr_coal_set(ndev);
>>  }
>>
>>  static int fec_enet_ipc_handle_init(struct fec_enet_private *fep)
> 
> I'm wondering if this check should be added to fec_enet_itr_coal_set() 
> instead. Right now any additional caller has to do it's own check for 
> FEC_QUIRK_HAS_COALESCE, so why not do check in fec_enet_itr_coal_set?

Yeah, I did consider that (see
https://lore.kernel.org/netdev/72eb4e63-10a8-702b-1113-7588fcade9fc@rasmusvillemoes.dk/).
But in the end I decided against it, for various small reasons.
Primarily my thinking was that while this caller is obviously ok with
fec_enet_itr_coal_set() just silently being a no-op, it's not clear that
some future caller wouldn't have to check the bit themselves and return
-EOPNOTSUPP or some other error just like the ethtool method does. Of
course we could also make fec_enet_itr_coal_set() not return void, but
then it's a whole different refactoring and definitely not for post-rc8.

But also, the above was what I had sent out as a "something like this?"
and tested on my own hardware before heading home, and due to the
imminent release, I wanted to send out the patch ASAP.

Rasmus

