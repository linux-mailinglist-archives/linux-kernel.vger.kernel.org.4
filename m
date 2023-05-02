Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE1B6F41D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjEBKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjEBKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:39:04 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F359DE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:38:06 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0383A5FD31;
        Tue,  2 May 2023 13:38:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683023884;
        bh=lHmQ9OUHChl15VP559Y0PqcWhHblA7lT610Z0d2GIMU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=SaZmeuWBJh06+e+TW45ejq/DzpYw0zO97oEI4fssQVPICWlUFfsynapZmXy85eOcp
         k0b+OeX3Y+xeDSkA2DLNx6wnyLdL1XFFk9keU46HF7g8AtcqS5K/yR0WAHm24IYRYC
         LwSAn9NPLMbQhjeGGzP3bR/iw7k+P4Qk29xTK7WJ3PsgFKe2YmGStOxvOsCy3RB+te
         75NmE3lkKz0dSiF3jB2CsRmd96Z8Knx0CiXlBUwJ36kgsommQCpHnScw4mwh3oEfVD
         R8XG2uav20ppZlzbj5vzougjyS944gh8LO+0l9AWDwAV6NzuSBOCWlXsncRsfF+o8H
         OBNUC91gq3mDA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  2 May 2023 13:38:02 +0300 (MSK)
From:   =?koi8-r?B?8s/Nwc7P1yDhzMXL08XKIPfB08nM2MXXyd4=?= 
        <AVRomanov@sberdevices.ru>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/5] Introduce objects folding mechanism
Thread-Topic: [RFC PATCH v1 0/5] Introduce objects folding mechanism
Thread-Index: AQHZcb6HWf5sffHx/k6nmlw8gBQWuq9GroMA
Date:   Tue, 2 May 2023 10:38:02 +0000
Message-ID: <20230502103752.sb3mwkdqhdzxlt65@cab-wsm-0029881>
References: <20230418062503.62121-1-avromanov@sberdevices.ru>
In-Reply-To: <20230418062503.62121-1-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.25]
Content-Type: text/plain; charset="koi8-r"
Content-ID: <9DEC1EF139199848A543125A8622170A@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/02 09:07:00 #21205017
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Apr 18, 2023 at 09:24:58AM +0300, Alexey Romanov wrote:
> Hello!
>=20
> This RFC series adds feature which allows fold identical
> zsmalloc objects into a single one.
>=20
> Based on ZRAM version:
> https://lore.kernel.org/lkml/Y3w8%2Fq%2FHoSbqamoD@google.com/t/
>=20
> Let's imagine that 3 objects with the same content got into zsmalloc:
>=20
> +----------------+   +----------------+   +----------------+
> |    handle 1    |   |    handle 2    |   |    handle 3    |
> +-------+--------+   +-------+--------+   +--------+-------+
>         |                    |                     |
>         |                    |                     |
> +-------v--------+   +-------v---------+  +--------v-------+
> |zsmalloc  object|   |zsmalloc  object |  |zsmalloc  object|
> ++--------------++   +-+-------------+-+  ++--------------++
>  +--------------+      +-------------+     +--------------+
>  | buffer: "abc"|      |buffer: "abc"|     | buffer: "abc"|
>  +--------------+      +-------------+     +--------------+
>=20
> As you can see, the data is duplicated. Fold mechanism saves
> (after scanning objects) only one zsmalloc object. Here's
> what happens after the scan and fold:
>=20
> +----------------+   +----------------+   +----------------+
> |    handle 1    |   |    handle 2    |   |    handle 3    |
> +-------+--------+   +-------+--------+   +--------+-------+
>         |                    |                     |
>         |                    |                     |
>         |           +--------v---------+           |
>         +-----------> zsmalloc  object <-----------+
>                     +--+-------------+-+
>                        +-------------+
>                        |buffer: "abc"|
>                        +-------------+
>=20
> Thus, we reduced the amount of memory occupied by 3 times.
>=20
> This mechanism doesn't affect the perf of the zsmalloc itself in
> any way (maybe just a little bit on the zs_free() function).
> In order to describe each such identical object, we (constantly)
> need sizeof(fold_rbtree_node) bytes. Also, all struct size_class now
> have new field struct rb_root fold_rbtree.
>=20
> Testing on my system (8GB RAM + 1Gb ZRAM SWAP) showed that at high
> loads, on average, when calling the fold mechanism, we can save
> up to 15-20% of the memory usage.
>=20
> This patch series adds a new sysfs node into ZRAM - trigger folding
> and provides new field in mm_stat. This field shows how many pages
> freed during folding:
>=20
>   $ cat /sys/block/zram0/mm_stat
>     431452160 332984392 339894272 0 339894272 282 0 51374 51374 0
>=20
>   $ echo 1 > /sys/block/zram0/fold
>=20
>   $ cat /sys/block/zram/mm_stat
>     431452160 270376848 287301504 0 339894272 282 0 51374 51374 6593
>=20
> Alexey Romanov (5):
>   mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
>   mm/zsmalloc: get rid of PAGE_MASK
>   mm/zsmalloc: introduce objects folding mechanism
>   zram: add fold sysfs knob
>   zram: add pages_folded to stats
>=20
>  Documentation/admin-guide/blockdev/zram.rst |   2 +
>  drivers/block/zram/zram_drv.c               |  30 +-
>  include/linux/zsmalloc.h                    |   4 +
>  mm/Kconfig                                  |   9 +
>  mm/zsmalloc.c                               | 484 +++++++++++++++++++-
>  5 files changed, 513 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.38.1
>=20

Really sorry for the noise, but could you comment on my patchset and
results? We have moved away from the terms and concepts used in the
patent we discussed in the ZRAM version, and I believe we can safely use
these changes in zsmalloc.

--=20
Thank you,
Alexey=
