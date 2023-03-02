Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59C6A8383
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCBNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCBNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:30:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8353B232
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:30:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l1so13479555wry.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyJzHuLKs+zr/cuVKBWD3Qz/nQMZpEHffUi+K+l+1QU=;
        b=Vc2Pf73L1VCdRibbTZ7bMQcFCG6AF1mApr0/+mlHaJSBJLAw+khTFC7jWoGpOkJ63m
         reSKbpM5T8a+7snDwCdVBOgxKDkRfIVz6Yxvx6fHWe2A3t/yamsT28hniJhm2XPD0Sj9
         k9DXKxpxBzLIVg0gSYBA38zoLUAPJg9JWiJFr3AAE3QSLzbbpvVfailTSkWDObn2c/2u
         gpwwprROZEKQIHZ3z596Xe8qDaqjSmz+yuC4LJN66x1+WLdTwLbPSLIzVwWlkNoRB7xq
         6Kj6B/v8gvzUbnNAjPP0kPaRFE/3LW8uB+W24jJz66hTaA9PPt5CkHlrgvnhJchqaFFN
         sx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YyJzHuLKs+zr/cuVKBWD3Qz/nQMZpEHffUi+K+l+1QU=;
        b=CZqLKkyU8cD9VgJqTuOhx1WtM0YzjUuoHPZZ0ujyN4NslqoMq1DmSJfckyWZ6UgPM9
         sveyegPcnuhntJOTRaOtQG1U4ANF+cT2029aR5JL2l00sMK3xHe3MYOMuwl653JbEEPC
         uNWNUxSECzYAnQvbGtBOTWPBxgY7DRbQsptQj161KosKzSCQ4er3yxiOYp5ATYdMInQn
         MqUH2ZLGIMQSldxliiRkRgZ2T8jsKQg6Ic2PN7TSI1SlcwewIEQ02wUbNXT6yrlioOBV
         AGUYXpRFCoMbkHwehZH21GLs//jcBAlxJD/K3nnAY7MKOad9R+LuYzN3mWPBLE+29leB
         otCg==
X-Gm-Message-State: AO0yUKV8HBryaI0DelXe+B0dLnGFI6tTzramgh08AP+l6sYyoRAikDGU
        yi023t6bw/4L22OSQIAiil5yZP4ZsAuHljME
X-Google-Smtp-Source: AK7set99EhUVwt6NFx97KT++nJGpHjdKwN3zuTgRTWITeq9YaOOXLCpMSiEfB6wd19z0oAYnyHIo0A==
X-Received: by 2002:a5d:62c6:0:b0:2c5:4c9c:e15d with SMTP id o6-20020a5d62c6000000b002c54c9ce15dmr7904802wrv.17.1677763812805;
        Thu, 02 Mar 2023 05:30:12 -0800 (PST)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id f12-20020adffccc000000b002c705058773sm15214427wrs.74.2023.03.02.05.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:30:12 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590> <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590> <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
 <87h6v3l9up.fsf@metaspace.dk> <ZAChttVoCHsnXmvF@T590>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Thu, 02 Mar 2023 14:28:33 +0100
In-reply-to: <ZAChttVoCHsnXmvF@T590>
Message-ID: <875ybjl1r0.fsf@metaspace.dk>
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


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Mar 02, 2023 at 11:07:15AM +0100, Andreas Hindborg wrote:
>>=20
>> Ming Lei <ming.lei@redhat.com> writes:
>>=20
>> > On Thu, Mar 2, 2023 at 5:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
>> >>
>> >> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
>> >> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
>> >> > >
>> >>
>> >> ...
>> >>
>> >> > >
>> >> > > I agree about fetching more zones. However, it is no good to fetc=
h up to
>> >> > > a max, since the requested zone report may less than max. I was
>> >> >
>> >> > Short read should always be supported, so the interface may need to
>> >> > return how many zones in single command, please refer to nvme_ns_re=
port_zones().
>> >>
>> >> blk_zone is part of uapi, maybe the short read can be figured out by
>> >> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
>> >> reporting zones.
>> >
>> > oops, we have blk_zone_report data for reporting zones to userspace al=
ready,
>> > see blkdev_report_zones_ioctl(), then this way can be re-used for gett=
ing zone
>> > report from ublk server too, right?
>>=20
>> Yes that would be nice. But I did the report_zone command like a read
>> operation, so we are not currently copying any buffers to user space
>> when issuing the command, we just rely on the iod.
>
> What I meant is to reuse the format of blk_zone_report for returning
> multiple 'blk_zone' info in single command.
>
> The only change is that you need to allocate one bigger kernel buffer
> to hold more 'blk_zone' in single report zone request.
>
>> I think it would be
>> better to use the start_sectors and nr_sectors of the iod instead. Then
>> we don't have to copy the blk_zone_report. What do you think?
>
> For IN parameter of report zone command, you still can reuse
> blk_zone_report:
>
> struct blk_zone_report {
>         __u64           sector;
>         __u32           nr_zones;
>         __u32           flags;
> };
>
> Just by using the 1st two 64b words of iod for holding 'blk_zone_report',=
 and
> keep the iod->addr field not touched.

I see. Would you make the first part of `struct ublksrv_io_desc` a union
for this, or would you just cast it at the use site?

BR Andreas
