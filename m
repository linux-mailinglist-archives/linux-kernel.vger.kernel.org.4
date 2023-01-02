Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F365B487
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjABP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:59:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065AAA470
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:59:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 786B5B80DA9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C7AC433D2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:59:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wb94PjBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672675150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBaZtMuASP9M2QZjnlkyVGAQ6P48cQt0rhGLMsa1ED0=;
        b=Wb94PjBCzSmS5PLO0tLXzgtk8roC7S2llT8cVa239gLD+rA2124Kp/OJ8wVLSHMaSaY1BN
        ELF84l9Ye01lHsiWKiIwiOjAznGyalybpbk9uVs1ERG6RPUhmR5MQtwmtTJoibJVKMJu8C
        cir2czraBQiuP3JWOiN691iAL0TfSng=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a9033aa7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 2 Jan 2023 15:59:10 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-4a263c4ddbaso65738557b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:59:09 -0800 (PST)
X-Gm-Message-State: AFqh2krdlG2KSMHGRAQE/w5z7HuwqYqS1TV5c56ENu6bDcIOA/XmPXSD
        TSuq51OhGPScJivTat6PVO87BXoiWSGQsE2iU9I=
X-Google-Smtp-Source: AMrXdXvbDc6DrorA7hbi5PyDzu2T3tcHlzNb3J0m2+g0ZRc198h1sFNU4QtrVfxViNV7yze9SU49C04dX7L8R1H15nU=
X-Received: by 2002:a0d:eb48:0:b0:46e:92d3:451a with SMTP id
 u69-20020a0deb48000000b0046e92d3451amr4985546ywe.454.1672675148945; Mon, 02
 Jan 2023 07:59:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:324a:b0:1a3:8917:b60e with HTTP; Mon, 2 Jan 2023
 07:59:08 -0800 (PST)
In-Reply-To: <Y7L4n0imic1ncHhe@zn.tnic>
References: <Y5oy0vwZQAwzkDkr@zx2c4.com> <20221214203454.337299-1-Jason@zx2c4.com>
 <20221214213015.GA16072@ranerica-svr.sc.intel.com> <Y5zRTqDmjeJzjeFf@zx2c4.com>
 <CAHmME9ojkPUV-acD8o1rFsfR+f7URG8PW44GUUt8WUK0O=KD6w@mail.gmail.com> <Y7L4n0imic1ncHhe@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 2 Jan 2023 16:59:08 +0100
X-Gmail-Original-Message-ID: <CAHmME9rMTNQ+hZPG1cbpP2zA6Cq3-f=gXXPF3=WYhQWicEYV4w@mail.gmail.com>
Message-ID: <CAHmME9rMTNQ+hZPG1cbpP2zA6Cq3-f=gXXPF3=WYhQWicEYV4w@mail.gmail.com>
Subject: Re: [PATCH v2] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
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

On 1/2/23, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Jan 02, 2023 at 03:49:23PM +0100, Jason A. Donenfeld wrote:
>> Do you think you could queue up this patch for 6.2 as a fix? It has
>> basically no chance of breakage and does fix a real symbol clash.
>>
>> https://lore.kernel.org/lkml/20221214203454.337299-1-Jason@zx2c4.com/
>>
>> This doesn't fix any existing compile error that I'm aware of, but if
>> this makes it into 6.2, it would avoid me having to carry it in a series
>> I'm working on,...
>
> Our general rule for urgent fixes going through tip is that they should
> qualify
> to be CC:stable fixes. And this one isn't so I think you should hold on to
> it
> and submit it along with the whole series as it is usually done.

Rest of series is intended to go through random.git tree, so it'd be
useful to not have to carry this there -- less pain.

Jason
