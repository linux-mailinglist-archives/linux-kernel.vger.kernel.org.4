Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2E68AEE8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBEIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBEIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:54:42 -0500
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549301A948
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 00:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=eiTAJ6Fb1BEUZsI/zThiZGrV6qs6o1U3O5z3WSMn4qA=;
        b=wppCrFKPnUt7gtXA8wVIfnSw7NL1scztg1euQLfHMJMcmfPOmk3AUQxOJV0dPDiaYkAUyoktahwb+
         CiY+N3q5roMDa7vB2w2uwnnHF060rLXu/DVswPXisri/y6wbcy1uEwG4gyqdD08OOQOtlWUK0YfcCf
         ZD62usawAyEfwa9HqFXmlJx1HAXO+DIIuyHPnqnDdJmq/S9RAtP+s8ER4hzNT6EFnc0i3h0/D12fjv
         lvSUDzKFSbOVzripUlnn8gxljea5lS1iX3/bwQFtgk6KokGkZjVvqnTht1vKGC8teo9BjfjN0VMkfc
         4MM/Xc4l1FRafJ5WlPvjVJMghOG7kFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=eiTAJ6Fb1BEUZsI/zThiZGrV6qs6o1U3O5z3WSMn4qA=;
        b=rhAKE5L1LTr703ddXrg25V3mR6n5YpEgIJFnHySXoegHC4TVT07v1oLgUPMYFnPHNAMiu7rEGL3mX
         NbNsvg5Ag==
X-HalOne-ID: b6b67382-a532-11ed-bc20-11abd97b9443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id b6b67382-a532-11ed-bc20-11abd97b9443;
        Sun, 05 Feb 2023 08:54:37 +0000 (UTC)
Date:   Sun, 5 Feb 2023 09:54:36 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Kirill Tkhai <tkhai@yandex.ru>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: allow PM configs for sparc32 COMPILE_TEST
Message-ID: <Y99uzN8lI/U3Jkxb@ravnborg.org>
References: <20230205004357.29459-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205004357.29459-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 04:43:57PM -0800, Randy Dunlap wrote:
> When doing randconfig builds for sparc32 with COMPILE_TEST,
> some (non-Sparc) drivers cause kconfig warnings with the
> Kconfig symbols PM, PM_GENERIC_DOMAINS, or PM_GENERIC_DOMAINS_OF.
> 
> This is due to arch/sparc/Kconfig not using the PM Kconfig for
> Sparc32:
> 
>   if SPARC64
>   source "kernel/power/Kconfig"
>   endif
> 
> Arnd suggested adding "|| COMPILE_TEST" to the conditional,
> instead of trying to track down every driver that selects
> any of these PM symbols.
> 
> Fixes the following kconfig warnings:
...
> 
> Fixes: bdde6b3c8ba4 ("sparc64: Hibernation support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Kirill Tkhai <tkhai@yandex.ru>
> Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
I hope Andrew picks this up.

	Sam
