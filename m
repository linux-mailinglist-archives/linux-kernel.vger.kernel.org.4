Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54B6B8729
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCNAoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCNAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A6765C40;
        Mon, 13 Mar 2023 17:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32109B816D9;
        Tue, 14 Mar 2023 00:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDBFC4339C;
        Tue, 14 Mar 2023 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678754571;
        bh=aP1kWzeFR2N4AdJC9C5+mL2TVxDe/IY9no0xXZaHp5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mjdzEtDKeW6VCE4SYht1PGtz42WoaYnTZrfJoBhDoG0B43L3zF858dAmnze3Cqc6x
         eqhRmw+ZDvSJ0fM/XRi8DYnyn+vHIYiXMngKYCAnHaz8Q863lkzXqbEmfhevd4rcID
         V+bfGUpkRjfdNLWKhA1/F3x2YUa7AH02qsy8rSKZ8xjejGSjGqj/mQMUmFvDG7mZsN
         d430AmJwRfIPwvBFVDkjohvAyhyc5qEweCA1jeJaQPVRJolfiWkXhY44AZTwvOyCv9
         RlzEIBiNHqog89BDBRLl30kY3DFbhyPfuQK20qTU+O8IuHLfGCHfvjUz/ftYbDv6sF
         aU9YXvJBKXVRQ==
Received: by mail-lf1-f46.google.com with SMTP id d36so17925081lfv.8;
        Mon, 13 Mar 2023 17:42:50 -0700 (PDT)
X-Gm-Message-State: AO0yUKXlkBl7OfJv481aCU9rtqclJVdguQTaeQB/1nahL9G6QenfCscB
        FFxAYMjTTldWKNzxY4nFIKQ7C+/lNNw8ejk0+zA=
X-Google-Smtp-Source: AK7set9Fu5cm3TR1FI95fKslcaie7BK6VR4qAOHSeumRUn02yLDo51sD0TAlZDLf2UBuwriaL9oVxZUC1BjuVJWFk6w=
X-Received: by 2002:ac2:4c84:0:b0:4d5:ca32:9bd7 with SMTP id
 d4-20020ac24c84000000b004d5ca329bd7mr141768lfl.3.1678754568986; Mon, 13 Mar
 2023 17:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Mar 2023 17:42:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7dTMBfb=ncQQE7m7vE_fL6dy4mSFCprGsvH8LsGLe1pQ@mail.gmail.com>
Message-ID: <CAPhsuW7dTMBfb=ncQQE7m7vE_fL6dy4mSFCprGsvH8LsGLe1pQ@mail.gmail.com>
Subject: Re: [PATCH -next 0/5] md: fix uaf for sync_thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Sat, Mar 11, 2023 at 1:32=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Our test reports a uaf for 'mddev->sync_thread':
>
> T1                      T2
> md_start_sync
>  md_register_thread
>                         raid1d
>                          md_check_recovery
>                           md_reap_sync_thread
>                            md_unregister_thread
>                             kfree
>
>  md_wakeup_thread
>   wake_up
>   ->sync_thread was freed
>
> Currently, a global spinlock 'pers_lock' is borrowed to protect
> 'mddev->thread', this problem can be fixed likewise, however, there might
> be similar problem for other md_thread, and I really don't like the idea =
to
> borrow a global lock.
>
> This patchset do some refactor, and then use a disk level spinlock to
> protect md_thread in relevant apis.
>
> Yu Kuai (5):
>   md: pass a md_thread pointer to md_register_thread()
>   md: refactor md_wakeup_thread()
>   md: use md_thread api to wake up sync_thread
>   md: pass a mddev to md_unregister_thread()
>   md: protect md_thread with a new disk level spin lock

Applied to md-next.

Thanks,
Song
