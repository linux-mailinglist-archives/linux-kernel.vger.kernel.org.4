Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C76632014
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKULPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiKULOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:14:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5D7BF839
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F66ECE11BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D001C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669028998;
        bh=SrnoE2ZwKMFebu9vJWEZ+n28lkE0/B5i1gCPufLzeR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UcjU7Cm1TKWDiiorJEj+aOA12ktOV1UNiOGeqrq6GCAxfFEr9NwuekUhbOTrRTdGm
         UgU7HRT4Z5KXL/BQ1bHVABkwR1gjEWVSq6vmKwpcXeDMrNNZAvXM9D8CC562TUCRWW
         tfuOtpOe2qi4Z+SaaosZKdeZxx3ikCj99w2y855LOry+DDYlsYebPc+LxKVpS970ds
         Z28EfkrPlqQ9TCyaYesIi076ye2luMetISph/zcfPYfM85190shKwEyxJdXR9HZEej
         iLEGr6u0/Qdc7WnU0EAcQl5QkdParo3YqJXAVumEg2wYl4BZGw38oJmq2PxG6wn9zG
         8JxdoRG37mYlA==
Received: by mail-ej1-f42.google.com with SMTP id n20so27815191ejh.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:09:58 -0800 (PST)
X-Gm-Message-State: ANoB5plX/2YQisTGZ/4gkHuexkvYgLR17fvHSvMnR8SkbB14DWAwYczs
        /pRREY1Nz1Vu+yDp1NmWTld/rob5mx8nMqFGxcM=
X-Google-Smtp-Source: AA0mqf7PWo/LXdMWM/qVMzfD6xXZltpTRX4XN8uDfabhE0uSKX3rmuH6/A0Wd1z0JVyxGzoC+SvQcoEZSyTztwNaEFI=
X-Received: by 2002:a17:906:6a8e:b0:78d:a136:7332 with SMTP id
 p14-20020a1709066a8e00b0078da1367332mr14856897ejr.355.1669028996847; Mon, 21
 Nov 2022 03:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20221120101049.2078117-1-guoren@kernel.org> <Y3tPEDvM3aVJmVxF@wendy>
In-Reply-To: <Y3tPEDvM3aVJmVxF@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 21 Nov 2022 19:09:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0FDgV3toa9wZxPhK2G+f4vCtrru7q3R4FXnMkxYmu-w@mail.gmail.com>
Message-ID: <CAJF2gTS0FDgV3toa9wZxPhK2G+f4vCtrru7q3R4FXnMkxYmu-w@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: patch: Fixup lockdep warning in stop_machine
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, changbin.du@intel.com,
        zong.li@sifive.com, rostedt@goodmis.org, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 6:13 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Sun, Nov 20, 2022 at 05:10:49AM -0500, guoren@kernel.org wrote:
> > From: Changbin Du <changbin.du@gmail.com>
>
> > Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
> > Cc: Changbin Du <changbin.du@gmail.com>
> > Co-developed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Zong Li <zong.li@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
>
> Hey Guo Ren,
>
> FYI you're missing a SoB from Chanbin on this patch. They gave one in
> their v1 though so you should be able to re-use that?
I'm waiting for his SoB. I don't think I could directly use his SoB in
v1. I need him to confirm my rewritten commit log for lockdep
analysis.

>
> Thanks,
> Conor.
>
> > Changes in v2:
> >  - Rewrite commit log with lockdep explanation [Guo Ren]
> >  - Rebase on v6.1 [Guo Ren]
> >
> > v1:
> > https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/
>


-- 
Best Regards
 Guo Ren
