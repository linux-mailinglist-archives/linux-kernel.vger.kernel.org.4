Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3660702C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJUGjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJUGj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:39:28 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CD6272
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:39:25 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id t16so1236863qvm.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWBVsxHhiv9xCEiXFNrEhpq+HZmBy55Vo5JJjjlyPeI=;
        b=cU5Qu2ClpzMDSEboebGlxnVVTBdQlxVVsy1wmFAWgLKfLVBayQ5ghBu/+HfjqdJyM/
         l6OGGl6wm/ct4fICI8qFGX30FkG+Km+UY6/lBW9z313JEb4IfZrclZjEIdFBA+NQqUVv
         qu4g+ctOOEAOy/645Rrvhy7c3gjjC42VomUOkEDpUBUFPebjRNZvE4+fqpk06Dkel/Hi
         3cLeMAmx8Z4QMjsP+w31K8PzTyigZ8Nt4hShQn/e9F1aKL/xATpOkwTujymg4aqr4Y1O
         MlYGT014R+4yVXw0ZOvRLqwm26W7Qj8AJvhmhbVd0KfAQYhTu04ajDQYEkQ2NFwElJRM
         vqjA==
X-Gm-Message-State: ACrzQf0ovIMfo1MV4OvBoZae9MggygYEKCweDQt1L0GccsdX5HXvTS35
        YzP8Ymtob3g7skBnee67UkbpUqA8BbO5Ng==
X-Google-Smtp-Source: AMsMyM5Wbnf1EqjAKujyusoUrMxmnau8ilXzlXH/KJqMVLXaaoQRxoU0j+ji/FgxiuHjRXjtlDn8hA==
X-Received: by 2002:a0c:cd13:0:b0:4b3:beaa:83b with SMTP id b19-20020a0ccd13000000b004b3beaa083bmr15712436qvm.129.1666334364034;
        Thu, 20 Oct 2022 23:39:24 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id r19-20020a05622a035300b00398313f286dsm7725490qtw.40.2022.10.20.23.39.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 23:39:23 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-369426664f9so14712547b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:39:23 -0700 (PDT)
X-Received: by 2002:a81:a24e:0:b0:358:934b:980c with SMTP id
 z14-20020a81a24e000000b00358934b980cmr15019528ywg.383.1666334363332; Thu, 20
 Oct 2022 23:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <202210201612.9d7547bf-yujie.liu@intel.com> <Y1FzKVLlLPrhb47D@yury-laptop>
 <Y1GHthWAyAq2Q+Yz@yujie-X299>
In-Reply-To: <Y1GHthWAyAq2Q+Yz@yujie-X299>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Oct 2022 08:39:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtXzO+gv7g+0kRgj2LnV27Jn8Ehv1H4KH3CBSuwen+zg@mail.gmail.com>
Message-ID: <CAMuHMdWtXzO+gv7g+0kRgj2LnV27Jn8Ehv1H4KH3CBSuwen+zg@mail.gmail.com>
Subject: Re: [lib/cpumask] 6f9c07be9d: WARNING:at_include/linux/cpumask.h:#prefill_possible_map
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, lkp@lists.01.org, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        feng.tang@intel.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yukie,

On Thu, Oct 20, 2022 at 7:40 PM Yujie Liu <yujie.liu@intel.com> wrote:
> On Thu, Oct 20, 2022 at 09:11:21AM -0700, Yury Norov wrote:
> > On Thu, Oct 20, 2022 at 06:05:51PM +0800, kernel test robot wrote:
> > > We noticed that below patch adds a FORCE_NR_CPUS config, and it is
> > > expected to show a warning when this config is enabled and
> > > CONFIG_NR_CPUS doesn't match the actual number of CPUs we have. But we
> > > also noticed that it not only shows a warning but could also break boot
> > > test in some cases. We are not sure if the break is actually related to
> > > this patch or not, so we send this report FYI.
> > >
> > > We noticed that a fix patch was posted at:
> > >
> > > https://lore.kernel.org/all/20221019225939.1646349-1-yury.norov@gmail.com/
> > >
> > > FORCE_NR_CPUS won't be enabled by allmodconfig or allyesconfig after
> > > applying the fix, but looks it could still be enabled by randconfig. Not
> > > sure if this is an expected behavior, but since our test robot runs many
> > > randconfig tests, this warning could still be triggered frequently and
> > > go to boot failure at last.
> > >
> > > Please kindly help to give some advice on handling this config in our
> > > testing. Thanks.
> > >
> > > Please check below report for more details:

> > Indeed, if FORCE_NR_CPUS is enabled by randconfig, it may cause at least
> > boot warning. I'm either not sure if the following alloc_pages is
> > related to the config, but anyways...
> >
> > The most logical solution would be disabling FORCE_NR_CPUS in
> > randconfig before building the kernel. We can do it in a post-script,
> > like:
> >
> > make randconfig
> > scripts/config -d FORCE_NR_CPUS
> > scripts/config -e UNFORCE_NR_CPUS
> > make
>
> This seems to need extra work to run config script for each randconfig
> build.

While randconfig is great for doing build tests, I would not use it
for boot tests, until you have some way to make sure critical options
are enabled (or disabled).  A plain randconfig kernel is almost
guaranteed to lack some driver you need.

> > Or we can create a pre-configuration file, so that randconfig would do
> > its work based on that. We already have such pre-configs for powerpc
> > and risc:
> >         arch/riscv/configs/32-bit.config
> >         arch/powerpc/configs/32-bit.config
> >         arch/powerpc/configs/64-bit.config
> >         arch/riscv/configs/64-bit.config
> >
> > Maybe it's time to create a generic config of this sort.
>
> It would be nice to have a pre-config file to ensure this config won't
> be enabled accidentally by randconfig if users are not aware of. This
> would also be consistent with common build flow so no extra steps are
> needed.

The above configs don't contain any options controlling included
drivers.
Which options would you add to it? This is very platform-specific.

> > Please let me know if that sounds sane to you. I'm not very familiar
> > to build system things, but I'll be happy to help implementing this,
> > if needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
