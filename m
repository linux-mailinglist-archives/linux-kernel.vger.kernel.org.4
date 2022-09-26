Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0285EAEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIZRzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiIZRy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:54:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6764DF91
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:30:09 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p3so5785916iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3UDB+4Tbwce9pR58c0ZN5geJK+uyQ//9lahofej6FOQ=;
        b=joF09ODOj2sn8V5OOw855GR4U83EMwZ+3twmgamSgjjg1BP6TBmzO7jNoFSOOCuNny
         mKF7J2mhJyi+LzstukLDBD7ji7ZDJsj+9BEpzm9eRMGqbdujbVUkrilHP3/s+pfjui7g
         66MRX6OBRQ9d5VOsTHeWfV/O7ItW75IsrudWxPPaAzLP8IkzQLzLCBYMtRoZx5A2OLgW
         DAeWpXX0biRU+b9RnlKAVEHrIwn1u30an5E1Ytnj2Ef8TexD9n2y5Ix8fQuxxNuWku9Q
         xg14DCuMx20sKfExJvEYEV4SpP5O4/jHmp1nCR0QB/GY3YML4xL5eiW/PNdyDKGxm1sD
         6g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3UDB+4Tbwce9pR58c0ZN5geJK+uyQ//9lahofej6FOQ=;
        b=cRvmURjgblE522mDsGRjYNAtKeaNo7XuJCKEI8+eoiqfDbKJyS9icQQo1qUZexrUaW
         rgmxTXGMGEsRKJV2Z3LCVQZqzXYrTporZZwBxyFNGoFc8RsgZ4d6PedXOnKLpNlPMNvW
         hyvDaSkTMNbpeG7+HMYWUeWE9B9ZFg52kopj4vIKxwpyOIHwyz1e8Eummk58jeOOicAJ
         BdZkW/+IYwBS7hZfd3oV9Cd4n4b9dgCFK7+ttIyR3aoOFclRmCkMTLssEW2Xd3LRZGF8
         4NKbkx4GFxjkR/vOS1inY6fxP7V+7wKOU6oqYedw9iSPcSktUeoa0HwVc9+CshUNdUr+
         ISHw==
X-Gm-Message-State: ACrzQf0j8C54XBVzsPjSGaY3KGyrLHUXS0kAY3yJtmmlV8MFAcShmq2w
        WThC7P80rkB3t+59pPtVXfV6Cs9L1AaGDg==
X-Google-Smtp-Source: AMsMyM7gfz3r1GWzTF3o2F6a+B6rA4hC8+lR9eZOD80wLjz0jLnwU6GITfP6n9gcxvQz/ikKb+VgJQ==
X-Received: by 2002:a02:900a:0:b0:35a:84e4:39aa with SMTP id w10-20020a02900a000000b0035a84e439aamr12597620jaf.191.1664213408836;
        Mon, 26 Sep 2022 10:30:08 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a11-20020a927f0b000000b002f5abff23aasm6611384ild.46.2022.09.26.10.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 10:30:08 -0700 (PDT)
Message-ID: <2098a505-3668-30cb-e3b6-2111a703b27e@kernel.dk>
Date:   Mon, 26 Sep 2022 11:30:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/3] io_uring: register single issuer task at creation
Content-Language: en-US
To:     Dylan Yudaken <dylany@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20220926170927.3309091-1-dylany@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220926170927.3309091-1-dylany@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 11:09 AM, Dylan Yudaken wrote:
> Registering the single issuer task from the first submit adds unnecesary
> complications to the API as well as the implementation. Where simply
> registering it at creation should not impose any barriers to getting the
> same performance wins. The only catch is users that might want to move the
> ring after creation but before submission. For these users allow them to
> create the ring with IORING_SETUP_R_DISABLED and then enable it on the
> submission task.
> 
> There is another problem in 6.1, with IORING_SETUP_DEFER_TASKRUN. That
> would like to check the submitter_task from unlocked contexts, which would
> be racy. If upfront the submitter_task is set at creation time it will
> simplify the logic there and probably increase performance (though this is
> unmeasured).
> 
> Patch 1 registers the task at creation of the io_uring, this works
> standalone in case you want to only merge this part for 6.0
> 
> Patch 2/3 cleans up the code from the old style

Thanks, I like 1/3 a lot better now. Will provide applications with an
easy path to use SINGLE_ISSUER, even if they currently setup the ring
from a different thread/task than they end up using it from.

I've updated the 6.0 and 6.1 repos to reflect this.

-- 
Jens Axboe


