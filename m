Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F66EF453
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbjDZMai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbjDZMac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:30:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9B2733;
        Wed, 26 Apr 2023 05:30:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q5yqr2YHkz4xFd;
        Wed, 26 Apr 2023 22:30:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682512200;
        bh=8LaY3/EdE4NVsF9YWnEonYJEbMaadgI0VtNBm8ceyN4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ezlHX53XcQh0cJTlV2sS3bQ0g2PN0QTR0hk5JRJFcOcLThfA8983vId1vYMvP+RCJ
         WrG0FLBABNmivnreMK5adZwpHqgw0Re4T72gvomty/kkIUY4uGRyCxA0ltLvkqI1ts
         RyCEFIFgnHc6B5xPUOHtHhFtDNC+EVLo6ia4OtWscKwFXgYS4nH9Vu8nYhcGEdJv6N
         YhNR3Uv8LHXcPLOX7UE49wjPPxBNBtdJYH+vC0Ta/MaycXJ30W9qENqHtO+VTovb20
         giHSyCC0cKz+xh82HBrU1OpLjhoSIaSOe6BJOXymMcev+qVhQy7kIZx3R2TD0t5a1w
         N5ukeAwPKWeew==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
In-Reply-To: <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org>
 <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
Date:   Wed, 26 Apr 2023 22:29:59 +1000
Message-ID: <877ctyzv08.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Fernandes <joel@joelfernandes.org> writes:
> On Tue, Apr 25, 2023 at 6:58=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com=
> wrote:
...
>
> Out of curiosity for PPC folks, why cannot 64-bit PPC use per-task
> canary? Michael, is this an optimization? Adding Christophe as well
> since it came in a few years ago via the following commit:

I think Christophe also answered these in his reply.

We do use a per-task canary, but because we don't have "current" in a
register, we can't use the value in current for GCC.

In one of my replies I said a possible solution would be to keep current
in a register on 64-bit, but we'd need to do that in addition to the
paca, so that would consume another GPR which we'd need to think hard
about.

There's another reason to have it in the paca, which is that the paca is
always accessible, even when the MMU is off, whereas current isn't (in
some situations).

In general we don't want to use stack protector in code that runs with
the MMU off, but if the canary wasn't in the paca then we'd have a hard
requirement to not use stack protector in that code.

cheers
