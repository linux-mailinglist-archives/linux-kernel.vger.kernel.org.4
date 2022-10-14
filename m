Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8616F5FE698
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJNBdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJNBdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22C19B661
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A750061653
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132ACC433B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665711183;
        bh=qI2JqxHHxDjqMhKzLnjI3LF8LTergtK4cDm9p816kik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n5u6A2cj2SU9jBbrpf6KHBXUrLrt7oQRLCYqidoQ860XZH1iqVwDmN4xCHZMUs5IO
         EyqyMJRBE3CgSQDebOUryaW9ly5JS5IpP0ywiXCYG3KUmou129R7z5NNZ76KjQNRJv
         yHoEZ5XtAJpiIUDPq6N+pDslMx1ti5xM2pTDPOKwTzAbHleGynl9iXfpnlbdjk/kBf
         USwH7J+BkzSjy4G0UBfaxHyuyN0K3GnuIYVt/sayEAriA1AkkB/sLm1dhwp5C7ta+A
         OZLBp6nz5uGI7EtgFS8j8WRRx6u7BYJU7aN9WjFAfMfiCrwYWrRzQ7JEcmFhzW3IX1
         LaE5J71y83L+g==
Received: by mail-ej1-f52.google.com with SMTP id a26so7550711ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:33:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf1A764FBgJcthC7QnQWR40sG1PD3s9ffORG0TE95ktkCJd7x6TH
        zs7DnPpDmC1sHnUaT9ZP8rVI01IAozLNT6e1Drg=
X-Google-Smtp-Source: AMsMyM5gQuF527t2wWp4WbtMsnxR85EtQMK0+yzpOGzN0znioqhz8d4nGMTCqHQPQcYUyOgta8AEOLaBdXhn7AsQgP4=
X-Received: by 2002:a17:907:7f05:b0:78d:e869:f2fe with SMTP id
 qf5-20020a1709077f0500b0078de869f2femr1677590ejc.684.1665711181275; Thu, 13
 Oct 2022 18:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221013131209.775969-1-yangyingliang@huawei.com>
 <CAAhV-H48bH5VAYhsMvupUSWouAUR=s9b4hJYdJYdymCYbKQfjA@mail.gmail.com> <b2dcb989-4bda-8921-a5a0-7ea29d6382ad@huawei.com>
In-Reply-To: <b2dcb989-4bda-8921-a5a0-7ea29d6382ad@huawei.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 14 Oct 2022 09:32:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7WwKyUUyPMsYQ0u3QNWVRo3hvUt30qXJ+e5rpE7Giotw@mail.gmail.com>
Message-ID: <CAAhV-H7WwKyUUyPMsYQ0u3QNWVRo3hvUt30qXJ+e5rpE7Giotw@mail.gmail.com>
Subject: Re: [PATCH] platform/loongarch: laptop: fix possible UAF in generic_acpi_laptop_init()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, lvjianmin@loongson.cn,
        chenhuacai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 9:23 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Hi, Huacai
>
> On 2022/10/13 23:47, Huacai Chen wrote:
> > Hi, Yingliang,
> >
> > Thank you for your patches, but could you please merge the two trivial
> > patches to a single one?
> It's OK to merge them into a single one in v2.
> But the two patches solved different things, they are not relative.
You can title it with "Simplify and improve generic_subdriver_init()" or so.

Huacai
>
> Thanks,
> Yang
> >
> > Huacai
> >
> > On Thu, Oct 13, 2022 at 9:12 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >> Current the return value of 'sub_driver->init' is not checked,
> >> if sparse_keymap_setup() called in the init function fails,
> >> 'generic_inputdev' is freed, then it willl lead a UAF when
> >> using it in generic_acpi_laptop_init(). Fix it by checking
> >> return value. Set generic_inputdev to NULL after free to avoid
> >> double free it.
> >>
> >> Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >> ---
> >>   drivers/platform/loongarch/loongson-laptop.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
> >> index f0166ad5d2c2..a665fd1042ac 100644
> >> --- a/drivers/platform/loongarch/loongson-laptop.c
> >> +++ b/drivers/platform/loongarch/loongson-laptop.c
> >> @@ -448,6 +448,7 @@ static int __init event_init(struct generic_sub_driver *sub_driver)
> >>          if (ret < 0) {
> >>                  pr_err("Failed to setup input device keymap\n");
> >>                  input_free_device(generic_inputdev);
> >> +               generic_inputdev = NULL;
> >>
> >>                  return ret;
> >>          }
> >> @@ -502,8 +503,11 @@ static int __init generic_subdriver_init(struct generic_sub_driver *sub_driver)
> >>          if (ret)
> >>                  return -EINVAL;
> >>
> >> -       if (sub_driver->init)
> >> -               sub_driver->init(sub_driver);
> >> +       if (sub_driver->init) {
> >> +               ret = sub_driver->init(sub_driver);
> >> +               if (ret)
> >> +                       goto err_out;
> >> +       }
> >>
> >>          if (sub_driver->notify) {
> >>                  ret = setup_acpi_notify(sub_driver);
> >> --
> >> 2.25.1
> >>
> > .
