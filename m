Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D273BD64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjFWRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjFWRHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:07:17 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA719C7;
        Fri, 23 Jun 2023 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687540020; bh=kjKd/MMfTv+/haFGlQ1tj3Dy+jsmWNlUJXETIqambKY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=grz78a/jWVbCtEPL2kmt6niKVZO1tfgCOiy/8eI1pw17B1+cMMsWYrtjaZHsmiHpm
         Rv1exG6vZ153foM5WNMfVr2qgBjnqfk6oXVIBH9oIA5JWdx2rheyKZ2SZM25DYukQH
         DosCLAAzTMhln6xLeChZVychPMi2FwpVJR6eBOVo=
Received: from [192.168.9.172] (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0E467600A9;
        Sat, 24 Jun 2023 01:07:00 +0800 (CST)
Message-ID: <64955942-274c-047d-aab3-308fbbe6dfbc@xen0n.name>
Date:   Sat, 24 Jun 2023 01:06:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
 <20230623134351.1898379-8-kernel@xen0n.name>
 <22d794613f70b04544e39e8861737af09365ae8a.camel@xry111.site>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <22d794613f70b04544e39e8861737af09365ae8a.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 01:00, Xi Ruoyao wrote:
> On Fri, 2023-06-23 at 21:43 +0800, WANG Xuerui wrote:
>
>> -cflags-y                       += -G0 -pipe -msoft-float
> -msoft-float should not be removed.  Our consensus (made when I was
> developing https://gcc.gnu.org/r13-6500) is -mabi=lp64s does *not*
> disable floating point instructions, but only disable FPRs for passing
> arguments and return values.  So w/o -msoft-float (or -mfpu=none) GCC is
> allowed to generate FP instructions everywhere in kernel and it may
> cause kernel FPD exception in the future.
Hmm, now I remember (still vaguely) about the discussion... I'll have to 
check how to minimize churn around FPU-touching code though if 
-msoft-float is to be kept.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

