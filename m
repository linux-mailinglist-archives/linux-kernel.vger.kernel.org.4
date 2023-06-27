Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD373FA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjF0KXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjF0KWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D572109;
        Tue, 27 Jun 2023 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QpIG8zIiPiSqoF8aX8idnXur9dqkJW4/QKoTrZH8cD8=; b=AvSWYAQNpQ/maAcKP7sl2uAWaM
        r8VUkC/gUpf8gqV4fszhxttZkOR2LWKnEc87QNlx02OHUeHuUts/aXwTibIk39V5MnW2AcRRxkFw/
        A5XYNmTvrwPSkdZqKNBuRoxZrePTBbZaP9Y1fHc3WOYafzBheEm/pdMdp/JftCUyKwlTmQLUhkkgO
        E5bE9FwoMVtR525XRJIhz1KEncHrv9TwrCTeIrqVtuiHNK4ELXfXcDrCfNZIsKJCz+H+LwZmJiLNU
        tB3d2WpFl5GpcyT6+4gZxPQsriZBPZcc2owzmgLkK5DEA6frQWGkpyGMtkQCmLDXJy7r6s1NWxF9P
        e47EPxlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE5nR-004e0Y-1h;
        Tue, 27 Jun 2023 10:19:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A8D5300118;
        Tue, 27 Jun 2023 12:19:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3790924A40809; Tue, 27 Jun 2023 12:19:39 +0200 (CEST)
Date:   Tue, 27 Jun 2023 12:19:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "J. Avila" <elavila@google.com>,
        Vivek Anand <vivekanand754@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Developers <coreteam@netfilter.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        x86@kernel.org
Subject: Re: Fwd: High cpu usage caused by kernel process when upgraded to
 linux 5.19.17 or later
Message-ID: <20230627101939.GZ4253@hirez.programming.kicks-ass.net>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
 <ZJpJkL3dPXxgw6RK@debian.me>
 <20230627073035.GV4253@hirez.programming.kicks-ass.net>
 <99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 05:15:42PM +0700, Bagas Sanjaya wrote:
> On 6/27/23 14:30, Peter Zijlstra wrote:
> > I can't tell from this. Also, please don't use bugzilla.
> 
> Why not BZ? I'm confused too...

Because we have email; and why would I want to touch a browser for this?
