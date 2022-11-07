Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3356200E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiKGVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiKGVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:18:08 -0500
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C3E3F2EF0D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:15:04 -0800 (PST)
Received: (qmail 3224 invoked from network); 7 Nov 2022 21:15:02 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2022 21:15:02 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 9FA69AB3A4; Mon,  7 Nov 2022 22:14:40 +0100 (CET)
Date:   Mon, 7 Nov 2022 22:14:40 +0100
From:   Solar Designer <solar@openwall.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
Message-ID: <20221107211440.GA4233@openwall.com>
References: <20221107201317.324457-1-jannh@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107201317.324457-1-jannh@google.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:13:17PM +0100, Jann Horn wrote:
> +oops_limit
> +==========
> +
> +Number of kernel oopses after which the kernel should panic when
> +``panic_on_oops`` is not set.

Rather than introduce this separate oops_limit, how about making
panic_on_oops (and maybe all panic_on_*) take the limit value(s) instead
of being Boolean?  I think this would preserve the current behavior at
panic_on_oops = 0 and panic_on_oops = 1, but would introduce your
desired behavior at panic_on_oops = 10000.  We can make 10000 the new
default.  If a distro overrides panic_on_oops, it probably sets it to 1
like RHEL does.

Are there distros explicitly setting panic_on_oops to 0?  If so, that
could be a reason to introduce the separate oops_limit.

I'm not advocating one way or the other - I just felt this should be
explicitly mentioned and decided on.

Alexander
