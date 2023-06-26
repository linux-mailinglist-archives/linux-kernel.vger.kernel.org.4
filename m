Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF573D94C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjFZINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjFZINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:13:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB5A10E7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:12:59 -0700 (PDT)
Date:   Mon, 26 Jun 2023 10:12:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687767176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ieJMa1dJGSeBQ+5q42kvQ0aAwTr385DfbQKxpY80eJY=;
        b=IgG+lBKQBgg9H8LdKmQ8ypTwQqagxrKjxmmRdAW8dlqjmExvsJ7u6Rn9HiUDllJJ5hez9Q
        M85Kbzb9hu8kmT5rYmioCqBTqiWQJ+E+e6z+AFBPbxl71X0T6HsYz911uizKvWak5XbMZT
        3ndKHvticc/yMbZsBTGbhapUxnznG6Jq8+fNSZKVx8pcB4SxleIZfJddGVvl3T6wld6V5e
        ktpQx1ib0ydwYFUzvkyrwFFuggu3cNUffpsweJoUJLT9C3WhrxWue5hh3FmpmN5iDp1som
        t2CDRc+NC1kRlDCrYTbSi1FwYWTYw0tDAKhnPJdd1KDv4LoJpIhRpDyvuCjYtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687767176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ieJMa1dJGSeBQ+5q42kvQ0aAwTr385DfbQKxpY80eJY=;
        b=imivjTsUAOGZ3TGDtu6GA8nDyVCkx2kGtQLzCLhB+1IN2eYad2VW4HiTO+RfnyH6p3qQl6
        aRurbMNxTP5jbIAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <20230626081254.XmorFrhs@linutronix.de>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
> Why not to do the same on the end side?
>=20
>  static inline void do_write_seqcount_end(seqcount_t *s)
>  {
> - 	seqcount_release(&s->dep_map, _RET_IP_);
>  	do_raw_write_seqcount_end(s);
> +	seqcount_release(&s->dep_map, _RET_IP_);
>  }

I don't have a compelling argument for doing it. It is probably better
to release the lock from lockdep's point of view and then really release
it (so it can't be acquired before it is released).

Looking at other locking primitives (spin_lock_unlock(),
mutex_unlock(),=E2=80=A6) that is what they do in the unlock path: lockdep
annotation followed by the actual operation. Therefore I would keep the
current ordering to remain in-sync with the other primitives.

Sebastian
