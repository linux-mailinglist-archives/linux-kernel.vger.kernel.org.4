Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC685BD50E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiISTIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540947BA3;
        Mon, 19 Sep 2022 12:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4AD661D2A;
        Mon, 19 Sep 2022 19:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C23C433C1;
        Mon, 19 Sep 2022 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663614499;
        bh=5N4rtjjaCac5zqOEKZ4/1Ep2rlFuHPVq28Uk69d7E08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bbJ4q2kiooDSaASEILD7y6KPsYKGxHlJVOwnfLAwjeWASMnbNvkZFiUg749LeyJde
         uE7NOepHGqRTTUExJax75UQuQmzmlHHksEymZa6qIDW3CfohLCWNCoofhpNpAvfxfI
         zmco3EnY7WmR0KYBlmdyfJ/KaP/FNBQdjPkPmOzJ2vj/VIBECjoslcbMdX7IZHSFyj
         7DEoFDLdDXL8nAGZAOawiYWywTrDbKL1kTrge0JA1vTO6v+5vhpaUzMltauGEKvlhW
         Vu0W3xuSAYMUFfTY6/SGfKxDSc8jKp8DgMHkaAV1jMqBQVh1S1mH9SkZFJTVun+vIC
         Td012K9mtCShg==
Received: by mail-ej1-f51.google.com with SMTP id go34so971683ejc.2;
        Mon, 19 Sep 2022 12:08:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf3PJpr48wvklLsomQdc+L++L83YYEtntacuefm/hnoJUeTdwtR3
        /juwvee3/UoxdcxSYv3AeAw8CEIbdvdeP/wbUpI=
X-Google-Smtp-Source: AMsMyM7m7633C0ivrwpCyIo3o3gdsqQPixmagxqV1MMBXvR8hFENI77U0QGkaATpDkZ5ZVqo9YxjTE8dstjs8dWKlOQ=
X-Received: by 2002:a17:906:974d:b0:780:2c07:7617 with SMTP id
 o13-20020a170906974d00b007802c077617mr14311386ejy.707.1663614497308; Mon, 19
 Sep 2022 12:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-6-yukuai1@huaweicloud.com> <e73dc8e8-09a3-ecc8-3199-ac87e8b9ee55@linux.dev>
 <a6364e1e-f661-9e32-9d49-5ec421d77025@huaweicloud.com> <b87f4f81-2514-5731-46b0-511b02e3420d@linux.dev>
In-Reply-To: <b87f4f81-2514-5731-46b0-511b02e3420d@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Mon, 19 Sep 2022 12:08:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW50E0zwrV0axpVA18qf6fRRQqNAZ1gqYQcqXinEPjS-2A@mail.gmail.com>
Message-ID: <CAPhsuW50E0zwrV0axpVA18qf6fRRQqNAZ1gqYQcqXinEPjS-2A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] md/raid10: convert resync_lock to use seqlock
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai3@huawei.com >> yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 3:28 AM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
>
>
> On 9/19/22 9:08 AM, Yu Kuai wrote:
> > Hi,
> >
> > =E5=9C=A8 2022/09/18 19:36, Guoqing Jiang =E5=86=99=E9=81=93:
> >>
> >>
> >> On 9/16/22 7:34 PM, Yu Kuai wrote:
> >>> From: Yu Kuai <yukuai3@huawei.com>
> >>>
> >>> Currently, wait_barrier() will hold 'resync_lock' to read
> >>> 'conf->barrier',
> >>> and io can't be dispatched until 'barrier' is dropped.
> >>>
> >>> Since holding the 'barrier' is not common, convert 'resync_lock' to u=
se
> >>> seqlock so that holding lock can be avoided in fast path.
> >>>
> >>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>> ---
> >>>   drivers/md/raid10.c | 87
> >>> ++++++++++++++++++++++++++++++---------------
> >>>   drivers/md/raid10.h |  2 +-
> >>>   2 files changed, 59 insertions(+), 30 deletions(-)
> >>>
> >>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> >>> index 9a28abd19709..2daa7d57034c 100644
> >>> --- a/drivers/md/raid10.c
> >>> +++ b/drivers/md/raid10.c
> >>> @@ -79,6 +79,21 @@ static void end_reshape(struct r10conf *conf);
> >>>   #include "raid1-10.c"
> >>> +#define NULL_CMD
> >>> +#define cmd_before(conf, cmd) \
> >>> +    do { \
> >>> +        write_sequnlock_irq(&(conf)->resync_lock); \
> >>> +        cmd; \
> >>> +    } while (0)
> >>> +#define cmd_after(conf) write_seqlock_irq(&(conf)->resync_lock)
> >>
> >> The two is not paired well given only cmd_before needs the 'cmd'.
> >
> > May be should I just remove cmd_after?
>
> I'd remove it but just my personal flavor.
>
> >>
> >>> +
> >>> +#define wait_event_barrier_cmd(conf, cond, cmd) \
> >>> +    wait_event_cmd((conf)->wait_barrier, cond, cmd_before(conf,
> >>> cmd), \
> >>> +               cmd_after(conf))
> >>> +
> >>> +#define wait_event_barrier(conf, cond) \
> >>> +    wait_event_barrier_cmd(conf, cond, NULL_CMD)
> >>
> >> What is the issue without define NULL_CMD?
> >>
> >
> > Checkpatch will complain this:
> >
> > ERROR: space prohibited before that close parenthesis ')'
> > #38: FILE: drivers/md/raid10.c:94:
> > +       wait_event_barrier_cmd(conf, cond, )
> >
> > total: 1 errors, 0 warnings, 169 lines checked
>
> Hmm, freeze_array has a different usage for it, so two cmds before sleep
> and one cmd after sleep, perhaps it is the best way for now.

Current version looks good to me. Please let me know if there is more
concern.

Applied the set to md-next. Thanks!

Song
