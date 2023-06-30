Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752C3743D90
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjF3Odu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjF3Odp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:33:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD0C10D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:33:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313f18f5295so2289155f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688135621; x=1690727621;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsEa83LElgV+AQL5e6o9aSSV0H6S/EdnOsnoqxBROhA=;
        b=H+Os4B7hYlGqCKP3ZBTL1CfbmQZAnDdA1Ma95DpqUEcPbitEtWpwDZroRvTY/Yd+Qj
         55yAJTSAzluveA0lcf4cot1uAHJTD5IxVpP3U33+/25vUo2yQRW28xqYUacd7JpKTaQh
         0VxMG0rwaI0ypKW1awW+rOqc8asLoLz7ciVrdelUHf6oWeLftc1sAUrqENr429lDxrzf
         FfsT0Dj5SON37+8P+ZGLYBM6o+r9QWBX7Y3/1j5+d5tP1FCetdVBNlx+x/+BbPCyx84n
         ZquXktVmxqaGYy6LVAUF+PgYVyVwYTx+dhsV6xlnBXXBCPycrfu4P2TfQWio0GPm0uTR
         DKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688135621; x=1690727621;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jsEa83LElgV+AQL5e6o9aSSV0H6S/EdnOsnoqxBROhA=;
        b=PmFb8/B1DjtlQLBd/YIlIqPLVHycC/ODB1sEQajyjyr+8mVx+z0IdqCSQr7zYpPVJQ
         qtcGd7sRKswc4ZZvE4w7fZYEcIAjtydeVpWcgvdga0hPxxhQ7b2j7tm6hZtAJpWMvbp2
         fyAKX/nC4vB3VX5kcynNeOk5l3t4lEcovjnr/wB7rLSxVZJ65M9ttD2Oi42LO9fll00b
         z8RQH4SGsmFuXgk7nnumb04V5AlRqsvh7FMEt9pQBSR5Ye2XNXAOOqqpBx9vYpNyJLu+
         gu1205oDBXMsUaivcw8f2SffaL8bq8HFUw/Dj026o55HtOwrkmUciBfCLTJhdR7MGSs2
         kSOg==
X-Gm-Message-State: ABy/qLYn5LJVkl2v1sJS6pJcBlmv4RMbIY9U8TAm3ZavJRpqUSOgm5++
        7T1sgzzzvO1r3ghVWU2fqwE4iA==
X-Google-Smtp-Source: APBJJlEARPMz2iDUCKng8lbKud0V7d0IOK5so+Rb4Rp4FIFyLs2G3PYHzo7Q0PG2iYHKhBDbiuYT0A==
X-Received: by 2002:a05:6000:1cb:b0:314:13a6:af20 with SMTP id t11-20020a05600001cb00b0031413a6af20mr2161017wrx.31.1688135621090;
        Fri, 30 Jun 2023 07:33:41 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d6986000000b0031130b9b173sm18354949wru.34.2023.06.30.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:33:40 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <5F597343-EC91-4698-ACBE-9111B52FC3FC@wdc.com>
 <b29f01c287c7469f47fb4b689a3cba68@opensource.wdc.com>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     aravind.ramesh@opensource.wdc.com
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        hch@infradead.org,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 0/4] ublk: add zoned storage support
Date:   Fri, 30 Jun 2023 16:26:28 +0200
In-reply-to: <b29f01c287c7469f47fb4b689a3cba68@opensource.wdc.com>
Message-ID: <87edltdnp8.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


aravind.ramesh@opensource.wdc.com writes:

>> =EF=BB=BFOn 29/06/23, 12:37 AM, "Andreas Hindborg" <nmi@metaspace.dk
>> <mailto:nmi@metaspace.dk>> wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com
>> <mailto:a.hindborg@samsung.com>>
>> Hi All,
>> This patch set adds zoned storage support to `ublk`. The first two patch=
es
>> does
>> some house cleaning in preparation for the last two patches. The third p=
atch
>> adds support for report_zones and the following operations:
>>=20
>
> Just to clarify, we do need you ublk user space patches
> to create a ublk device node (with these patches in kernel), right ?

I provide an example implementation. I put a link in the cover letter,
but I think the sentence referring to the link got lost, thanks for
pointing out.

https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952dd88=
bf5e668b

This implementation is based on Ming's ubdsrv code. You do not need to
use this one, you can write your own. I am also working on an
implementation in Rust, but that is still very early. I think Ming is
also writing a Rust library for user space ublk devices.

But currently my patched ubdsrv is the only user space implementation
supporting zoned ublk devices (with the loop and null targets).

>
>> - REQ_OP_ZONE_OPEN
>> - REQ_OP_ZONE_CLOSE
>> - REQ_OP_ZONE_FINISH
>> - REQ_OP_ZONE_RES
>
> REQ_OP_ZONE_RESET

Thanks!

>
>> The last patch adds support for REQ_OP_ZONE_APPEND.
>> v3 [2] -> v4 changes:
>> - Split up v3 patches
>> - Add zone append support
>> - Change order of variables in `ublk_report_zones`
>> Read/write and zone operations are tested with zenfs [3].
>> The zone append path is tested with fio -> zonefs -> ublk -> null_blk.
>> The implementation of zone append requires ublk user copy feature, and
>> therefore
>> the series is based on branch for-next (6afa337a3789) of [4].
>> [1]
>> https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952d=
d88bf5e668b
>> <https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952=
dd88bf5e668b>
>> [2]
>> https://lore.kernel.org/linux-block/20230316145539.300523-1-nmi@metaspac=
e.dk
>> <mailto:20230316145539.300523-1-nmi@metaspace.dk>/
>> [3] https://github.com/westerndigitalcorporation/zenfs
>> <https://github.com/westerndigitalcorporation/zenfs>
>> [4] https://git.kernel.dk/linux.git <https://git.kernel.dk/linux.git>
>> Andreas Hindborg (4):
>> ublk: change ublk IO command defines to enum
>> ublk: move types to shared header file
>> ublk: enable zoned storage support
>> ublk: add zone append
>> MAINTAINERS | 2 +
>> drivers/block/Kconfig | 4 +
>> drivers/block/Makefile | 4 +-
>> drivers/block/ublk_drv-zoned.c | 155 +++++++++++++++++++++++++++++++++
>> drivers/block/ublk_drv.c | 150 +++++++++++++++++++------------
>> drivers/block/ublk_drv.h | 71 +++++++++++++++
>> include/uapi/linux/ublk_cmd.h | 38 ++++++--
>> 7 files changed, 363 insertions(+), 61 deletions(-)
>> create mode 100644 drivers/block/ublk_drv-zoned.c
>> create mode 100644 drivers/block/ublk_drv.h
>> base-commit: 3261ea42710e9665c9151006049411bd23b5411f
>
> Regards,
> Aravind

