Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E77327C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbjFPGmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjFPGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF251FE5;
        Thu, 15 Jun 2023 23:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C95960C85;
        Fri, 16 Jun 2023 06:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BC1C433C8;
        Fri, 16 Jun 2023 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686897717;
        bh=Ro4WZCLClSIUhQJstNEKJQAQNJma+nBXsYqzw56HSbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJHQAuLzg8rT6Rz5PoxBTo/ohMhhVqVbg40Xx+csbb4iN768rMIlFkO4J3mYuRxAd
         HfIrY/ZiuY/JHBWzRzHnryUnOAn3CvJDoD7x7ekHfbN7luN0AABZcEuWGUnBEbXsjL
         UYTZyRXcnL8xmlxCa0LogLOmdxCb9q8w2fBG/2qfjirYaUR1a4M9hGSkG3QGnE+cRN
         8WS3djYEY2UyMRiWIG8dfU7EdT2MW6u7Wntcxon5VnfDrFAVVxMuR7SpXRvc6NgBE8
         9S3eodvxlSFjoLXzU2y8VkwsrPKkq9HxiO9TB1RbUPXLIWBbqYlLuFe8orA13/ul8/
         pyEMX9v2jc/zg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso354913e87.3;
        Thu, 15 Jun 2023 23:41:57 -0700 (PDT)
X-Gm-Message-State: AC+VfDxH2hVIiiAt7kJSKunxiH+53IJZMqp2It1YKk0MH0KPlOk7jIDB
        IsY0jkC/l5okRoGTmlTECJYx3chQJzFxP6hXcWE=
X-Google-Smtp-Source: ACHHUZ4Wg122FV+dsoalr3CT9nTUFfF3JCY4jxnldzEwjXLvc+KYP8fZMeQfaopTPmrrq1uIutQVSMBQWMKoG3YHqTQ=
X-Received: by 2002:a19:660a:0:b0:4f6:424c:4fa8 with SMTP id
 a10-20020a19660a000000b004f6424c4fa8mr493140lfc.17.1686897715724; Thu, 15 Jun
 2023 23:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-4-yukuai1@huaweicloud.com> <c96f2604-e1ef-c3ad-9d15-5e0efa5f222b@redhat.com>
 <254fc651-aa75-074d-f567-49bafc437e9c@huaweicloud.com>
In-Reply-To: <254fc651-aa75-074d-f567-49bafc437e9c@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 15 Jun 2023 23:41:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5nyv0=e3WR+B4gQmHo9O0cDBmzpEOZwXTLbvPzjX5iDw@mail.gmail.com>
Message-ID: <CAPhsuW5nyv0=e3WR+B4gQmHo9O0cDBmzpEOZwXTLbvPzjX5iDw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH -next v2 3/6] md: add a mutex to synchronize
 idle and frozen in action_store()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Xiao Ni <xni@redhat.com>, guoqing.jiang@linux.dev, agk@redhat.com,
        snitzer@kernel.org, dm-devel@redhat.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 6:15=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/13 22:43, Xiao Ni =E5=86=99=E9=81=93:
> >
> > =E5=9C=A8 2023/5/29 =E4=B8=8B=E5=8D=889:20, Yu Kuai =E5=86=99=E9=81=93:
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Currently, for idle and frozen, action_store will hold 'reconfig_mutex=
'
> >> and call md_reap_sync_thread() to stop sync thread, however, this will
> >> cause deadlock (explained in the next patch). In order to fix the
> >> problem, following patch will release 'reconfig_mutex' and wait on
> >> 'resync_wait', like md_set_readonly() and do_md_stop() does.
> >>
> >> Consider that action_store() will set/clear 'MD_RECOVERY_FROZEN'
> >> unconditionally, which might cause unexpected problems, for example,
> >> frozen just set 'MD_RECOVERY_FROZEN' and is still in progress, while
> >> 'idle' clear 'MD_RECOVERY_FROZEN' and new sync thread is started, whic=
h
> >> might starve in progress frozen. A mutex is added to synchronize idle
> >> and frozen from action_store().
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c | 5 +++++
> >>   drivers/md/md.h | 3 +++
> >>   2 files changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 23e8e7eae062..63a993b52cd7 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -644,6 +644,7 @@ void mddev_init(struct mddev *mddev)
> >>       mutex_init(&mddev->open_mutex);
> >>       mutex_init(&mddev->reconfig_mutex);
> >>       mutex_init(&mddev->delete_mutex);
> >> +    mutex_init(&mddev->sync_mutex);
> >>       mutex_init(&mddev->bitmap_info.mutex);
> >>       INIT_LIST_HEAD(&mddev->disks);
> >>       INIT_LIST_HEAD(&mddev->all_mddevs);
> >> @@ -4785,14 +4786,18 @@ static void stop_sync_thread(struct mddev *mdd=
ev)
> >>   static void idle_sync_thread(struct mddev *mddev)
> >>   {
> >> +    mutex_lock(&mddev->sync_mutex);
> >>       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>       stop_sync_thread(mddev);
> >> +    mutex_unlock(&mddev->sync_mutex);
> >>   }
> >>   static void frozen_sync_thread(struct mddev *mddev)
> >>   {
> >> +    mutex_init(&mddev->delete_mutex);
> >
> >
> > typo error? It should be mutex_lock(&mddev->sync_mutex); ?
> >
>
> Yes, and thanks for spotting this, this looks like I did this while
> rebasing.

I fixed this one and applied the set to md-next.

Thanks,
Song
