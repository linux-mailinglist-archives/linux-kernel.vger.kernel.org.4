Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2245F68875C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjBBTLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjBBTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:11:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9834C25
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:11:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n13so2203349wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cmqPx/Zy279diCwL80ZzQVZT2Mcv1030GfDHO64ZwaM=;
        b=rx8n/zPQAkVDgqYtXeVL8F0TnK38f8l/sJKC7Iw6IjH4QL1MAaJHL0FJeHMz1V21kf
         Jbm9izq0xBt1iNhCYXs7gXTM7mhkddeSKb/oD1d9dPQ022nlIde3tKQsTklfZaKR4lX/
         dxr34usvKTUG1ei0NbJu5KZ1RA9uQtIik7lHAXtSLR4lzA4IyQr6xcfOm9Uursp/AoIk
         dYmXeGNB5CTGUmx/aJ494btV5e/xnEKwzUAqVUWjt6qrAzbibsdBwMDmeSzQvcl5Tt1i
         Ak675YUxYRmrcjzLQnrP3ToqhGiNWjVYS2t7C9GL0GrFGoZXGiu5d6KKI0j6iskItLgC
         rdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmqPx/Zy279diCwL80ZzQVZT2Mcv1030GfDHO64ZwaM=;
        b=GyXewDQEZWELKoHcR7VCYkDbH/ULUgSZWyervmbMo5RIGqQZnv3Qp6exz5mMxCFkS9
         0FX/iHiUIIg9SXPvZK/SUpGFaaIgpwN/EuZTFhyrnVzlkAs8GWuWUVw5RAjQfGP3NE4D
         CO/ziWoAS9umm978cKTpoRR8LAHHAnfIyFgTfOJJTrk3L6ZijJwT6RLRNDXUYKJKcXRd
         bkzE5UKH8BiEynzoqESqc8LlNaMh5dRlQ7hJJWhrdTQf6IP5VLMkK4qiMVTiOnBAXyNx
         3DnIBB1vwyhvUwKQyKmAuWK3KXcktgOMsFcW3K9p9OeSlAcCXI8k6YvbEsu1v9/Kpn1i
         rXZQ==
X-Gm-Message-State: AO0yUKVNd+dmn6K5SAv9NUbenYRUmi1iO7bHObXF1K5BsW9OhRe3ti9M
        vuw2C3FJY44KNHTxTIf4m0ZwDqngI462aw5bJU0h4g==
X-Google-Smtp-Source: AK7set96hCXSN8RisUiNR5YsJkh6ScE8+8SR4F6BqhH6feHgPVQmnMOF+Dd5nQ7x6loD3WWBhySd5AaVOyA9RgQ/D6o=
X-Received: by 2002:a05:600c:1da3:b0:3da:b40f:c734 with SMTP id
 p35-20020a05600c1da300b003dab40fc734mr372362wms.115.1675365087907; Thu, 02
 Feb 2023 11:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20230202012348.885402-1-nhuck@google.com> <Y9vnte1xP5T+nZ6j@redhat.com>
In-Reply-To: <Y9vnte1xP5T+nZ6j@redhat.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Thu, 2 Feb 2023 11:11:16 -0800
Message-ID: <CAJkfWY5sYxPe1ArxSe3fkwqkOFSxxz9HDdF6XoL_Wc9g070hRg@mail.gmail.com>
Subject: Re: dm-verity: Remove WQ_UNBOUND.
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     mpatocka@redhat.com, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, dm-devel@redhat.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good. Thanks.

On Thu, Feb 2, 2023 at 8:41 AM Mike Snitzer <snitzer@kernel.org> wrote:
>
> On Wed, Feb 01 2023 at  8:23P -0500,
> Nathan Huckleberry <nhuck@google.com> wrote:
>
> > Setting WQ_UNBOUND increases scheduler latency on ARM64.  This is likely
> > due to the asymmetric architecture of ARM64 processors.
> >
> > I've been unable to reproduce the results that claim WQ_UNBOUND gives a
> > performance boost on x86-64.
> >
> > This flag is causing performance issues for multiple subsystems within
> > Android.  Notably, the same slowdown exists for decompression with
> > EROFS.
> >
> > | open-prebuilt-camera  | WQ_UNBOUND | ~WQ_UNBOUND   |
> > |-----------------------|------------|---------------|
> > | verity wait time (us) | 11746      | 119 (-98%)    |
> > | erofs wait time (us)  | 357805     | 174205 (-51%) |
> >
> > | sha256 ramdisk random read | WQ_UNBOUND    | ~WQ_UNBOUND |
> > |----------------------------|-----------=---|-------------|
> > | arm64 (accelerated)        | bw=42.4MiB/s  | bw=212MiB/s |
> > | arm64 (generic)            | bw=16.5MiB/s  | bw=48MiB/s  |
> > | x86_64 (generic)           | bw=233MiB/s   | bw=230MiB/s |
> >
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  drivers/md/dm-verity-target.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> > index ccf5b852fbf7..020fd2341025 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -1399,8 +1399,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >               goto bad;
> >       }
> >
> > -     /* WQ_UNBOUND greatly improves performance when running on ramdisk */
> > -     wq_flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
> > +     wq_flags = WQ_MEM_RECLAIM;
> > +
> >       /*
> >        * Using WQ_HIGHPRI improves throughput and completion latency by
> >        * reducing wait times when reading from a dm-verity device.
> > --
> > 2.39.1.456.gfc5497dd1b-goog
>
> Hi,
>
> I've discussed with Mikulas, tweaked your patch slightly but accepted
> your change, please see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.3&id=6f30cc248507ee96c22ff4c3cbc86099ff12b7a9
>
> Thanks,
> Mike
