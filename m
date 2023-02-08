Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6768F95F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjBHVCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjBHVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:02:18 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730294C6F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JyTei5zpK8ApzCKRu7QoHZ4mObsZ47vMw3jzATgftIs=; b=dy9Vl6+wUpEsXjTv/0b8bbhkKo
        +HPC0EdhdNsvTJQJ2LOON3AYQWBWwYJxazPIOXdri+VEl6syQ6OvNSJEZwsbz15bPisZFlB2Jqh/k
        kar3T7La6bku7d7JuXVgU9hkJStLbSE7xEicgZ+pnPrdSK9TkP5xBUzXVI4/yRPczSy/r22HWDDTI
        sSW9z+GsVFMSKw+eCV0qsZiITVK42X+iW67PCly3fEERLrHhVdqcmQub2lXfofBfDR8Fd1S1gjO3g
        gEXleHzCHzBJEsmm4jIX5j3EM9cRAO3EWQ1zIGu1SMXDmogH4Pfh8xp1OAXFBLJU4aUsjqjY5WE5t
        CSodS9XA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPrYP-007aoQ-24;
        Wed, 08 Feb 2023 21:00:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 709A6300129;
        Wed,  8 Feb 2023 22:01:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DA38209BAB68; Wed,  8 Feb 2023 22:01:11 +0100 (CET)
Date:   Wed, 8 Feb 2023 22:01:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Message-ID: <Y+QNlx3VmeStqz+X@hirez.programming.kicks-ass.net>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
 <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
 <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:44:04PM +0100, Peter Zijlstra wrote:

> Works as advertised. Next up are 8 12 byte nopes and 8 13 byte nops,
> after that we're left with:

Yeah, we can ignore those, those are the retpoline thunks being patched.
They should be totally unused. These NOPs are after an indirect jmp and
as such pure speculation food.

Arguably I should just merge that patch that turns them into UD2 --
funneling and all that.

But there was some i386 issues... oh well.
