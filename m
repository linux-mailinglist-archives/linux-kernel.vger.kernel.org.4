Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B619770E432
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjEWSFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbjEWSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578FBF;
        Tue, 23 May 2023 11:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E7B61A78;
        Tue, 23 May 2023 18:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61082C433A0;
        Tue, 23 May 2023 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684865133;
        bh=b3t5Gx+ugyIRyjbDZAA94kYedVCnqDFkf41gqK2qYjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ucCaNAWNQC1uXle8eDxFS7C294anKuz/5c5d8+ghTp8DcMDtkAegjQjZ6fQh8SXWJ
         tIN9Z971Dnjlb1buE+4x14s78wTRgMvuCaxphswbBXbzI/5/BG7mtQyQq7ZNFWL1Xx
         nile7rqqsp+nU/VRzgjcRjVq3Rom2KtLl0Cg0rcAN7RNJ4XuzGS0+EeMo0GRy0NZaQ
         /s1OK86Ftp7MHC7dTqx8KKTXpFfQ8o+eEmTBiuqdrnouHeKKUU1atx01tsUq+5waB1
         ZUJNppN550OhORmjlFlsG6fjH5Rh6wn7s29LVygJpIydoqCXfYMQ02B1VY5PPpnesA
         DBomrhAgVOtAw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2afb2874e83so1813681fa.0;
        Tue, 23 May 2023 11:05:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDxudfZhljxj9ushSFJG42qI42BwFgFUO9rBy4/3Iynk776R3/JP
        ED5eIsGluRRa/13+P3OSg497yyiaasGA/rbD0xw=
X-Google-Smtp-Source: ACHHUZ7LSYfnYGogDK37Or8AN1sbRimvTaumCalpLufljag3TafLAnqMLMRYMOKZ8oh+fCotj0fenuvVABE4bd1jQFU=
X-Received: by 2002:a2e:8743:0:b0:2b0:2f2f:4954 with SMTP id
 q3-20020a2e8743000000b002b02f2f4954mr1421164ljj.44.1684865131245; Tue, 23 May
 2023 11:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230523012727.3042247-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230523012727.3042247-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 May 2023 11:05:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5AERnf5D4804ksgZEB2ZP7gVAG8f5Fghwnn0FKseBG+g@mail.gmail.com>
Message-ID: <CAPhsuW5AERnf5D4804ksgZEB2ZP7gVAG8f5Fghwnn0FKseBG+g@mail.gmail.com>
Subject: Re: [PATCH v3] md: fix duplicate filename for rdev
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     pmenzel@molgen.mpg.de, akpm@linux-foundation.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Mon, May 22, 2023 at 6:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device
> from an md array via sysfs") delays the deletion of rdev, however, this
> introduces a window that rdev can be added again while the deletion is
> not done yet, and sysfs will complain about duplicate filename.
>
> Follow up patches try to fix this problem by flushing workqueue, however,
> flush_rdev_wq() is just dead code, the progress in
> md_kick_rdev_from_array():
>
> 1) list_del_rcu(&rdev->same_set);
> 2) synchronize_rcu();
> 3) queue_work(md_rdev_misc_wq, &rdev->del_work);
>
> So in flush_rdev_wq(), if rdev is found in the list, work_pending() can
> never pass, in the meantime, if work is queued, then rdev can never be
> found in the list.
>
> flush_rdev_wq() can be replaced by flush_workqueue() directly, however,
> this approach is not good:
> - the workqueue is global, this synchronization for all raid disks is
>   not necessary.
> - flush_workqueue can't be called under 'reconfig_mutex', there is still
>   a small window between flush_workqueue() and mddev_lock() that other
>   contexts can queue new work, hence the problem is not solved completely=
.
>
> sysfs already has apis to support delete itself through writer, and
> these apis, specifically sysfs_break/unbreak_active_protection(), is used
> to support deleting rdev synchronously. Therefore, the above commit can b=
e
> reverted, and sysfs duplicate filename can be avoided.
>
> A new mdadm regression test is proposed as well([1]).
>
> [1] https://lore.kernel.org/linux-raid/20230428062845.1975462-1-yukuai1@h=
uaweicloud.com/
> Fixes: 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device=
 from an md array via sysfs")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Thanks for the fix! I made the following changes and applied it
to md-next:

1. remove md_rdev->del_work, which is not used any more;
2. change list_empty_safe to list_empty protected by the mutex, as
   list_empty_safe doesn't seem safe here.

Please let me know if either change doesn't make sense.

Thanks,
Song
