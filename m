Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9716D0739
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjC3NqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjC3NqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:46:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9271D1991
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XJ16pFUzS6YFSr3Ur+FjbLP7LAyPHGr4htZiJJd9HBk=; b=ldNhFbA1tXlMsL0mumu8xVPGLS
        rR9BL1313Tzy9UsV2h1zrC+p/umO9RPdx1uBFkJsI7b6fNqTTf280/sRzVAWmI1jMIfg3aGQDrazD
        oApbHDZVBcoIC62RuBWzBvvTbWfOVBzhEYnVseYpiDD41SQoA03d5GeShLRfFMHMJ3zepkGfMe+Zs
        RmSSqsIbcZW1mK5o1NtyDzBygzCBMDti5Kjr2ot8qBxZV56f5eK3ZEWRyGnOdldA2MUUpdLqUlmQy
        rt7dW7b7iDanuvXGfrrh9RrliFMrY1mYS0UdMGYKlvPPICR4qTD3AbUaoaqwMv+XG50xDsOKtyJRx
        +PnrZGXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phsbH-007DAa-0B;
        Thu, 30 Mar 2023 13:45:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D96BC3001E4;
        Thu, 30 Mar 2023 15:45:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9959820C0F375; Thu, 30 Mar 2023 15:45:57 +0200 (CEST)
Date:   Thu, 30 Mar 2023 15:45:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Message-ID: <20230330134557.GG124812@hirez.programming.kicks-ass.net>
References: <20230329162610.4130188-1-chris.hyser@oracle.com>
 <d1fbf2d4-8989-effd-c908-2784f386fb8d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fbf2d4-8989-effd-c908-2784f386fb8d@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:28:25PM -0400, chris hyser wrote:
> On 3/29/23 12:26, Chris Hyser wrote:
> > From: chris hyser <chris.hyser@oracle.com>
> 
> Apologies. Something in my email chain put this in, but I think I figured it
> out and sent a version 1.

Not actually a problem -- all patch processing tools can deal with this
since it's a common pattern when forwarding patches written by others.
