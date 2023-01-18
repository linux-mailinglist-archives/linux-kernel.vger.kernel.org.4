Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF5F67106C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjARBtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjARBt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:49:28 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E151C66
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:49:26 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g14so35042077ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EofrsKclU1Bd3gKxPPxphmvSRJzHoKFWbRAdp5SlbJI=;
        b=boIYGE+m3kCDRxqRd/7+64o/AV97y54ui0V/gJ+LcZtZQFDolp9kiY0orqv9r6OoWz
         6WvVy7YJDD4saHCXC0p38hRhEYs3CITcGcu4PaFl/KhTs5bo3Xc5xn4pZ1o7Cx4KSBPL
         e3OROPvSLfcbPA64tDnupmGitqE0lDZs2hwSQ76OLgO6ioV0sll70E6e7nX1QIFQ74TS
         H5pOEeCnxYiVT3694FMkgGVSCdfx0ogjR2AUWGwyZDtqfqu3i0gNAYgVp2vUQ9s0arls
         w1sf23ADKa46AMgylZG/XezZgu6Ah6yauYwEieEp7nj8hu418zEn8eLHvmadNFgrqiF0
         qaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EofrsKclU1Bd3gKxPPxphmvSRJzHoKFWbRAdp5SlbJI=;
        b=z2Yz+ZK+0rXXGwHfJo2MjVfxWrx/WTfZzrpCzH4SzPn0gcZuwDe76NNciAxnakXxMK
         YRwtiSCx/GRrhb/xqJqTvkQ5vhPBFDM3Pl3r0EEsdnCZUtsC+okmqnYqGgohKBZ/L9C8
         /RVONo/7kg91rxn2i2g6uvfIv4CamhzoFhm/8ARo1WaMkdcEBoeirTAMAGg/HXqCaUDX
         VbMbdLLBVBe64e6LQBKTSCW7ySMGx/oEeS5tnF1waBT4d1jdO1F80kKLCmYigCPhb+6X
         sSZuPMT8mwvWuGsx15NaugqtEihbKFR1a6yl3myTmlUU/ouPcwGFXG+HPHvpDYzgygUO
         fd1w==
X-Gm-Message-State: AFqh2kq1KLBa7vS0DsyPWgZrSNHrnHMuC0Ozt0vn5NmsxnsWqZmv76y6
        X36tmVnpP4DyzyHVfNvOqZw49QfRXSBPo+zFOh4=
X-Google-Smtp-Source: AMrXdXtOClVIp1XhZ2IuXdLjsnrX8fXXvUg+8qrxI/0LmwZXgA8uFMETv75h/57JZoWdiu1DERbX/HGKuAOKcji4vc8=
X-Received: by 2002:a2e:a49a:0:b0:28b:6abf:29ea with SMTP id
 h26-20020a2ea49a000000b0028b6abf29eamr464639lji.359.1674006565275; Tue, 17
 Jan 2023 17:49:25 -0800 (PST)
MIME-Version: 1.0
References: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20230117161731.ab69c2352a62a0693570cf70@linux-foundation.org>
 <CAGWkznHKJF1hiVTS2gAxgywnGz4T9u8UQtDV_Oj7r3cWqM5=nA@mail.gmail.com>
 <20230117173145.867a06c1585728da1e9b6a54@linux-foundation.org> <CAGWkznEusXRmi=ZEOvfK8qRfe+aKWa3X-bLG28=XoeGZ5umeuQ@mail.gmail.com>
In-Reply-To: <CAGWkznEusXRmi=ZEOvfK8qRfe+aKWa3X-bLG28=XoeGZ5umeuQ@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 18 Jan 2023 09:49:01 +0800
Message-ID: <CAGWkznFDCTXM3-6YEGyFtDOvqPZhK9+XoTvem26fz996fFnLJg@mail.gmail.com>
Subject: Re: [PATCHv2] mm: use stack_depot_early_init for kmemleak
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 9:40 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 9:31 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 18 Jan 2023 09:25:48 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > > On Wed, Jan 18, 2023 at 8:17 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Tue, 17 Jan 2023 16:11:52 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
> > > >
> > > > > Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> > > > > Solve this by having stackdepot use stack_depot_early_init. Extra Kconfig also
> > > > > done by moving kmemleak stuff to mm/Kconfig.debug.
> > > >
> > > > I don't understand - what was the reason for the Kconfig change?
> > > The items related to kmemleak are moved from lib/Kconfig.debug to
> > > mm/Kconfig.debug
> >
> > Well yes, but why?
> It was suggested by Vlastimil in a previous comment. It makes more
> sense to have kmemleak's source code and Kconfig items under the same
> directory.
> >
> > Is that related to this bug fix?  If not then please let's have that
> > change in a separate patch.
> The moved items are updated for this bug fix.
sorry for my faint. I will make another patch for Kconfig changes.
> >
