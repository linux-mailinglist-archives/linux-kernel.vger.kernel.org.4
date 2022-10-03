Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526F5F3389
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJCQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJCQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:27:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF42D138
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:27:21 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h10so5493805qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zYLq29gPDUofOXdnDZ5NbApDEfZ9Ds4SRQ4Jyr86GEM=;
        b=bJEI7apWKsq31fsnNXI3e7OeGiZOeWe1wuesZ4L4KfVciKzz4T9N9bcjEVERTw1AHw
         5nrE/dngwCgzGhNUXmLqbSoNLvz1NZrszgdsA5eq9MMKotEekCvWkYyNv1w176p+9u6n
         ghr1Rb8Kz6RjMrzhdSRlTNoebnQJJb/mFOf8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zYLq29gPDUofOXdnDZ5NbApDEfZ9Ds4SRQ4Jyr86GEM=;
        b=ddvKsu5wqnrA4rj6tjw7bqK2ziITcXXZO8ePs4EmmW5Nr8YXR1fTU7UJkIGBdbBrfv
         clGPnBYnW+nDtgu2xBupw0M0AA+uWXTjTh0Ik0aHY3+gVsfNgKHCuLJhqPJllGduXA0R
         njEJnwcfOq9JPGhiB5KD9hd0pwqL67eQppi7296bMf+amIF9sG7i3rv2HtIh3kZSUXKJ
         LKH/ezM589knN7LCnqYBEZF//ipS6oL1teHw9dgpDVxGnDW0oVK6NaDWDcK/Jy+vsIgg
         Y5MJC06AkH7cWDPnzLNgGV2vr6fwPJ+LzWVpFgZpgrX5qCZh+D/6hTpgTFS0xLmADOL2
         RBOw==
X-Gm-Message-State: ACrzQf1s3mwOMsnD0RAUPpQtRuKSTqY2xfD3riVzc7vFZszNOGR9wAnQ
        RfYw22rkoYhzZbdMKXZwB61JhQ==
X-Google-Smtp-Source: AMsMyM6awKns7A74EXB5E4DvlrPQSiHfkRtW1dfiFEul8EDFKExrhMaQfhjOCaApOidS+BJl3WDbFA==
X-Received: by 2002:a05:6214:1c4d:b0:4b1:7a21:e26f with SMTP id if13-20020a0562141c4d00b004b17a21e26fmr8919792qvb.81.1664814440154;
        Mon, 03 Oct 2022 09:27:20 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id k17-20020a05622a03d100b00343057845f7sm10405460qtx.20.2022.10.03.09.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 09:27:19 -0700 (PDT)
Message-ID: <160a2ded-b8e0-acf0-a8b6-df1b0f2c0fa8@joelfernandes.org>
Date:   Mon, 3 Oct 2022 12:27:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Sum of weights idea for CFS PI
Content-Language: en-US
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a lot to unwind so I will reply in pieces after spending some time
thinking about it, but just for this part:

On 10/3/2022 12:14 PM, Qais Yousef wrote:
>> In this case, there is no lock involved yet you have a dependency. But I don't
>> mean to sound depressing, and just because there are cases like this does not
>> mean we should not solve the lock-based ones. When I looked at Android, I saw
>> that it uses futex directly from Android Runtime code instead of using pthread.
>> So perhaps this can be trivially converted to FUTEX_LOCK_PI and then what we do
>> in the kernel will JustWork(Tm) ?
> I guess it will depend on individual libc implementation, but I thought all of
> them use FUTEX under the hood for pthreads mutexes.
> 
> Maybe we can add a bootparam to force all futexes to be FUTEX_LOCK_PI?
> 

In the case of FUTEX_LOCK_PI, you have to store the TID of the 'lock owner' in
the futex word to signify that lock is held.

That wont work for the case above, Producer/Consumer signalling each other on a
bounded-buffer, right? That's not locking even though it is acquiring and
release of a limited resource.

thanks,

 - Joel
