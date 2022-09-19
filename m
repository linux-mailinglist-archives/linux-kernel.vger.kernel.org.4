Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2915BD605
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiISVBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiISVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:00:48 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483B4BD04
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:00:42 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j8so626019qvt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+TpJY9WA2TgbKk/FBFvRVyGAUeZgvGLaYz5TdJGtlf8=;
        b=cpw4k/mKjf/eRLwXExK0P1CNtft8mtxO2omAgM2yLwgj17aRiniJkN/+fQopoTcFsM
         4TrZazwKaImECkxpymH4XrPV+B6BZf6VhV2wwHUgUjO186f9syskCuANjMtvmXJ/KHIi
         MC8pZpwgWCXuUP66Ow0czTuxpn8fH7uf1UVZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+TpJY9WA2TgbKk/FBFvRVyGAUeZgvGLaYz5TdJGtlf8=;
        b=GmOVCsZ7XH78ysuz7LikvCYTjEciIrxaLCYyUk21dhK0Z+0M2DUhurhwTSlO9IAfmK
         inoQo8yts/TNQ+DWw7Y0LoXhxp+VmpvOgy3u3MqrGvfdOQBkxM7F2TDqPH1sbFsvTO8I
         /ZhafmUFXDeDIgKVGPeMzuBtomKKdFYtP4C3UadoIJsPcXmDm+zat+feYL60EfFMBBv5
         EcUmA2NcUNt03I3IOwUWzQKDc5tUx+85fShkYOUp2tCoYtNau7tJTKZGMJXBeDmVCNWA
         R4ohQTmwHyeLTy61IfzpeGT5MbbwGBDyUgrkmdBEybusLy3dF0KSWthZvWkMAeciYzmD
         JYfQ==
X-Gm-Message-State: ACrzQf3aLIvGFpjuoyVJvToYDlQFfOWTgdgyomNUJUTQHue5y11qaIlV
        jlKZgkF7BMohhipDSdGMXWgI8w==
X-Google-Smtp-Source: AMsMyM6XWNDSwpR8DvxvlafkY5AtGT85GBC74I/In4fGAR7WLSNCVpkK6dWZA9jAbPDtV+tm/LxFYw==
X-Received: by 2002:a05:6214:1c07:b0:4a4:bf44:df79 with SMTP id u7-20020a0562141c0700b004a4bf44df79mr15999852qvc.1.1663621241739;
        Mon, 19 Sep 2022 14:00:41 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a405200b006bb9125363fsm12612292qko.121.2022.09.19.14.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 14:00:41 -0700 (PDT)
Message-ID: <c244a304-1689-274e-2bba-2ee1ce5f1bff@joelfernandes.org>
Date:   Mon, 19 Sep 2022 17:00:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC] rcu/nocb: Fix possible bugs in rcu_barrier()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, neeraj.iitr10@gmail.com, paulmck@kernel.org,
        rostedt@goodmis.org
References: <20220918221231.79143-1-joel@joelfernandes.org>
 <20220919093411.GB56640@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220919093411.GB56640@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/2022 5:34 AM, Frederic Weisbecker wrote:
> On Sun, Sep 18, 2022 at 10:12:31PM +0000, Joel Fernandes (Google) wrote:
>> When going through the lazy-rcu work, I noticed that
>> rcu_barrier_entrain() does not really wake up the rcuog GP thread in any
>> path after entraining. This means it is possible the GP thread is not
>> awakened soon (say there were no CBs in the cblist after entraining
>> time).
> 
> Right.
> 
>>
>> Further, nothing appears to be calling the rcu_barrier callback
>> directly in the case the ->cblist was empty which means if the IPI gets
>> delayed enough to make the ->cblist empty and it turns out to be the last
>> CPU holding, then nothing calls completes rcu_state.barrier_completion.
> 
> No need for that, if the cblist is empty there is no need for a callback
> to enqueue.
> 

Thanks! I was worried about the race where an smp_call_function_single() takes a
long time to IPI. But I missed that the smp_call_function_single() in
rcu_barrier() is in a synchronous wait. I wrongly thought thought that the
waiting was facilitated by barrier_completion which has a whole different purpose.

 - Joel
