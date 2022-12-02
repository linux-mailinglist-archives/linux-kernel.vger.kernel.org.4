Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6520B64105B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLBWJD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 17:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiLBWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:09:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DEE7854
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:08:58 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-251-qOdtnuOcMPyNnrWdwCRZpQ-1; Fri, 02 Dec 2022 22:08:55 +0000
X-MC-Unique: qOdtnuOcMPyNnrWdwCRZpQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 2 Dec
 2022 22:08:54 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 2 Dec 2022 22:08:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     'Anders Roxell' <anders.roxell@linaro.org>,
        =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Thread-Topic: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Thread-Index: AQHZBekth9IOKPP1MEG2CcwZTmA4Xa5aWPsAgACbPoCAADOrgA==
Date:   Fri, 2 Dec 2022 22:08:54 +0000
Message-ID: <188246d459d14c93a9b71352fdc4698e@AcuMS.aculab.com>
References: <20221028210527.never.934-kees@kernel.org>
 <20221202005814.GD69385@mutt>
 <4f7ffdd948a84013a0e84876b3e3944b@AcuMS.aculab.com>
 <202212021057.B1B1BDE380@keescook>
In-Reply-To: <202212021057.B1B1BDE380@keescook>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook
> Sent: 02 December 2022 18:58
> 
> On Fri, Dec 02, 2022 at 10:01:50AM +0000, David Laight wrote:
> > From: Anders Roxell
> > > Sent: 02 December 2022 00:58
> > >
> > > On 2022-10-28 14:05, Kees Cook wrote:
> > > > GCC 12 appears to perform constant propagation incompletely(?) and can
> > > > no longer notice that "len" is always 0 when "data" is NULL. Expand the
> > > > check to avoid warnings about memcpy() having a NULL argument:
> > > >
> > > >    ...
> > > >                     from drivers/crypto/caam/key_gen.c:8:
> > > >    drivers/crypto/caam/desc_constr.h: In function 'append_data.constprop':
> > > >    include/linux/fortify-string.h:48:33: warning: argument 2 null where non-null expected [-
> > > Wnonnull]
> > > >       48 | #define __underlying_memcpy     __builtin_memcpy
> > > >          |                                 ^
> > > >    include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
> > > >      438 |         __underlying_##op(p, q, __fortify_size);                        \
> > > >          |         ^~~~~~~~~~~~~
> > ...
> >
> > Is this really a bug in the fortify-string wrappers?
> > IIRC the call is memcpy(NULL, ptr, 0) (or maybe memcpy(ptr, NULL, 0).
> > In either case call can be removed at compile time.
> >
> > I'd bet that the constant propagation of 'len' fails because
> > of all the intermediate variables that get used in order to
> > avoid multiple evaluation.
> >
> > The some 'tricks' that are used in min() (see minmax.h) to
> > generate a constant output for constant input could be
> > use to detect a compile-time zero length.
> >
> > Something like:
> > #define memcpy(dst, src, len) \
> > 	(__is_constzero(len) ? (dst) : memcpy_check(dst, src, len))
> >
> > With:
> > #define __is_constzero(x) sizeof(*(1 ? (void *)(x) : (int *)0) != 1)
> > Which could go into const.h and used in the definition of __is_constexpr().
> 
> While it could be possible to strip the nonnull attribute, I think it's
> not an unreasonable check to have. This is literally the only case in
> the entire kernel that is tripped, for example.

It is probably the only place that calls memcpy() with compile-time
NULL and zero length.
IIRC the memcpy() call comes from a #define expansion where some
expansions don't need anything copied.
A simple 'builtin_constant' check and then one for zero in the
#define itself would probably suffice - and avoid the call
being compiled in at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

