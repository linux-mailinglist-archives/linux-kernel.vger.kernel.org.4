Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A968698D71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBPG4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPG4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:56:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338961F5E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C329061A1E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337A6C4339B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676530592;
        bh=KTt3PVoUKhjeVgfW8ilo26U9ErpIJj2Y4fMqhuE5aa4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FO9U3rWOhTslIIK3R2HWl0KU0SNkOYA3nKfMHU6jkDZowyqVdCVvWSkxn3kICbP0Y
         waRw8ykuSQ6pqogANMQFjHU64w9o30YJElshSJvqRCghF7EJHy/t4so5blpppc0hy4
         UCFduCZzaXjbIr7Uu2/OXMu2rOwsP58yEpT6ZKUziXKW/lej9GUMU227LliFym0syX
         gJOYSpNNqdMI83TKKEo+Sip8TzaVIIe4FjMON6ZSx2tgiWNDP6H8MAqTFhEuTjj0Pf
         h3tfmL21YUeonWqIOtMOXZEg8vNEA0DxUjL1eXFNFsnschnbGKdE3rjQWkMb4PuP80
         A1P4KloOd0X/w==
Received: by mail-ej1-f46.google.com with SMTP id ky6so2907365ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:56:32 -0800 (PST)
X-Gm-Message-State: AO0yUKUVI13W81p/Pwb36mjFnFPNhyM4shhfLh6JOvvpZWLVO3t8aWVU
        XsiPOArjEgbu7AEB4SAw8HgCP2UnqBpquGdNtM8=
X-Google-Smtp-Source: AK7set/u0QW8gGZONF9Ge49yzbkg9oekboobMtq8+hlKDYN6nhW6TOSFvd0g+jrt4fXJmjP1sBMQuFbE2GSDz56aQ88=
X-Received: by 2002:a17:906:9442:b0:87b:db53:2d7d with SMTP id
 z2-20020a170906944200b0087bdb532d7dmr2357547ejx.1.1676530590453; Wed, 15 Feb
 2023 22:56:30 -0800 (PST)
MIME-Version: 1.0
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
 <1676018856-26520-3-git-send-email-tangyouling@loongson.cn>
 <CAAhV-H4Bs5n_ek3mq6zwxAgVw0nvER1XUA+WUA8M12eKcYVPDQ@mail.gmail.com>
 <05ef2d91-ab87-b8d9-85fa-6a90a92f8f39@loongson.cn> <848e2985-9ba3-c14d-23ac-a7f1c218215f@loongson.cn>
In-Reply-To: <848e2985-9ba3-c14d-23ac-a7f1c218215f@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 16 Feb 2023 14:56:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+_1U=H3TgUUzG+aOc7ftuvn2vbwn7eC4HDv9cUhf8RQ@mail.gmail.com>
Message-ID: <CAAhV-H7+_1U=H3TgUUzG+aOc7ftuvn2vbwn7eC4HDv9cUhf8RQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] LoongArch: Use la.pcrel instead of la.abs for
 exception handlers
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin lv <lvjianmin@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:32 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Hi folks,
>
> On 02/10/2023 05:18 PM, Youling Tang wrote:
> >
> >
> > On 02/10/2023 05:09 PM, Huacai Chen wrote:
> >> Hi, Youling and Ruoyao,
> >>
> >> Thank you very much for implementing the per-node exceptions. But I
> >> want to know if the per-node solution is really worthy for a PIE
> >> kernel. So, could you please test the performance? Maybe we can reduce
> >> the complexity if we give up the per-node solution.
>
> Tested on Loongson-3C5000L-LL machine, using CLFS7.3 system.
>
> - nopernode:
>    Based on the v1 patch method, and remove the else branch process in
>    setup_tlb_handler().
>
> - pernode: Based on the v4 patch method.
>
> - pie: Enable RANDOMIZE_BASE (KASLR).
>
> - nopie: Disable RANDOMIZE_BASE and RELOCATABLE.
>
>
> The UnixBench test results are as follows:
>
> - nopernode-nopie: 3938.7
>
> - pernode-nopie: 4062.2
>
> - nopernode-pie: 4009.7
>
> - pernode-pie: 4028.7
>
> In general, `pernode` is higher than `nopernode`, and `nopie` is higher
> than `pie`. (except that nopernode-pie is higher than nopernode-nopie,
> which is not as expected, which may be caused by the instability of the
> machine).
>
> Everyone is more inclined to use `pernode` or `nopernode` to implement
> in the exception handling process?
From my point of view, for the PIE kernel the performance difference
between pernode and nopoernode is negligible. On the other hand,
pernode implementation needs some compiler hackings and makes the
logic significantly complex. So I prefer to remove the pernode
exception support.

Huacai
>
> Youling.
>
>
