Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95960C61C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiJYIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJYIJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:09:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912991;
        Tue, 25 Oct 2022 01:09:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s196so10824073pgs.3;
        Tue, 25 Oct 2022 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVjQky+pk196r9RAv5o1rMy3whlIn85hqQF7J4WAiDw=;
        b=onxmJibQwYDVAIZGOfUPTaB8KLWOtRORkXGQlqwOynS5capo9LY5BFYOHaMX/ODSHU
         KM2P9fJv7Q4ciG2QH0jartbrZEhhl8IO6X0mSJAVby6PqPMGznw/yoMpWPYOcC12hfLB
         t2OGj5+uxth2k/Z4yf4kMQGiFPdoTgWr5YoCA4dTb8K3CicByvuLZkn34kTNqQvocrmo
         oJ3i66W11yeG4H+V9c8qo6pz9faNRE9V4cB+aNFywEw+daZFZJ4FlHIyc+osbQ0waUTE
         Bz2cxqYa9gd4iSRdVgN9qa0rMBTR3D1jYUmI7dN6Cn0OePhzPsYdvaB9cgX5wF3CgCS4
         hXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVjQky+pk196r9RAv5o1rMy3whlIn85hqQF7J4WAiDw=;
        b=d8syaudAyyahoZON6TZpPNyMp3WflGLcMm/Hq4H3w/1Gm4E/8e2S+JMXoBK9dYh5ho
         8HjLEwjiGXsG5hBzCOt3myXbJ/Z6o7sdSRF4sGIaoxblIRFxU5+dKMxbLi7ebQuBTAdG
         jkt6pOBis2XIEyPSre6vvt5DX9wM0kjXv4jXuCX+I2ZIbDV8X4smQqLiLunzoA6+GjRh
         uWFMUMsPF0XObJ1fZ0YPjIdax+lxtzPCKGVT+vGN/8bm27iDvLdS2E3ELZUNC75/GS/l
         IwksEu8k78xVwpLiOfBNNqtdjqo6HO2YBWe0A+4RWLj/BRMl4zDqs+DPCm1KEbD51qUi
         OXFg==
X-Gm-Message-State: ACrzQf3avNhhQ+E09pa6QK+Bmhp9/6iaOX9tC4MUZxx/6Ai/xCqJG6Lj
        ckQk49WTKqR/5inENYRpEHs=
X-Google-Smtp-Source: AMsMyM7QWK2kbqsmB7W4+9pJuo9rJAkHf2RQ6ytrKvKalRlv591T44kYht/TuIdByUPI7YnbZqV95w==
X-Received: by 2002:aa7:88c4:0:b0:563:9fe9:5da9 with SMTP id k4-20020aa788c4000000b005639fe95da9mr37503966pff.41.1666685380910;
        Tue, 25 Oct 2022 01:09:40 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-21.three.co.id. [180.214.232.21])
        by smtp.gmail.com with ESMTPSA id h23-20020aa796d7000000b00562677968aesm577851pfq.72.2022.10.25.01.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 01:09:40 -0700 (PDT)
Message-ID: <97ed229f-9411-2741-f5b6-28be4259420c@gmail.com>
Date:   Tue, 25 Oct 2022 15:09:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V3] x86/split_lock: Add sysctl to control the misery mode
To:     Dave Hansen <dave.hansen@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Andre Almeida <andrealmeid@igalia.com>
References: <20221024200254.635256-1-gpiccoli@igalia.com>
 <Y1dcDmmIu8gSX4Rb@debian.me> <7db9c3a5-2120-5ede-eb4e-077e3ed6c1f7@intel.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <7db9c3a5-2120-5ede-eb4e-077e3ed6c1f7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 11:10, Dave Hansen wrote:
> On 10/24/22 20:46, Bagas Sanjaya wrote:
>> The prose can be improved:
> 
> I'm not sure that's a universal improvement.  It chops out some valuable
> context.

Seems like you forgot to quote my suggested diff.

-- 
An old man doll... just what I always wanted! - Clara

