Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9434864ED5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiLPPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLPPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:03:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4EF4A5B7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:03:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EFBD5D0B0;
        Fri, 16 Dec 2022 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671202997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9KisPsVRKMU9Y9GSdp6ns77n16JF/alFGvZ9mhsHCgY=;
        b=w7m1JrUFNUHLp1VgTO3SNpkvbBYIkoxloHDYibci+KUuoI8HDvmbQVbmKcIZaNybvF66cl
        lsXEwHLm7Ff2zBpqTLr2XEk3nT8fWK6Yfr9+jb2EMgGHTSR/BB+5T7pEhtwRw5hwtUDcn6
        zS8ErzK5FHddwSWY8ZBSkixItSi6PPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671202997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9KisPsVRKMU9Y9GSdp6ns77n16JF/alFGvZ9mhsHCgY=;
        b=+FdzYC1/GkY0dfZADGewqc8/PnmWJ2LON11iKkWmFfqWLsj4sdDMetbqXmldQm29s5jDhu
        sTN/dx48nZ6fGmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FEBC138FD;
        Fri, 16 Dec 2022 15:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qcrgB7WInGNdewAAMHmgww
        (envelope-from <jwiesner@suse.de>); Fri, 16 Dec 2022 15:03:17 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 981F329795; Fri, 16 Dec 2022 16:03:16 +0100 (CET)
Date:   Fri, 16 Dec 2022 16:03:16 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v6 2/6] locking/rwsem: Disable preemption at all
 down_read*() and up_read() code paths
Message-ID: <20221216150316.GA19097@incl>
References: <20221118022016.462070-1-longman@redhat.com>
 <20221118022016.462070-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118022016.462070-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:20:12PM -0500, Waiman Long wrote:
> Commit 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically
> spin on owner") assumes that when the owner field is changed to NULL,
> the lock will become free soon. Commit 48dfb5d2560d ("locking/rwsem:
> Disable preemption while trying for rwsem lock") disables preemption
> when acquiring rwsem for write. However, preemption has not yet been
> disabled when acquiring a read lock on a rwsem. So a reader can add a
> RWSEM_READER_BIAS to count without setting owner to signal a reader,
> got preempted out by a RT task which then spins in the writer slowpath
> as owner remains NULL leading to live lock.
> 
> One easy way to fix this problem is to disable preemption at all the
> down_read*() and up_read() code paths as implemented in this patch.
> 
> Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Tested-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
