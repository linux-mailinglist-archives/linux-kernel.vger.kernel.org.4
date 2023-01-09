Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B7662F08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjAIS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbjAIS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:27:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1633F76216;
        Mon,  9 Jan 2023 10:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E2656131B;
        Mon,  9 Jan 2023 18:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8131C433EF;
        Mon,  9 Jan 2023 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673288684;
        bh=Up8QqGMyFDjE0WjGpp7skXEYattOheVK7AbCVFlqypg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rh+GN8Jv3V8RZE6bwSRP+a3YMg7owuOENFwn/qlIQ8GAOqfd8eVJ4c8rJy44cBWvY
         R+qaP+Vwburvs2eBSUDf61a/tjUXzXSSoPS8qfEmFGpf96dXl2NPsAFpk6avvBgekh
         +ZBFW4k0l7Zs9hVY+U0YDwEnvFov+QKaLXfU82Xf0xWUG5yQ0Cv9Kmq4ZDDV3J/iBC
         6ExjMYtcDIg/n0HNaXO7b4sbg06VHGBhoEK5ZH0+906mEtqo6vdLUU8Gn8hEETqev6
         PJEiJxl9D4O0DaoZiHqV+SyiBoi1ApPbhOboxIT4m3MZYJHh1NzmHJ1KtTQmWxe9/p
         wby0BveNsZonQ==
Received: by mail-lj1-f174.google.com with SMTP id s22so9787266ljp.5;
        Mon, 09 Jan 2023 10:24:44 -0800 (PST)
X-Gm-Message-State: AFqh2krXbamDlV3JDxTWKWFJ4dc056roVy9pJo4AsFzEt5w2n2/lEHzB
        3ghiEiZZ/rZd8wzOcOi7tzbJmU0d0cw25xbu2lE=
X-Google-Smtp-Source: AMrXdXvIw6hG9gDAnoAfdI8nZINwTIra0pcoyKs3iOgDfBqzH5BLBcnZSVgRGYuLxsD9/MzBF8MT6j3QCVcK2U5fnPM=
X-Received: by 2002:a2e:a5c5:0:b0:280:5b72:c3ce with SMTP id
 n5-20020a2ea5c5000000b002805b72c3cemr1383100ljp.203.1673288682865; Mon, 09
 Jan 2023 10:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <83941b74-7585-235b-ee54-3b127ca70d9e@csgroup.eu>
In-Reply-To: <83941b74-7585-235b-ee54-3b127ca70d9e@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Mon, 9 Jan 2023 10:24:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
Message-ID: <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
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

On Mon, Jan 9, 2023 at 10:03 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 06/01/2023 =C3=A0 23:09, Song Liu a =C3=A9crit :
> > module_layout manages different types of memory (text, data, rodata, et=
c.)
> > in one allocation, which is problematic for some reasons:
> >
> > 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> > 2. It is hard to use huge pages in modules (and not break strict rwx).
> > 3. Many archs uses module_layout for arch-specific data, but it is not
> >     obvious how these data are used (are they RO, RX, or RW?)
> >
> > Improve the scenario by replacing 2 (or 3) module_layout per module wit=
h
> > up to 7 module_memory per module:
> >
> >          MOD_MEM_TYPE_TEXT,
> >          MOD_MEM_TYPE_DATA,
> >          MOD_MEM_TYPE_RODATA,
> >          MOD_MEM_TYPE_RO_AFTER_INIT,
> >          MOD_MEM_TYPE_INIT_TEXT,
> >          MOD_MEM_TYPE_INIT_DATA,
> >          MOD_MEM_TYPE_INIT_RODATA,
> >
> > and allocating them separately.
> >
> > Various archs use module_layout for different data. These data are put
> > into different module_memory based on their location in module_layout.
> > IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT=
;
> > data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc=
.
>
> I dislike how it looks with enums, things like
> mod->mod_mem[MOD_MEM_TYPE_INIT_TEXT] are odd and don't read nicely.
> Could we have something nicer like mod->mod_mem_init_text ?
> I know it will complicate your for_each_mod_mem_type() but it would look
> nicer.

Hmm.. I am not sure whether we want 7 module_memory here. But if we
agree that it looks better like that, I am ok with it.

>
> Also, can you explain how you switch from two trees to only one ?
> As far as I remember, the same question arised when I implemented
> CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, and the conclusion was that
> we had to keep two independant trees, so I'm a bit puzzled that you have
> now merged everything into a single tree.

AFAICT, we only need __module_address() to work? So one tree is enough.
Did I miss something?

Thanks,
Song
