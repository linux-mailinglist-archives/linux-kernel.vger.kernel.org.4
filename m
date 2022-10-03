Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303865F369A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJCToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJCTof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6118B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33CE66119D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C1DC433D6;
        Mon,  3 Oct 2022 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664826272;
        bh=vwbKkuF2wgNTlxFTl7XFVQoe4NhIBY93S/l4jLMNYQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnXQxE7SUkc1jx6jdva0ZwAxXA0Dhmu7omY5dR7Fn4zSBoAemtP8U6PIO/TE29ECC
         hufTXddWx3coKnuOwKsi3xKEXS26OeCqKTAifMy7Cpj0kKrWxUEXqQgEkXIEI0zC6u
         fNPXMQYLBqTpmmCkaJgSOHlVOMpFImP94XpWP4aB387UEyDj3n3zlCGly/vB1mywC/
         UWpbBKiIOYvWaramlJH9RD1sV9d281mXeNXJUzO5jhs2M3uJsC5l4A5giPDVIW/h1Y
         FrGOUJORsKhCf/jFkRYhuX1jMCSpIRsWu9NssnRvDXjSYnTH8K3AJNQGpMT4K3ZKgA
         hoefNnnF8wBpA==
Date:   Mon, 3 Oct 2022 15:44:31 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ryan Huang <tzukui@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: Allow tuning tracing keys constant.
Message-ID: <Yzs7n48vRiE1+ASX@sashalap>
References: <20220930170058.2645213-1-tzukui@google.com>
 <5be617ad-0652-642f-aff8-7b7734f33973@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5be617ad-0652-642f-aff8-7b7734f33973@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 01:34:24PM -0400, Waiman Long wrote:
>On 9/30/22 13:00, Ryan Huang wrote:
>>+config LOCKDEP_KEYS_BITS
>>+	int "Bitsize for MAX_LOCKDEP_KEYS"
>>+	depends on LOCKDEP && !LOCKDEP_SMALL
>>+	range 10 30
>>+	default 13
>>+	help
>>+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_KEYS too low!" message.
>>+
>>  config LOCKDEP_STACK_TRACE_BITS
>>  	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
>>  	depends on LOCKDEP && !LOCKDEP_SMALL
>
>The lockdep key is embedded in a bit field within the held_lock 
>structure to utilize all the 32 bits of an integer. Changing its size 
>will require adjusting other bit fields or expand the bit field size 
>from 32 bits to 64 bits. 13 bits allows up to 8k unique lock classes. 
>Unless there is good evidence that we are going to run out of that, we 
>shouldn't change it.

Right, and this patch doesn't propose changing that (the value is
currently hardcoded to '13', and the config option defaults it to 13).

This change is about making it configurable.

-- 
Thanks,
Sasha
