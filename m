Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F470D2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 06:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjEWETp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 00:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEWETn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 00:19:43 -0400
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [IPv6:2001:41d0:203:375::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC385FA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 21:19:42 -0700 (PDT)
Date:   Tue, 23 May 2023 00:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684815581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMAr9JP2hoTAH+Bide6gNNQRYXdTO7ObonfjjJc9oAw=;
        b=oXT0gBS0u1+rwwEAfPnn9QDggZKtT2BAOBV7RLC3zSDszYSfm4EuvaQgdu7QcBnDUYC9lQ
        KhWQE+igjycWN7q3usgRZ2GkTp3wusMtP5h7YCqfcMEksGjEJsLkYtwuJUpTSUuHPruATl
        /iak359vRwlqxuUyXeUYAlFaaWmgu0s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2] locking: SIX locks (shared/intent/exclusive)
Message-ID: <ZGw+2abYSDohPG2E@moria.home.lan>
References: <20230522171314.1953699-1-kent.overstreet@linux.dev>
 <ZGvnJZYQfAmgdsqr@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGvnJZYQfAmgdsqr@boqun-archlinux>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:05:25PM -0700, Boqun Feng wrote:
> > + * bits 29-30		has read waiters
> > + * bits 30-31		has intent waiters
> > + * bits 31-32		has write waiters
> > + */
> > +
> > +#define SIX_LOCK_HELD_read_OFFSET	0
> > +#define SIX_LOCK_HELD_read		~(~0U << 26)
> > +#define SIX_LOCK_HELD_intent		(1U << 26)
> > +#define SIX_LOCK_HELD_write		(1U << 27)
> > +#define SIX_LOCK_WAITING_read		(1U << (28 + SIX_LOCK_read))
> > +#define SIX_LOCK_WAITING_intent		(1U << (28 + SIX_LOCK_intent))
> > +#define SIX_LOCK_WAITING_write		(1U << (28 + SIX_LOCK_write))
> > +#define SIX_LOCK_NOSPIN			(1U << 31)
> 
> ^ NOSPIN is the 31st bit.

Thanks - I think I'll just delete that comment, it's out of date and
the state bits have simplified a bit :)
