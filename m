Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981AB656B10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiL0Mjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiL0Mi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:38:59 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75951137;
        Tue, 27 Dec 2022 04:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672144724;
        bh=Feg6gp26ReY8Yuqxz0JpcMo1IPS+gS/uMRlrbjt4aow=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=e2DNNn7JIjAIjj4fVUAKmwvLjE2OSNcP9EinHNaR4Rj3ZpGGwXBgEq046dYFobUga
         cn7dOQR3wsSekbpJLzF8ewvNBEHUayMmytx799xn01EUkx08GehTXodNPEVdR7242z
         Ob6imB8L+TLry9gMnevAQhmxO5sG6mL5wSRdYtvQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D4C741286053;
        Tue, 27 Dec 2022 07:38:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6QcQOiF4QHbp; Tue, 27 Dec 2022 07:38:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672144724;
        bh=Feg6gp26ReY8Yuqxz0JpcMo1IPS+gS/uMRlrbjt4aow=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=e2DNNn7JIjAIjj4fVUAKmwvLjE2OSNcP9EinHNaR4Rj3ZpGGwXBgEq046dYFobUga
         cn7dOQR3wsSekbpJLzF8ewvNBEHUayMmytx799xn01EUkx08GehTXodNPEVdR7242z
         Ob6imB8L+TLry9gMnevAQhmxO5sG6mL5wSRdYtvQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 00ACE128603E;
        Tue, 27 Dec 2022 07:38:43 -0500 (EST)
Message-ID: <eaad272203baa65ad65ac2206e5197595c88508e.camel@HansenPartnership.com>
Subject: Re: [PATCH linux-next] parisc: use strscpy() to instead of strncpy()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Helge Deller <deller@gmx.de>, yang.yang29@zte.com.cn
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Date:   Tue, 27 Dec 2022 07:38:41 -0500
In-Reply-To: <0fb8a86a-ca92-8d5f-99da-6815b2d5ec3e@gmx.de>
References: <202212231040562072342@zte.com.cn>
         <0fb8a86a-ca92-8d5f-99da-6815b2d5ec3e@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-23 at 08:55 +0100, Helge Deller wrote:
> On 12/23/22 03:40, yang.yang29@zte.com.cn wrote:
> > From: Xu Panda <xu.panda@zte.com.cn>
> > 
> > The implementation of strscpy() is more robust and safer.
> > That's now the recommended way to copy NUL-terminated strings.
> 
> Thanks for your patch, but....
> 
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > Signed-off-by: Yang Yang <yang.yang29@zte.com>
> > ---
> >   drivers/parisc/pdc_stable.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/parisc/pdc_stable.c
> > b/drivers/parisc/pdc_stable.c
> > index d6af5726ddf3..403bca0021c5 100644
> > --- a/drivers/parisc/pdc_stable.c
> > +++ b/drivers/parisc/pdc_stable.c
> > @@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry
> > *entry, const char *buf, size_t coun
> > 
> >         /* We'll use a local copy of buf */
> >         count = min_t(size_t, count, sizeof(in)-1);
> > -       strncpy(in, buf, count);
> > -       in[count] = '\0';
> > +       strscpy(in, buf, count + 1);
> 
> could you resend it somewhat simplified, e.g.
> strscpy(in, buf, sizeof(in));

I don't think you can: count is the size of buf, if that's < sizeof(in)
you've introduced a write beyond end of buffer.  In fact sysfs tends to
pass pages as buffers, so there's no actual problem, but if that ever
changed ...

James

