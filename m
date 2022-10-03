Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E05F37AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJCV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiJCV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F295BC0D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81B6AB815FB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F4FC433D6;
        Mon,  3 Oct 2022 21:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664831833;
        bh=R79UHR49+cXdxY8Lzokv7OALE2VQe1R1YCemJrDV0ww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXo8NeGfnawnAbcWrPKG3bJGNF/FPDIQJz5mRJjcmarNGdWkqJAQM7NoLHRXFFCZd
         gZjhHq5zbZs9UsGgfMDVJCyOkhretNMQ8kgHtDudzcoJgQUrlUmqe6/OVKrrTWPPuI
         WhBrQFeI093tvqpVEJs9cwpW3wipxIY2eNBQYJ0U=
Date:   Mon, 3 Oct 2022 14:17:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4 -next] fault-injection: make some stack filter attrs
 more readable
Message-Id: <20221003141712.ff7aceb8e29073f3aa9be2ec@linux-foundation.org>
In-Reply-To: <CAC5umyhZrUsOCDbWPznRpuaDwScHf7yKA5m8X8jwVztm6B+meA@mail.gmail.com>
References: <20220817080332.1052710-1-weiyongjun1@huawei.com>
        <20220817080332.1052710-4-weiyongjun1@huawei.com>
        <CAC5umyhZrUsOCDbWPznRpuaDwScHf7yKA5m8X8jwVztm6B+meA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 22:24:10 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2022年8月17日(水) 16:45 Wei Yongjun <weiyongjun1@huawei.com>:
> >
> > Attributes of stack filter are show as unsigned decimal, such
> > as 'require-start', 'require-end'. This patch change to
> > show them as unsigned hexadecimal for more readable.
> >
> > Before:
> >   $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
> >   $ cat /sys/kernel/debug/failslab/require-start
> >   18446744072638263296
> >
> > After:
> >   $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
> >   $ cat /sys/kernel/debug/failslab/require-start
> >   0xffffffffc0257000
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  lib/fault-inject.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> > index 515fc5aaf032..deca05e7c9b3 100644
> > --- a/lib/fault-inject.c
> > +++ b/lib/fault-inject.c
> > @@ -179,6 +179,14 @@ static void debugfs_create_ul(const char *name, umode_t mode,
> >
> >  #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
> >
> > +DEFINE_SIMPLE_ATTRIBUTE(fops_xl, debugfs_ul_get, debugfs_ul_set, "0x%llx\n");
> > +
> > +static void debugfs_create_xl(const char *name, umode_t mode,
> > +                             struct dentry *parent, unsigned long *value)
> > +{
> > +       debugfs_create_file(name, mode, parent, value, &fops_xl);
> > +}
> 
> How about using an existing `debugfs_create_xul()` instead of defining
> a local helper function?

Could we please have a response to this?


