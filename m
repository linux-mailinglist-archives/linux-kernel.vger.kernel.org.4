Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591D6B02A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjCHJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCHJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:15:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7379F2A6D3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:15:02 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:14:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678266900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rda/hVBYL9tdHrwSbnr3bOIGD8iVEKN6KsERHvgY5/E=;
        b=0Fw9ByjVlUp35tfSRq9QOXOZRVO3Pu8pK+9OyyeIquSSbBsJZyr+PMSB2iZcTws5JhEKic
        P2Z670IW+Kr3Ur2BbeQVx0i/lRWZ2ilrBLZymZHBVDCLargsHWCyCNaFV1/Y+LZS4p/Jvv
        26UDvj4Zx6RM9AYEZzk7Q6J0Dam/ejhrVAuPi+dXeyFpQw+FRbk5sPD5H1jGzbfc+uEOMS
        UAOlZCQlUlzAz4reNkVv5BxfUbsbfXylKv36/SBLr5znU7kLgyuNE8/oeUGfksKxKuN6xs
        GAdqHjerY8wBOLh2BnQcFuhv0DJydV867IG7HztUDON//gx099bweHMi6ffI0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678266900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rda/hVBYL9tdHrwSbnr3bOIGD8iVEKN6KsERHvgY5/E=;
        b=8Dd8WdgjALWZYrcZXhdtFoKucCuO3V8y5aonAG17LfxS3agOgn+J82IIbgzSaHvgaZJTbl
        jxJnAB8tOlsiZBAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        tglx@linutronix.de, nsaenzju@redhat.com, frederic@kernel.org
Subject: Re: [PATCH] softirq: Do not loop if running under a real-time task
Message-ID: <20230308091458.Q42uCjR2@linutronix.de>
References: <20230306154548.655799-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306154548.655799-1-oss@malat.biz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-06 16:45:48 [+0100], Petr Malat wrote:
> Softirq processing can be a source of a scheduling jitter if it executes
> in a real-time task as in that case need_resched() is false unless there
> is another runnable task with a higher priority. This is especially bad
> if the softirq processing runs in a migration thread, which has priority
> 99 and usually runs for a short time.
> 
> One option would be to not restart the softirq processing if there is
> another runnable task to allow the high prio task to finish and yield the
> CPU, the second one is to not restart if softirq executes in a real-time
> task. Usually, real-time tasks don't want to be interrupted, so implement
> the second option.

This affects only PEEMPT_RT, right?

I have plans to redo parts of it. You shouldn't enter ksoftirqd to be
begin with. There is this ktimerd in v6.1 which mitigates this to some
point and I plan to extend it to also cover the sched-softirq.
Other than that, you are right in saying that the softirq must not
continue with a RT prio and that need_resched() is not visible here.
However ksoftirqd itself must be able to do loops unless the
need-resched flag is seen.

Since you mentioned migration thread, how ofter to you see this or how
does this trigger?

> Signed-off-by: Petr Malat <oss@malat.biz>

Sebastian
