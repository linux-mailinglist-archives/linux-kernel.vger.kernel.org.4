Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DB6905A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBIKvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBIKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:50:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0FCEC76
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:49:39 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675939777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZ7H/98z/jOtDV+k2l/UU911c/aZMHld0kyoGx+rVAA=;
        b=Lhk8l0ti3TLghbFdhB6XnrEdcJSPTsmZ0I1RMfBHRTuq0UG91albJC5kL45UZhelPaynOx
        tkQ+IcDn002aGeDf8gcCnfsYngtSKERmpeaBXvgZNEOxwkIQKKIor2NByWyl6y2+FGMSGz
        ptEu/5JbTKC4MJwGj3RNJYpmByI4TEHgtVvkC8F6Llp2OkY3BlH06ERX3aDU1Y8FrxRxuF
        nHetu+Civ00aAbbLHsCIDDpty3arRPutvejkMMQQMGlxF9eYuMzH6zzTJOvlurrtREqVfM
        K37fX8pKYqQKv874vHCorNYl50geRbNsXRszwcsjQgxip3JKDU1okT9cv9mF/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675939777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZ7H/98z/jOtDV+k2l/UU911c/aZMHld0kyoGx+rVAA=;
        b=YjNXtvGBLGsbiEG2NyG+1rf5Yn1gZPqfeD1SWz6mxu+szvOKqbsiiZt6v/mOFs4BybhB/z
        dkQtEr8tMei1K/Ag==
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq: ipi: fix NULL pointer deref in
 irq_data_get_affinity_mask()
In-Reply-To: <774e2812-2856-f146-b8b3-e4f772c5e38a@omp.ru>
References: <b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru>
 <774e2812-2856-f146-b8b3-e4f772c5e38a@omp.ru>
Date:   Thu, 09 Feb 2023 11:49:37 +0100
Message-ID: <875ycb2jwe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08 2023 at 21:35, Sergey Shtylyov wrote:
> On 8/17/22 11:00 PM, Sergey Shtylyov wrote:
>
>> Iff ipi_send_{mask|single}() get called with e.g. an invalid IRQ #, all the
>> local variables there will be NULL -- the problem is that ipi_send_verify()
>> (that's called first thing) doesn't verify its 'data' parameter, resulting
>> in a kernel oops in irq_data_get_affinity_mask() as the passed NULL pointer
>> gets dereferenced.  Add a missing NULL check in ipi_send_verify()...
>> 
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>> 
>> Fixes: 3b8e29a82dd1 ("genirq: Implement ipi_send_mask/single()")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
>    Patch fell thru the cracks? :-/

Obviously :)

/me goes to find trash tongs to pick it up
