Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B190A613457
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJaLOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiJaLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:14:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DCDF8C;
        Mon, 31 Oct 2022 04:14:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so15494445wrw.2;
        Mon, 31 Oct 2022 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9bbGo0bvK6KW8lmRDeE10oRwrE5N7HeEJNDkRQyO8A=;
        b=WlQA7cWjwEb+Xdd5jtfQ912UBKuCDuH5SlcDmbcO9sHxyPWBlv0pr7XseAS1DU3+QI
         jao6daZ/G2L+o2hFwCQBVmiA3632G+JqYnBpyCMez9moZfFDeTDA9sQSp5qTOTD+Mh/Q
         4JrtfdAhhByjPfbXS35SiQ7SW09/6H9ulxDXBgj3ddtz7A//4lyxjvn2FBX1LxwigPOE
         apbmT+pkDD6Xl+xOVsRUBqgnBxaMGDNBADOnQU7SnL0+OwEE+GCDGKh8aHhoL+fakbeQ
         SDXv2qJlrCby362um47ZwlK4kX6actxGQ0ksi+rFDqvtYIODILVEiIqnUmJFesGTOReo
         M7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9bbGo0bvK6KW8lmRDeE10oRwrE5N7HeEJNDkRQyO8A=;
        b=qnG+LWkooslw1TXi0ai6yvvpYEUGayvNM3oW7/7zb86gUhcZA/v+xYrhwiDm+21a2B
         1TC7dWbWAHJ8EJTAVkIzWDzxVyvoVEox9G8S8GCAsiK9DQtecBmrPrDbbZvML12h7ESE
         uAfzdzOboVcvM/IL8fG1+M5JCMH0Oas3fQSmuVjN5u92Bv+JOIi/jKRStl3e+IN6v5HF
         bA0mfKcJI5E8r9IT+8Dso5NZpCikopgiGoQPOndhlK1mIptIotioQd8MbwGjG++H1Ht/
         RtgejY+u6pq++FkEG78Kbw/Sxzm+yTMxQRQ/Z1Ir+WKYJADnOTfxipjQ+rlngtaZUa0n
         pVsQ==
X-Gm-Message-State: ACrzQf2wqeGyDDgnhh2R6u7QENiZdcKIloKVcGzER/Lx0K+KwtnXMUA2
        Nrjn1gixJhX4G4Oo+qLnsq6bl6KigWBQRQ==
X-Google-Smtp-Source: AMsMyM6e2wBSZmbNMzzhU5zkyKz9QkfZfTr0UqJoQ8AgVgL5qpBKKqLziz5rnQeg3xP+GQf7IWZeLw==
X-Received: by 2002:adf:c582:0:b0:22b:3c72:6b81 with SMTP id m2-20020adfc582000000b0022b3c726b81mr7784585wrg.320.1667214874081;
        Mon, 31 Oct 2022 04:14:34 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id o18-20020a05600c511200b003c6c3fb3cf6sm7976775wms.18.2022.10.31.04.14.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 04:14:33 -0700 (PDT)
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
Message-ID: <108e96f7-d86a-2c1e-1a6a-c0ed02667719@gmail.com>
Date:   Mon, 31 Oct 2022 13:14:30 +0200
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

I think I have an idea:

omap_framebuffer_pin() calls omap_gem_pin() without verifying the 
returned plane->dma_addr. To me it seems the assumption is that plane 
BOs are scanout/linear, which most-probably isn't the case. I was unable 
to find who provides those BOs though (they are passed as handles to 
omap_framebuffer_create(), most-probably set by the userspace)


> 
> Regards,
> 
> Tony
> 
