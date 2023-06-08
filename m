Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5877284A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjFHQMZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjFHQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:12:23 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C28311A;
        Thu,  8 Jun 2023 09:12:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 093FC605DED7;
        Thu,  8 Jun 2023 18:12:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YsTv-yOP3HrN; Thu,  8 Jun 2023 18:12:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7E9E36081100;
        Thu,  8 Jun 2023 18:12:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VYHkTxYt_ulp; Thu,  8 Jun 2023 18:12:11 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 508B4605DED7;
        Thu,  8 Jun 2023 18:12:11 +0200 (CEST)
Date:   Thu, 8 Jun 2023 18:12:11 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
        kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Message-ID: <520885538.3699431.1686240731083.JavaMail.zimbra@nod.at>
In-Reply-To: <ZIHzbBXlxEz6As9N@alley>
References: <20230607223755.1610-1-richard@nod.at> <202306071634.51BBAFD14@keescook> <ZIHzbBXlxEz6As9N@alley>
Subject: Re: [RFC PATCH 0/1] Integer overflows while scanning for integers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Integer overflows while scanning for integers
Thread-Index: eRz4qdIczSWHayESvWhfMkCVWHkibA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Petr Mladek" <pmladek@suse.com>
> On Wed 2023-06-07 16:36:12, Kees Cook wrote:
>> On Thu, Jun 08, 2023 at 12:37:54AM +0200, Richard Weinberger wrote:
>> > Hi!
>> > 
>> > Lately I wondered whether users of integer scanning functions check
>> > for overflows.
>> > To detect such overflows around scanf I came up with the following
>> > patch. It simply triggers a WARN_ON_ONCE() upon an overflow.
>> > 
>> > After digging into various scanf users I found that the network device
>> > naming code can trigger an overflow.
>> > 
>> > e.g:
>> > $ ip link add 1 type veth peer name 9999999999
>> > $ ip link set name "%d" dev 1
>> > 
>> > It will trigger the following WARN_ON_ONCE():
>> > ------------[ cut here ]------------
>> > WARNING: CPU: 2 PID: 433 at lib/vsprintf.c:3701 vsscanf+0x6ce/0x990
>> 
>> Hm, it's considered a bug if a WARN or BUG can be reached from
>> userspace,
> 
> Good point. WARN() does not look like the right way in this case.

Well, the whole point of my RFC(!) patch is showing the issue and providing a way
to actually find such call sites, like the netdev code.
 
> Another problem is that some users use panic_on_warn. In this case,
> the above "ip" command calls would trigger panic(). And it does not
> look like an optimal behavior.

Only if we don't fix netdev code.
 
> I know there already are some WARN_ONs for similar situations, e.g.
> set_field_width() or set_precision(). But these do not get random
> values. And it would actually be nice to introduce something like
> INFO() that would be usable for these less serious problems where
> the backtrace is useful but they should never trigger panic().
> 
>> so this probably needs to be rearranged (or callers fixed).
>> Do we need to change the scanf API for sane use inside the kernel?
> 
> It seems that userspace implementation of sscanf() and vsscanf()
> returns -ERANGE in this case. It might be a reasonable solution.
> 
> Well, there is a risk of introducing security problems. The error
> value might cause an underflow/overflow when the caller does not expect
> a negative value.

Agreed. Without inspecting all users of scanf we cannot change the API.

> Alternative solution would be to update the "ip" code so that it
> reads the number separately and treat zero return value as
> -EINVAL.

The kernel needs fixing, not userspace.

Thanks,
//richard
