Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D6D731AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbjFOOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFOOBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446E1FF9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686837620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iY9+jzWeLLrhR3zsPgELSfNoWOXUeIAPez3AsCnmyUE=;
        b=LwBVV/q01KAQRmnkMIT8bVgEW9pRN3hyBJeKqOVrbhpZ8pttCWjCXjwUOc3/ejbG9VCwpO
        QpeOODmqbkWKTCCDQskLW8IImh3ptBeLwbrFQ3o5aWq0i0WN/i6AyDCd41aK+/rS1H4LfM
        VRAJ1MfKCEnGOX7AOWEIUQmt/HdxDA8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-RExO7t_INOeGskhcug2Ijw-1; Thu, 15 Jun 2023 10:00:18 -0400
X-MC-Unique: RExO7t_INOeGskhcug2Ijw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51664cc4bddso6771587a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837616; x=1689429616;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY9+jzWeLLrhR3zsPgELSfNoWOXUeIAPez3AsCnmyUE=;
        b=FXxFRv4tJyStsce8bseycWLanL6g+ELdQ750ewluQmYF6LZoNrNHHFOTPEBtdKdxD4
         oUKVscRICOojjDGofT9gFIh8Z0jc2wO4y5q2wMOR6XON7w1hEeUfT1bc69spWyCW3M3c
         9s1oTk92nR+EKIsi90XTFfI3niDFCyvewE766d9jh0ZEID8tQzm24KTgZq6Kn7SGKlOQ
         XYP8K11Xc4KurlTZQkANRMyYWbvJWuhqoOnDQs+HZ+pV0Pn0Vj7NPp97jaWOss3NFWJj
         xbxkja8jpO6HuRTOHbw7OVIj4M6TvYxBu5f89iTz/ERrPCJXJKG8cOd0d/y6z7/DUDlU
         S+qg==
X-Gm-Message-State: AC+VfDxAy/qRQqCV7fWsFZE55fCyNw1lQOgU3Oe2aBfr4ZLecRjZXzQr
        1gKZJCAuK4CRnXmdVc5dXlC0UvkkpJBTL2k2kmcwdvY9I7JpnbhLryY9fR/Jd1YYokh5codZBZx
        SYTFA0onPIVTh2S34jKQ5eiG9
X-Received: by 2002:a05:6402:1252:b0:518:82c4:cc7e with SMTP id l18-20020a056402125200b0051882c4cc7emr3651691edw.17.1686837616423;
        Thu, 15 Jun 2023 07:00:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58ICTUk9qzBYW9m2U3cHL0vpsVIWAJ3qpjhMUfMNM+LxWyP8r4apEo2Pcp5+Wa7vwiB9elyA==
X-Received: by 2002:a05:6402:1252:b0:518:82c4:cc7e with SMTP id l18-20020a056402125200b0051882c4cc7emr3651672edw.17.1686837616076;
        Thu, 15 Jun 2023 07:00:16 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050bc6983041sm8920929edb.96.2023.06.15.07.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:00:15 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b28b0e3e-87e4-5a02-c172-2d1424405a5a@redhat.com>
Date:   Thu, 15 Jun 2023 16:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] page pool: not return page to alloc cache during
 pool destruction
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Liang Chen <liangchen.linux@gmail.com>
References: <20230615013645.7297-1-liangchen.linux@gmail.com>
 <20230614212031.7e1b6893@kernel.org>
In-Reply-To: <20230614212031.7e1b6893@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2023 06.20, Jakub Kicinski wrote:
> On Thu, 15 Jun 2023 09:36:45 +0800 Liang Chen wrote:
>> When destroying a page pool, the alloc cache and recycle ring are emptied.
>> If there are inflight pages, the retry process will periodically check the
>> recycle ring for recently returned pages, but not the alloc cache (alloc
>> cache is only emptied once). As a result, any pages returned to the alloc
>> cache after the page pool destruction will be stuck there and cause the
>> retry process to continuously look for inflight pages and report warnings.
>>
>> To safeguard against this situation, any pages returning to the alloc cache
>> after pool destruction should be prevented.
> 
> Let's hear from the page pool maintainers but I think the driver
> is supposed to prevent allocations while pool is getting destroyed.

Yes, this is a driver API violation. Direct returns (allow_direct) can
only happen from drivers RX path, e.g while driver is active processing
packets (in NAPI).  When driver is shutting down a page_pool, it MUST
have stopped RX path and NAPI (napi_disable()) before calling
page_pool_destroy()  Thus, this situation cannot happen and if it does
it is a driver bug.

> Perhaps we can add DEBUG_NET_WARN_ON_ONCE() for this condition to
> prevent wasting cycles in production builds?
> 

For this page_pool code path ("allow_direct") it is extremely important
we avoid wasting cycles in production.  As this is used for XDP_DROP
use-cases for 100Gbit/s NICs.

At 100Gbit/s with 64 bytes Ethernet frames (84 on wire), the wirespeed
is 148.8Mpps which gives CPU 6.72 nanosec to process each packet.
The microbench[1] shows (below signature) that page_pool_alloc_pages() +
page_pool_recycle_direct() cost 4.041 ns (or 14 cycles(tsc)).
Thus, for this code fast-path every cycle counts.

In practice PCIe transactions/sec seems limit total system to 108Mpps
(with multiple RX-queues + descriptor compression) thus 9.26 nanosec to
process each packet. Individual hardware RX queues seems be limited to
around 36Mpps thus 27.77 nanosec to process each packet.

Adding a DEBUG_NET_WARN_ON_ONCE will be annoying as I like to run my
testlab kernels with CONFIG_DEBUG_NET, which will change this extreme
fash-path slightly (adding some unlikely's affecting code layout to the
mix).

Question to Liang Chen: Did you hit this bug in practice?

--Jesper

CPU E5-1650 v4 @ 3.60GHz
  tasklet_page_pool01_fast_path Per elem:  14 cycles(tsc)  4.041 ns
  tasklet_page_pool02_ptr_ring  Per elem:  49 cycles(tsc) 13.622 ns
  tasklet_page_pool03_slow      Per elem: 162 cycles(tsc) 45.198 ns

[1] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c

