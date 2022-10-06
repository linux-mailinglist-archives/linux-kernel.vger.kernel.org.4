Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418805F64C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiJFLFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiJFLFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:05:13 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333673FD65;
        Thu,  6 Oct 2022 04:05:12 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 13B9284940;
        Thu,  6 Oct 2022 13:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665054310;
        bh=uB3llXnK0KYLYYhpTualwjpRdRLy8b7Ts3GeCKJRb+E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JwS15yadaMbolc4mFfxB7s2jNP+Lhr5urPPF+CnPRGcfEmnCpmG2NDf4vUN5FeKij
         l5CvODJ8va4xbM75MvHU6R2KYGnJ81J+7AqGDmgRiEmyh/DUsy+qUxgEKJ7nmA0Ecf
         XeXQ6SbcVQTAWEJ7jlkA3kyjfqdKDqncGkVyEmunAbFIuKaCDbrNIZ8ygEJt6rOa/d
         4td8/gMzafgxfpe+vFyajFDMOpRip14h5OwGwv6XRnB0MvxwpiuuJSPsYBeTrUzQo5
         LnNij59bho/H57Ky82T13yzLjJbkT+F5bOO/JDifyjyS8q9Vk3hHaRqd8s+Php9ayv
         d/hxmljzpPF2w==
Message-ID: <f85808f9-979d-1dc5-ac9a-9519c62e2737@denx.de>
Date:   Thu, 6 Oct 2022 13:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>, abel.vesa@linaro.org,
        abelvesa@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
 <20221005082348.v43xbjrhbdlbaohv@pengutronix.de>
 <20221005230609.5BA04C433D6@smtp.kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221005230609.5BA04C433D6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 01:06, Stephen Boyd wrote:
> Quoting Marco Felsch (2022-10-05 01:23:48)
>> Hi Stephen, Michael,
>>
>> I know it is a busy time right now, but maybe you have a few minutes for
>> this RFC. I know it is incomplete, but the interessting part is there
>> and it would fix a real issue we encountered on the imx8mm-evk's.

The i.MX8M hang when using 32kHz supplied by PMIC is solved by modeling 
the clock in DT correctly, see:

https://lore.kernel.org/all/20220924174603.458956-1-marex@denx.de/

> There's another approach by Marek[1]. Can you work together on a
> solution? I think we should step away from trying to make the critical
> flag work during clk registration, and turn on the clk during provider
> registration instead.

So that would work like the qualcomm-specific 'protected-clock' property?

I really want to avoid such clock-driver specific hacks which are poorly 
or inconsistently supported. This critical-clock should be a generic 
solution and that should be in clock core.

> That hopefully makes it simpler. We can keep the
> clk flag of course, so that the clk can't be turned off, but otherwise
> we shouldn't need to make registration path check for the property.
> 
> [1] https://lore.kernel.org/all/20220924174517.458657-1-marex@denx.de/

