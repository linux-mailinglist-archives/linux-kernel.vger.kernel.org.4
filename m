Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6772A736ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjFTLRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFTLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:16:59 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBF10DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:16:52 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0FDDC5FD2F;
        Tue, 20 Jun 2023 14:16:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687259803;
        bh=rRdH1qSvA4EXGN7LOvS9GhiA87cu+zd2tHJIWeuHKis=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=sE2KBRRShZwiNerdcnUf9FxWsEgnXpVUg9GCUOkSmufXHNwEB06OHsXTLbcHn1o1+
         qwWPnOYZtav1PRwYkFzXlCsMQPpiCO87+Eo+BWEdne+LHhL4tHIrAdeAaNYEmaBqpn
         R4Eo6etm9/gXpBtDuBv6Jwt0QRTHu/xoskAggFl8egxeqGKp4W0ZnrYhoCR8Ny02Tn
         U9AGWYtvTCLTiM7NGHPlhhlAYdhSabCDNhvu9gOjh2FtvKcsAL+Kz5dF585lCYw6wo
         djDqL0Mv9KHCQepX0GLy50ExlK6f7/Gbx4aNzQiGTZBT7hWO4OlYOjpXRdLz43jIJ4
         FoAF3Sd0R1Tng==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 20 Jun 2023 14:16:41 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Thread-Topic: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Thread-Index: AQHZortECyHNmKOx4kiy6hdprH0m0a+TTmOAgAALNIA=
Date:   Tue, 20 Jun 2023 11:16:36 +0000
Message-ID: <20230620111635.gztldehfzvuzkdnj@cab-wsm-0029881>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
 <20230619143506.45253-2-avromanov@sberdevices.ru>
 <20230620103629.GA42985@google.com>
In-Reply-To: <20230620103629.GA42985@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D31E99819F292841AF30CA0DFC9D1415@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/20 08:27:00 #21534026
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey! Thank you for feedback.

On Tue, Jun 20, 2023 at 07:36:29PM +0900, Sergey Senozhatsky wrote:
> On (23/06/19 17:35), Alexey Romanov wrote:
> >=20
> > We use a variable of type unsigned int to store the offset
> > of the first object at the subpage In turn, the offset cannot
> > exceed the size of PAGE_SIZE, which is usually 4096. Thus,
> > 12 bits are enough to store the offset.
>=20
> [..]
>=20
> > If the page size is 4Kb
>=20
> It's certainly not a given. PAGE_SIZE is architecture specific.
> PAGE_SIZE_16KB and PAGE_SIZE_64KB would be simple examples, but there
> are, apparently, architectures that even can have PAGE_SIZE_256KB.

Sure.=20

As far I understand at the moment the maximum size of the page
(according to Kconfig info in linux sources) is 256Kb. In this case,
we need maximum 18 bits for storing offset. And 2^18 / 32 =3D 8192 bytes
(13 bits, I think u16 is OK for such purpose) for storing allocated
objects counter.=20

If sizeof(unsigned int) >=3D 32 bits the this will be enough for us.=20
Of course, in rare cases this will not be the case. But it seems that
zram and kernel already has similiar places. For example, if page size
is 256 Kb and sizeof(unsigned int) =3D 16 bits (2 byte), zram will not
wotk on such system, because we can't store offset. But such case is
very rare, most systems have unsigned int over 32 bits.=20

Therefore, I think that my idea is still applicable, we just need to
change the counter type. What do you think?

--=20
Thank you,
Alexey=
