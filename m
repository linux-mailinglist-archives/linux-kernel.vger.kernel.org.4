Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119570BB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjEVLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEVLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DFE19A1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684753704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLk/swCEBdEOMxAQERr3X1E7KbSBUqBT0EzlMcOckoc=;
        b=aOI5v0z1yoZiKCgK8hVlXr5pfndh8sinWDJGP6Hg87JQ70xxCx5sfkxep2IAHB/rG5Cq8s
        JHcBDrD1ZaSRhCTxk91Jl1jbaoDx2cOG7KeKoIHGEVWv4T//AlrBTSFDWyF06vs2gBFZE7
        BTR7qXNOpgUyCCOfxaZ5/X/Oo3ICLBg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-cx8y2tT4NGmJClyPWCBytA-1; Mon, 22 May 2023 07:08:23 -0400
X-MC-Unique: cx8y2tT4NGmJClyPWCBytA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96fe843f61eso96323266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753702; x=1687345702;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLk/swCEBdEOMxAQERr3X1E7KbSBUqBT0EzlMcOckoc=;
        b=caxK2HtQ4tvFaFr6cvPO/J1JMteypQ3FEqMBv79yzJhIj8Puh1BsyXvIAk8W2TulKo
         QuUAEmdc4e4I+uWGOborORA2dIBUoOCd+wAUssnpOE13cVMhls3j2eFx6gKZNRmNmZG5
         eChEPShmBAVNfvh4rabs3YaNh4j235/csVTC3X7qakZznFEXLzJXo1O5iBCuNfd1yxIA
         NBrMO0SnQCBsA8fn0/GhLCJXHc4833oJskM9u6I90A7Rw+GgS/BXs2/olA3LIsSgdVg3
         u4BnlD7C8YIxBtcKY/PYPxGMwprXi0WYxN/j6s7M4bef9psYjUs1tMbaax4UJ8VigOyt
         jQiw==
X-Gm-Message-State: AC+VfDzMg0VUEX+cH5VTViIpy95/v1ezhptaWpMgUxSHScIMUXaBlyer
        yK7bH1jzNeBVacKMaspysfh3+VBOuzf9EX8zeAfqjP6LoGBpTDarM9U+EiW7kUnaTNYGMTA8uMx
        qdsd3N4GeGD9bda8eJ4a4CZbJ
X-Received: by 2002:a17:907:a429:b0:96f:7070:3419 with SMTP id sg41-20020a170907a42900b0096f70703419mr9222669ejc.51.1684753702350;
        Mon, 22 May 2023 04:08:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YpWk9shikRUpmBDi2xBmsf0R3nZDrKxczfoCY+ndrd5UW2VnZ4JfT+15TuggmOv9E0ff3Bw==
X-Received: by 2002:a17:907:a429:b0:96f:7070:3419 with SMTP id sg41-20020a170907a42900b0096f70703419mr9222653ejc.51.1684753702096;
        Mon, 22 May 2023 04:08:22 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709062b4a00b00966447c76f3sm2983431ejg.39.2023.05.22.04.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 04:08:21 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <1fc46094-a72a-f7e4-ef18-15edb0d56233@redhat.com>
Date:   Mon, 22 May 2023 13:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net] page_pool: fix inconsistency for
 page_pool_ring_[un]lock()
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
References: <20230522031714.5089-1-linyunsheng@huawei.com>
In-Reply-To: <20230522031714.5089-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2023 05.17, Yunsheng Lin wrote:
> page_pool_ring_[un]lock() use in_softirq() to decide which
> spin lock variant to use, and when they are called in the
> context with in_softirq() being false, spin_lock_bh() is
> called in page_pool_ring_lock() while spin_unlock() is
> called in page_pool_ring_unlock(), because spin_lock_bh()
> has disabled the softirq in page_pool_ring_lock(), which
> causes inconsistency for spin lock pair calling.
> 
> This patch fixes it by returning in_softirq state from
> page_pool_producer_lock(), and use it to decide which
> spin lock variant to use in page_pool_producer_unlock().
> 
> As pool->ring has both producer and consumer lock, so
> rename it to page_pool_producer_[un]lock() to reflect
> the actual usage. Also move them to page_pool.c as they
> are only used there, and remove the 'inline' as the
> compiler may have better idea to do inlining or not.
> 
> Fixes: 7886244736a4 ("net: page_pool: Add bulk support for ptr_ring")
> Signed-off-by: Yunsheng Lin<linyunsheng@huawei.com>

Thanks for spotting and fixing this! :-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

