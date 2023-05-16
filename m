Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001C3704A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjEPKLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjEPKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:11:49 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2FD10DC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:11:46 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0D0F95FD03;
        Tue, 16 May 2023 13:11:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684231905;
        bh=1RxlCrk6EbJqNqa0OM5M3VptbYHjnItP/oMfvlu7bZI=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=V9tNJ3abcwAmG9d5Rm/WDNKi8sXW6a+/JS5FRTOQhyySkpFoH7eFYLjLzWdS/Gdxk
         L0dy2Lv2n0E45b07dTPJ7JpEsMM/VBrIo0xZEPhnqtUay8LibGbhrjYX/7qw7EvHiH
         oyuUlPVB/NCLXOvFlNeLOWlhpCa7VdzT8tfNDWbeXnYYjREJLvcS7ToFMvxTAZFCKn
         T4+JsN56rXoa6ozYoqjjdcPeQwEYSssTNOOm1+7uwJEcRUR4eHu04aaDpaALQIbDv/
         MOvcVXFefVrZFv+3Y9gk6gujBw6i54kAO8LenH8pYlQHHGqIbfl6sUjWOaUbY6cX8p
         X7B1f2hhFxP/A==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 16 May 2023 13:11:44 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
Thread-Topic: [PATCH v1 1/2] mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
Thread-Index: AQHZh9vrJATALyC8P0GomQA8blaPZ69cdoOAgAAFE4A=
Date:   Tue, 16 May 2023 10:11:44 +0000
Message-ID: <20230516101137.gqu5746k6qzigsw4@cab-wsm-0029881>
References: <20230516095029.49036-1-avromanov@sberdevices.ru>
 <20230516095327.GA15689@google.com>
In-Reply-To: <20230516095327.GA15689@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.25]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E07895E9119B50448C049C809AA8A778@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/16 05:57:00 #21317490
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, May 16, 2023 at 06:53:27PM +0900, Sergey Senozhatsky wrote:
> On (23/05/16 12:50), Alexey Romanov wrote:
> >  mm/zsmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 702bc3fd687a..f23c2da55368 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -1888,7 +1888,7 @@ static struct zspage *isolate_zspage(struct size_=
class *class, bool source)
> >  		fg[1] =3D ZS_ALMOST_EMPTY;
> >  	}
> > =20
> > -	for (i =3D 0; i < 2; i++) {
> > +	for (i =3D 0; i < ARRAY_SIZE(fg); i++) {
> >  		zspage =3D list_first_entry_or_null(&class->fullness_list[fg[i]],
> >  							struct zspage, list);
> >  		if (zspage) {
>=20
> This patch needs to be dropped. We don't have that function anymore.

Do I need to sumbit v2 without this patch, or will Andrew just take
only the 2/2 patch into the branch?

--=20
Thank you,
Alexey=
