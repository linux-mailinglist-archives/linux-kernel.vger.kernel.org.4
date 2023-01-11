Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19C5665D38
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjAKOBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjAKOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:01:02 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4B2656
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:00:56 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id F13B85FD0B;
        Wed, 11 Jan 2023 17:00:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1673445654;
        bh=HxgiRE5rRaXmpjC0HmfMMATSVDjKNRWhxPVRMIQT9eQ=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=gsYo9GJdUDmSirzFbgZstDSdw0EHDpRM6/mn/9oxGjvFdXVQAhI0H09Oq/JeBw5lv
         Tzs1eNS+hGdoDOP/5WA2MrUNMZEN7M5fANQRqOQX+dW9OFUkXucQSYG6NTKiQcRd9g
         VoWAGYMB5y3hfUp2RaumifR8UMg0eZZJLHWdqjIbMcE3E/VRXBuhfgZndg/xRkSHj8
         Da/oyQGQkkFD5DyD1DUAhqUrvYV2GxvQABI9m1R5Bt85EDL1GwdJxXENUBcBL+k7T9
         81bMmO05FY51o9CdZgrrU91r87WUjen11D+ZmUs1iJf+aKrRUukZgcGPF4Wj1DgECX
         dl9zl94C84kRA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 11 Jan 2023 17:00:51 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Thread-Topic: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Thread-Index: AQHY/duSaivivX4eVEi4n5R4teXteK5JpjKAgABo/ACAAAH8AIAAmLKAgAEMI4CAAE4AAIAMqVaAgAAJPYCAQKWgAA==
Date:   Wed, 11 Jan 2023 14:00:51 +0000
Message-ID: <20230111140046.ls5vitsymjz47uba@cab-wsm-0029881.sigma.sbrf.ru>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org> <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com>
 <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
 <20221201101417.f6qm4v3m7ibh3l72@CAB-WSD-L081021>
 <Y4iGOTRvAS+WRrtq@google.com>
In-Reply-To: <Y4iGOTRvAS+WRrtq@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <685091418666C048A33A8D8B7F6D81E9@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/01/11 02:11:00 #20757923
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey!=20

On Thu, Dec 01, 2022 at 07:47:21PM +0900, Sergey Senozhatsky wrote:
> On (22/12/01 13:14), Dmitry Rokosov wrote:
> > Hello Sergey,
> >=20
> > Hope you are doing well. Really sorry for the ping.
> >=20
> > Did you get a chance to see the patch series, my questions, and
> > thoughts?
>=20
> Hey,
>=20
> Not really, sorry. It's a holidays season + pre-merge window week.
> I probably will start looking attentively next week or so.
>=20
> In the meantime time I'll try to reach out to lawyers to get more
> clarifications on that patent thingy.

Is there any news about the patent, lawyers and my patchset?

--=20
Thank you,
Alexey=
