Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D57E601B24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJQVQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJQVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F405B87B;
        Mon, 17 Oct 2022 14:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32EF8B81ACB;
        Mon, 17 Oct 2022 21:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C36C433C1;
        Mon, 17 Oct 2022 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666041408;
        bh=M0iIpq0yjJ7zG7PlxsMHDRIbhItXcsqY5S0vGXphA2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LQhA4D9k7KCzHwZUUSby19364lcxZGcLwcPQzSEiogLZN4lv9wec/stComXpFDLla
         ukgPYqkHoWrDE3M0c4ld+Sbae3RFTi5Gdu6UY2cIyBwcb0mwMiRPmZLXqcj0/fEKN0
         K1pMLhBZKAUYMsQgH9J1nU83bp7KwR7qK6KjILJh/R5exT7DTi2L4t+Te1VEdzSlvF
         bS/AzEVVFwEbRTfKsJw3OWq4wysY5j2TvFEJZlI+z7zug0EB9ExJomKjCxuTbCXylM
         AOQ/KpUdwV4cIhf+12ygZCGOKHnN452Is37PK3BI/2+autqbAlJaznI2F1xJkUoe9P
         zNW7F2yMgfLog==
Received: by mail-lj1-f182.google.com with SMTP id h8so15539808lja.11;
        Mon, 17 Oct 2022 14:16:48 -0700 (PDT)
X-Gm-Message-State: ACrzQf1/Zjjg1CSkLOG1J3pEzjJvKxXE9B9lwvEpe4NEVdfroT2Pe7Uy
        b8yqgslOz5srdSHwvz/wK0KjJzwY66w0JK2tpZg=
X-Google-Smtp-Source: AMsMyM5VuYZ3IgUUsvx2pTq54fRq2fx58wePUctP/yy1Vdza3cpMd8Iclx8R8OKYyyq2h7CY/4xtn5iX9ehtVqpOuiw=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mr5048121ljq.152.1666041406979; Mon, 17
 Oct 2022 14:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com> <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook> <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook> <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
 <202210171307.32A5D9C07@keescook> <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
 <202210171333.309A3D9@keescook> <CAMj1kXHTxc2PM1mz3pm-UEcmch9YG5QKF+JKAUNe9b+1L0OnfA@mail.gmail.com>
 <cb44c124-c940-6f5f-d195-bdf133008ba1@igalia.com>
In-Reply-To: <cb44c124-c940-6f5f-d195-bdf133008ba1@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 23:16:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGA=kBdahDTuFDPzZKf5bbvxH2Ns7Ows+5D-PAx8rwP2w@mail.gmail.com>
Message-ID: <CAMj1kXGA=kBdahDTuFDPzZKf5bbvxH2Ns7Ows+5D-PAx8rwP2w@mail.gmail.com>
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 at 23:10, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 17/10/2022 18:01, Ard Biesheuvel wrote:
> > [...]
> >
> > In summary, we're better off sticking with the legacy comp interface,
> > but unfortunately, due to the way that has been plumbed into the
> > scomp/acomp with scatterlists version, that doesn't really help us get
> > rid of the memory overhead.
> >
>
> Out of curiosity, do you have a number here, like X kilobytes per active
> CPU?

2x128 KB per CPU, which makes 128  KB also the maximum input/output
size per request when using this interface. (SCOMP_SCRATCH_SIZE)

On my 32x4 CPU workstation, this amounts to 32 MB permanently locked
up for nothing when the pstore driver is loaded (with compression
enabled)
