Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1791963E388
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK3Wh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiK3WhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:37:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257B8C453
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99340B81D11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2F2C433C1;
        Wed, 30 Nov 2022 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669847840;
        bh=zYsNbDHSQZ6QKvCH+Y2IXFnV1un2L85lK4tF30YwHK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pc2fr1ldVRBQ8QVl1y/2ZFiBGI7k945coMZwIhITLwcxuuTZmGqnQu7GGMMiiDQv8
         FZCsNPXuzoAOPI5GlJI/eEooKEVkrKZFgbZgMAUZa3AD92+X3rpX5K1nU5UEpFo6kM
         K4UtJhqRuT6+SaDiqHbxTbEy7MADmYSxEZOQqYP4=
Date:   Wed, 30 Nov 2022 14:37:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Mason <clm@meta.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-Id: <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
In-Reply-To: <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
References: <20221121104403.1545f9b5@gandalf.local.home>
        <Y3vSQo85ofkfD/L8@zn.tnic>
        <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <Y3ymzAYRyH5IWEe/@zn.tnic>
        <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
        <20221122132905.12a8d5ad@gandalf.local.home>
        <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 14:51:08 -0500 Chris Mason <clm@meta.com> wrote:

> On 11/22/22 1:29 PM, Steven Rostedt wrote:
> > On Tue, 22 Nov 2022 12:42:33 -0500
> > Chris Mason <clm@meta.com> wrote:
> > 
> >> On 11/22/22 5:39 AM, Borislav Petkov wrote:
> >>> On Mon, Nov 21, 2022 at 03:36:08PM -0800, Alexei Starovoitov wrote:  
> >>>> The commit log is bogus and the lack of understanding what  

Why am I not understanding the controversy here?  With this patch
applied, people who want function error injection enable
CONFIG_FUNCTION_ERROR_INJECTION and people who don't want it don't do
that.

Alexei, can you please suggest a less bogus changelog for this?
