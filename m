Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7506B63F30F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiLAOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLAOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:41:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D989A8FF5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:41:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCB3762036
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C41EC433C1;
        Thu,  1 Dec 2022 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669905686;
        bh=zLnrAXdPNWv4KF6y1QKF5sGGSOuDH+HIqfZx7S9WE5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sM5HfNIkmV37FbZ/aIR+v7hpiIbh2JKa7LBIW9BsjwkJ95O5r+PbX6cojgLAbOeq4
         WVbXDkj++3whvAdamwA4x1yOwWU4RQRRbwD6CMCrZLqw1aqtEq18iIegvt8Bda8M9R
         38wTTDIhjJX+Q//nLrmSS83ZXa+ZUDgIm3ZIF38rYhdANBhtRJn8QHVlzBpaSmNXCV
         0DdJO+ghqWMG4oSKYLJgptAWvmTyvU+MdjOBBIeeMWEbBtAJBbviWejf+HZ1EYIRoR
         TKzmZ1NGzSYcWWo5sHKYTyL5ClF+fgyPPzNht76veQn4QfVIppRBaTd4zXmip12QIY
         SD3PHXQzWZABg==
Date:   Thu, 1 Dec 2022 23:41:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chris Mason <clm@meta.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-Id: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
In-Reply-To: <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
References: <20221121104403.1545f9b5@gandalf.local.home>
        <Y3vSQo85ofkfD/L8@zn.tnic>
        <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <Y3ymzAYRyH5IWEe/@zn.tnic>
        <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 22 Nov 2022 12:42:33 -0500
Chris Mason <clm@meta.com> wrote:
> 
> - fault injection for testing: we have a stage of qualification that
> does error injection against the prod kernel.  It helps to have this
> against the debug kernel too, but that misses some races etc.  I always
> just assumed distros and partners did some fault injection tests against
> the prod kernel builds?
> 
> - fault injection for debugging:  it doesn't happen often but at some
> point we run out of ideas and start making different functions fail in
> prod to figure out why we're not prodding.

For those purpose, isn't it enough to add a taint flag for the fault
injection? This will help us to identify that the kernel is possible
to be under debug mode.

> - overriding return values for security fixes: also not a common thing,
> but it's a tool we've used.  There are usually better long term fixes,
> but it happens.

I don't recommend to use the fault injection for this purpose. For fixing
the security issue online, you should use livepatch.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
