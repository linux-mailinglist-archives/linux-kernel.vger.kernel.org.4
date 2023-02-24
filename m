Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34F6A2169
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBXSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBXSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:25:36 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65381241E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:25:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x10so633935edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyWIOFkNkOsI6c/mdG3GOw56CloR0iy8yfGzZUhpBaU=;
        b=whAYIbB5kRU1oPfGv0iqc/PMQl7BZVJHKetXDOskXfsD1gEH4TW5FVtGYVCaKLHpJg
         izbw48FjNsGBiGuSpLVUB54oubBB035/1GLCLluNHXWfvY7zZ5OWWfpIRDvMOG0fkv+z
         RPxp4dQ1xEk7YJeuB/qnCwaNmxHy45EtOHbTPc4kJWz1uwF7/KVwNXThgV0LMrfQqYMh
         tRERC/xXbw40ebP35onFaBFvK3PLdpkORB0BlzupcDyFNjH2EHUaJshfv1yh+lMG1k4e
         0FhmjN7jmrc7/t6ikrYHJHSQbNN/vrVW8DQfE8wHI39eyIKSLFjh4cmxFkRu41Ycack8
         bqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GyWIOFkNkOsI6c/mdG3GOw56CloR0iy8yfGzZUhpBaU=;
        b=CLU5MkUQLxv4EuO8CItOSuVIBg+m4qVF0UtEc8ovP8+UsxIcbz33B+Arlj19bu1fpq
         XTa/J4937B7acQQFb1KN9OwMyFJGZ3oKUvxlIUjQpY2K/GTe1iuu36/ED0hC0jWFuLtF
         B1MJkRs7EQ9ahSDhUgOrLv64imoVDzfiX69uP1XOiUBNpcK5jUE3kxP7KoZ2e4dnHQuu
         9V97tsYkiTXFZH21abIKtDQuSnYU+OnqtPRjU1roQw0aV29DeL7KezOUoY9EJOW2Zk41
         7ulI8q9z+R7WpOHTG6lCgW6Jg0FALEwbz1pO9T3dbE2JEXwKqWn1doJoMs8irA7fpcEl
         hlAg==
X-Gm-Message-State: AO0yUKWnTEyxAdKnjTmU/x4zoPOZa/VaWDt/ay50nLDYhtEQSBCIUKto
        7yoNgZKkg0q4DzeaEL8pIQFH1Nh4y6xEMVz3
X-Google-Smtp-Source: AK7set+wxFCdSh4J/yfn3u8xFPRm3OStLNQUL6UKLo/N9MSs7Ff/LQmnO+VZAUE0FWaN8hiir16xOQ==
X-Received: by 2002:a05:6402:5158:b0:4aa:a4f1:3edb with SMTP id n24-20020a056402515800b004aaa4f13edbmr15135062edd.29.1677263113882;
        Fri, 24 Feb 2023 10:25:13 -0800 (PST)
Received: from localhost ([79.142.230.49])
        by smtp.gmail.com with ESMTPSA id by17-20020a0564021b1100b004aef48a8af7sm5970136edb.50.2023.02.24.10.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:25:13 -0800 (PST)
References: <20230224125950.214779-1-nmi@metaspace.dk>
 <Y/jdkCR4ug7iZZ+L@x1-carbon> <Y/jfpKyntm9KSBVo@x1-carbon>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: ublk: enable zoned storage support
Date:   Fri, 24 Feb 2023 19:20:03 +0100
In-reply-to: <Y/jfpKyntm9KSBVo@x1-carbon>
Message-ID: <87edqec453.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> On Fri, Feb 24, 2023 at 04:53:52PM +0100, Niklas Cassel wrote:
>> Hello Andreas,
>>=20
>> On Fri, Feb 24, 2023 at 01:59:50PM +0100, Andreas Hindborg wrote:
>> > Add zoned storage support to ublk: report_zones and operations:
>> >  - REQ_OP_ZONE_OPEN
>> >  - REQ_OP_ZONE_CLOSE
>> >  - REQ_OP_ZONE_FINISH
>> >  - REQ_OP_ZONE_RESET
>> >=20
>> > This allows implementation of zoned storage devices in user space. An
>> > example user space implementation based on ubdsrv is available [1].
>> >=20
>> > [1] https://github.com/metaspace/ubdsrv/commit/14a2b708f74f70cfecb076d=
92e680dc718cc1f6d
>> >=20
>> > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> > ---
>>=20
>> Did you try to build this patch with CONFIG_BLK_DEV_ZONED disabled?
>>=20
>> I got the following build errors when building it on top of vanilla v6.2
>> when CONFIG_BLK_DEV_ZONED is disabled:
>>=20
>> drivers/block/ublk_drv.c: In function =E2=80=98ublk_dev_param_basic_appl=
y=E2=80=99:
>> drivers/block/ublk_drv.c:221:28: error: =E2=80=98struct gendisk=E2=80=99=
 has no member named =E2=80=98nr_zones=E2=80=99
>>   221 |                 ub->ub_disk->nr_zones =3D p->dev_sectors / p->ch=
unk_sectors;
>>       |                            ^~
>> drivers/block/ublk_drv.c: In function =E2=80=98ublk_dev_param_zoned_appl=
y=E2=80=99:
>> drivers/block/ublk_drv.c:244:17: error: implicit declaration of function=
 =E2=80=98disk_set_max_active_zones=E2=80=99; did you mean =E2=80=98bdev_ma=
x_active_zones=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>>   244 |                 disk_set_max_active_zones(ub->ub_disk, p->max_ac=
tive_zones);
>>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>>       |                 bdev_max_active_zones
>> drivers/block/ublk_drv.c:245:17: error: implicit declaration of function=
 =E2=80=98disk_set_max_open_zones=E2=80=99; did you mean =E2=80=98bdev_max_=
open_zones=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>>   245 |                 disk_set_max_open_zones(ub->ub_disk, p->max_open=
_zones);
>>=20
>
> The problem here is probably that blkdev.h does not have dummy functions =
for
> disk_set_max_active_zones() and disk_set_max_open_zones()
>
> in the:
> #else /* CONFIG_BLK_DEV_ZONED */
> case.
>
> I do see dummy functions in blkdev.h for disk_nr_zones(), disk_zone_is_se=
q()
> and disk_zone_no() when CONFIG_BLK_DEV_ZONED is not set.

Thanks for the comments Niklas :)

I completely forgot to test without CONFIG_BLK_DEV_ZONED =F0=9F=A4=A6 What =
is the
preferred resolution here? Conditionally remove the lines with #ifdef
rather than use if(IS_ENABLED(...))? Dummy functions would resolve lines
244 and 245, but would not help with assignment of nr_zones at 221 as
that will not exist when CONFIG_BLK_DEV_ZONED is disabled.

BR Andreas

