Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0F6E2563
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDNOOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDNOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:14:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB4B769
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:13:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5144043d9d1so1049897a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681481617; x=1684073617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0khoLy+eSzRa5gLnIJcGGxbaem/Y8O3pCzVmwyuZdh8=;
        b=aIsHBNmgQ+I5xxhNUCld03Q4z6H1qoe/GoSM/gCG3+wIWLtddL8oXoNZjrSbJS/bX7
         OVhihL6OXXevY79Zf81aJ6PLeaRS0d3iH/F4op/s0DIpUgLgnIs4xafEH1KD7kwmvkZ0
         saKhz7L7R6O7RT7Aasc1MVzmcGgzFsnYITAoZvas3y7FPNGYUIlqL1BOPfvAhpgm8VKp
         9iyg4vx6clQQDNddnpxk2zwOtmcyXYy/DSN0tNLAPnMtNPQHL73rQV6Ney5dmAxnVFkj
         K2ZqNi8YjxS7yHyeRcKQ5WqzaDqbwVq6j/yNpvUDhOuH74Pmhli9uEIgU0WZTKUcrlDb
         6AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481617; x=1684073617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0khoLy+eSzRa5gLnIJcGGxbaem/Y8O3pCzVmwyuZdh8=;
        b=RScKb+uXKxq95fEPErC9N8E3F3YwPpWOEdjLhW/hi2GIWKUE9iN4mi5omkdBTE8FdY
         D6muYoT0CgaiMGN0BMf70uDd4zVCXsVXV7CijlKCziZdnDyImvmKdT1L1G7NQKOAI06I
         Xs67BkXQVaZ0hkZFHDZdJGtLfRYzeM3atJfc0WiutmzH34NkUnJAmtoVop3w4wBF1lOD
         /Ko9J+E3zhP39DcbiVjHBkvoDUxqy2r/6rrIDU3/KSgBOuhrkKlQ5FEwAi7kn15VnbCa
         MBeiTKCi3z7nmnRuV3pgrRk4L4d/XDY2EPGO4ZS6yk/JNRl3t99Fs0slwNB/6CLp7aJ+
         P7hQ==
X-Gm-Message-State: AAQBX9eyOErUL+qYtNj7NauvlmaJKuBKtca66hTTBk7nX2PXR1nc9GNa
        txQHcHvlXtUWgaD7A8L6LO5c879xqSB9cqwk56Uo2w==
X-Google-Smtp-Source: AKy350aKg9lmYOUaUEQlZgWqZ66lzJFD1dcVcEBuDBWsSx/PM4wkmkAYb4pSZQkjOSGOhInZapBxgA==
X-Received: by 2002:a05:6a00:178c:b0:63b:4e99:807d with SMTP id s12-20020a056a00178c00b0063b4e99807dmr7746205pfg.8.1681481616918;
        Fri, 14 Apr 2023 07:13:36 -0700 (PDT)
Received: from [10.255.185.5] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78294000000b005921c46cbadsm3189981pfm.99.2023.04.14.07.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:13:36 -0700 (PDT)
Message-ID: <1a9c4365-aae1-b4fe-d31d-dfd9b42afae6@bytedance.com>
Date:   Fri, 14 Apr 2023 22:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [PATCH V5 4/5] cachefiles: narrow the scope of triggering
 EPOLLIN events in ondemand mode
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, yinxin.x@bytedance.com,
        zhujia.zj@bytedance.com
References: <20230329140155.53272-5-zhujia.zj@bytedance.com>
 <20230329140155.53272-1-zhujia.zj@bytedance.com>
 <1250225.1681480128@warthog.procyon.org.uk>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <1250225.1681480128@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/14 21:48, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>>   	if (cachefiles_in_ondemand_mode(cache)) {
>> -		if (!xa_empty(&cache->reqs))
>> -			mask |= EPOLLIN;
>> +		if (!xa_empty(xa)) {
>> +			rcu_read_lock();
>> +			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
>> +				if (!cachefiles_ondemand_is_reopening_read(req)) {
>> +					mask |= EPOLLIN;
>> +					break;
>> +				}
>> +			}
>> +			rcu_read_unlock();
> 
> You should probably use xas_for_each_marked() instead of xa_for_each_marked()
> as the former should perform better.
> 
> David

Hi David,

Thanks for your advice. I'll revise it in next version.

Jia
> 
