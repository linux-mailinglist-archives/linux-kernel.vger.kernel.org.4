Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5C678F69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 05:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjAXEmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 23:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXEmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:42:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F410DF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 20:42:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 52B2C4246F;
        Tue, 24 Jan 2023 04:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1674535362;
        bh=WN44PrcFYfKoSeZ8iNlkhBh4hAFJ2coVdS4b3nGwky4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=s6egbtndiSbiZ/wVjze+mu8WzgzI0W5aW1+npUC4X3VfE49li/f2dcxgMfKRdMl5H
         20nlbjOJ1Ruok6qYMdRcs6/+isZz20t/8hPdiiwCbLbHbP5le/67Q3wcF8Q4EL1ony
         0bJaadrNRJ2vnkydz41McBsDozAPGvrNyZfzKFCk99o/ieWO7rOIIrqMKGbma+aADA
         vfT8pf5Bz/rqITgH8ACqEWE58vaTYqB8BCpu2UhMhD7UcjSxZe6B4Q9pLu0oW7KH7k
         U+hBvwVHEo+W8szYaiinwBsCyvKqqW/sgeWW8dXJoedRZ+MTdiiCHzq3XKakanj1jy
         5VykBTJpsSmzA==
Message-ID: <3ddc508c-749d-801c-83fe-c5c4de31498a@asahilina.net>
Date:   Tue, 24 Jan 2023 13:42:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] soc: apple: rtkit: Add register dump decoding to
 crashlog
Content-Language: en-US
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230123031728.22515-1-lina@asahilina.net>
 <CAOgh=FwHc_sy5dfQo8OvnG+gfy6UpW08a6qA7R9ErytG83NHrQ@mail.gmail.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <CAOgh=FwHc_sy5dfQo8OvnG+gfy6UpW08a6qA7R9ErytG83NHrQ@mail.gmail.com>
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

On 23/01/2023 21.18, Eric Curtin wrote:
> On Mon, 23 Jan 2023 at 03:19, Asahi Lina <lina@asahilina.net> wrote:
>>
>> When the coprocessor crashes, it's useful to get a proper register dump
>> so we can find out what the firmware was doing. Add a decoder for this.
>>
>> Originally this had ESR decoding by reusing the ARM64 arch header for
>> this, but that introduces some module linking and cross-arch compilation
>> issues, so let's leave that out for now.
>>
>> Reviewed-by: Sven Peter <sven@svenpeter.dev>
>> Reviewed-by: Eric Curtin <ecurtin@redhat.com>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
> 
> I would be thinking, rather that duplicating the PSR_MODE_* defines
> and values, why not just ifdef the whole
> "apple_rtkit_crashlog_dump_regs(" function and the "case
> APPLE_RTKIT_CRASHLOG_REGS" part (and maybe even
> apple_rtkit_crashlog_regs struct also). Is it worth compiling that
> code on other CPU architectures when PSR seems to be an ARM specific
> thing?

It's mostly just for compile testing! The code is about the architecture
of the coprocessor, not the host CPU, so it still makes sense in
principle (though of course it's not very likely that SoCs with a
combination like that will ever exist). It helped the kernel test robot
find a bad format specifier in this code during a compile test run for a
32-bit arch, so I think it makes sense to keep it.

~~ Lina
