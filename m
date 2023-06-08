Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BCB7284AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjFHQOj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFHQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:14:37 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995AD11A;
        Thu,  8 Jun 2023 09:14:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E8F236081100;
        Thu,  8 Jun 2023 18:14:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oqHi80E8qL1V; Thu,  8 Jun 2023 18:14:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1F8CE605DED7;
        Thu,  8 Jun 2023 18:14:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tehA2qorFK82; Thu,  8 Jun 2023 18:14:34 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C30E76081100;
        Thu,  8 Jun 2023 18:14:33 +0200 (CEST)
Date:   Thu, 8 Jun 2023 18:14:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-hardening <linux-hardening@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        senozhatsky <senozhatsky@chromium.org>,
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
Message-ID: <1744246043.3699439.1686240873455.JavaMail.zimbra@nod.at>
In-Reply-To: <ZIHlZsPMZ2dI5/yG@smile.fi.intel.com>
References: <20230607223755.1610-1-richard@nod.at> <20230607223755.1610-2-richard@nod.at> <ZIHlZsPMZ2dI5/yG@smile.fi.intel.com>
Subject: Re: [RFC PATCH 1/1] vsprintf: Warn on integer scanning overflows
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: vsprintf: Warn on integer scanning overflows
Thread-Index: HtQ8lTrkG2Q6/iouRL6tfcEr+5bePw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
>>  	if (prefix_chars < max_chars) {
>>  		rv = _parse_integer_limit(cp, base, &result, max_chars - prefix_chars);
>> +		WARN_ON_ONCE(rv & KSTRTOX_OVERFLOW);
> 
> This seems incorrect. simple_strto*() are okay to overflow. It's by design.

Is this design decision also known to all users of scanf functions in the kernel?

Thanks,
//richard
