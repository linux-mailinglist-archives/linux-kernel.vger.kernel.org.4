Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851CA6DA909
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjDGGnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDGGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B95B88;
        Thu,  6 Apr 2023 23:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FCF64F09;
        Fri,  7 Apr 2023 06:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8241EC433EF;
        Fri,  7 Apr 2023 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680849815;
        bh=smTCBFIGHrjUaej+WC9aX2FlcE+64sY4UeW5a0kKAIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bFbZEIl0PqlT4iE55biHBcvpvPjEhQGGSAMrUC78/UBrOsEWT9pmV/UfDW1BtB3iC
         kfETtlc7+y2g93BkQb8T9mJdf2cNkOJUgdANbXEWojEkiX6rM3WRBpZinYj04r57gm
         XsALMDaZ5s2w9bIoayALpkirMbkBYieIaWXaCyc5Spp7h4kA5/0kVhi2ldW+f4tqNs
         tgv9H4YEf4cBQqSGvAZar82oOBLL3rNECvKpOxMOtPzodxltp9QU+i9pQ13DX+tKel
         mZgRrBXOQ3i5EqFWKGxVQPYI2OK1uLZY3I5VDm9k9q80St+DSJUlELDLuIblA9/TLc
         dwDUcscjUxhJA==
Message-ID: <68d22a80-663c-104a-c51c-496fa1a29d00@kernel.org>
Date:   Fri, 7 Apr 2023 08:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
To:     Mark Brown <broonie@kernel.org>
Cc:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        daniel.baluta@nxp.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405203419.5621-1-danascape@gmail.com>
 <2dc882b7-d09f-dfa0-67a1-3f9e6f1ac457@linaro.org>
 <2c32b1e0-20f7-4d9f-9dbc-8725562e456e@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2c32b1e0-20f7-4d9f-9dbc-8725562e456e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 22:26, Mark Brown wrote:
> On Thu, Apr 06, 2023 at 07:38:19PM +0200, Krzysztof Kozlowski wrote:
> 
>> Please squash all your three WM bindings (wm8711, wm8580 and wm8523)
>> into one binding, if they are the same. Probably other WM from your
>> previous submissions as well. We really do not need binding per each of
>> this simple codecs. If they ever need to grow, then we can split them.
> 
> At a minimum all of these devices should have separate regulator
> specifications should they ever grow regulator support (and ideally
> would have regulators specified in the binding from the get go).

Good point. The bindings are incomplete that's why they look so similar.
Therefore maybe we should not merge them, just like we do not add
non-trivial-devices to trivial-devices schema, just because device is
incomplete.

> There's also no reason to restrict simple CODECs to a particular
> manufacturer...

True, we could extend it to other brands.

Best regards,
Krzysztof

