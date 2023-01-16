Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949866B6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjAPF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjAPF04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:26:56 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB1686A9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:26:54 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id s5so39202598edc.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzfSsbsU0LC9+g3awLc2s9r4X/Fk0lDSH0KSZj2wCXc=;
        b=z9QrCJNlJsGHTbMr/1k6/ibfplFAnXYcM1pGd5uZfU3btDOUdJWiTt+YLHKXBtxJ8w
         Kz3d9Uj3feFveKVj69tD2M7rsAMYhLLLJGBVWFhhecBUEwdQEaqSs3Ltu8O0PrIHClH6
         Y7dFL5krRIXZBs5703q4m0WXbBQ4NnzUPb1nQHwBvBk1pAfPmplyuP3mlyuPu/UM0mvx
         bpL7BT73hPBD1CAAS7WfceChtVoZZ2x45YpsQcVc9v8ngQnRikwIYcXcaXqdirRke/RN
         r0tAqwn9obaJ4n70mUALUWL1LLzwnfkQQAjUkYwNVdwlO9/+87bOnp8V3PLsQeJAvO5+
         ahFg==
X-Gm-Message-State: AFqh2krxtq9+bR0dZS9/6BCYe6DEQeIFGLuT/rK19y5/C1cZ4zq7689q
        bmfq+2dkmVFU9A/e0rH2AMuvSU0780A=
X-Google-Smtp-Source: AMrXdXuOPQ8GmxEosTmJpxic8TEcYaeDqBkNJtwwOfqInFGBUazHRB1mV1zWNmqUmkGNaf+N+m1eMQ==
X-Received: by 2002:a05:6402:528e:b0:481:420e:206d with SMTP id en14-20020a056402528e00b00481420e206dmr73703448edb.42.1673846813332;
        Sun, 15 Jan 2023 21:26:53 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id bc25-20020a056402205900b0046b00a9eeb5sm10996402edb.49.2023.01.15.21.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 21:26:52 -0800 (PST)
Message-ID: <b0b18b83-0b6b-ea89-b701-0375b8302d1e@kernel.org>
Date:   Mon, 16 Jan 2023 06:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel Verkamp <dverkamp@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <1b184587-128d-e5cc-67e9-1d27feb87213@kernel.org> <Y7VlZsaWz4/b6Phf@zn.tnic>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Y7VlZsaWz4/b6Phf@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 01. 23, 12:39, Borislav Petkov wrote:
> On Wed, Jan 04, 2023 at 08:43:51AM +0100, Jiri Slaby wrote:
>> Let me resurrect this thread... Our customer has an AMD CPU which has indeed
>> both capabilities under normal circumstances. But they have a cool UEFI BIOS
>> too. They say:
>>
>> """
>> In AMD platform, while disalbe ERMS(Enhanced Rep MOVSB/STOSB) in UEFI
>> (system setup -> processor -> Enhanced Rep MOVSB/STOSB), the OS can't boot
>> normally.
> 
> Any particular reason they're disabling ERMS?

Just so you know (I see you progressed with Ingo to fix this) -- despite 
I asked the very same question, I received no answer quite yet. I 
suppose it will sound like usual "because we can".

> What do they set FSRM to?

I suppose they keep it "enabled".

thanks,
-- 
js
suse labs

