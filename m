Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9D65AD42
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 06:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjABFl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 00:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjABFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 00:41:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48410FF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 21:41:22 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d4so17466896wrw.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 21:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvJuMP+L/v0VaSUSwJcVqo54T4tBiI2lngCqwC2iFRY=;
        b=jdE+clNc/4TDQB8whIIyEl2ZSBNq5czPHTE9de0nJW2ABylXLDESIP47gOK+ETeBfV
         yPv9YmhZfMp4/MO/t/Pd9AQwbdpkYiy0yZQaHx9AyWss5NyTwJwp0l00YR6RZCdXyqXD
         7SaBlPu7Ct7rtHLV/zsIPdbZ6xmYILCwB+BJEhh+4Z2LHT9aerKZsfXbyxImb4HdF2Cr
         nmNSBvEcfroDdKaWzt1qBqoHyk5fNsHXLQjxl7Trd4q+b7ga53d21CxebVeiGubzl5vF
         WDG3+6HoQ9TniYJqiNx994VeG57FVOK+kcayF90vvY5Lpd/DHiv/9xeCzQy0hQVdpSAc
         7nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvJuMP+L/v0VaSUSwJcVqo54T4tBiI2lngCqwC2iFRY=;
        b=Z/0m7pcS0RtHpOW9QmXHpw9hiVTjZ+i/3BAh0pRUErTA0Iy/7AtaesWZOupnsxZwOS
         UAC6syTIYeLgIIGnIoX9ehXMMJ0QAK8MpRKMa6spFwZxObh11PQ2s8QS/b3J66zwsjEj
         HN4b5EoyNli9yoty6ReKqPbtxe3/6x0cAx9JUe9xn5+IAF3eLVTnSGNlEiWqTRrpqAer
         JDjLy9MEmeoHiVSII/HcARWK0VKI0y/nvez02iS19lnPeQ2+jcxWDzEGrZlTasXhW1bG
         JXDSE/NPJ9VycOTgqa+JkygIWLCQSCBvDX0ZB7vqDVi7TnEvZ82XXU5oT0I0XMlbjM+0
         KIuQ==
X-Gm-Message-State: AFqh2kpOQSnNQaI2pESo61MgL9V1iDghRpOcStcQIsOdsqTXc31ds3LE
        qpCcdLnQH+PzWF6UwsOJGcp5hg==
X-Google-Smtp-Source: AMrXdXs5EtV/UCpCmjN/PveRZ2nIvMPUeyMOlaloRrFdNtQBaE+E7PWBC6E4sF4JfGAlP/qwF7FfhA==
X-Received: by 2002:a5d:5908:0:b0:279:4938:eb98 with SMTP id v8-20020a5d5908000000b002794938eb98mr18309009wrd.11.1672638080618;
        Sun, 01 Jan 2023 21:41:20 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.242])
        by smtp.gmail.com with ESMTPSA id l17-20020adfe9d1000000b0024165454262sm27106850wrn.11.2023.01.01.21.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 21:41:20 -0800 (PST)
Message-ID: <f66ff338-f3ec-e7a3-5698-250b97511982@linaro.org>
Date:   Mon, 2 Jan 2023 07:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ext4: Fix possible use-after-free in ext4_find_extent
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com,
        syzbot+0827b4b52b5ebf65f219@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20221230062931.2344157-1-tudor.ambarus@linaro.org>
 <Y66LkPumQjHC2U7d@sol.localdomain>
 <cf1be149-392d-afa0-092a-c3426868f852@linaro.org>
 <Y69E9DMEk+yEFDNQ@sol.localdomain>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Y69E9DMEk+yEFDNQ@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.2022 22:07, Eric Biggers wrote:
> On Fri, Dec 30, 2022 at 01:42:45PM +0200, Tudor Ambarus wrote:
>>
>> Seems that __ext4_iget() is not called on writes.
> 
> It is called when the inode is first accessed.  Usually that's when the file is
> opened.

Okay, thanks.

> 
> So the question is why didn't it validate the inode's extent header, or
> alternatively how did the inode's extent header get corrupted afterwards.
> 
>> You can find below the sequence of calls that leads to the bug.
> 
> A stack trace is not a reproducer.  Things must have happened before that point.
> 

I will try to dig more to understand what's happening. If you like to
take a look into the reproducer, here it is:
https://syzkaller.appspot.com/text?tag=ReproC&x=17beb560480000

The reproducer was used for Android 5.15 and the bug is reported at [1],
but as I mentioned earlier, using the same reproducer and config I hit
the bug on v6.2-rc1 as well.

Thanks for the help.
ta

[1] 
https://syzkaller.appspot.com/bug?id=be6e90ce70987950e6deb3bac8418344ca8b96cd
