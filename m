Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3365F12C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiI3TgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiI3Tfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:35:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A92D56
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:34:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 126so6422229ybw.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/PMOqu3mb1YcC9oShPiTE/sDF0QVx4wiRqM9S/jS6DA=;
        b=XFamMtHe3wFj90Zic29OQxY7ydKVQWyjuaA+OajjlX2kaQrLP+LV/KC6v+97J9JTvN
         w3pnz6LummO/Ig7O6gHV6i2jyUqwSAmWY1p9iGQp5wCy7atAWzx5G4DVYFz+QMaVpOht
         paH4c64gVe/jg01ThRW021KFn5yOTVIGtXv/YT2cLH398me0bINX5O4tREerRgp/+En5
         wz4r085xkhnWieb1u1bIDsczrp+hJuW7SJaLP0AOMS07p+cB/iI51voGADLvKAipl77A
         9Sy8S1KN3LdK5fnZhML/wINeoLuQzrrBxUtQIfGhC2rK0veSYiNH8rfJrJ8iety0Sek4
         Gn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/PMOqu3mb1YcC9oShPiTE/sDF0QVx4wiRqM9S/jS6DA=;
        b=0YLwl1oIqhr2zUOONNww9aju+KoN4vx/WEnR1ra8vqAKJLnGYcqSgUVOywy/Q8oOtz
         D+7AVZUIac6QmMzpSv4++usQgrozsFConDw0MoShXWb4nGf4B/BIgpLJ08x9WF8y02wi
         FrpvxS00IKPWP2nQO1qp3WK8oGcNHL4i82EsNLBXwkiTtiNdfamPBKSDDV+RUS7XwdPF
         F1+rjgyk7HseOlCdty2H/k+ftL9bv2k2l3tdeeJUY1UUCclHknUVZw7ZLPjEf1K9VnjN
         zRBpVTNWVW6grN6+cECNM6wmqshQCIvQkpRzmCK/i+clAGw5lU83Z5OxrYR4CR2duGZv
         a24g==
X-Gm-Message-State: ACrzQf1IpkgdmH5ixAJAyH0d3pyhecem9B6VRhP1fFC4FH0ISltWlv9M
        4n6ZBVqaw4PPBzDuVb6uTJs7gwG/d8jNrl8UYDAMwQ==
X-Google-Smtp-Source: AMsMyM6xHXoWqlyzGBlDnCpWNRdIwZAVm9F5lFDjnllvUUMzQOSZ+KT4aCVuuQpPPyXaG7ZYfWXkTrYhXUEx3tLy4bY=
X-Received: by 2002:a25:1844:0:b0:6bc:d8d9:5b35 with SMTP id
 65-20020a251844000000b006bcd8d95b35mr7027618yby.474.1664566473748; Fri, 30
 Sep 2022 12:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220908125037.1119114-1-bgeffon@google.com> <Yy4JkpZ/SnXtrVRf@google.com>
In-Reply-To: <Yy4JkpZ/SnXtrVRf@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 30 Sep 2022 15:33:11 -0400
Message-ID: <CADyq12yo+iREA_4FP1K-b-PekZQdLUDBT_Yd1v2vFyEbtq9ZOA@mail.gmail.com>
Subject: Re: [RESEND RFC] zram: Allow rw_page when page isn't written back.
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>,
        linux-mm <linux-mm@kvack.org>
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

Hi Minchan,
Thank you for taking a look.

On Fri, Sep 23, 2022 at 3:31 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Sep 08, 2022 at 08:50:37AM -0400, Brian Geffon wrote:
> > Today when a zram device has a backing device we change the ops to
> > a new set which does not expose a rw_page method. This prevents the
> > upper layers from trying to issue a synchronous rw. This has the
> > downside that we penalize every rw even when it could possibly
>
> Do you mean addiontal bio alloc/free?
> Please specify something more detail.

Yes, the additional overhead is primarily this bio_alloc/free.

>
> > still be performed as a synchronous rw. By the very nature of
>
> Even though zram go though the block layer in the case, it's still
> synchronous operation against on in-memory compressed data. Only
> asynchrnous IO happens for the data in backing device.
>
> > zram all writes are synchronous so it's unfortunate to have to
> > accept this limitation.
> >
> > This change will always expose a rw_page function and if the page
> > has been written back it will return -EOPNOTSUPP which will force the
> > upper layers to try again with bio.
>
> Sounds a good idea.
>
> >
> > To safely allow a synchronous read to proceed for pages which have not
> > yet written back we introduce a new flag ZRAM_NO_WB. On the first
> > synchronous read if the page is not written back we will set the
> > ZRAM_NO_WB flag. This flag, which is never cleared, prevents writeback
> > from ever happening to that page.
>
> Why do we need a addtional flag?
> Why couldn't we do?
>
> 1. expose the rw_page all the time.
> 2. If the page was written back, just return an error in rw_page to make
> upper layer retry it with bio.

Yes this approach is much simpler, I'll send a new patch.

>
> >
> > This approach works because in the case of zram as a swap backing device
> > the page is going to be removed from zram shortly thereafter so
> > preventing writeback is fine. However, if zram is being used as a
> > generic block device then this might prevent writeback of the page.
> >
> > This proposal is still very much RFC, feedback would be appreciated.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 68 +++++++++++++++++++++--------------
> >  drivers/block/zram/zram_drv.h |  1 +
> >  2 files changed, 43 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 92cb929a45b7..22b69e8b6042 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -52,9 +52,6 @@ static unsigned int num_devices = 1;
> >  static size_t huge_class_size;
> >
> >  static const struct block_device_operations zram_devops;
> > -#ifdef CONFIG_ZRAM_WRITEBACK
> > -static const struct block_device_operations zram_wb_devops;
> > -#endif
> >
> >  static void zram_free_page(struct zram *zram, size_t index);
> >  static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
> > @@ -309,7 +306,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
> >                */
> >               zram_slot_lock(zram, index);
> >               if (zram_allocated(zram, index) &&
> > -                             !zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> > +                             !zram_test_flag(zram, index, ZRAM_UNDER_WB) &&
> > +                             !zram_test_flag(zram, index, ZRAM_NO_WB)) {
> >  #ifdef CONFIG_ZRAM_MEMORY_TRACKING
> >                       is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
> >  #endif
> > @@ -439,7 +437,6 @@ static void reset_bdev(struct zram *zram)
> >       filp_close(zram->backing_dev, NULL);
> >       zram->backing_dev = NULL;
> >       zram->bdev = NULL;
> > -     zram->disk->fops = &zram_devops;
> >       kvfree(zram->bitmap);
> >       zram->bitmap = NULL;
> >  }
> > @@ -543,17 +540,6 @@ static ssize_t backing_dev_store(struct device *dev,
> >       zram->backing_dev = backing_dev;
> >       zram->bitmap = bitmap;
> >       zram->nr_pages = nr_pages;
> > -     /*
> > -      * With writeback feature, zram does asynchronous IO so it's no longer
> > -      * synchronous device so let's remove synchronous io flag. Othewise,
> > -      * upper layer(e.g., swap) could wait IO completion rather than
> > -      * (submit and return), which will cause system sluggish.
> > -      * Furthermore, when the IO function returns(e.g., swap_readpage),
> > -      * upper layer expects IO was done so it could deallocate the page
> > -      * freely but in fact, IO is going on so finally could cause
> > -      * use-after-free when the IO is really done.
> > -      */
> > -     zram->disk->fops = &zram_wb_devops;
> >       up_write(&zram->init_lock);
> >
> >       pr_info("setup backing device %s\n", file_name);
> > @@ -722,7 +708,8 @@ static ssize_t writeback_store(struct device *dev,
> >
> >               if (zram_test_flag(zram, index, ZRAM_WB) ||
> >                               zram_test_flag(zram, index, ZRAM_SAME) ||
> > -                             zram_test_flag(zram, index, ZRAM_UNDER_WB))
> > +                             zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
> > +                             zram_test_flag(zram, index, ZRAM_NO_WB))
> >                       goto next;
> >
> >               if (mode & IDLE_WRITEBACK &&
> > @@ -1226,6 +1213,10 @@ static void zram_free_page(struct zram *zram, size_t index)
> >               goto out;
> >       }
> >
> > +     if (zram_test_flag(zram, index, ZRAM_NO_WB)) {
> > +             zram_clear_flag(zram, index, ZRAM_NO_WB);
> > +     }
> > +
> >       /*
> >        * No memory is allocated for same element filled pages.
> >        * Simply clear same page flag.
> > @@ -1654,6 +1645,40 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
> >       index = sector >> SECTORS_PER_PAGE_SHIFT;
> >       offset = (sector & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
> >
> > +#ifdef CONFIG_ZRAM_WRITEBACK
> > +     /*
> > +      * With writeback feature, zram does asynchronous IO so it's no longer
> > +      * synchronous device so let's remove synchronous io flag. Othewise,
> > +      * upper layer(e.g., swap) could wait IO completion rather than
> > +      * (submit and return), which will cause system sluggish.
> > +      * Furthermore, when the IO function returns(e.g., swap_readpage),
> > +      * upper layer expects IO was done so it could deallocate the page
> > +      * freely but in fact, IO is going on so finally could cause
> > +      * use-after-free when the IO is really done.
> > +      *
> > +      * If the page is not currently written back then we may proceed to
> > +      * read the page synchronously, otherwise, we must fail with
> > +      * -EOPNOTSUPP to force the upper layers to use a normal bio.
> > +      */
> > +     zram_slot_lock(zram, index);
> > +     if (zram_test_flag(zram, index, ZRAM_WB) ||
> > +                     zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> > +             zram_slot_unlock(zram, index);
> > +             /* We cannot proceed with synchronous read */
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     /*
> > +      * Don't allow the page to be written back while we read it,
> > +      * this flag is never cleared. It shouldn't be a problem that
> > +      * we don't clear this flag because in the case of swap this
> > +      * page will be removed shortly after this read anyway.
> > +      */
> > +     if (op == REQ_OP_READ)
> > +             zram_set_flag(zram, index, ZRAM_NO_WB);
> > +     zram_slot_unlock(zram, index);
> > +#endif
> > +
> >       bv.bv_page = page;
> >       bv.bv_len = PAGE_SIZE;
> >       bv.bv_offset = 0;
> > @@ -1827,15 +1852,6 @@ static const struct block_device_operations zram_devops = {
> >       .owner = THIS_MODULE
> >  };
> >
> > -#ifdef CONFIG_ZRAM_WRITEBACK
> > -static const struct block_device_operations zram_wb_devops = {
> > -     .open = zram_open,
> > -     .submit_bio = zram_submit_bio,
> > -     .swap_slot_free_notify = zram_slot_free_notify,
> > -     .owner = THIS_MODULE
> > -};
> > -#endif
> > -
> >  static DEVICE_ATTR_WO(compact);
> >  static DEVICE_ATTR_RW(disksize);
> >  static DEVICE_ATTR_RO(initstate);
> > diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> > index 158c91e54850..20e4c6a579e0 100644
> > --- a/drivers/block/zram/zram_drv.h
> > +++ b/drivers/block/zram/zram_drv.h
> > @@ -50,6 +50,7 @@ enum zram_pageflags {
> >       ZRAM_UNDER_WB,  /* page is under writeback */
> >       ZRAM_HUGE,      /* Incompressible page */
> >       ZRAM_IDLE,      /* not accessed page since last idle marking */
> > +     ZRAM_NO_WB,     /* Do not allow page to be written back */
> >
> >       __NR_ZRAM_PAGEFLAGS,
> >  };
> > --
> > 2.37.2.789.g6183377224-goog
> >
> >
