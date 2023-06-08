Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A77284B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjFHQTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjFHQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC0E11A;
        Thu,  8 Jun 2023 09:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1E4F64B2E;
        Thu,  8 Jun 2023 16:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D634BC433EF;
        Thu,  8 Jun 2023 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686241175;
        bh=TOwT0GuJCz2bKXbQWOs8IqmDNX1diLd0cKOY/ea6+9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRW6izjx7+VO0YQ7ZXQ7nXFDTCyvOCxELhItwX4djo6jBb0usZ+WJ4ThHAzlHba9d
         z85IjLzhK3CoEMQXIt6RJkx3nDPQE+FmFRJpUNpIgFfizrchWjnEY6eNH6FQMyWiu1
         23uqEAjCd0U4Dz0N5FLleaTbsVmKEbaZoS9WJjLk=
Date:   Thu, 8 Jun 2023 18:19:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC PATCH 0/1] Integer overflows while scanning for integers
Message-ID: <2023060820-atom-doorstep-9442@gregkh>
References: <20230607223755.1610-1-richard@nod.at>
 <202306071634.51BBAFD14@keescook>
 <ZIHzbBXlxEz6As9N@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIHzbBXlxEz6As9N@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:27:40PM +0200, Petr Mladek wrote:
> On Wed 2023-06-07 16:36:12, Kees Cook wrote:
> > On Thu, Jun 08, 2023 at 12:37:54AM +0200, Richard Weinberger wrote:
> > > Hi!
> > > 
> > > Lately I wondered whether users of integer scanning functions check
> > > for overflows.
> > > To detect such overflows around scanf I came up with the following
> > > patch. It simply triggers a WARN_ON_ONCE() upon an overflow.
> > > 
> > > After digging into various scanf users I found that the network device
> > > naming code can trigger an overflow.
> > > 
> > > e.g:
> > > $ ip link add 1 type veth peer name 9999999999
> > > $ ip link set name "%d" dev 1
> > > 
> > > It will trigger the following WARN_ON_ONCE():
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 2 PID: 433 at lib/vsprintf.c:3701 vsscanf+0x6ce/0x990
> > 
> > Hm, it's considered a bug if a WARN or BUG can be reached from
> > userspace,
> 
> Good point. WARN() does not look like the right way in this case.
> 
> Another problem is that some users use panic_on_warn. In this case,
> the above "ip" command calls would trigger panic(). And it does not
> look like an optimal behavior.

"some users" == "most major cloud providers and a few billion Android
phones"  So in pure numbers, the huge majority of Linux systems running
in the world have that option enabled.

So please don't use WARN() to catch issues that can be triggered by
userspace, that can cause data loss and worse at times.

thanks,

greg k-h
