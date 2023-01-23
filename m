Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F29677DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjAWOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjAWOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:11:14 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB7173C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:11:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3967E424B1;
        Mon, 23 Jan 2023 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1674483070; bh=bbSIP462T9IWJaDvs/yDGdukakATco/XlecnUVLW0Kc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=aNzR9wYhRljXiqeQMoLIwTCDWNVbBoGhIrA4GnKrkPQ9c9t2u5ngI8f9gBb1yXzgo
         9E5Sl6buIuusWwrDr3VGZQb5vx6WcNwVm69yqO5LQE9bJFtjsw5nItPkvgxF1zFTft
         SRxwvDdmvANYiKCvj6L4TJ1vZ55eeyQyFxLtCfRa9jS4TGp/x5jdvZPjoMVqR+gvRx
         dfhzeGvPZHNRaars5DZevjeOe1ElHKm8QZv4ur4skU++VvuvPaxUss9TmJ1BJIsQz4
         W8DQb2OT29f/4IscyaD9UmAGYSliOHD+dH27avqHJjXzNZHx3I3Ukbn847wQUEB1WE
         8T0U9p7dWJGMg==
Message-ID: <8790890e-f33c-47f2-6704-e6666e516f9f@marcan.st>
Date:   Mon, 23 Jan 2023 23:11:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123065125.26350-1-marcan@marcan.st>
 <CAOgh=FwEpMGx-F6GZumOBkBYShtU_SVUWTzZ+WWY0Euc-75YGQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] soc: apple: apple-pmgr-pwrstate: Switch to IRQ-safe mode
In-Reply-To: <CAOgh=FwEpMGx-F6GZumOBkBYShtU_SVUWTzZ+WWY0Euc-75YGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20.22, Eric Curtin wrote:
> On Mon, 23 Jan 2023 at 07:01, Hector Martin <marcan@marcan.st> wrote:
>>
>> This requires changing the reset path locking primitives to the spinlock
>> path in genpd, instead of the mutex path.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
> 
> It seems we need this to avoid a race from reading #asahi-dev IRC,
> commit message could be more detailed here.
> 
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Not exactly, that was unrelated. We just need this to be able to switch
power states from IRQ/atomic context, which came up when adding runtime
PM to the DART driver (IIRC, this was a few weeks back and I threw
runtime PM into like 3 drivers that day so I might be misremembering,
but we definitely need it for one of them :-)).

The power state part of the driver itself is trivially IRQ-safe already,
so there is no reason not to do it. We just have to switch the locking
primitive the reset code uses (genpd already supports both), which is
only used to provide the reset functionality safely since it involves
the same register as the power state control.

- Hector
