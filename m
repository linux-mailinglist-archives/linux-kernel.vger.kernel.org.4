Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E337065EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjEQLAx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjEQLAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:00:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7117A6A77
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:00:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-21-rAgZD7axM7GFuHj9YrRhAw-1; Wed, 17 May 2023 11:59:16 +0100
X-MC-Unique: rAgZD7axM7GFuHj9YrRhAw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 May
 2023 11:59:14 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 17 May 2023 11:59:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'15330273260@189.cn'" <15330273260@189.cn>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
Subject: RE: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Thread-Topic: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Thread-Index: AQHZiBwkXHI4wBkIl0yfSK4Xtptrs69eSnTg
Date:   Wed, 17 May 2023 10:59:14 +0000
Message-ID: <f6bd362145124f34a1af800dd330f8e9@AcuMS.aculab.com>
References: <20230516173026.2990705-1-15330273260@189.cn>
In-Reply-To: <20230516173026.2990705-1-15330273260@189.cn>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 15330273260@189.cn
> Sent: 16 May 2023 18:30
> 
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Both mode->crtc_htotal and mode->crtc_vtotal are u16 type,
> mode->crtc_htotal * mode->crtc_vtotal will results a unsigned type.

Nope, u16 gets promoted to 'signed int' and the result of the
multiply is also signed.

> Using a u32 is enough to store the result, but considering that the
> result will be casted to u64 soon after. We use a u64 type directly.
> So there no need to cast it to signed type and cast back then.
....
> -		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
> +		u64 frame_size = mode->crtc_htotal * mode->crtc_vtotal;
...
> -		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
> +		framedur_ns = div_u64(frame_size * 1000000, dotclock);

The (u64) cast is there to extend the value to 64bits, not
because the original type is signed.
The compiler will detect that the old code is a 32x32 multiply
where a 64bit result is needed, that may not be true for the
changed code (it would need to track back as far as the u16s).

It is not uncommon to force a 64bit result from a multiply
by making the constant 64bit. As in:
	div_u64(frame_size * 1000000ULL, dotclock);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

