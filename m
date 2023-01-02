Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8279F65B399
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjABOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjABOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:49:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066C8FE9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91670B80C70
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 14:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7CFC433D2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 14:49:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="b3JaSxn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672670976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FySLmRk1CkpgiQXUD8lcmRXk9llYMvDDaPAibWTajeQ=;
        b=b3JaSxn/394OVlfIVr4GJ9ri+uzzEpn/2clCA993P0SH4RTcQhJ3W5tNKdwX86abKiXGvj
        /SzHaIzPqU2bZM93hnRbl9iehspePjGHlxEvddtxdaXLvbnqTwimF+JZiH2xZolZ4YjYzE
        GW3FENg1QYW52tYXgYn+7BkqYXL5ztQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 90c8ebd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 2 Jan 2023 14:49:36 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id 186so30407027ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:49:36 -0800 (PST)
X-Gm-Message-State: AFqh2krVBQp57h9/SfiSnTg1y71N0YyEYwISTLxRCp6oib3W7f33H4PM
        bPMczeTWjqahBMdO1hhwQOuB3n+9DPXbpObtHkw=
X-Google-Smtp-Source: AMrXdXvCDC5wHxYTibm+MBKaGB0oa20gxNOVCCLis096x+gcsolduEJCPyou6LBDB9VJ/i7BPsOkFbv+bUG7r80TB2s=
X-Received: by 2002:a25:d243:0:b0:702:90b4:2e24 with SMTP id
 j64-20020a25d243000000b0070290b42e24mr2794003ybg.365.1672670974668; Mon, 02
 Jan 2023 06:49:34 -0800 (PST)
MIME-Version: 1.0
References: <Y5oy0vwZQAwzkDkr@zx2c4.com> <20221214203454.337299-1-Jason@zx2c4.com>
 <20221214213015.GA16072@ranerica-svr.sc.intel.com> <Y5zRTqDmjeJzjeFf@zx2c4.com>
In-Reply-To: <Y5zRTqDmjeJzjeFf@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 2 Jan 2023 15:49:23 +0100
X-Gmail-Original-Message-ID: <CAHmME9ojkPUV-acD8o1rFsfR+f7URG8PW44GUUt8WUK0O=KD6w@mail.gmail.com>
Message-ID: <CAHmME9ojkPUV-acD8o1rFsfR+f7URG8PW44GUUt8WUK0O=KD6w@mail.gmail.com>
Subject: Re: [PATCH v2] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
To:     bp@alien8.de
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

Hello Borislav,

On Fri, Dec 16, 2022 at 9:13 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Dec 14, 2022 at 01:30:15PM -0800, Ricardo Neri wrote:
> > On Wed, Dec 14, 2022 at 01:34:54PM -0700, Jason A. Donenfeld wrote:
> > > Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
> > > Rename the insn ones to have a INSN_ prefix, so that the headers can be
> > > used from the same source file.
> > >
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > FWIW: Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>
> Thanks. Any chance this can get in for 6.2?

Do you think you could queue up this patch for 6.2 as a fix? It has
basically no chance of breakage and does fix a real symbol clash.

https://lore.kernel.org/lkml/20221214203454.337299-1-Jason@zx2c4.com/

Thanks,
Jason
