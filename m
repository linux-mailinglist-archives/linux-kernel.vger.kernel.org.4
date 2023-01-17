Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE25670BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjAQWk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjAQWj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:39:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDA4A219
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:20:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so34972810plw.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lSGOsJAtpiNhXze0eb7NkEGJHEgCM3o3h68MxeurWOQ=;
        b=d21qx3XZ6vWnpM2uMNOpnaDrS6JFYZLqsPmQZR4rEDpPNDTK7CxWECLavKnY5flXhE
         xYn3PSdRgFwFcUMkYcOEnDq3GHlWRS49qWlUXrbUqbvIH0yCw15L6qX0Z0C94FHLKOkc
         VvFcZS93yqCWJXeQtYmHhWSxuVqHgPxtrcq7aaxyIoZJVF4uLEpeizfgCV+lD2wyjlno
         OT6u3A6pd+rbjY8jz41OW/xfuyUQV1LORUTY9ehw+XngDyK2N6nDiauJ67MVNuXg3oWL
         Kwnw8HaQavzOcd85p16aGf4pQ+7HlvzaCHiW/NewsYN2nc4MXSXIaVdSXzsZaeFyzTxa
         Hi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSGOsJAtpiNhXze0eb7NkEGJHEgCM3o3h68MxeurWOQ=;
        b=zWyOSZp5i4zme+WO/m5AIAfhLNUyBL+7LVArHJkL8Ql2H/MGjNRxjAb/pjkok7OkfY
         MUq2uc5bxTMgmUp1hcKh81p/SW1RnE7Ma0zlrpxa4estNF69rmkOGOoioNDaFjGJ85jq
         hFYhS/kc476cZ6rafdbDOKWLhhZTBp0jDQmi3NlYWslS1m5xXuusyZkbBBEJ4HSsEqzV
         6NdTZL1p+KpiGeo2kkSbAZ6ndn50OW7WRyTQBUvorcwzzXKMTczDxq4p4524xntTqvZT
         CxAo4hLAlzAqNPmQMKbf+WtpPOcktmPmXxCxLaLQuinwDQB98y+2E7/pMk5oYApFa9QI
         theA==
X-Gm-Message-State: AFqh2kqbOlBswvDj8fmYpSEh7mwoDsf161jJVPgoVtXjIBf5EYD2STYV
        pVrCFVDkpHo97LtTC/CnjAfsMSHJvhnEwX53TO18vw==
X-Google-Smtp-Source: AMrXdXv1tNSDA/vdVXrwznsUrTfJP5P5q4ykJ1GIOQkYbHKQCS2WJEk7FEHpnkKj40mxqilmHFwVqHlzOhVZdPBqT8w=
X-Received: by 2002:a17:902:d506:b0:193:3760:1ca3 with SMTP id
 b6-20020a170902d50600b0019337601ca3mr310680plg.98.1673994041426; Tue, 17 Jan
 2023 14:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20230117023335.1690727-31-Liam.Howlett@oracle.com> <20230117191109.116438-1-sj@kernel.org>
In-Reply-To: <20230117191109.116438-1-sj@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 17 Jan 2023 14:20:30 -0800
Message-ID: <CAGS_qxru93E+=6nD31=8UGS=7ADnb3VG3hv=hfh-R1zVcqTJ3w@mail.gmail.com>
Subject: Re: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple
 tree store
To:     SeongJae Park <sj@kernel.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>, brendanhiggins@google.com,
        kunit-dev@googlegroups.com,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
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

On Tue, Jan 17, 2023 at 11:11 AM SeongJae Park <sj@kernel.org> wrote:
>
> Cc-ing kunit people.
>
> Hi Liam,
>
>
> Could we put touching file name on the summary?
> E.g., mm/damon/vaddr-test: Stop using ...
>
> On Tue, 17 Jan 2023 02:34:19 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
>
> > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> >
> > Prepare for the removal of the vma_mas_store() function by open coding
> > the maple tree store in this test code.  Set the range of the maple
> > state and call the store function directly.
> >
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: damon@lists.linux.dev
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/damon/vaddr-test.h | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > index bce37c487540..6098933d3272 100644
> > --- a/mm/damon/vaddr-test.h
> > +++ b/mm/damon/vaddr-test.h
> > @@ -14,19 +14,26 @@
> >
> >  #include <kunit/test.h>
> >
> > -static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> > +static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> >                       ssize_t nr_vmas)
> >  {
> > -     int i;
> > +     int i, ret = -ENOMEM;
> >       MA_STATE(mas, mt, 0, 0);
> >
> >       if (!nr_vmas)
> > -             return;
> > +             return -ENOENT;

We could pass in the `test` object here and give more detailed info, e.g.
  (if !nr_vmas)
     kunit_skip(test, "...");

And below could be

bool stored_all = false; // instead of ret
...
for (...) {

}
stored_all = true;

failed:
  mas_unlock(&mas);
  if (!stored_all) kunit_skip(test, "failed to...");

> >
> >       mas_lock(&mas);
> > -     for (i = 0; i < nr_vmas; i++)
> > -             vma_mas_store(&vmas[i], &mas);
> > +     for (i = 0; i < nr_vmas; i++) {
> > +             mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > +             if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > +                     goto failed;
> > +     }
> > +     ret = 0;
> > +
> > +failed:
> >       mas_unlock(&mas);
> > +     return ret;
> >  }
> >
> >  /*
> > @@ -71,7 +78,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
> >       };
> >
> >       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> > -     __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
> > +     KUNIT_EXPECT_EQ(test, __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)), 0);
>
> In case of the __link_vmas() failure, I think we should skip this test using
> 'kunit_skip()', rather marking this test failed.

As noted above, I'd suggest we also pass in the `test` object to
__link_vmas() and call kunit_skip() from there.

>
>
> Thanks,
> SJ

Daniel
