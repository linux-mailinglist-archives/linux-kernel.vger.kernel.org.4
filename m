Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B066133A9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJaKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJaKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:30:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3416DFE2;
        Mon, 31 Oct 2022 03:30:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v27so16806883eda.1;
        Mon, 31 Oct 2022 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkfY3OKUEb1lL3Bfe/yjIjQzK3oeH8bSWlJlOHIXGiE=;
        b=WeCNjBWfLE2cu4AqgVxwuz6y7Jc+k9wx9QAUEcaN/D6fuaGxQw4tdi12AOUVu2PSiL
         R69NCNd+ZwVy43Y7EGQmTkTcZKYQ1YMV57e3VpOKXfP+Q95nxr2N4dbCxLt2O4IfeyUi
         PUI10Vm8TG1xc4D/SdcuMaJfdG1BhANXFuYlXesbsx6ju9lOaE6FdANboIZSdarrubvZ
         KVAdZKmyZz5nx7l8fJVAsodAwdgEGJKr85inPYUizIVaBkA6IaiP5vewm5TLe1ssL7Ze
         VpbnCI67O2aBlRV8LGI833AyrpY/QiiCn74K2TwOP1P4QXtf3j+aqMnOl2ihkMnBI6fj
         7XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkfY3OKUEb1lL3Bfe/yjIjQzK3oeH8bSWlJlOHIXGiE=;
        b=Rmg/SurCfxWqxYO9j9e6lxYp+ngH1bqTfD2jGbInu9/6EfOEQnIeBIAH7qkIiMNic7
         BfjXKjllPIZJUN/SocjH8pdwbXNAXvCQvyCK+KnSWF2Wlvkj4m9Wq26GSSuDzR+hAFvl
         9ODgwywpN+klK2tFDNekb7Oh3no2vh0ZiFznWXbyh2MuvrnJ6putLOJRsLYwHbrn4fS1
         9oZcG4fXE+IPP6iyyB7LZ6bvKOzag05uCd+k8SrszUGwrCG5PZakHBDhW7cO9Wgw6axK
         LEwthn8QX5YaMuw1a2477wjmMbADlUOGWb1gMjcOZeMNoFZzaatT7XUZCXsWLqxacTGJ
         OUaw==
X-Gm-Message-State: ACrzQf2Ed889D3uZSOe+qQXeSN7GUr6zhxzoSJGlO6raIuekxxeUPBwO
        SKvbcStxyESof+BKmKZlDDI=
X-Google-Smtp-Source: AMsMyM58xPXb9PLApmoVRMOgeG546jQFtpocVEZzBFNb44Snwz4s4WgLZIsVLu9hSj1k5oigRg7rBg==
X-Received: by 2002:a05:6402:174f:b0:463:12ed:3f8f with SMTP id v15-20020a056402174f00b0046312ed3f8fmr10249383edx.67.1667212243275;
        Mon, 31 Oct 2022 03:30:43 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id re21-20020a170906d8d500b007415f8ffcbbsm2841076ejb.98.2022.10.31.03.30.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 03:30:42 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
To:     Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <4B3F8E50-3472-4AED-9A77-3E265DF8C928@goldelico.com>
 <0000784a-ae89-1081-0ec7-fc77d3381545@gmail.com>
 <Y1+f0zG50ZR4aWGX@atomide.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <71a44adf-a97b-07cd-18d3-026bef229a6d@gmail.com>
Date:   Mon, 31 Oct 2022 12:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <Y1+f0zG50ZR4aWGX@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.10.22 г. 12:13 ч., Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221031 06:55]:
>> On 31.10.22 г. 0:08 ч., H. Nikolaus Schaller wrote:
>>> [   39.419846] WARNING: CPU: 0 PID: 3673 at drivers/bus/omap_l3_noc.c:139 l3_interrupt_handler+0x23c/0x330
>>> [   39.429914] 44000000.l3-noc:L3 Custom Error: MASTER MPU TARGET GPMC (Idle): Data Access in Supervisor mode during Functional access
>>> ...
>>>
>>
>> I have no idea what that error is supposed to mean. @Tony?
> 
> The error above is GPMC related. It means GPMC is not properly clocked or powered
> while trying to access it's IO range.
> 
> Maybe DSS is somehow trying to access GPMC address space registers with DMA? The
> GPMC address space starts at 0. Maybe the DSS DMA address is 0 somwhere?
> 

Seems like, but I can't see how this can happen given that 
omap_fbdev_create() calls omap_gem_new() with OMAP_BO_SCANOUT. Unless 
something bad happens in omap_framebuffer_init(), which is called before 
omap_gem_pin() is called.

Regards,
Ivo

> Regards,
> 
> Tony
> 
