Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5777B6F31A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEAN5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEAN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:57:15 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47396BA;
        Mon,  1 May 2023 06:57:13 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f16f792384so6723725e9.0;
        Mon, 01 May 2023 06:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682949431; x=1685541431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5J9a5kf3kmdYh2Ndj6S+0+amm34/1HJ3W1fY7sBGzIs=;
        b=LZxMJrM2C7J9bQAOdA3/N3QYg6V+sfGRaA3KO85cin79k5AtY6HnfSbHcxuQJXIQjM
         qOfdcvEItIOq7bqUYMVf4mHBo746P7a1cdY9pXuYEXgH7v1XZcXr/tBsf1sUJEdsjLsF
         0Z6kEUhj7kZSUOTqxoyC3dlA+GFvHTlU+5RknXGPASbvPcqOA4tL2k2KX7Z38D6HHu9j
         Zmz/s/YK58o3zJ26pJSvcWAIcs1Xv4hyTZOdDdFiH82+jiNMwEBQcycmzDWYLffTSGoL
         0qru1T9oAVsoUMViIYPyr31+QPCcA6gzjUbTtC+5AUONhIqV2VZOkOZCHODbItJgsF72
         azlg==
X-Gm-Message-State: AC+VfDzJTLxVVX9yZvOxRQDEoYafs8uFFF+hnG9sRi/KYj0klYZ+decc
        kkzM5Drhm/d5WDMXDcP3KFU=
X-Google-Smtp-Source: ACHHUZ7huY9T4MZzSyl932OZ5qbrifrmg+VePH2kBZVD2pNW6t9H7hY3XxVgttyySFZmhsuk8n5wWw==
X-Received: by 2002:a05:600c:310a:b0:3f1:960d:68ce with SMTP id g10-20020a05600c310a00b003f1960d68cemr10825464wmo.3.1682949430985;
        Mon, 01 May 2023 06:57:10 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003f173be2ccfsm47590803wmn.2.2023.05.01.06.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:57:10 -0700 (PDT)
Message-ID: <012a86ad-933a-2948-29d3-764346afbd6e@grimberg.me>
Date:   Mon, 1 May 2023 16:57:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] optimize some data structure in nvme
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>, hch@lst.de,
        kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This serie is a proposal to slighly optimize the memory needed for some
> structures used in nvme.
> 
> This follows the discussion in [1].
> 
> Honnestly, I'm not convinced that this serie really brings semething.
> Because of the way memory alocation works, and its over-allocation to try to
> avoid memory fragmentation, some limited gains are most of the time useless.
> 
> It could still help:
>     - many holes in structure can, at some point, have its size reach a threshold
>       (this is specially true if such structures are allocated with kcalloc() or
>       kmalloc_array())
>     - it can save some space in some other structures if embedded in them
>     - it can save a few cycles if the structure is memcpy()'ed or zeroed, for
>       example
>     - can reduce cache usage
> 
> With that in mind, patch 3 is a win, patch 4 is likely a win, the other ones are
> much more theorical.
> 
> The changes are really limited, so even if the gain is marginal, maybe it still
> makes sense to merge them.

Don't see why not, given they make do the structures smaller.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
