Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833576A0F46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBWSMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBWSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:12:06 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC822A24;
        Thu, 23 Feb 2023 10:12:05 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id x10so44542378edd.13;
        Thu, 23 Feb 2023 10:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEaarM4/v7i0Lz3hIFlrkMuKcSO1J4oYqrHpx/IZ4/Q=;
        b=zYr/etDOmn4y9bRvzJaOj2VY7/S3RtK0w4EIZX4QBXDLivotKS7fmJc9mrumaWOArZ
         LpP7bgmzrt4KOaYyzecLr8Sxhw40M1pmVM93CCOrEpyr52PLofSteesSlE8nYjd4DbLy
         oJLdfCY0GEEYiyCFOzfOu2zscRZkCJcZ/ZWuZwUBsgVOlrsMof1GYld1a8DNmml0nLwp
         7Xx2e3NVqwjmWWMCV3hGcdTyKIxFdT4h2b+v5jzqDjb2jqXfO0LNUgPTpMOQJCI1hmLm
         OjC9kphoNoVNxxeJ9oaUdJ/LeqydiWNVYNx6XAv0rswSbcpjqsx0WivSL38kxazmXnPP
         sB5w==
X-Gm-Message-State: AO0yUKUT5CCMBfTC94xTtU5IMC/Wa/EJKQ7NJ4gATCRwLWtqpDjXZyMt
        EJhu9PqDqQvtBJ7cnI0cBtiNdTqeDrOHRqVHGuCSGpynQLo=
X-Google-Smtp-Source: AK7set+bwHnQcCisA+iUZl7QFkGD3nyxV+T3/46gXI0+hISWrIpYlVWBV6JDac7BpdVg0qbq1B5yIFZFnGzzoNW3seE=
X-Received: by 2002:a50:9f6a:0:b0:4ae:e548:1c6 with SMTP id
 b97-20020a509f6a000000b004aee54801c6mr6007111edf.6.1677175923968; Thu, 23 Feb
 2023 10:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20230223044550.339811-1-luoxueqin@kylinos.cn>
In-Reply-To: <20230223044550.339811-1-luoxueqin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Feb 2023 19:11:52 +0100
Message-ID: <CAJZ5v0jyz_dpKW1GhWN=yYpR9-7WG33GbZ65aoGv+B+R9vEpEw@mail.gmail.com>
Subject: Re: [PATCH -next] PM: tools: add "CPU killed" timeline on arm64 platform
To:     Xueqin Luo <luoxueqin@kylinos.cn>, todd.e.brandt@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 5:46 AM Xueqin Luo <luoxueqin@kylinos.cn> wrote:
>
> On the arm64 platform, the core log of cpu offline is as follows:

Please spell CPU in capitals.

> [  100.431501] CPU1: shutdown
> [  100.454820] psci: CPU1 killed (polled 20 ms)
> [  100.459266] CPU2: shutdown
> [  100.482575] psci: CPU2 killed (polled 20 ms)
> [  100.486057] CPU3: shutdown
> [  100.513974] psci: CPU3 killed (polled 28 ms)
> [  100.518068] CPU4: shutdown
> [  100.541481] psci: CPU4 killed (polled 24 ms)
>
> 'smpboot: CPU (?P<cpu>[0-9]*) is now offline' cannot be applied
> to the arm64 platform, which caused the loss of the suspend
> machine stage in S3.

I'm not exactly sure what you mean by "loss of the suspend machine stage in S3".

>  Here I added core code to fix this issue.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  tools/power/pm-graph/sleepgraph.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
> index 82c09cd25cc2..d816970b0a3d 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -4132,9 +4132,12 @@ def parseKernelLog(data):
>                         elif(re.match('Enabling non-boot CPUs .*', msg)):
>                                 # start of first cpu resume
>                                 cpu_start = ktime
> -                       elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)):
> +                       elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)) \
> +                               or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
>                                 # end of a cpu suspend, start of the next
>                                 m = re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)
> +                               if(not m):
> +                                       m = re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)
>                                 cpu = 'CPU'+m.group('cpu')
>                                 if(cpu not in actions):
>                                         actions[cpu] = []
> --

The changes look reasonable to me, though.

Todd, any comments?
