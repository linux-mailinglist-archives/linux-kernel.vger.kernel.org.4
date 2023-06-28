Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032C47415AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjF1Pvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjF1PvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:51:12 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3B1FEB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=1iJuHJHB1EdBNj+ROyjXEOKp8k7bQvo5TeQDvRwemT4=;
        b=IUlBkFhlxCsnL2+euX2Z+/5DQRPqF67IaLqj7JfOT9enbKQRSkwz8dHUvHuykAWX8DI+UO6E5Hfh8
         AxGovHNPFYSWg/duZTi4xSsDL1O3oSV3Ze5+76MjRl8N3He4O5j+dhYviwTL0JTFCvqsiu38oeg2Sc
         qCtuOLJv5b1JpmmVEiLfwGAq+0T2vmrp6MizxRx4JS6rxf1JWxzw247/wZdPsa3ucX8F7hO0BJ5/PR
         wJR5Oh2WvCs70FJJr8PsuSFUsDmJb+r4rCXbfV0eahCNQLeJTMWo+jMmfI7/QhHjkDlwi0c4ftoiEl
         BlC89IpM1NVfm4vYMzZvysCPAQlHqKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=1iJuHJHB1EdBNj+ROyjXEOKp8k7bQvo5TeQDvRwemT4=;
        b=n/WmLL6foHVUCi+3yWrwkWVXfGv1W1PKPZZhIF9GPDDyB1SXVJui6d/LJxM7lCLs4cHKh6BX7Dori
         +daPrX/Dg==
X-HalOne-ID: 95c56ae6-15cb-11ee-a2f3-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 95c56ae6-15cb-11ee-a2f3-b90637070a9d;
        Wed, 28 Jun 2023 15:51:05 +0000 (UTC)
Date:   Wed, 28 Jun 2023 17:51:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: mark __arch_xchg() as __always_inline
Message-ID: <20230628155103.GA214400@ravnborg.org>
References: <20230628094938.2318171-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628094938.2318171-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:49:18AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> An otherwise correct change to the atomic operations uncovered an
> existing bug in the sparc __arch_xchg() function, which is calls
> __xchg_called_with_bad_pointer() when its arguments are unknown at
> compile time:
> 
> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
> 
> This now happens because gcc determines that it's better to not inline the
> function. Avoid this by just marking the function as __always_inline
> to force the compiler to do the right thing here.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I assume you will find a way to apply the patch.

	Sam
