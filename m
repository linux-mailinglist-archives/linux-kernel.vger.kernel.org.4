Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6036C68CBB9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBGBJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBGBJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:09:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9954934C0B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B55A61086
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDCFC433EF;
        Tue,  7 Feb 2023 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675732168;
        bh=Is5IYjovA33IkxlkcVAb/pKH9UnUIGnHNwDX3f1xhzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dPWFqqPgigUD7Uw8Q0f0jMeoDqstNCzKcg3Odo+Hw57YCnQP1mRKAnenuQeuTS08i
         bJGrW6vtpe1UCjjGSGZogrpaz783MHOXC6dTrqQrVlTTHVsKOeVmFHPP6PUQ50DFXj
         yBcr42fxnPFaIvOJe8TBRI61ADjqH5u6YX8V4k5w=
Date:   Mon, 6 Feb 2023 17:09:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling
 context
Message-Id: <20230206170927.9d5afee653dfa0738983dbfa@linux-foundation.org>
In-Reply-To: <20230206130449.41360-1-wander@redhat.com>
References: <20230206130449.41360-1-wander@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Feb 2023 10:04:47 -0300 Wander Lairson Costa <wander@redhat.com> wrote:

> Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
> locks. Therefore, it can't be called from an non-preemptible context.

Well that's regrettable.  Especially if non-preempt kernels don't do
this.

Why does PREEMPT_RT do this and can it be fixed?

If it cannot be fixed then we should have a might_sleep() in
__put_task_struct() for all kernel configurations, along with an
apologetic comment explaining why.

