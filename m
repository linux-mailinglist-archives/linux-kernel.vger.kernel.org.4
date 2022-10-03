Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4EF5F3222
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJCOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJCOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:48:10 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E252D754
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:48:08 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-349c4310cf7so108707897b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/fK4j8MeExXgiB4LNpy8fXk97jz55ShDa3XaZipcnRA=;
        b=XKGhDGNIRIwD2ad2zCVJCjwpJs1C0QkN7IVbZj9GFS8DwPX40YLMiin0D7PUfL3Mtt
         auB83GQwVX4W+nmv93KkGt5oodkTyAWQIOvArBoQZ+SJPqK97sn/w0bUAnn35rIA3+qQ
         9cefCyaUPYqeLqpbny6JOcmahubNwprMl/YxLA4JrM7S2jkvu87Y3PxDDay8ZzUf/FqK
         eV304uHKOVzTgMgcvQpmycyA5oOWbI57thLOAffzkTV2Br/YifMXpW0lkWJJM6Q9zwst
         QU4BuYzDtKp2wn9R2XYm/DcP1iC2D5Eaodc4uDvRPsgCcBs4jAKRotdssxC/KGFNrAOw
         Olug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/fK4j8MeExXgiB4LNpy8fXk97jz55ShDa3XaZipcnRA=;
        b=7tluuz2l+8Y6cH24BgV3dyQ28xmmDRx0Z+ss8Q6lQUzWIT5QyTbU3LI7XbMMUfmw5a
         ePx0lx6ElfTGyHH50unfpDnwNGwSibijFvvTTFmp24gnFzCErce47jv8540KaRQjPGxT
         O+Q6PT5dNY5P8T8TRKFvz1H3/uRBvEALD6ETHxzR3cmSYP0sIFQmpPleb0qPb/g3IE+7
         qTn00V6RIxDvlEouwc7HMGYhHGkwytmsyVhkA5Wxt2SGetIxCpYeJAXP72U32ex3fO5L
         NP8lMDKG924hyFW5S5xxFdZQVfuY0nkoWpZomlxT8+ki1i6c13IPE3bW6RnQNRC6dT8g
         dT+Q==
X-Gm-Message-State: ACrzQf2ZktzBE66aXfhdLuBmgsfzhsgdU7VXV1qojS387hHc+vt0tT62
        RYxASK/cL4QwsqNFaV/32IA7kvnKd3U0kKm7QmOAzQ==
X-Google-Smtp-Source: AMsMyM4dTW0t/Y1+lBn2NWl6UDI/XjiZffhYEYMKQ+Vft2QfWIpHWcw//AzN4KpCM/ONKvRZp9ZZeWnbe39ibMEsiuo=
X-Received: by 2002:a0d:fac2:0:b0:349:f1d4:8b1e with SMTP id
 k185-20020a0dfac2000000b00349f1d48b1emr20263484ywf.456.1664808487681; Mon, 03
 Oct 2022 07:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <Yy4JkpZ/SnXtrVRf@google.com> <20220930195215.2360317-1-bgeffon@google.com>
 <YzpQBqwET9bTEsoU@google.com>
In-Reply-To: <YzpQBqwET9bTEsoU@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 3 Oct 2022 10:46:43 -0400
Message-ID: <CADyq12wo_LS3v44Fs4R68hZAcmM4YVZ=17Vfyo+SECX15Y9LXg@mail.gmail.com>
Subject: Re: [PATCH] zram: Always expose rw_page
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
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

On Sun, Oct 2, 2022 at 10:59 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/09/30 15:52), Brian Geffon wrote:
> > Currently zram will adjust its fops to a version which does not
> > contain rw_page when a backing device has been assigned. This is
> > done to prevent upper layers from assuming a synchronous operation
> > when a page may have been written back. This forces every operation
> > through bio which has overhead associated with bio_alloc/frees.
> >
> > The code can be simplified to always expose a rw_page method and
> > only in the rare event that a page is written back we instead will
> > return -EOPNOTSUPP forcing the upper layer to fallback to bio.
>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Thank you.

>
> > @@ -1267,6 +1253,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
> >               struct bio_vec bvec;
> >
> >               zram_slot_unlock(zram, index);
> > +             /* If we don't have a bio we came via rw_page, we must fallback to bio */
> > +             if (!bio)
> > +                     return -EOPNOTSUPP;
>
> The comment is above 80 cols.

Fixed in a new patch.
