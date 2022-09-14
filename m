Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1EC5B8D48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiINQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiINQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:42:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102965FF55;
        Wed, 14 Sep 2022 09:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD282B8172B;
        Wed, 14 Sep 2022 16:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C01C433C1;
        Wed, 14 Sep 2022 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663173769;
        bh=5rjnZD4aW6Ta7RnXoGxlFAwk+JqLOxszQ44sIzN65/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIfbNPuyzSs45A+qFUmsLkLy+OLSCzaFrqkfB5h7CKohyL43gm71wS4YsFZuOuvDY
         C3geizrBnXtwIwazo3rZmp8T3qWRfS5nHIlv59cNZsLnkyFdcwi+bq6zy6xfSFCb5v
         ZRcDu94pvz0ChOaHQlYMcWxfJxRIA1eJBy9ZNoE2o3ilQBm0OEEOgnxQhi6NozyFxB
         2exBGmh+ilVmwmrSM9cFTjN/DywFrVHTXEOJNYl4gh6RS39+Us/APOAZpiyWWSak96
         Bo9l94NrOIvx0/P9JiqgjlhYK4sV28O2ahVQZJ3Z7Bk7fsvSjxqamttWdxqHiQx2Nq
         YNBoxXe+ewODg==
Date:   Wed, 14 Sep 2022 09:42:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, dchinner@redhat.com,
        chandan.babu@oracle.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: remove the redundant check in xfs_bmap_first_unused
Message-ID: <YyIEiEXJuExymird@magnolia>
References: <20220909030756.3916297-1-zhangshida@kylinos.cn>
 <20220911231251.GA3600936@dread.disaster.area>
 <CANubcdWe9thzi0WXHBg+vccP7UaGv1c8FiGQkORV6PGw_4cOwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdWe9thzi0WXHBg+vccP7UaGv1c8FiGQkORV6PGw_4cOwQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:39:23PM +0800, Stephen Zhang wrote:
> Dave Chinner <david@fromorbit.com> 于2022年9月12日周一 07:12写道：
> > Given that all the types and comparisons involved are 64 bit
> > unsigned:
> >
> > typedef uint64_t        xfs_fileoff_t;  /* block number in a file */
> >
> > #define XFS_FILEOFF_MAX(a,b) max_t(xfs_fileoff_t, (a), (b))
> >
> >         xfs_fileoff_t br_startoff;
> >
> >         xfs_fileoff_t           lastaddr = 0;
> >         xfs_fileoff_t           lowest, max;
> >
> > We end up with the following calculations (in FSBs, not bytes):
> >
> >         lowest + len    = 0x800000ULL + 1
> >                         = 0x800001ULL
> >
> >         got.br_startoff - max   = 0ULL - 0x800000
> >                                 = 0xffffffffff800000ULL
> >
> > and so the existing check is:
> >
> >         if (0 >= 0x800001ULL && 0xffffffffff800000 >= 1)
> >
> > which evaluates as false because the extent that was found is not
> > beyond the initial offset (first_unused) that we need to start
> > searching at.
> >
> > With your modification, this would now evaluate as:
> >
> >         if (0xffffffffff800000 >= 1)
> >
> > Because of the underflow, this would then evaluate as true  and we'd
> > return 0 as the first unused offset. This is incorrect as we do not
> > have a hole at offset 0, nor is it within the correct directory
> > offset segment, nor is it within the search bounds we have
> > specified.
> >
> > If these were all signed types, then your proposed code might be
> > correct. But they are unsigned and hence we have to ensure that we
> > handle overflow/underflow appropriately.
> >
> > Which leads me to ask: did you test this change before you send
> > it to the list?
> >
> 
> I am so sorry about the mistake, and thanks for your elaboration about
> this problem. it indeed teaches me a lesson about the necessity of test
> even for the simplest change.
> 
> By the way, theoretically, in order to solve this, I wonder if we could
> change the code in the following way:
> ====
> xfs_bmap_first_unused(
>                 /*
>                  * See if the hole before this extent will work.
>                  */
> -               if (got.br_startoff >= lowest + len &&
> -                   got.br_startoff - max >= len)
> +               if (got.br_startoff >= max + len)

Er... what problem does this solve?  Is there a defect in this range
checking code?  Why not leave it alone, since that's less retesting for
all of us.

--D

>                         break;
> ====
> 
> Thanks,
> 
> Stephen.
