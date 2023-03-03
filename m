Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77846AA55D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjCCXHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjCCXH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:07:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A0940F5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wdc4wwRdBZi2KCYL+f49abvbfVFtFlSDviLKIC2K2i4=; b=z5huQjr+4ieWENXLMFi2jLZZ5Q
        11nzUNlRglNFO5GQUhkKA31Yzs3D4aTjF82c8Dibshud/Bf/2dLXdorHuFByMiJkIphgVylVgjvfs
        cqSGt1uwwjqXORfHdWEzqCXOSFyF2zpRRMMh0nh2TIqAS968aVopF88prvyCSgUDa0APZ45idDrau
        CZNqz/rySb8WxC3NI/KQx6U8FTEdHNGCQ04DDLZtKPFc7cl2OWYs6qLIb7iFdTQwFtonKDkPE9KHq
        TcROO+SqarMpMJsLN7gi09Dz7dma8NAsaYEgIAhanBIMDZjAlVSHuq39AX8tfnyVs2GAMhHphVfHQ
        B0dctfhg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYEUP-007mJF-P1; Fri, 03 Mar 2023 23:07:01 +0000
Date:   Fri, 3 Mar 2023 15:07:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Paris <eparis@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        James Morris <jmorris@namei.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usermode-helper code oddity query..
Message-ID: <ZAJ9lfVzZr9Erm/t@bombadil.infradead.org>
References: <CAHk-=whjmfvccPgFSfbpZ4nQ6fkYwTEAZhqZvfW8=rKMDsZarQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjmfvccPgFSfbpZ4nQ6fkYwTEAZhqZvfW8=rKMDsZarQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:44:17PM -0800, Linus Torvalds wrote:
> So this is a bit out of the blue, but I cleaned up some really old
> legacy capability code in commit f122a08b197d ("capability: just use a
> 'u64' instead of a 'u32[2]' array") and in the process I became the
> last person to touch kernel/umh.c.
> 
> Tag, I'm clearly it. Not that I want to take that glory away from
> PeterZ, who was the previous last person to touch that code. In fact,
> I'm just cc'ing everybody who has been touching that file at all in
> the last years, and a few /proc sysctl maintainers too.
> 
> Anyway, I wanted to try to keep the capability code cleanups clear,
> and really only touched the data structure conversion, but I'm just
> left staring at that code and wondering why we have those odd CAP_BSET
> / CAP_PI dummy pointers. They've been there since the whole /proc
> interface was introduced, but they seem strangely pointless.

Actually that seems to have come from Eric Paris on v3.0 via commit 17f60a7da150f
("capabilites: allow the application of capability limits to usermode helpers")

mcgrof@fulton ~/linux (git::master)$ git describe --contains 17f60a7da150f
v3.0-rc1~309^2~1^2~12

> It would _seem_ like it would be a lot simpler and more
> straightforward to just put the actual pointer to the usermodehelper
> capability in there instead, and not have that odd fake pointer
> enumeration at all.

Agreed.

> IOW, I'm wondering what's wrong with a patch like the attached. I
> might be missing something.

Yes, the only thing I think think of is that at first it just seemed
like a good way to abstract access to usage of the same routine for
two separate variables. I can't really see *why* its done that way
though.

The only thing I can think of is perhaps it was a sort of defensive
mechanism back from the days we had tons of sysctls on kernel/sysctl.c
large kitchen sink to prevent someone from thinking they could use
proc_cap_handler() for other variables. That file used to be hell.

> I also would have like that array to be an array of "u32" rather than
> "unsigned long" (because that is, sadly, the interface we have, like
> it or not), but we don't seem to have a proc_dou32vec_minmax(). I
> guess "uint" is the same thing, but it's not pretty. Anyway, that's a
> separate and independent issue from this.
> 
> And no, none of this is important. Just random cleanup of code I
> happened to look at for other reasons.
> 
>            Linus

>  kernel/umh.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 2a4708277335..60aa9e764a38 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -32,9 +32,6 @@
>  
>  #include <trace/events/module.h>
>  
> -#define CAP_BSET	(void *)1
> -#define CAP_PI		(void *)2
> -
>  static kernel_cap_t usermodehelper_bset = CAP_FULL_SET;
>  static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
>  static DEFINE_SPINLOCK(umh_sysctl_lock);
> @@ -512,16 +509,11 @@ static int proc_cap_handler(struct ctl_table *table, int write,
>  	/*
>  	 * convert from the global kernel_cap_t to the ulong array to print to
>  	 * userspace if this is a read.
> +	 *
> +	 * Legacy format: capabilities are exposed as two 32-bit values
>  	 */
> +	cap = table->data;
>  	spin_lock(&umh_sysctl_lock);
> -	if (table->data == CAP_BSET)
> -		cap = &usermodehelper_bset;
> -	else if (table->data == CAP_PI)
> -		cap = &usermodehelper_inheritable;
> -	else
> -		BUG();
> -
> -	/* Legacy format: capabilities are exposed as two 32-bit values */
>  	cap_array[0] = (u32) cap->val;
>  	cap_array[1] = cap->val >> 32;
>  	spin_unlock(&umh_sysctl_lock);
> @@ -555,14 +547,14 @@ static int proc_cap_handler(struct ctl_table *table, int write,
>  struct ctl_table usermodehelper_table[] = {
>  	{
>  		.procname	= "bset",
> -		.data		= CAP_BSET,
> +		.data		= &usermodehelper_bset,
>  		.maxlen		= 2 * sizeof(unsigned long),
>  		.mode		= 0600,
>  		.proc_handler	= proc_cap_handler,
>  	},
>  	{
>  		.procname	= "inheritable",
> -		.data		= CAP_PI,
> +		.data		= &usermodehelper_inheritable,
>  		.maxlen		= 2 * sizeof(unsigned long),
>  		.mode		= 0600,
>  		.proc_handler	= proc_cap_handler,

Feel free to add:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
