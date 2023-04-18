Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C056E6BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjDRSGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:06:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A32340EE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:05:59 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id opiEpZRwNpD2AopiEpj41M; Tue, 18 Apr 2023 20:05:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681841157;
        bh=GctzAXq88S367TGXB24PxESHXE0rCHGQao6MmRQJ5s4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iQPsGxG2ccQpIpDHBiSK9ttsZ+xkAE70wIBuy8olOQYB+BfdA6Ftk6ZMhYc6ogekz
         nsOlnqEbHYVXJA1iKdnrj74ew/Qld7mqDhsVs+7G69l61sOHcF6+q1D3xkWUG/WG2h
         Jd+NF74/as2IMeU+t6kw2m1UGlZHyAwYt3lLmSa0bcpCjWnCLX5F7XHSmjUVhBCotr
         oMxGuJZLlIi3EN2YkXmorzMGT7ptgkvsVRRS3ArFzChyPWJx7gCZrXj+/81Mwv0q+q
         Fd5E4Hucok6O0bhyDBpfgNPAJaKORMNWSNcr2Va2r/EZ+jyfsKOfOlRO+1e5KF+MGj
         KSUwXyNuB+BFQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Apr 2023 20:05:57 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d2b2baca-589d-83ef-04b0-0f64b18f9d95@wanadoo.fr>
Date:   Tue, 18 Apr 2023 20:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
Content-Language: fr, en-GB
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
 <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
 <CAMuHMdWz7YJ4ifkxU2GGdoj46fTsjS5WE66R0YzvOYr1ZKY=4w@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAMuHMdWz7YJ4ifkxU2GGdoj46fTsjS5WE66R0YzvOYr1ZKY=4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/04/2023 à 09:14, Geert Uytterhoeven a écrit :
> 
> Nice catch!
> 
> Looking more deeply at the code, the intention is to allocate a bitmap
> with nr_pages bits, so the code fater Christophe's patch is correct.
> However, the old code is indeed wrong:
> 
>      (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG
> 
> The aim is to calculate the size in bytes, rounded up to an integral
> number of longs, but it lacks a final multiplication by BITS_PER_BYTE,
> so it's off by a factor of 4.
> 
> Fixes: d7c30c682a278abe ("sh: Store Queue API rework.")
> 
> As we didn't have bitmap_zalloc() until commit c42b65e363ce97a8
> ("bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()")
> in v4.19, it would be good to fix the bug first in a separate patch,
> not using
> 
> BTW, interesting how this got missed when fixing the other out-of-range
> bug in commit 9f650cf2b811cfb6 ("sh: Fix store queue bitmap end.",
> s/marc.theaimsgroup.com/marc.info/ when following the link).

So, this means that this got unnoticed for 16 years?
Waouh!

I would never have thought that a "trivial" clean-up that I took time to 
repost could trigger such a thing!

Again.
Waouh!


Maybe, 0x04000000 is way to big?
Anyone knows where this value comes from?

Could there have been some memory corruption in real world application?

CJ

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

