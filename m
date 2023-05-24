Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1570FC97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjEXRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjEXRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A671B5;
        Wed, 24 May 2023 10:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B3C263FA5;
        Wed, 24 May 2023 17:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AFAC433D2;
        Wed, 24 May 2023 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684948914;
        bh=H23kapb5DNJcM15IBsjyR2uv9rZz+iynRivlE9lYlMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qwc5bGgK2asPU9lvbt3S5yi+LsxVDWG3KPVhXcKbxQE8y1EVaGyp9bemMoBGuyJ1P
         r428M49VAab29Zibu8PSCHTqtwEvkzlk4/X6/QDlwOOuWPkjvdtvpRkSZOKlLHxz9F
         I0FbYGwY6dQcMWK/BEJ/o1vR8o2VRsgS8N0F0nZ03bpWMqMDfgUPqw9lET2BqT70n2
         jDuJ3lD4fyIossCWtJMaWTV/AFadq588uQA6N7K+56jS7SWJw7/oJqDk7oA0H8qD8R
         e45G6BXxFzgAw7R5dUtjGRW71ySzm5qkFD7HQPehDJbrpFbCCAsyZVZoPGfDp07cb7
         O6vC0JBLXNfRA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2af1e290921so15095601fa.3;
        Wed, 24 May 2023 10:21:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDxr7QnswsC4W/+4N7FR5sVdccEyoUkQOTLhFZHpRPg5LAyqtG+R
        gliE0qrm3bX9WMUncCWD4cV1UqeUi9jAgOmddEA=
X-Google-Smtp-Source: ACHHUZ4UxcgUge7e2vehx/UJslCfpAsV6h46GEpEQUu2lMlqj2aKLN0pWdcnM5M6hNytbVjJQ+U8zKflE1Fdyvi7ktE=
X-Received: by 2002:a2e:8890:0:b0:2ac:8e5a:1054 with SMTP id
 k16-20020a2e8890000000b002ac8e5a1054mr183971lji.0.1684948912038; Wed, 24 May
 2023 10:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230524014118.3172781-1-yukuai1@huaweicloud.com> <7075bfd8-7c52-a778-5651-71ade3cd1f03@kernel.dk>
In-Reply-To: <7075bfd8-7c52-a778-5651-71ade3cd1f03@kernel.dk>
From:   Song Liu <song@kernel.org>
Date:   Wed, 24 May 2023 10:21:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5cBZUdBFM7jdfP11ev5UpQX_YCe_EmR+A1B4XgSrw+-w@mail.gmail.com>
Message-ID: <CAPhsuW5cBZUdBFM7jdfP11ev5UpQX_YCe_EmR+A1B4XgSrw+-w@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: fix miscalculation of 'end_sector' in raid5_read_one_chunk()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
        chaitanya.kulkarni@wdc.com, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, linux-raid@vger.kernel.org,
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

On Wed, May 24, 2023 at 8:03=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/23/23 7:41=E2=80=AFPM, Yu Kuai wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > 'end_sector' is compared to 'rdev->recovery_offset', which is offset to
> > rdev, however, commit e82ed3a4fbb5 ("md/raid6: refactor
> > raid5_read_one_chunk") changes the calculation of 'end_sector' to offse=
t
> > to the array. Fix this miscalculation.
> >
> > Fixes: e82ed3a4fbb5 ("md/raid6: refactor raid5_read_one_chunk")
>
> This needs a stable tag as well, Fixes alone is not enough to guarantee
> it ends up in stable.
>
> Song, are you picking this up?

Yes, I will test it and send it via md-fixes.

Thanks,
Song
