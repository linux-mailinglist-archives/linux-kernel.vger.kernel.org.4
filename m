Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5496A7D66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCBJPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCBJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AD7136EA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677748467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gn95fNZsWohda/Gt3RBIsmBf9yhGLuJiMqSDf2HskJM=;
        b=fkXzPlapp2zgEJDhGu8AV064fTCv7+977MxLRU//NHw5J3ADaV2uOn8cS+6AOQWKBgvJVg
        ojz6PSb0H4qyhItoFwRSfEJ2RR7z3BnKrzRM1I/49WqWssrH9oR6CKJIgaCyJUXISOxe0R
        0wtZSks57FwTWHb71N8b3ry1dKN9btA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ExsDxMD_Ow2rZzLPG5r3WQ-1; Thu, 02 Mar 2023 04:14:26 -0500
X-MC-Unique: ExsDxMD_Ow2rZzLPG5r3WQ-1
Received: by mail-vs1-f72.google.com with SMTP id f18-20020a0561020c9200b004216d910ebeso5384283vst.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677748465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn95fNZsWohda/Gt3RBIsmBf9yhGLuJiMqSDf2HskJM=;
        b=Kq9YFc3ws0bkIce+k+iHoOjZ9p9K1uqeFmbvq3FKP6P77BSyXuaN4cU22oVSPeTXTN
         MA8luW24/8SMxVpYWuxV9npwxoGQsisbyCV1g184Jp+7+lgAUmB/YFjLW4Ps95scLEnh
         bzLRANeUIrgUVmbHwaIgWunVk7EwlxeYEPj3gwrpVChV1TN03x83s1ssUiazjH0wnW6g
         nkUKyrZb0LPVWUJvXjnGst/LQtwJR8hm2yZwNxcHqNCLX+REa6i4Mx8n4e4d6mgNxWLd
         pOT2BkVUiSkBJn4WZg1K2XB6sAO7+0pNAOFVAnBThvTfapWkVKaWrJcPLAIzwzvI1aQN
         ov4A==
X-Gm-Message-State: AO0yUKVlBjmRwQLlPfdM2MHfNysKLqHJ6MX3N8z9VjMSyIKu0XjiAXq6
        8i0DTHcI2LXyup48VSgh052u+fcyS/a49JIRWUOn2fwJRJZfVakqL2WcAn037C1HzDKmP3y0Yod
        G5xS4QFmeWQRP96wxM5h1LxqDKuctaJ/Vvw4mcpCvSOC2hzZLchU=
X-Received: by 2002:a67:b910:0:b0:412:364c:68be with SMTP id q16-20020a67b910000000b00412364c68bemr6074226vsn.7.1677748465725;
        Thu, 02 Mar 2023 01:14:25 -0800 (PST)
X-Google-Smtp-Source: AK7set9yW7PU8Zj8MjrA77EC8H0DigRUOzdN0Dz8qC8KWJKL3ib/eNM3P5KnWHbX3gi8isXs+lAWQfcMSDapi1ZlXxs=
X-Received: by 2002:a67:b910:0:b0:412:364c:68be with SMTP id
 q16-20020a67b910000000b00412364c68bemr6074220vsn.7.1677748465514; Thu, 02 Mar
 2023 01:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20230224200502.391570-1-nmi@metaspace.dk> <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk> <ZABfFW+28Jlxq+Ew@T590> <ZABmAR6Du1tUVEa7@T590>
In-Reply-To: <ZABmAR6Du1tUVEa7@T590>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 2 Mar 2023 17:14:13 +0800
Message-ID: <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 5:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> > >
>
> ...
>
> > >
> > > I agree about fetching more zones. However, it is no good to fetch up=
 to
> > > a max, since the requested zone report may less than max. I was
> >
> > Short read should always be supported, so the interface may need to
> > return how many zones in single command, please refer to nvme_ns_report=
_zones().
>
> blk_zone is part of uapi, maybe the short read can be figured out by
> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
> reporting zones.

oops, we have blk_zone_report data for reporting zones to userspace already=
,
see blkdev_report_zones_ioctl(), then this way can be re-used for getting z=
one
report from ublk server too, right?

Thanks,
Ming

