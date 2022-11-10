Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A86239FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiKJCsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiKJCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:48:28 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E192BE3D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:48:27 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id h193so442500pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 18:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7eUyiQ6IzU2+8YpPxlxYGEz6hnrs4cMH/uVBORMyPA=;
        b=hJj2r8CBurme6Ps/PCRGDQ3Ut2BotHl6PwfMBtsW7ln7DRdh0pA3cM5hiaEWBSqlVP
         SY66mlbXOKxsctjgeY4XX4nHLI2vM3O2SKr6OqdnrVRYFEdos4rJ9QHklqnYLqaHG5aN
         /WJeRVBHALT+4aBNRJ8FpvYsP2q+OydgmEW3BojR3++p3aWiGlb8agop3By+kFGHXJo2
         oEsKLhzBRhbwc0fFfqJWkjRMUS1jm4kP+P/WCLgCaEpSyMurjI1dK61vyWeybyzTsmP7
         80cfVi/G89288QVex5RaQ/VzondOZ4PCka2oSB8tOAWBYGu71bOhMV85fxIUh4Od3Oyo
         YnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e7eUyiQ6IzU2+8YpPxlxYGEz6hnrs4cMH/uVBORMyPA=;
        b=kGrymT7c9Nu4ODvd/Mk8EDIW/eP9GCBrHG1JuULqBEPbRSnifbyTBHcszwTuuGQ5Al
         rT6DmdBr5JKtaUNdZPKPIJ/mC3WO0R6TqJHgg5uNYNvOV7Q1PPOPDdiIKXgZjrcl1RML
         RB+vhnDtqHaCYwpLQL25RCxgdO1QyWBnDjbAztpl5+rSW/4r3D/PJT14araZiOQrwRUI
         T/1F5zLjSwktEibVn1JksML++xjLwLPwR0O7cweVFn+oXhBS9XMg+aD6cb7JODsc6wiB
         e+Qv9GQybMiLmVHHmxISsAqm4ypcw2enRRKtcVg1hAldXrR9FJ9ajPCjWpQk1npcOgNZ
         XGYA==
X-Gm-Message-State: ACrzQf1HQ3yZvmvkej6Swe5JPyWFB1l4aU0unl+LMVlg9uaUuBnDiqhY
        aH4RcsLwR6vwCEQtY44o0kI=
X-Google-Smtp-Source: AMsMyM52mojWHoQ9X8h45pTN2+QLha+lM23Z556YFa768OQUBcX3vm/KoCOk34Z0LACmhNVGf8hYJQ==
X-Received: by 2002:a65:4b88:0:b0:44e:74d0:e843 with SMTP id t8-20020a654b88000000b0044e74d0e843mr1616131pgq.95.1668048506995;
        Wed, 09 Nov 2022 18:48:26 -0800 (PST)
Received: from [10.114.96.16] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id ij26-20020a170902ab5a00b0017f6c9622b9sm9744756plb.183.2022.11.09.18.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 18:48:26 -0800 (PST)
Message-ID: <7113d66a-9792-b026-cece-5c1b21dd989d@gmail.com>
Date:   Thu, 10 Nov 2022 10:48:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mm/vmscan: simplify the nr assignment logic for pages to
 scan
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chao Xu <Chao.Xu9@zeekrlife.com>
References: <20221109070416.620887-1-Chao.Xu9@zeekrlife.com>
 <20221109171952.826d991327e07319c5eb8cd3@linux-foundation.org>
From:   Chao Xu <amos.xuchao@gmail.com>
In-Reply-To: <20221109171952.826d991327e07319c5eb8cd3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/10 9:19, Andrew Morton 写道:
> On Wed,  9 Nov 2022 15:04:16 +0800 Chao Xu <amos.xuchao@gmail.com> wrote:
>
>> By default the assignment logic of anonymouns or file inactive
>> pages and active pages to scan using the same duplicated code
>> snippet. To simplify the logic, merge the same part.
>>
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5932,14 +5932,11 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>   		 * scan target and the percentage scanning already complete
>>   		 */
>>   		lru = (lru == LRU_FILE) ? LRU_BASE : LRU_FILE;
>> -		nr_scanned = targets[lru] - nr[lru];
>> -		nr[lru] = targets[lru] * (100 - percentage) / 100;
>> -		nr[lru] -= min(nr[lru], nr_scanned);
>> -
>> -		lru += LRU_ACTIVE;
>> -		nr_scanned = targets[lru] - nr[lru];
>> -		nr[lru] = targets[lru] * (100 - percentage) / 100;
>> -		nr[lru] -= min(nr[lru], nr_scanned);
>> +		for ( ; lru <= lru + LRU_ACTIVE; lru++) {
> The "lru++" implicitly assumes that LRU_ACTIVE=1.  That happens to be
> the case, but a more accurate translation of the existing code would
> use "lru += LRU_ACTIVE" here, yes?
By default the value of LRU_ACTIVE is 1，but if someone change it one day, I
use "lru++" maybe facing some exceptions, which is not robust. So I 
agree with
that "lru += LRU_ACTIVE" is appropriate instead of "lru++". I will send 
a new patch.
>> +			nr_scanned = targets[lru] - nr[lru];
>> +			nr[lru] = targets[lru] * (100 - percentage) / 100;
>> +			nr[lru] -= min(nr[lru], nr_scanned);
>> +		}
>>   
>>   		scan_adjusted = true;
>>   	}
