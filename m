Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E8672520
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjARRiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjARRiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:38:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075A73B0DE;
        Wed, 18 Jan 2023 09:38:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADA1AB81E15;
        Wed, 18 Jan 2023 17:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64801C433D2;
        Wed, 18 Jan 2023 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063491;
        bh=6dUq+W2mqEx0g4Or3chy+W983T739CIoWnzDTGhRhGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nf7sfxZq9tl8Nzgn+ro+WGZ8uO2szublwfHlp+L0eBc5tLiwUnnG9Fw+ndDTCaEr1
         P2xV/udYU8BBDEfcaAmB1ojLhwFpRSt9TIwMz4/gwzZANoUkahj3krVKzB1I6Pm1KA
         RQG7DSFkgS1Mw4ZK2x/8zv2wAJAnHLklny3KF4OSQojiJMpqXEbjOOxGSnnDTu5m0M
         fiF+cdOLKSlVEUIEaLk2Lwdy17KRwn1CRZ6l7v/C8Tak+VNv2EQU5JvF8oUWeuGgcn
         5ppc/lGY4spSCuSPjzefpesdCoqfxqIwzwdiWInPS2N15QjfplRhSgjHQbsZmJTPNy
         BHViU1AW31d6g==
Received: by mail-lf1-f52.google.com with SMTP id a11so12630253lfg.0;
        Wed, 18 Jan 2023 09:38:11 -0800 (PST)
X-Gm-Message-State: AFqh2kq/j9XUDFJYmKplH9CAouZ4OduTm2e9+WEpgj/fxVWzZbnCQZXP
        lnoDuIY9KBvNLiUWUpqAavIq6KARGj3c0u4Oy+g=
X-Google-Smtp-Source: AMrXdXsXJT800vKamK8IsZv9B2ch+q+KajiuJpC8TbalLVf3MdSaxmfsYmd/o2VA6AcCEPP9zk1pQEK3GKaiPjbUeVU=
X-Received: by 2002:a05:6512:3c8a:b0:4d5:8d49:569c with SMTP id
 h10-20020a0565123c8a00b004d58d49569cmr550359lfv.643.1674063489432; Wed, 18
 Jan 2023 09:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
 <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com> <20230118074047.GA27385@lst.de>
In-Reply-To: <20230118074047.GA27385@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Wed, 18 Jan 2023 09:37:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5rRgcW7DocBVpqGoEgnHmXHffOD0uByWk64s8PCV8yZg@mail.gmail.com>
Message-ID: <CAPhsuW5rRgcW7DocBVpqGoEgnHmXHffOD0uByWk64s8PCV8yZg@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        songliubraving@fb.com, Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jan 17, 2023 at 10:50:55AM -0800, Song Liu wrote:
> > Hi Thomas and Luis,
> >
> > Could you please share your comments on this? Specifically, is this on
> > the right direction? And, what's your preference with Christophe's
> > suggestions?
> >
> > "I dislike how it looks with enums, things like
> > mod->mod_mem[MOD_MEM_TYPE_INIT
> > _TEXT] are odd and don't read nicely.
> > Could we have something nicer like mod->mod_mem_init_text ?
> > I know it will complicate your for_each_mod_mem_type() but it would look
> > nicer."
>
> FYI, I don't particularly like the array either.  But if it makes
> the code much simpler I can live with it.

Thanks for the feedback! Let me see whether I can make the
code clean without the array.

Song
