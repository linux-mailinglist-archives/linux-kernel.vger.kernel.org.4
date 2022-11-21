Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282B63298A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKUQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiKUQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:32:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D480B26;
        Mon, 21 Nov 2022 08:32:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7BF5B8114D;
        Mon, 21 Nov 2022 16:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A655BC433C1;
        Mon, 21 Nov 2022 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669048345;
        bh=iTyQ6oW9PS2870YEdN16DxwGc5vOzwMA9nRCe4hOR0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qZ4jSJx1uAC8xWkW9Zvu8I8CQWPMG89KTNIqXU3xnN97M85BCmZHEgQnwwIIFkTmy
         wKX7rq56fkxprAwVQwdtam8mUSeuFSKNPGsVL+L8ZQ9Sg83SoaqMdN8HDAta41v8No
         quZNL7c9hj8NdHl5sQ2n6WZhIUyFaTLoeCL3OqtnvrtnqzUpBDuLu6s66fWUbyhAuj
         AprDzf27Fbm31vLxFfJ/jT29hRLiixOoxUnxdti8W3g/T8UyS2audVYfVKTNuAwzHB
         lq1rf8pUH5nvsziXsGxAJcNl5RNVIr2+NEiT5y8CI4+jQsCOX5vxHqLa0Fq+KZum/z
         3LKBB/DGBLAwA==
Received: by mail-ed1-f54.google.com with SMTP id v8so5995871edi.3;
        Mon, 21 Nov 2022 08:32:25 -0800 (PST)
X-Gm-Message-State: ANoB5pmIiCimyJ9je1F8jVw/f6PbL3WQNAJ/biG1qhLpU8go0g/Epl4I
        BBK3ZmX1/1yGc+wWLwmqob1MTQmL4O9DYwH2NH8=
X-Google-Smtp-Source: AA0mqf59hdeFp3pfAA6MPvqNEA/WxDhlx0M4qlJP7fkbFsr3sIG7IKu3IWfapn6h1JA3P61AE5bZKmmM04cQpaXJIhw=
X-Received: by 2002:aa7:ccd3:0:b0:468:f345:aa4a with SMTP id
 y19-20020aa7ccd3000000b00468f345aa4amr16363516edt.412.1669048343933; Mon, 21
 Nov 2022 08:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20220901171252.2148348-1-song@kernel.org> <Y3expGRt4cPoZgHL@alley>
 <CAPhsuW4MaiJBTNnwVhqkmxPxBn8e1cn9PPGm9PkgF6YaO0AWKQ@mail.gmail.com> <09ac46a0-45fe-e280-cabb-682e05c7fddc@redhat.com>
In-Reply-To: <09ac46a0-45fe-e280-cabb-682e05c7fddc@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Nov 2022 09:32:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4OTB+_nq6oRuyY1=sA00ik7X19W2TwoYL7WVDBccZxrw@mail.gmail.com>
Message-ID: <CAPhsuW4OTB+_nq6oRuyY1=sA00ik7X19W2TwoYL7WVDBccZxrw@mail.gmail.com>
Subject: Re: [PATCH v6] livepatch: Clear relocation targets on a module removal
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 8:32 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> On 11/18/22 12:14 PM, Song Liu wrote:
> > Hi Petr,
> >
> > On Fri, Nov 18, 2022 at 8:24 AM Petr Mladek <pmladek@suse.com> wrote:
> >>
> >> On Thu 2022-09-01 10:12:52, Song Liu wrote:
> > [...]
> >>>
> >>>  arch/powerpc/kernel/module_32.c |  10 ++++
> >>>  arch/powerpc/kernel/module_64.c |  49 +++++++++++++++
> >>>  arch/s390/kernel/module.c       |   8 +++
> >>>  arch/x86/kernel/module.c        | 102 +++++++++++++++++++++++---------
> >>>  include/linux/moduleloader.h    |   7 +++
> >>>  kernel/livepatch/core.c         |  41 ++++++++++++-
> >>
> >> First, thanks a lot for working on this.
> >>
> >> I can't check or test the powerpc and s390 code easily.
> >>
> >> I am going to comment only x86 and generic code. It looks good
> >> but it needs some changes to improve maintainability.
> >
> > Thanks for these comments and suggestions. I will work on them
> > and send v4.
> >
>
> Hi Song,
>
> I'll help with testing the arches (at least ppc64le and s390x, I can
> only cross-build ppc32).  I can either pick up the patches from the list
> when you post, or if you want to run them through testing first, lmk.

Thanks Joe!

I am on vacation this week. I will pick this up next week.

Song
