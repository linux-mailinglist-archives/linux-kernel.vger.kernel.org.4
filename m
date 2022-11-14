Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39329627B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiKNLHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiKNLHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:00 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C2FAC1;
        Mon, 14 Nov 2022 03:06:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6FA6941A36;
        Mon, 14 Nov 2022 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1668424016; bh=mEO3KaY4WycE6m/ZsEnGy8Jcr+7DDVadkM8nmAQA1LY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k/asXcbh6z+OeutUMQEIQNPkUjIC8KOxNcIYNi80fAsCVzMK9dhurY+vPp4fDsrca
         DMDgCDkii26DP6CMUnzpgicAP4VrVu1lFDpqE5g5djv4G0qRlKtQ7RNU77MnTg8WZa
         Woo6fwinBRk4uW+QXvy/qQR1813tuX7pdW9AMLPmw6x67bgwZ2nbih/Fb4xIN/vXpX
         VfqnHiOJzBBW9wKod/dpB1mXdpxZx0KK1w4cSQgbzUV5EZQ9dyCN0Nu8Tq4/MsZC4H
         /xtmiuJ5vGjjBS4/0YnFROCKX6Yw06sLlOuEyKTR66P1rnqy7lE2Wsr+9Ramt4SSBJ
         dOM7GDm4ZCh6Q==
Message-ID: <8c7b25f0-aee2-c3ee-c6da-3432b6513c57@marcan.st>
Date:   Mon, 14 Nov 2022 20:06:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-5-marcan@marcan.st>
 <20221102061819.dyl5ah6qffntqieh@vireshk-i7>
 <c3b88bae-f6da-4242-0b19-5e2a32b9c266@marcan.st>
 <20221114065116.zs67pkbhhgfoze52@vireshk-i7>
 <367270ad-114a-96ca-a92a-a7f54a5f3318@marcan.st>
 <20221114070323.gjwgllfd44hthwon@vireshk-i7>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20221114070323.gjwgllfd44hthwon@vireshk-i7>
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

For the benefit of everyone else: I screwed up a reply from mobile and
ended up with a brief exchange offline, but here's the useful part of
the context. Viresh also pointed out dropping opp-shared if we don't use
that mechanism, so I'll do that for v4.

On 14/11/2022 16.03, Viresh Kumar wrote:
> On 14-11-22, 15:57, Hector Martin wrote:
>> There is no way to express this relationship with OPP tables without
>> duplicating the tables themselves.
> 
> Can you show how the DT looks in this case ? I am still not clear on what the
> scenario is here :(

Here's the most complicated one we have so far: 20 cores and 6 clusters
sharing 2 OPP tables (mind the include and define fun - this is the best
way we could come up with to express two SoC dies glued together into
one MCM).

https://github.com/AsahiLinux/linux/blob/asahi-wip/arch/arm64/boot/dts/apple/t6002.dtsi

- Hector
