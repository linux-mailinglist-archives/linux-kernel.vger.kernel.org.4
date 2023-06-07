Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94182725207
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjFGCPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjFGCPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:15:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71111BC0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:15:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b24b34b59fso5059825ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 19:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686104116; x=1688696116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oQUlCOcqt0tuXvcUCaoZv+EjOka/kZ7fKStDDBCleig=;
        b=q+TsFLfQE4gn0cXqpEsWkLsNprKrqq8d0lYmxTWIi38uAFA2ziC8yx5o/30ncBczrn
         zLmgXFV/zcNyl9FhreLy3L7DJsJ7E+hRoIj4bQznRSdPefG7jMnHzzoQ5Xn/0kfLegPL
         hO3hfWhbjtLOYTpkZpFeXMikvagv4kvfPHiq2e0C7uDCC8qd9AJOIhPkTNhO1SJYJtAI
         y+r3wMfkE/TExvpTLnn1QuvGByptzbVUv+EQEpzJ576IwooDMl/13BjSEYQKAqpmzwYD
         Q91cRCAHRlV6YEuT/2Wy8hE1qV3spvT7z/V+UxhL8TXfaJmNPhgBfHDiJDovUX8a5e1e
         eiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686104116; x=1688696116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQUlCOcqt0tuXvcUCaoZv+EjOka/kZ7fKStDDBCleig=;
        b=IjxUcx0UABGRLbD9WB9eYnoAdt9K6om9isYkZBA7S1r1BZz4T3sGygNEAkZFvsoNAo
         VRk+UI3JhCrP6CjJYHKgIJdP6L8WYrjnts2ScpsDK/OFmlmommDG5H4pILdZxyVGgX/o
         eT0l7sRDLWtvmZ1mxCSopFkztuj9iqktUr/7FZgJ/rmzH51JGm1xdChXWRZ1apKFyndv
         cuuQyoSiNbBk1SnSCD00Dua2fR60PS2LTx+RQoJ9SUDV0lZyYrznpjB5UrnbJOd2sB5Y
         nSf1bRZMxiSabNsKLHbA2YF6u0dYEFPLi4BMxxEWd1x8fkLH7ipbvQFUd+ok0idJPU5B
         euFQ==
X-Gm-Message-State: AC+VfDy2zXh6IBUFQavB6P7N4dG8H1yeV9CsKojLYcudfa5mA6IC4Vz0
        uLX4hA132SI4lVXu43D0VT6DQg==
X-Google-Smtp-Source: ACHHUZ6vvabNin59tYSUj++K9GAS9dwnlbxvpk5BtcC6SjhWGVfnYwarfgRhemu10fEWP5UF/cCASw==
X-Received: by 2002:a17:902:db0f:b0:1b0:4bc7:31ee with SMTP id m15-20020a170902db0f00b001b04bc731eemr3975802plx.32.1686104116012;
        Tue, 06 Jun 2023 19:15:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b00199203a4fa3sm9173051pld.203.2023.06.06.19.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 19:15:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q6ihc-008ieJ-1f;
        Wed, 07 Jun 2023 12:15:12 +1000
Date:   Wed, 7 Jun 2023 12:15:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZH/oMK7BoBo8a3Hu@dread.disaster.area>
References: <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <ZHti/MLnX5xGw9b7@redhat.com>
 <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:14:44PM -0700, Sarthak Kukreti wrote:
> On Sat, Jun 3, 2023 at 8:57 AM Mike Snitzer <snitzer@kernel.org> wrote:
> > On Fri, Jun 02 2023 at  8:52P -0400,
> > Dave Chinner <david@fromorbit.com> wrote:
> > > On Fri, Jun 02, 2023 at 11:44:27AM -0700, Sarthak Kukreti wrote:
> > > > > The only way to distinquish the caller (between on-behalf of user data
> > > > > vs XFS metadata) would be REQ_META?
> > > > >
> > > > > So should dm-thinp have a REQ_META-based distinction? Or just treat
> > > > > all REQ_OP_PROVISION the same?
> > > > >
> > > > I'm in favor of a REQ_META-based distinction.
> > >
> > > Why? What *requirement* is driving the need for this distinction?
> >
> > Think I answered that above, XFS delalloc accounting parity on thinp.
> >
> I actually had a few different use-cases in mind (apart from the user
> data provisioning 'fear' that you pointed out): in essence, there are
> cases where userspace would benefit from having more control over how
> much space a snapshot takes:
> 
> 1) In the original RFC patchset [1], I alluded to this being a
> mechanism for pre-allocating space for preserving space for thin
> logical volumes. The use-case I'd like to explore is delta updatable
> read-only filesystems similar to systemd system extensions [2]: In
> essence:
> a) Preserve space for a 'base' thin logical volume that will contain a
> read-only filesystem on over-the-air installation: for filesystems
> like squashfs and erofs, pretty much the entire image is a compressed
> file that I'd like to reserve space for before installation.
> b) Before update, create a thin snapshot and preserve enough space to
> ensure that a delta update will succeed (eg. block level diff of the
> base image). Then, the update is guaranteed to have disk space to
> succeed (similar to the A-B update guarantees on ChromeOS). On
> success, we merge the snapshot and reserve an update snapshot for the
> next possible update. On failure, we drop the snapshot.

Sounds very similar to the functionality blksnap is supposed to
provide....

https://lore.kernel.org/linux-fsdevel/20230404140835.25166-1-sergei.shtepa@veeam.com/


> 2) The other idea I wanted to explore was rollback protection for
> stateful filesystem features: in essence, if an update from kernel 4.x
> to 5.y failed very quickly (due to unrelated reasons) and we enabled
> some stateful filesystem features that are only supported on 5.y, we'd
> be able to rollback to 4.x if we used short-lived snapshots (in the
> ChromiumOS world, the lifetime of these snapshots would be < 10s per
> boot).

Not sure that blksnap has a "roll origin back to read-only snapshot"
feature yet, but that's what you'd need for this. i.e. on success,
drop the snapshot. On failure, "roll origin back to snapshot and
reboot".

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
