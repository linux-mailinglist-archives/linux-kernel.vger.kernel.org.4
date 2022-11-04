Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAC9619D33
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKDQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKDQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:27:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C402036A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:27:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so7825576wrh.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lU5/XEKeEYTgyjlFy5jQKXE6sh1CHCZXxKWhDyd9wVo=;
        b=fgzu6MAfeHRhUzrucU8YesBtIheIVBMu0VNr0KIsxCqRBtqdoZFgxV3X7IAFHFx493
         5FGfBwFl+m8gWwF8QiR3ua0PPnUsvbexQJXV9x3mvfhmFYmlEjVZ6bSouDU42tzEMpul
         5lSXTLnggEhHBZQtMArbjL0DkWzKJXF0LtkI7f2ZjRXZnBP7kvUT9l7PA47m9DTXhad8
         Mc9dZf0dwcS+YIiTLf3TKW16EPxvwEIUHahyxh0ENVdlrj8FeKAyZie7AXfu11+i0D3R
         Y4bhOIa+06qpVu+TfKIep1qQsb+RU1lQUxhNrBcIwEa+UG1LIsz18REhuAqWgEeqwUb1
         KaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU5/XEKeEYTgyjlFy5jQKXE6sh1CHCZXxKWhDyd9wVo=;
        b=zuBEloCjuTM5xTiCKkP7g58F6rhhDdqX3tVib593XZAQim9Rtlgd/HPJyODNtYIWkq
         itSKIawM7ZpsXqb1mNmFuiDA/oPNFiSJLQXiVUQMRotUeTRiUdrMHR3GsTLC9vNWPYia
         CG68Z7TwcUl4Ajgbv+jL12OxuIaQmZ5/CKV/NQlA7AOOWEEHYuu4DWv5ddTL+eoWbfto
         TlEdVBQbzJ7a2Y6xF4xlWXCZ2Buaq0pkc4OYscfOU9+UTHiAG9V24Sa/Y0cmlm3MGPmU
         cJBlO0EAectw02Y3N8pIzWv+J2vsRI6gF3N8+CILozSaGDu/7U/fST9DWInJNDXVfGxn
         KxaQ==
X-Gm-Message-State: ACrzQf1ZQ5UoNB7QKPjVk3W2CSAY4gCc0Dg7uRF0Zjdt19UqzrMgxovs
        OJtTfTogTyqObhU6ddj8Z70sBA==
X-Google-Smtp-Source: AMsMyM6cCn+CwsvflYaQp+z8TaAzPo/W2awtYM4W4qvCyUK82FR9LYt4fg4+LBEIbw5PXKbpt7TM0Q==
X-Received: by 2002:adf:dd12:0:b0:236:6ef7:dacf with SMTP id a18-20020adfdd12000000b002366ef7dacfmr22849219wrm.204.1667579241392;
        Fri, 04 Nov 2022 09:27:21 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d4-20020adff2c4000000b002366b17ca8bsm4326719wrp.108.2022.11.04.09.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 09:27:20 -0700 (PDT)
Message-ID: <89d05f19-ca8e-7906-e3ca-973225d8300f@arista.com>
Date:   Fri, 4 Nov 2022 16:27:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/3] jump_label: Add static_key_fast_inc()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221103212524.865762-1-dima@arista.com>
 <20221103212524.865762-2-dima@arista.com>
 <Y2Q1laQoklgDtVg9@hirez.programming.kicks-ass.net>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <Y2Q1laQoklgDtVg9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 21:41, Peter Zijlstra wrote:
> On Thu, Nov 03, 2022 at 09:25:22PM +0000, Dmitry Safonov wrote:
>> A helper to add another user for an existing enabled static key.
> 
> Utter lack of clue what for.
> 
>> +/***
>> + * static_key_fast_inc - adds a user for a static key
>> + * @key: static key that must be already enabled
>> + *
>> + * The caller must make sure that the static key can't get disabled while
>> + * in this function. It doesn't patch jump labels, only adds a user to
>> + * an already enabled static key.
>> + */
>> +static inline void static_key_fast_inc(struct static_key *key)
>> +{
>> +	STATIC_KEY_CHECK_USE(key);
>> +	WARN_ON_ONCE(atomic_read(&key->enabled) < 1);
>> +	atomic_inc(&key->enabled);
>> +}
> 
> And no, that's racy as heck. We have things like atomic_inc_not_zero(),
> I suggest looking into it.

Thanks for the review, I'll look into that for v3.

Thanks,
          Dmitry
