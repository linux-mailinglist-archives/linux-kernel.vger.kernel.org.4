Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF5624C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiKJUnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKJUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:43:47 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEC24BF6;
        Thu, 10 Nov 2022 12:43:45 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 867912CB;
        Thu, 10 Nov 2022 20:43:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 867912CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668113024; bh=4LcTONyiLyLVkTe5BAYLb5ptVLcYspwd8D5C7sLwB8M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h7BymJ1j/R3RBMfanqMCdTq2mqwWNrmTz9Palwj0nxQv5pU5aJAqWtSeWjRh1gqpU
         7BwwpJsqIL0SBZh+pPr5L3+2ZHTwZH5Y289j8n636i3q1k4FPYsJhHf+OVa+Ia4gZr
         SmEjXO5y+m9lbnV7Uptk9d2C0T1aa/mXiRztzbcKaiRGehan9QvOSklRxAx0/I3VSi
         x8kUM0ACr9dvN7oZa/SUn3+an9bD7/M5QKCfSz/btcZznV1JxMXvLadWxzbQKJ0/uU
         SCaRVxi6BTXgBfME+psovLlFuQ2dcgLSvPnlmaHwM4yDLwMViPOvKWcETTkps2nVOG
         8DlrEwm4ZbV7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
In-Reply-To: <e523ce8c-9c60-13de-7e91-a553de985838@infradead.org>
References: <20221110183352.08cc2303@canb.auug.org.au>
 <CAHk-=wiyYSrBiOKJEV3phOBDT7EMgdXCnDUrp57E8HGNT4SFdA@mail.gmail.com>
 <e523ce8c-9c60-13de-7e91-a553de985838@infradead.org>
Date:   Thu, 10 Nov 2022 13:43:43 -0700
Message-ID: <87a64yh75s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Looks like scripts/kernel-doc is deficient in parsing
>
> struct encoded_page;
>
> without having any { ... }
>
> and it doesn't handle "typedef union" or "typedef struct". :(

It's never needed to do that before...it's not often we document
structure types that don't actually exist :)  kernel-doc wants to be
able to check that all of the fields and such are documented, so it
tries to parse the whole thing.

In this case, the right solution might be to just write kerneldoc
comments for the accessor functions instead, since that's what will
actually be used.

jon
