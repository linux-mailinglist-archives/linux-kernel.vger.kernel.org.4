Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693AB72CC74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjFLR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjFLR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:26:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B9FB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:26:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686590794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIBjGUV+1Qdt7xBVsl779Oh8izwwi2MIffihiqSLtQE=;
        b=X3ZXeLPkA2SjMGwNLr7gDYVKitV03gtazqSmonuYleaT8qV7WePO8zxyR3obAIyYR7hGkq
        EZrUKYsljNj0JRsHQTQBbsZgmlo5Qbr0hMIrHvA9hNG91baBQg97zvCHrbkyKuTH6RRya9
        bccYCnqTSCPaU+6DPMvjzPut8e15ikyaFksG4JqaS2Jcaxzj35IRWfiD8QQu4rPyGDwIc2
        oqdVEUOcbUa/i4zzH9rKwc6IUe1ttyTW4PFhSl02aSz2E1n8x1kC3cWCffzs30HAkArWno
        OOyDNcNAvfo/pg4eXzAj2KJlfg9ypch2frzgW1rxmgwd2NJlGx/M2GyKtsg4lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686590794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIBjGUV+1Qdt7xBVsl779Oh8izwwi2MIffihiqSLtQE=;
        b=4e6f2xFtivul8NfHZaXG6Us0gjAnR32uMcpk94/xal2zn7ah2xDrkQa+eaqGGjIt1+DXhR
        Z+cNiwlVzlOpyODQ==
To:     Breno Leitao <leitao@debian.org>, Borislav Petkov <bp@alien8.de>,
        pawan.kumar.gupta@linux.intel.com
Cc:     pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
In-Reply-To: <ZIdJs0F8Ow4sV27r@gmail.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx> <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
 <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
 <ZIdJs0F8Ow4sV27r@gmail.com>
Date:   Mon, 12 Jun 2023 19:26:33 +0200
Message-ID: <877cs87fsm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12 2023 at 09:37, Breno Leitao wrote:
> On Mon, Jun 12, 2023 at 06:08:07PM +0200, Borislav Petkov wrote:
>> On Mon, Jun 12, 2023 at 07:16:18AM -0700, Breno Leitao wrote:
>> > Sorry, to waht menu specifically?
>> 
>> CONFIG_SPECULATION_MITIGATIONS
>> 
>> It even has the proper text in there, warning people.
>> 
>> menuconfig SPECULATION_MITIGATIONS
>>         bool "Mitigations for speculative execution vulnerabilities"
>>         default y
>>         help
>>           Say Y here to enable options which enable mitigations for
>>           speculative execution hardware vulnerabilities.
>
> I am not sure if these bugs (MDS, TAA) are speculations related. Pawan
> could help us here.

 https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/index.html

might answer your question.
