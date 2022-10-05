Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FBF5F55F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJEN5o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Oct 2022 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJEN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:57:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6896B7C1C1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:57:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-118-5a9usHOPMJiio1QRFnRiZg-1; Wed, 05 Oct 2022 14:57:36 +0100
X-MC-Unique: 5a9usHOPMJiio1QRFnRiZg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 5 Oct
 2022 14:57:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 5 Oct 2022 14:57:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>,
        "xu.panda668@gmail.com" <xu.panda668@gmail.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
        "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "Xu Panda" <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: RE: [PATCH linux-next] arm64/idreg: use strscpy() is more robust and
 safer
Thread-Topic: [PATCH linux-next] arm64/idreg: use strscpy() is more robust and
 safer
Thread-Index: AQHY1+dBQlRmI/zldUe2KkA+YOQema3/0VNg
Date:   Wed, 5 Oct 2022 13:57:34 +0000
Message-ID: <8533a82ace484fe4ab73fccea7dc009b@AcuMS.aculab.com>
References: <20220929072905.282639-1-xu.panda668@gmail.com>
 <20221004114818.GA23663@willie-the-truck>
In-Reply-To: <20221004114818.GA23663@willie-the-truck>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon
> Sent: 04 October 2022 12:48
> 
> On Thu, Sep 29, 2022 at 07:29:06AM +0000, xu.panda668@gmail.com wrote:
> > From: Xu Panda <xu.panda@zte.com.cn>
> >
> > The implementation of strscpy() is more robust and safer.
> > That's now the recommended way to copy NUL terminated strings.

In this case the input string isn't NUL terminated....

> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > Signed-off-by: Xu Panda <xu.panda668@gmail.com>
> > ---
> >  arch/arm64/kernel/idreg-override.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> > index 95133765ed29..61bbec7ef62e 100644
> > --- a/arch/arm64/kernel/idreg-override.c
> > +++ b/arch/arm64/kernel/idreg-override.c
> > @@ -246,7 +246,7 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
> >                         return;
> >
> >                 len = min(len, ARRAY_SIZE(buf) - 1);
> > -               strncpy(buf, cmdline, len);
> > +               strscpy(buf, cmdline, len);
> >                 buf[len] = 0;
> 
> Aren't we terminating the buffer explicitly here anyway?

I doubt the code was tested.
It is always wrong regardless of the initial value of 'len'.

I think using strscpy() will delete the last character
and always add two '\0'.

On the face of it, that could probably be a memcpy().

But with the checks you don't need any of the length
checks that memcpy() might be gaining.

OTOH, if the code used parameqn() a few lines lower the
entire copy could be removed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

