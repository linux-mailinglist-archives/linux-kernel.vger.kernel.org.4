Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05AF743CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjF3N2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjF3N21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:28:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504E1996
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:28:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc0981743so17096885e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688131704; x=1690723704;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSsHR++MOz5mMLvON2+y3Ow7cVC9uhlMql65hDIpGCA=;
        b=qZ7bgD7Ubj5fsotnD1uP7fB9XKGEHhWz+S+5zIiT+bAvaYlLO8NosSnlZ7GaiXsLQR
         29OFVwPQve04Jk0zg0qCrSk5/E+ntQ5YQE2XVj6oWXsFbSq9YRC+rje8H5q9CnkrzTUt
         PGphJv+nl5dY+U+6FivwINt/ec914HBXSQN9p52Nmjr5gKMT9wh0VGZD2QkzyqnKBnl6
         dr/XgHBRw8umMcKo74hx0v/kPsokrh/m5rCMX9r9/V4exCIbkdF6tsP1s0zQ6WdyRs/x
         sSnVe+NRUML3VPfRQpHDT5061SVCcTzP1ftnOoqGuDSzvlEf8KPFiO9JhMaybDr+Tw3B
         oqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688131704; x=1690723704;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSsHR++MOz5mMLvON2+y3Ow7cVC9uhlMql65hDIpGCA=;
        b=EVAkAXSVtZtbJeFwAXi2LgueLjk8l3jfDYiCU+V6PjLOiQpVRemKJ6JdIxjOO03t1X
         DYygYO8VU199i+AETzwFDX4ns/yG2oo+3RbPVSuoYyHswF+MpbFpzoi/ecRt50KGY890
         dkJgMGb4Dn/d82yz3a03IsMcMzfF43820iAz1NTuNOsYZkue8Ad+7qybMJQVs9FmPu2B
         zzsjKx9xwz1r24mVanvmpa+Y1JjBWKREtwQ0a1ir658y7hyNpq1KYlTS7g8X1xCMxWIV
         ckCkhKjifNHivOJnbJ5goF3aC0heaYBsfxossRwKNCu9wR9Rpyw6PI1lhJQrQqiWDSDY
         tYgA==
X-Gm-Message-State: AC+VfDxzWt4B+Wg168aGpKwmdYTfZwXnOpV3AKlEbcYu2SNolmJguQFx
        JjDH5nLxdgBrPaxTckxCC2YGVg==
X-Google-Smtp-Source: ACHHUZ50akRrQs3uymW5/8iFg9PFp6xTgRf1QltmVzS5vB1EPAiNo383a3DvCn5X7T9QJ9+pu6x9Wg==
X-Received: by 2002:a05:600c:2145:b0:3fa:1af8:6ebf with SMTP id v5-20020a05600c214500b003fa1af86ebfmr1985717wml.0.1688131703637;
        Fri, 30 Jun 2023 06:28:23 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003fbb346279dsm6345498wmd.38.2023.06.30.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 06:28:23 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
 <be52be54-3178-082c-4bfc-7702308a0012@kernel.org>
 <87ilb6y6j9.fsf@metaspace.dk>
 <87a03e67-67f0-5ac7-41c7-5ccd393d0b66@kernel.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Date:   Fri, 30 Jun 2023 13:53:58 +0200
In-reply-to: <87a03e67-67f0-5ac7-41c7-5ccd393d0b66@kernel.org>
Message-ID: <87ilb5dqq1.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien Le Moal <dlemoal@kernel.org> writes:

> On 6/29/23 16:50, Andreas Hindborg (Samsung) wrote:
>>>>  UCLINUX (M68KNOMMU AND COLDFIRE)
>>>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>>>> index 5b9d4aaebb81..c58dfd035557 100644
>>>> --- a/drivers/block/Kconfig
>>>> +++ b/drivers/block/Kconfig
>>>> @@ -402,6 +402,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
>>>>  	  suggested to enable N if your application(ublk server) switches to
>>>>  	  ioctl command encoding.
>>>>=20=20
>>>> +config BLK_DEV_UBLK_ZONED
>>>> +	def_bool y
>>>
>>> This can be "bool" only.
>>=20
>> I did it like this because I wanted BLK_DEV_UBLK_ZONED to be set
>> automatically to "y" when BLK_DEV_UBLK and BLK_DEV_ZONED are enabled.
>> BLK_DEV_UBLK_ZONED has no menu entry. If we change it to "bool" it will
>> be default "n" and we would have to make it appear in menuconfig to be
>> manually enabled.
>>=20
>> Isn't it more sane if it is just unconditionally enabled when
>> BLK_DEV_ZONED and BLK_DEV_UBLK is enabled?
>
> Maybe something like this then:
>
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 5b9d4aaebb81..105e1121bf5f 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -370,9 +370,13 @@ config BLK_DEV_RBD
>
>           If unsure, say N.
>
> +config BLK_DEV_UBLK_ZONED
> +       bool
> +
>  config BLK_DEV_UBLK
>         tristate "Userspace block driver (Experimental)"
>         select IO_URING
> +       select BLK_DEV_UBLK_ZONED if BLK_DEV_ZONED
>         help
>           io_uring based userspace block driver. Together with ublk serve=
r, ublk
>           has been working well, but interface with userspace or command =
data

OK =F0=9F=91=8D

>>>> +		ub->ub_disk->nr_zones =3D p->dev_sectors / p->chunk_sectors;
>>>> +}
>>>> +
>>>> +void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>>>> +{
>>>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>>>> +
>>>> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
>>>> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>>>> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>>>
>>> You do not need to check if the max_active_zones and max_open_zones val=
ues are
>>> sensible ? E.g. what if they are larger than the number of zones ?
>>=20
>> I don't think it will be a problem. I assume you can set them to 0 to
>> indicate infinite. If user space sets them to more than the actual
>> number of available zones (that user space set up also), user space will
>> have to handle that when it gets a zone request for a zone outside the
>> logical drive LBA space. I don't think the kernel has to care. Will this
>> break anything kernel side?
>
> zonefs and btrfs look at these limits. So I would rather prefer seeing se=
nsible
> values. 0 =3D=3D no limit is fine. But seeing maz or moz > nr_zones for t=
he device
> is just too strange and I would prefer an error in that case to let the u=
ser
> know it is not doing something right. Getting moz > maz is also nonsense =
that
> needs to be checked. There is one case we could silently change: if maz =
=3D=3D
> nr_zones or moz =3D=3D nr_zones, then that essentially means "no limit", =
so we could
> use 0 to let the in-kernel users that they do not need to care about the =
limits.

OK, will check.

>
>>=20
>>>
>>>> +	}
>>>> +}
>>>> +
>>>> +int ublk_revalidate_disk_zones(struct gendisk *disk)
>>>> +{
>>>> +	return blk_revalidate_disk_zones(disk, NULL);
>>>> +}
>>>
>>> I do not think this helper is needed at all (see below comment on the c=
all site).
>>=20
>> This is required because the prototype for `blk_revalidate_disk_zones()`
>> is not defined when BLK_DEV_ZONED is not defined. Without this helper
>> for which the prototype is always defined, we will have a compile error
>> at the call site.
>
> You have this hunk in ublk_ctrl_start_dev:
>
> disk_set_zoned(disk, BLK_ZONED_HM);
> blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRIT=
E);
> ret =3D ublk_revalidate_disk_zones(disk);
> if (ret)
> 	goto out_put_disk;
>
> And that is called under "if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)". So I do =
not see
> how you can get compile errors using directly blk_revalidate_disk_zones()=
. The
> entire hunk above should be a helper function I think.

The prototype for `disk_set_zoned()` is defined independent of
CONFIG_BLK_DEV_ZONED. The prototype for `blk_revalidate_disk_zones()` is
only defined when CONFIG_BLK_DEV_ZONED is enabled. It is not the same.
We can't have a call to `blk_revalidate_disk_zones()` in a translation
unit when the prototype is not defined, even behind a `if
(IS_ENABLED())` guard. It would be fine behind an `#ifdef` though.

If we move the entire hunk to a helper for which the prototype is always
defined, we should be able to call `blk_revalidate_disk_zones()`
directly =F0=9F=91=8D I'll see if I can do that.

>>>> +
>>>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>>>> +		ublk_set_nr_zones(ub);
>>>
>>> So if the user is attempting to setup a zoned drive but the kernel does=
 not have
>>> CONFIG_BLK_DEV_ZONED=3Dy, the user setup will be silently ignored. Not =
exactly
>>> nice I think, unless I am missing something.
>>=20
>> We have this in `ublk_ctrl_add_dev()`:
>>=20
>> 	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> 		ub->dev_info.flags &=3D ~UBLK_F_ZONED;
>>=20
>> User space is supposed to check the flags after the call to know the
>> kernel capabilities.
>
> And you trust user space to be always correct ? I never do :)
> So definitely, check and error if not supported. No silently clearing the=
 device
> zoned flag.
>

I'll make it fail instead of just clearing the flag =F0=9F=91=8D

>
>>> Also, repeating that "if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))" for all zo=
ne
>>> related functions is very verbose. Stub the functions in ublk_drv.h. Th=
at will
>>> make the main C code lighter.
>>=20
>> Not sure what you mean "stub the functions". Like so:
>>=20
>> @@ -216,8 +216,7 @@ static void ublk_dev_param_basic_apply(struct ublk_d=
evice *ub)
>>=20=20
>>  	set_capacity(ub->ub_disk, p->dev_sectors);
>>=20=20
>> -	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> -		ublk_set_nr_zones(ub);
>> +	ublk_config_nr_zones(ub);
>>  }
>>=20
>> And then in the header:
>>=20
>> void ublk_config_nr_zones(struct ublk_device *ub)
>> {
>> 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> 		ublk_set_nr_zones(ub);
>> }
>>=20
>> Or something else?
>
> #ifndef CONFIG_BLK_DEV_ZONED
> static inline void ublk_set_nr_zones() {}
> #endif
>
> That avoid repeating that if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) all over =
the
> place. The stubbed functions can be called only for "if (ub->dev_info.fla=
gs &
> UBLK_F_ZONED", which is OK since this flag is never supposed to be accept=
ed and
> set for the CONFIG_BLK_DEV_ZONED=3Dn case.

Alright =F0=9F=91=8D

>
>>>> +		disk_set_zoned(disk, BLK_ZONED_HM);
>>>> +		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SE=
Q_WRITE);
>>>> +		ret =3D ublk_revalidate_disk_zones(disk);
>>>> +		if (ret)
>>>> +			goto out_put_disk;
>>>
>>> This should be all a helper ublk_set_zoned() or something.
>>=20
>> Ok =F0=9F=91=8D Unfortunately this block of code is split up in the zone=
 append
>> patch. I will see what I can do, maybe 2 functions.
>
> Beware that I just posted patches that require zone size (chunk_sectors l=
imit)
> and max append sectors limit to be set *before* calling
> blk_revalidate_disk_zones(). Otherwise, you will get an error.

Got it, thanks.

>
>>>>  	get_device(&ub->cdev_dev);
>>>>  	ub->dev_info.state =3D UBLK_S_DEV_LIVE;
>>>>  	ret =3D add_disk(disk);
>>>> @@ -1997,6 +2046,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd=
 *cmd)
>>>>  	if (ub->dev_info.flags & UBLK_F_USER_COPY)
>>>>  		ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
>>>>=20=20
>>>> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>>>> +		ub->dev_info.flags &=3D ~UBLK_F_ZONED;
>>>
>>> Arg, no. The user should be notified with an error that he/she is attem=
pting to
>>> create a zoned device that cannot be supported.
>>=20
>> As I wrote above, this is part of the ublk uapi. This is the way user
>> space does kernel capability check. User space will check the flags when
>> this call returns. @Ming did I understand this correctly or did I miss s=
omething?
>
> OK. So this is like a virtio capability flags thing ? Negotiation between=
 device
> and driver ?

I'm not familiar with that one, but I think you are right we should fail
the request here. I makes no sense to configure a regular ublk device if
user space wants to set up a zoned one. Failing is more sensible.

>
>>>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_c=
md.h
>>>> index 471b3b983045..436525afffe8 100644
>>>> --- a/include/uapi/linux/ublk_cmd.h
>>>> +++ b/include/uapi/linux/ublk_cmd.h
>>>> @@ -176,6 +176,11 @@
>>>>  /* Copy between request and user buffer by pread()/pwrite() */
>>>>  #define UBLK_F_USER_COPY	(1UL << 7)
>>>>=20=20
>>>> +/*
>>>> + * Enable zoned device support
>>>
>>> Isn't this for "Indicate that the device is zoned" ?
>>=20
>> User space sets this flag when setting up the device to enable zoned
>> storage support. Kernel may reject it. I think the wording is
>> sufficient. Could be updated to:
>>=20
>> "User space sets this flag when setting up the device to request zoned
>>  storage support. Kernel may deny the request by clearing the flag
>>  during setup."
>
> I really have a big problem with this. If the user driver does not check =
that
> the flag was cleared, the user will assume that the device is zoned, but =
it is
> not. This is not super nice... I would really prefer just failing the dev=
ie
> creation if zoned was requested but cannot be satisfied, either because t=
he
> kernel does not support zoned block devices or when the user specified so=
mething
> nonsensical.

Changed to:

/*
 * User space sets this flag when setting up the device to request zoned st=
orage support. Kernel may
 * deny the request by returning an error.
 */
#define UBLK_F_ZONED (1ULL << 8)

Best regards,
Andreas
