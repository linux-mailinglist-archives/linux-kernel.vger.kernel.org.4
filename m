Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207265CB46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjADBP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjADBPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:15:24 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B167017066
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:15:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EA5ED41F7F;
        Wed,  4 Jan 2023 01:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672794919; bh=qSDvUWv4Dln/ZMI530762hLaHXHSQxp0JPpDtgI0LJk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=wrWJnfCt3yLfh5yDesDBbs30xMTnbb5YYJXaHYThKPQeV4DQv136G4qn7ptoygBSw
         5mPqT2VJyTBoeLGPugP4OLDz19DSiyg0KTFye7fNeZEZzVvFW6TxO0/KRTByU2aaU4
         K5GyhGpeTGpHbkex6oGK8FYQZzl6NTmBroV6kMsixiRh3rehFESqN/mI5CvOYfLgXW
         bIJwS2fdCt5VzEOnyKw+pyKlt6xfSJ16L9blDwbjZqI9CZj85V8ssBbWNhTNCep1rE
         2lrPvpO4sFN7ow5ZoG6GMRKEeRaTWk32scegCThEHhOdt4L1ENILLAbYBsbSSYj4yd
         xt5qt5qD4IdOg==
Message-ID: <c5b1949f-f39e-8783-19be-cb27c96aea33@marcan.st>
Date:   Wed, 4 Jan 2023 10:15:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/5] Fix a whole host of nvmem registration/cleanup
 issues
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
 <7f6b2a9a-1ffc-424f-2287-5934cf653bde@linaro.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <7f6b2a9a-1ffc-424f-2287-5934cf653bde@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 06.15, Srinivas Kandagatla wrote:
> Hi Russell,
> 
> 
> On 03/01/2023 16:58, Russell King (Oracle) wrote:
>> Hi,
>>
>> This series fixes a whole host of nvmem registration/error cleanup
>> issues that have been identified by both Hector and myself. It is a
>> substantial rework of my original patch fixing the first problem.
>>
>> The first most obvious problem is the race between nvmem registration
>> and use, which leads to sporadic failures of drivers to probe at boot
>> time.
>>
>> While fixing this, it has been noticed that a recent fix to check the
>> return value of dev_set_name() introduced a new bug where wp_gpio was
>> not being put in that newly introduced error path.
>>
>> Then there's a fix for a previous fix which itself purports to fix
>> another bug, but results in the allocated ID being leaked. Fix for a
>> fix for a fix is not good!
>>
>> Then there's an error in the docbook documentation for wp_gpio (it's
>> listed as wp-gpio instead) but as nothing seems to set wp_gpio, we
>> might as well get rid of it - which also solves the issue that we
>> call gpiod_put() on this whether we own it or not.
>>
>> Lastly, there's a fix for yet another spurious white-space in this
>> code, one of what seems to be a long history of past white-space
>> fixes.
>>
>> These patches have been individually build-tested in the order of
>> posting, but not run-time tested except for the entire series.
> 
> 
> thanks for fixing these issues, I have applied these after fixing the 
> subject on all the patches, as it ended up with email ids in subject.

Right. I see none of the issues you two lectured me about actually
mattered, it was all for show, and this isn't getting backported anyway.

Good job you two. The day I finally rage quit the kernel after enough of
this nonsense and make a big dossier of just how fucked up the kernel
maintainer community's attitude is, I will be sure to use this as an
example.

That day is not today though. But I certainly won't be upstreaming any
more patches to nvmem.

- Hector
