Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A544D6CCE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjC1X7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjC1X7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:59:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC743A8F;
        Tue, 28 Mar 2023 16:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D23A6B81D7A;
        Tue, 28 Mar 2023 23:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA4C433D2;
        Tue, 28 Mar 2023 23:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680047953;
        bh=5s/jceGBhS3x4pTau5j0F/bp4u/ttUTJOoT4GP/kaDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nzzO98GPpCO3/vxDivRrwZP7vYJ3AhTGjwz49hFyKsvIMC5v4kQ4f1wBqaknH3Wc2
         86EX97p7MJVPW+tpy9X6ZIPx/FioVMtSSnC6RXYXuyVzhR1/RhRLIIlEbq99ca6zFe
         PdJb6L9KbxqJFPs96bHOPvXVlYySH+tQYQMS46cXMF/JWtz5X4ltlHVRsfWYHAjdgK
         DVGxBLRYNT7VrKZt5mcWjn6PAsJbMAIuRJLgpmbv++QWUCuJxXBS7bxYo0oLDjpSIr
         SqI2tIZW082oufaZLDWOrW/8m3DfpUZzOe949JLCmL4fbITAXcteER5p4OZGINxxB5
         vE0qHonLLtpZQ==
Received: by mail-lf1-f51.google.com with SMTP id y15so17969008lfa.7;
        Tue, 28 Mar 2023 16:59:13 -0700 (PDT)
X-Gm-Message-State: AAQBX9e9NMt9Yerw5mIJCVRxmJT8/iJ9fDfqfCjWvxpKIEFGOqOWkCWd
        3wAQ83fApowtmH61xyAlsLIdd2bbuSbMC3T/Vbg=
X-Google-Smtp-Source: AKy350YbrjYclmVhV0j1n7mZbByxXKtbnVAmnJcTWPqxpv6BuqIqu0kDvRzeody5bGDgfItmFOQpSZTilNi3xkQH2po=
X-Received: by 2002:ac2:5338:0:b0:4eb:1316:a2e6 with SMTP id
 f24-20020ac25338000000b004eb1316a2e6mr2124951lfh.3.1680047951477; Tue, 28 Mar
 2023 16:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
 <20230322064122.2384589-2-yukuai1@huaweicloud.com> <2c2599ec-ac35-6494-aedf-93ecca1969ee@linux.dev>
 <d1d27b2a-96ec-319e-4690-64e781c9a473@huaweicloud.com> <b91ae03a-14d5-11eb-8ec7-3ed91ff2c59e@linux.dev>
 <31e7f59e-579a-7812-632d-059ed0a6d441@huaweicloud.com> <3fc2a539-e4cc-e057-6cf0-da7b3953be6e@linux.dev>
 <3aa073e9-5145-aae2-2201-5ba48c09c693@huaweicloud.com>
In-Reply-To: <3aa073e9-5145-aae2-2201-5ba48c09c693@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Mar 2023 16:58:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7c2b4yYbwNcqKW+TBL=QYEzchnVQ4pDLBT-xoBoTvQmg@mail.gmail.com>
Message-ID: <CAPhsuW7c2b4yYbwNcqKW+TBL=QYEzchnVQ4pDLBT-xoBoTvQmg@mail.gmail.com>
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Marc Smith <msmith626@gmail.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:32=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2023/03/23 11:50, Guoqing Jiang =E5=86=99=E9=81=93:
>
> > Combined your debug patch with above steps. Seems you are
> >
> > 1. add delay to action_store, so it can't get lock in time.
> > 2. echo "want_replacement"**triggers md_check_recovery which can grab l=
ock
> >      to start sync thread.
> > 3. action_store finally hold lock to clear RECOVERY_RUNNING in reap syn=
c
> > thread.
> > 4. Then the new added BUG_ON is invoked since RECOVERY_RUNNING is clear=
ed
> >      in step 3.
>
> Yes, this is exactly what I did.
>
> > sync_thread can be interrupted once MD_RECOVERY_INTR is set which means
> > the RUNNING
> > can be cleared, so I am not sure the added BUG_ON is reasonable. And
> > change BUG_ON
>
> I think BUG_ON() is reasonable because only md_reap_sync_thread can
> clear it, md_do_sync will exit quictly if MD_RECOVERY_INTR is set, but
> md_do_sync should not see that MD_RECOVERY_RUNNING is cleared, otherwise
> there is no gurantee that only one sync_thread can be in progress.
>
> > like this makes more sense to me.
> >
> > +BUG_ON(!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
> > +!test_bit(MD_RECOVERY_INTR, &mddev->recovery));
>
> I think this can be reporduced likewise, md_check_recovery clear
> MD_RECOVERY_INTR, and new sync_thread triggered by echo
> "want_replacement" won't set this bit.
>
> >
> > I think there might be racy window like you described but it should be
> > really small, I prefer
> > to just add a few lines like this instead of revert and introduce new
> > lock to resolve the same
> > issue (if it is).
>
> The new lock that I add in this patchset is just try to synchronize idle
> and forzen from action_store=EF=BC=88patch 3), I can drop it if you think=
 this
> is not necessary.
>
> The main changes is patch 4, new lines is not much and I really don't
> like to add new flags unless we have to, current code is already hard
> to understand...
>
> By the way, I'm concerned that drop the mutex to unregister sync_thread
> might not be safe, since the mutex protects lots of stuff, and there
> might exist other implicit dependencies.
>
> >
> > TBH, I am reluctant to see the changes in the series, it can only be
> > considered
> > acceptable with conditions:
> >
> > 1. the previous raid456 bug can be fixed in this way too, hopefully Mar=
c
> > or others
> >      can verify it.
> > 2. pass all the tests in mdadm

AFAICT, this set looks like a better solution for this problem. But I agree
that we need to make sure it fixes the original bug. mdadm tests are not
in a very good shape at the moment. I will spend more time to look into
these tests.

Thanks,
Song
