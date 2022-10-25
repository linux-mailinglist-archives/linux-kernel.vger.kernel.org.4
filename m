Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9DB60D447
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJYTAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJYTAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:00:04 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A8286E4;
        Tue, 25 Oct 2022 12:00:00 -0700 (PDT)
Received: from [10.7.7.5] (unknown [182.253.183.140])
        by gnuweeb.org (Postfix) with ESMTPSA id B519E804FD;
        Tue, 25 Oct 2022 18:59:55 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1666724399;
        bh=CqaYWiGYhpo0ooPSCo8Ptr71Fmqkx1RjwX744NmAy+Q=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=q0+yVgdOymkXEOQWbRij5Zui2/yBpqTRQa8U54HlQLPjwUi9Me7wPlAI/bBdsqKlE
         5gSNo4dw0yh0+Ub6rgjowYMVQmpHqnK6kRgUiv/0OGNLgT9Ikzbz85GPSM/lj9Ig68
         Pw2UHHbkHUTl1OKIgkr2LF3qhOC1nIY6VBwDXYLnf+av+UY4Kj7PDU5OAWHgqHKNiX
         esqvE4S8N0Fa2bGLiz6sfRbI8pmOC0uLiYPG4KPHB5BslUaisuOfROGy18pOII9rU/
         rushACInW7O/+j8f1A0dJ2cwamYBDr0s1ie/eUq34zo+hD4uBMmIU1EZD3oUOtuhYb
         pPjtXoi6uDAOQ==
Message-ID: <e3464bac-82cb-2180-74f5-448e70540190@gnuweeb.org>
Date:   Wed, 26 Oct 2022 01:59:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <Y1gBoUZrRK5N/lCB@kili>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] x86/retpoline: Fix crash printing warning
In-Reply-To: <Y1gBoUZrRK5N/lCB@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 10:32 PM, Dan Carpenter wrote:
> The first argument of WARN() is a condition, so this will use "addr"
> as the format string and possibly crash.
> 
> Fixes: 3b6c1747da48 ("x86/retpoline: Add SKL retthunk retpolines")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hello x86 maintainers,

I found this patch in the tip tree with the following commit message:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/core&id=98dcf58159365d753b54d07f85a89d61ee15e036

	x86/retpoline: Fix crash printing warningx86/core

	The first argument of WARN() is a condition, so this will use "addr"
	as the format string and possibly crash.

	Fixes: 3b6c1747da48 ("x86/retpoline: Add SKL retthunk retpolines")
	Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
	Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
	Link: https://lkml.kernel.org/r/Y1gBoUZrRK5N/lCB@kili

When I visited that lkml link, it shows "message ID not found". The
problem seems to be coming from the tool used to pick up the patch.

That message ID contains a URL special char '/'. Thus it should be
URL-encoded like this:

    https://lore.kernel.org/r/Y1gBoUZrRK5N%2FlCB%40kili

Anyway, lkml.kernel.org doesn't work for such a message ID, even with
URL-encoded message ID like this:

    https://lkml.kernel.org/r/Y1gBoUZrRK5N%2FlCB%40kili (not found)

-- 
Ammar Faizi
