Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA56ED810
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjDXWii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjDXWig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C877C658F;
        Mon, 24 Apr 2023 15:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A6B61DD7;
        Mon, 24 Apr 2023 22:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDFEC4339C;
        Mon, 24 Apr 2023 22:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682375914;
        bh=evOcVpwCy5DHD+rptVWH5BM9ayFOiHmM7ew5mfght2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RD68tCpxiM5jq0EqkWQlRWyxsEyUYbFXiEwUGWvl21T+60MkWysjyHwFrV7mhOEU9
         WgM9XKlwpegm1/Ryw1wy1RrbJXZQ5ZOHbQK3JNYG/908/HFoGBTE1BIfldQ4pK+VlM
         15TmqDWefKTb7ps2GfG+/pcKT7pKGZh93VOSFmqU85u493wpKX8b2IsH+t2vsvuPNt
         N/zCJR4EtdqYmc9YZ4edUwNF3oQnBLr6QhCL1KWOWYzOGu8HmtbLOkwtgSwQjzhnao
         aswEHzBKzkcDIjeOQxer6n8+SV8gnM4pvjEHTVgQpL6bns04uowUg4BnrwRiQ81aZ+
         zQ8eLjLsSxVkA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4eff50911bfso1341697e87.2;
        Mon, 24 Apr 2023 15:38:34 -0700 (PDT)
X-Gm-Message-State: AAQBX9eVKXazKDEpcUIFDmwjX4AGmSZ9SwuJI0XPQIqXM2K/a0jkGm9d
        vuuW8iCjBU6q/K/Me87wEHv0RLOtf2KKvD9XkJM=
X-Google-Smtp-Source: AKy350bd03oPgDoxJXhRz3alMs69f/8aOlpheo2UHJcn6VTzQX+1IFK8tt/wetIT9YCRjA/Wx2qU6mra+4RS/Ovq8AE=
X-Received: by 2002:ac2:5d4f:0:b0:4db:3d51:6896 with SMTP id
 w15-20020ac25d4f000000b004db3d516896mr3326186lfd.11.1682375912802; Mon, 24
 Apr 2023 15:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <961691d0-7224-caad-6c19-d9c8ca07a801@deltatee.com>
 <20230414013246.1969224-1-yukuai1@huaweicloud.com> <623c9eb9-b8e6-381f-894f-8d7b955e9651@huaweicloud.com>
In-Reply-To: <623c9eb9-b8e6-381f-894f-8d7b955e9651@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Apr 2023 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4XvTtJJ=4Xbu9-zd83OnoyJGaJronzVcn2+nKjs8G1aA@mail.gmail.com>
Message-ID: <CAPhsuW4XvTtJJ=4Xbu9-zd83OnoyJGaJronzVcn2+nKjs8G1aA@mail.gmail.com>
Subject: Re: [PATCH -next v7 5/5] md: protect md_thread with rcu
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 7:42=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/04/14 9:32, Yu Kuai =E5=86=99=E9=81=93:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > Our test reports a uaf for 'mddev->sync_thread':
> >
> > T1                      T2
> > md_start_sync
> >   md_register_thread
> >   // mddev->sync_thread is set
> >                       raid1d
> >                        md_check_recovery
> >                         md_reap_sync_thread
> >                          md_unregister_thread
> >                           kfree
> >
> >   md_wakeup_thread
> >    wake_up
> >    ->sync_thread was freed
> >
> > Root cause is that there is a small windown between register thread and
> > wake up thread, where the thread can be freed concurrently.
> >
> > Currently, a global spinlock 'pers_lock' is borrowed to protect
> > 'mddev->thread', this problem can be fixed likewise, however, there are
> > similar problems elsewhere, and use a global lock for all the cases is
> > not good.
> >
> > This patch protect all md_thread with rcu.
>
> Friendly ping... Or do I need to resend the whole patchset for v7?

Sorry for the delay. But yes, please resend the whole patchset.

Song
