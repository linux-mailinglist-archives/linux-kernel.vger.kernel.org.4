Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB307615161
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKASRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKASR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:17:29 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A810548;
        Tue,  1 Nov 2022 11:17:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 90F894267F;
        Tue,  1 Nov 2022 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1667326644; bh=GJ6UagwrNwG/uy6EayoDIRM68iGK+xdSGDUz3nYaQYk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=zL6q+tNEyi5i/2DUXyv6d24t0f5qiyTKF5Oyf7Zy6rigRBpX7SEPw6hEZwy7xg7Zl
         1IM4ww4DszMY8f0McbZqzDAnwG6/J8eMNfLfWGZW702nTigM6q5w2cR8YN/xVp0x/l
         Ybi6RNCHP3YadSkYjDe5nvu8Gt5fkaS40rPfkU8wZMjBcUVZZzobfnSsIAGm+jFcvE
         +M6ZptTWWuJtYaSGMtURzQPCZ4WPNEikroi1LWyJ1HE1QnMtD19PcNViH5naCsCMgn
         jeSzUbZ8gEF8b7gcurOGoyVhxcsTUqcBKMMo3BjpO5n3AaKEMj1ffglaHIFIqzgiij
         yHxuxbK5p17Dw==
Message-ID: <c791b776-c90f-4ee5-b025-79352937bf62@marcan.st>
Date:   Wed, 2 Nov 2022 03:17:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-5-marcan@marcan.st>
 <CAPDyKFqYr5NDhZNT=EHWzWq=eCZKbF8Z3Y0eRHY8-nY7Ej0PBw@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <CAPDyKFqYr5NDhZNT=EHWzWq=eCZKbF8Z3Y0eRHY8-nY7Ej0PBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 00.16, Ulf Hansson wrote:
> On Mon, 24 Oct 2022 at 06:40, Hector Martin <marcan@marcan.st> wrote:
>>
>> This driver implements CPU frequency scaling for Apple Silicon SoCs,
>> including M1 (t8103), M1 Max/Pro/Ultra (t600x), and M2 (t8112).
>>
>> Each CPU cluster has its own register set, and frequency management is
>> fully automated by the hardware; the driver only has to write one
>> register. There is boost frequency support, but the hardware will only
>> allow their use if only a subset of cores in a cluster are in
>> non-deep-idle. Since we don't support deep idle yet, these frequencies
>> are not achievable, but the driver supports them. They will remain
>> disabled in the device tree until deep idle is implemented, to avoid
>> confusing users.
> 
> Out of curiosity, may I ask if this implies the need of a
> synchronization mechanism on the Linux side? Or is the boost frequency
> dynamically managed solely by HW/FW?

It's managed by hardware - Linux gets to request whatever frequency it
wants, and the hardware will limit it to what is achievable given the
current idle states within the cluster (and it will change automatically
with them). So if Linux asks for 3.2 GHz but there are no deep idle
cores in the cluster, you get 3.0. If there's one deep idle core, you
get 3.1 (I think). Three, 3.2. So this driver doesn't have to do
anything (and will report the correct current-frequency as long as the
per-SoC compatible is matched; without that this feature is disabled and
it just reports the requested frequency). We could enable the boost
states today just fine, it's just that they would never actually be
reached by the hardware.

- Hector
