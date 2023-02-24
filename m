Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B36A1C54
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBXMlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:41:16 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407867E01;
        Fri, 24 Feb 2023 04:41:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 62C8D3FA55;
        Fri, 24 Feb 2023 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677242473;
        bh=VYSTeFhUHymOJzVGfDtM32Jjb9Ss3teuG3euFgeyF2w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=J4Nchlg13ixTkt3we9I2G3XyyTlC08snI5BpXQTwDeRFwBVEvkMH1JN2yk+Fnry4z
         pAOKJt/b/rlaEz9VwufHXZPzzk7I56n/lbqwSM3sOug1pk3qYLGNHlMl5EauSUmLeJ
         7jZEhM3s1nlRDGcrHW3M1nmIerMqVR1tFFPlsyJ7SdvlzhQRIqAPMtOF+eo/q7qTWm
         U159F1HoCS+BX0va6tqkZFpFTIMwLasuTeyMi9MY6+yiDpiGO7SR3sMallMkXYfGIV
         et9Zoi0Q2w2CUUP+tQs6T06Xe7so+eXExXMGZ+FJ/Mb3u8ZOtg/k8U7DkSosJG3Y7i
         cmNtWc8X7NkMA==
Message-ID: <5220876d-f226-117a-d8ed-1d380cd3f14e@asahilina.net>
Date:   Fri, 24 Feb 2023 21:41:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] rust: macros: Allow specifying multiple module
 aliases
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Finn Behrens <me@kloenk.dev>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
 <20230224-rust-macros-v1-3-b39fae46e102@asahilina.net>
 <Y/hpiWDLm0fB0Xp/@kroah.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/hpiWDLm0fB0Xp/@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 16.38, Greg KH wrote:
> On Fri, Feb 24, 2023 at 04:25:57PM +0900, Asahi Lina wrote:
>> Modules can (and usually do) have multiple alias tags, in order to
>> specify multiple possible device matches for autoloading. Allow this by
>> changing the alias ModuleInfo field to an Option<Vec<String>>.
> 
> Note, manually specifying the MODULE_ALIAS is only really ever done for
> platform drivers today (and I would argue we need to fix that up),
> otherwise the use of MODULE_DEVICE_TABLE() should really really be used
> instead of having to manually specify aliases.

That's the plan, I just added this before adding support for
MODULE_DEVICE_TABLE() when I first realized that it wasn't yet in there!
We were briefly hardcoding the bus aliases for downstream kernels
because the depmod stuff couldn't work with the way device ID tables
were done in Rust downstream at the time (and I only noticed the first
time I tried to build it as a module, since I always develop with
monolithic kernels). That's fixed now ^^

However, the issue is that right now the module macro already takes a
single optional alias, and that doesn't make sense as an API. We could
remove support for this entirely (if I get my Rust MODULE_DEVICE_TABLE()
implementation in, there will be zero users of the alias argument as far
as I know), or add support for multiple aliases. But I think just
leaving it as a single alias doesn't really make sense? It doesn't
represent the way module aliases work, which is 0..N.

I'm fine with removing it if people prefer that, I just thought that for
something as basic as module metadata we might as well do it properly
even if there are no users right now, since it's already half in there...

~~ Lina
