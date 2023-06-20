Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF75737324
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFTRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFTRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DE1737;
        Tue, 20 Jun 2023 10:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 726B961349;
        Tue, 20 Jun 2023 17:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A73C433C0;
        Tue, 20 Jun 2023 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687283144;
        bh=EeaznO+5npE/ee/8pXl1M4Dwk8jMVEieFQAc0R5JPlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ED7SwzXsGiaz6GOhSz/GZar7UzTfRGVqVhgS+FKmVyULbZ4uRM58c+q2gPDUYHcEn
         KDafi6ZOB2c+wWu0t7QgtcRjKOkvOUH4CBeLN4YJQB2fa7ZDx3BuYalqzslkSdudWf
         0ZHJciPMGNFAAP2k9Wweb9Jp/OJtBsdI0a/RZ4FmI/s4wnFGHXglEaAL/SJ8ZRhSG8
         25uwsmzo2APDF4eRZR0a8ya4/zhaLNlB/VduPEdd2KmqhbB44GCHQcD+WgfauvR+A3
         jV5arj61rwKbbLI4IZFyzKH5reNiNZhR8WORHEoZIcRGnyKu/8PP5AhUOSMQSlemmh
         qFX1p8lM2Nq4Q==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b475b54253so40845371fa.2;
        Tue, 20 Jun 2023 10:45:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDxDa9qKieF7hcXdnhUz/YmgtI9IFvBDtuj8jOp3XqHW46bid0Pr
        IWV8Cz8GRVfW6oJnMSQLmTdmoxURg5KDIr2h5jE=
X-Google-Smtp-Source: ACHHUZ4jFLWFSKFnc24kJ85aTtH7vu96WwjMnmGd7qzzpUc1cg34XTk/EaePf3/mC/4ePWldCKzvwwkHj/gAYYsnmfI=
X-Received: by 2002:a2e:7819:0:b0:2b4:7fc5:21ab with SMTP id
 t25-20020a2e7819000000b002b47fc521abmr3789343ljc.51.1687283142838; Tue, 20
 Jun 2023 10:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 20 Jun 2023 10:45:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW42vR2vLniY+GN-iLwo0dFDCWf69--ahXbee0HrF7kq6w@mail.gmail.com>
Message-ID: <CAPhsuW42vR2vLniY+GN-iLwo0dFDCWf69--ahXbee0HrF7kq6w@mail.gmail.com>
Subject: Re: [PATCH -next 0/8] md: fix and refactor io accounting and 'active_io'
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Mon, Jun 19, 2023 at 5:49=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> This patchset do following things:
>  - make io accounting for all raid levels consistent, patch 1, 3-5;
>  - enable io accounting for all raid levels, patch 6-8;
>  - hold 'active_io' before io start to dispatch, and release 'active_io'
>  when io is done, make mddev_suspend() will wait for io to be done, patch=
 2

This set looks good to me (pending more tests). Please respin with
feedback from folks. We need to move fast to catch the upcoming
merge window.

Thanks,
Song
