Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE42743AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjF3LZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3LZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DDD19BA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4525961722
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BA3C433C8;
        Fri, 30 Jun 2023 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688124320;
        bh=X31RKRIHXlJbmFQz+NTD/ZkZDT5OmzkD7mBCLIY1Www=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOWRoCccKwwIA7EnL67Jli7SOaLQnESZ35Ce3qY46kJyS74eyJYqXBL03LYzlEdmi
         SFvnMyPJm2CeUZMM3SCh85nQlyHJnm0sP6uwtiI2bB+wG3alqnWeNHp7TDlhgCiucx
         88tIPnlUXKVP3JsP076UGn1UAhViduqENAa8u3unLSnbR8tXAbzn7ncws67YNEEZE6
         kJzbwe0zs9nHeJWvOx17qtCkkhRe6FHzyRbtetl9S+U/2ww863XMKAnuViGC0XCSKc
         crHytPY6oNSVaMEyQOvbKNglrzyobWjwaneXnesGW3REXzzNtBQ8EQeYPZl5n9F9za
         K6XWuipXJI2qg==
Date:   Fri, 30 Jun 2023 13:25:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 14/45] posix-timers: Consolidate interval retrieval
Message-ID: <ZJ67nQ6Q8F3mu6Jb@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.816970056@linutronix.de>
 <ZJww66Svi84Bvw9Z@localhost.localdomain>
 <87ttuq14xp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttuq14xp.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 08:47:30PM +0200, Thomas Gleixner wrote:
> On Wed, Jun 28 2023 at 15:08, Frederic Weisbecker wrote:
> 
> > Le Tue, Jun 06, 2023 at 04:37:40PM +0200, Thomas Gleixner a écrit :
> >> There is no point to collect the current interval in the posix clock
> >> specific settime() and gettime() callbacks. Just do it right in the common
> >> code.
> >> 
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > The only difference I see is that we now return the old interval
> > even if the target is reaped, which probably doesn't matter anyway.
> 
> But we don't return it to user space because ret != 0 in that case.

In the case of ->set yes but in the case of ->get there is no error
handling.

But still this shouldn't matter as the task is fetched under rcu protection.
And also it can be reaped by the time we return to userspace, so this is
inherently racy. Well, the effect could be visible if current is the reaper
and it has reaped the target already, then it could expect a 0 value in the
interval. I don't think we care though.

Thanks.
