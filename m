Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360C95EFBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiI2R02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiI2R00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83D14A7A4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664472385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EyJmMTqutL3Lku2JZ2dyQ6stk9i/1LzNE6W3+Pfwt4=;
        b=PQPU1DPbhcfJ21CswzNTZZve1luIV6NNU/poXqaoiwnKS6h0iOORt6gkE5rDFgGBoTOG1T
        /N0FXk6RZNdYAJNMahVABHeUTrnrI6OkcTvESu+DwcB+B2GVuiRUtLv9F8fViRp4qfg/iA
        qrxJTkCaNa3Pgx4xirUaBUNaRJzqCzo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-4jBB8wI5NEW-Ufi9BHDJ6A-1; Thu, 29 Sep 2022 13:26:23 -0400
X-MC-Unique: 4jBB8wI5NEW-Ufi9BHDJ6A-1
Received: by mail-oi1-f198.google.com with SMTP id u203-20020acaabd4000000b0034f684ca118so875527oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6EyJmMTqutL3Lku2JZ2dyQ6stk9i/1LzNE6W3+Pfwt4=;
        b=O5Lpn4ztASCgB8rSG/ZuXWCFjgvCzc7bV0+gkjgsFRGUo1UDaBfN1e60gMvEFqNDMI
         X4F/URE8pCU+qu0ASQ+EcMhUvI9PBQG232A1OSpmX/cpO0wG9JgNf2sMG5470S//ACUj
         2gCguViCQ02FCjBniwkQZ79YwcT/mInd+GpEeN5qyeiozdU0UF/2huS1JFI9DKMBs1PN
         RVyeriMNt53J/Q2MG0PxJ43VQcNLO7Dj8MNIaIHHjjZEFsC96zxHdL/1fOeOYaQQnhPE
         9ri9ULdiqKhewUT1KHUSgXKteMR6ws7phjXAYXcqXAlA1zvUYEV2glMrQYnnkc6Z+Pf0
         cSPA==
X-Gm-Message-State: ACrzQf2/KVocPieWXaB3XFWLX1uvcNwNkA7Y2rDp3h7+GLJoeRi4bXqA
        lf8KrT1XigefCRDKK7rZFktM9+i/Wnfw4daAVEuYBdv3NDcRtoArQgrqvwhtWrbOx6jyqoVo46h
        /BJIazVtdYR73y9VvvrTyUqDy
X-Received: by 2002:a05:6870:46a6:b0:12d:130c:2fd5 with SMTP id a38-20020a05687046a600b0012d130c2fd5mr8931882oap.92.1664472383088;
        Thu, 29 Sep 2022 10:26:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4le1yaUd/iytxRMieJ2Zmv7xiQLbc05aejyCDQqd4KJ09PnAlJheP6tmqKbeQ+3RpOZ+pqqg==
X-Received: by 2002:a05:6870:46a6:b0:12d:130c:2fd5 with SMTP id a38-20020a05687046a600b0012d130c2fd5mr8931870oap.92.1664472382893;
        Thu, 29 Sep 2022 10:26:22 -0700 (PDT)
Received: from [192.168.1.35] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e190-20020a4a55c7000000b0044b491ccf97sm28212oob.25.2022.09.29.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:26:22 -0700 (PDT)
Message-ID: <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koba Ko <koba.ko@canonical.com>
Date:   Thu, 29 Sep 2022 10:26:20 -0700
In-Reply-To: <YzXRbBvv+2MGE6Eq@matsya>
References: <20220830093207.951704-1-koba.ko@canonical.com>
         <20220929165710.biw4yry4xuxv7jbh@cantor> <YzXRbBvv+2MGE6Eq@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 22:40 +0530, Vinod Koul wrote:
> On 29-09-22, 09:57, Jerry Snitselaar wrote:
> > On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
>=20
> >=20
> > Hi Vinod,
> >=20
> > Any thoughts on this patch? We recently came across this issue as
> > well.
>=20
> I have only patch 3, where is the rest of the series... ?
>=20

I never found anything else when I looked at this earlier.
The one=C2=A0thing I can think of is perhaps Koba was seeing multiple
issues at time when he found this, like:

https://lore.kernel.org/linux-crypto/20220901144712.1192698-1-koba.ko@canon=
ical.com/

That was also being seen by an engineer here that was looking
at client_count code.

Koba, was this meant to be part of a series, or by itself?


Regards,
Jerry

