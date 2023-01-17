Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41E666E75A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjAQUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjAQT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:58:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315CD1E2B2;
        Tue, 17 Jan 2023 10:51:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2047461502;
        Tue, 17 Jan 2023 18:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED6C43396;
        Tue, 17 Jan 2023 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673981469;
        bh=gd6R4XluMPB27r6LRcEsEEMwkleNjaoutuHbO7D0GHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hJ3VpHNAGVQLfHfCQw6iz4bsXMbG+3VG9IOv0Yeo0GklHd7TUgHoDf3T4QV6oYO/V
         LeQhJBQImYjldHG8NkhTtMmSUklOh3/25QuAHnWC1Bik0aeOwUMPcUtRtLOidQFgzA
         y5c+4UCcdSPlihYBD1Ky9vewXXUtO5DEEpNysVeung5A0DTyOEgjFEHLm07Q8JMRWL
         iSPx1Rx8ZoIIAkDzKoIKU6793lAfZ0FbLkGBb7LITBdyPDnGfdmQkmRDZ62Q4X05ga
         0G40nZXW8snZ+cAqQjKukHasEp7VMpTdl+bmd3zYa6+WruW5+yoZ5agffsU7Gr17sZ
         gBYuwNiYQ/Z6A==
Received: by mail-lj1-f169.google.com with SMTP id q2so34144867ljp.6;
        Tue, 17 Jan 2023 10:51:09 -0800 (PST)
X-Gm-Message-State: AFqh2krJRJ8bMj8C5W8jAKgnIpBkw0ohHzKQpwwFU27VsxL+qP3kWjRW
        1xEj9QjaomVnbSIkkAK+fTHXfI/s9Y/vStylUlU=
X-Google-Smtp-Source: AMrXdXvQFn1OJOI8BCI6E1NnIneOX1k2nFbTJrW83pBXfodpFFEGBJa32CrPe4b21KUJtpNBDt+8RNt/dk+fPHFf9YE=
X-Received: by 2002:a2e:b166:0:b0:284:b05a:9e82 with SMTP id
 a6-20020a2eb166000000b00284b05a9e82mr303044ljm.479.1673981467417; Tue, 17 Jan
 2023 10:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
In-Reply-To: <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 17 Jan 2023 10:50:55 -0800
X-Gmail-Original-Message-ID: <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com>
Message-ID: <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     songliubraving@fb.com, Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Luis,

Could you please share your comments on this? Specifically, is this on
the right direction? And, what's your preference with Christophe's
suggestions?

"I dislike how it looks with enums, things like
mod->mod_mem[MOD_MEM_TYPE_INIT
_TEXT] are odd and don't read nicely.
Could we have something nicer like mod->mod_mem_init_text ?
I know it will complicate your for_each_mod_mem_type() but it would look
nicer."

Thanks,
Song

On Tue, Jan 10, 2023 at 10:31 AM Song Liu <song@kernel.org> wrote:
>
> + Christoph
>
> Hi folks,
>
> Could you please share your comments on this work? If there isn't
> major issue with it, maybe we can ship it in 6.3? (so we don't pile
> too many changes in one big set).
>
> Thanks,
> Song
>
> On Fri, Jan 6, 2023 at 2:10 PM Song Liu <song@kernel.org> wrote:
> >
> > module_layout manages different types of memory (text, data, rodata, etc.)
> > in one allocation, which is problematic for some reasons:
> >
> > 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> > 2. It is hard to use huge pages in modules (and not break strict rwx).
> > 3. Many archs uses module_layout for arch-specific data, but it is not
> >    obvious how these data are used (are they RO, RX, or RW?)
> >
> > Improve the scenario by replacing 2 (or 3) module_layout per module with
> > up to 7 module_memory per module:
> >
> >         MOD_MEM_TYPE_TEXT,
> >         MOD_MEM_TYPE_DATA,
> >         MOD_MEM_TYPE_RODATA,
> >         MOD_MEM_TYPE_RO_AFTER_INIT,
> >         MOD_MEM_TYPE_INIT_TEXT,
> >         MOD_MEM_TYPE_INIT_DATA,
> >         MOD_MEM_TYPE_INIT_RODATA,
> >
> > and allocating them separately.
> >
> > Various archs use module_layout for different data. These data are put
> > into different module_memory based on their location in module_layout.
> > IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> > data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
>
> [...]
