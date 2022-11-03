Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FBB617CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKCMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKCMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC010FCE;
        Thu,  3 Nov 2022 05:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ABAA61E87;
        Thu,  3 Nov 2022 12:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F788C433D6;
        Thu,  3 Nov 2022 12:47:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Smh8FGbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667479649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEafQTxAuW0C4fSx/Iqx7gKDvE8FeF6q8xGkkUzlxAQ=;
        b=Smh8FGbQysyPMnlAH5nxL3SJq3YZXL39spy870v39JxOQZfwzi7MrbddktJNMunEFrU8eC
        OynhrAK3EcIB1RHvciDoO2wkGCCpmMTMk8INhQwH3n0KFH/YQZtpGj0zqSORV3qf0zA/1/
        07o443KW0UGOU+9UERHtcQQ1W1lUulg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7ed9d1ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 12:47:28 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id t14so1738112vsr.9;
        Thu, 03 Nov 2022 05:47:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf2XpxBscMhpJ9h+EGxnZnhLmB7X0460SRNkkevv8NnS+zlB5l5R
        hfS4qqhfnysFXOFqRIBc/VX/9ZR/aLcXv+QTOqY=
X-Google-Smtp-Source: AMsMyM7/RXkbrCjYnWkyhHkbTsSOAEyVJ72RQIBH6pFt1o/bKzLMGprYdKpvYo/RZOrLoVNVk+ndwxTwU4khg0wyfhY=
X-Received: by 2002:a05:6102:f9a:b0:3aa:1a11:2702 with SMTP id
 e26-20020a0561020f9a00b003aa1a112702mr17019626vsv.73.1667479646250; Thu, 03
 Nov 2022 05:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook> <Y1iSYddi3BpP8gvf@zx2c4.com>
 <Y1ku+jfRAyezq6Nz@zx2c4.com> <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
 <Y2MGlTwh9aB+4z4l@zx2c4.com> <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr>
In-Reply-To: <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 3 Nov 2022 13:47:14 +0100
X-Gmail-Original-Message-ID: <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
Message-ID: <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kees Cook <keescook@chromium.org>, cocci@inria.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Thu, Nov 3, 2022 at 1:45 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> It should work now.

Thanks!

> However, without disable optional_qualifier, char is
> still matching signed char.  If you think that should be changed, I can do
> that.

Does `optional_qualifier` disable other things that might be
interesting to have? If so, maybe this is less than ideal? If not,
maybe it doesn't matter?

Though, for what it's worth, gcc treats `char` as a separate type,
even when using `-funsigned-char` or `-fsigned-char`.

Jason
