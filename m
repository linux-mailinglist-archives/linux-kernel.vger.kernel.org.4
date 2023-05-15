Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D019A702770
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjEOIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjEOIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D62E49;
        Mon, 15 May 2023 01:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD86620AD;
        Mon, 15 May 2023 08:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8915DC433D2;
        Mon, 15 May 2023 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684140092;
        bh=olAMRw6s9hQhR6pfKJUZieMg8yda1LBQqHGZrpGbpGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MZKyc4OUpvHKXG+EVhdLNGqV2KwAl9GP1vCzJTifHAyJ4yAkDhOd0De5vdWtmjWnW
         xlsWSn3JwGoiqbg0DQmkLJd4g2OdsadDP1BrnqyiP75pz9hslPSrWZrSEesozJ0gRr
         fA6b19uTSyRUTJBhKtVMY4s187ypEYRav6lZdHdAYRw3sVLcsEbvhnKDKGq5pNKh4g
         sObwaX4wVDGjCMdEe4TYyjJrn9e4eGz0sA5XQHiI/LhBmveoo1RMXpOaErPbB4Uyp1
         2HPun3pKAy3hwCPGoIypcpkqKYr0VNimQzMCtrPg2Uh4pF0PswtHKab0ZnGYW9QnWw
         JfXTWzw0Fcerg==
Message-ID: <e1b34042-9de3-92cb-c04d-ba19e3e87f0f@kernel.org>
Date:   Mon, 15 May 2023 10:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        202305140640.VLcvhR5G-lkp@intel.com,
        kernel test robot <lkp@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
References: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
 <202305140640.VLcvhR5G-lkp@intel.com>
 <d35b5a67-eeb3-1f0f-c892-4bafcccbf317@wolfvision.net>
 <40f4e8a3-bac7-f64f-161d-f863103f3aec@kernel.org>
 <e458d47e-e0da-c6a4-f91a-c44b3a66531b@wolfvision.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <e458d47e-e0da-c6a4-f91a-c44b3a66531b@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 10:33, Javier Carrasco wrote:
>>> All these functions are declared in the linux/input/ts-virtobj.h header
>>> and also inline-defined there if ts-virtobj is not selected. If it is
>>> selected (either y or M), the functions are exported from
>>> driver/input/touchscreen/ts-virtobj.c. According to the error report,
>>> ts-virtobj was selected as a module.
>>>
>>> I could build the kernel with the three possible configurations
>>> (ts-virtobj y/n/M) for x86_64 as well as for arm64 with no errors or
>>> warnings repeatedly, so I am a bit confused now. I am probably
>>> missing something, but I do not know what.
>>>
>>> I wonder if the new file where the functions are defined (ts-virtobj.c)
>>> could not be found by some reason or if the test build does not like the
>>> way I handled the function declaration/definition. Any hint or advice
>>> would be more than welcome.
>>
>> The report is correct. Build driver builtin and your virtual as module.
> 
> You are right, that was the configuration I was missing, which I
> honestly did not even consider when I tested this feature.
> 
> The problem seems to be that I am using the IS_ENABLED macro which
> returns true if selected as a module, but the define is in that case
> CONFIG_TOUCHSCREEN_TS_VIRTOBJ_MODULE instead of
> CONFIG_TOUCHSCREEN_TS_VIRTOBJ. As I am using the latter define in the
> Makefile, it does not get compiled.

This could be proper solution for build failure but does not look like
the proper solution for entire choice/design. The questions are: why
TOUCHSCREEN_TS_VIRTOBJ should be selectable by user? How can user know
that he needs a driver with VIRTOBJ?

I think he cannot and your config help option suggests that:
"you are using a touchscreen driver that supports printed overlays".
What driver supports or not, is a job for kernel developers. Not for
kernel configurators or distros. User should never investigate whether
his touchscreen driver support printed overlays. Why would user like to
dig into kernel to know that? Thus either your driver should select
VIRTOBJ or depend on it.

Best regards,
Krzysztof

