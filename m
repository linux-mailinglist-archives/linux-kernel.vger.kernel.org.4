Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3CA674A62
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 04:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjATDuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 22:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjATDuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:50:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AFC7D657
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:50:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so3718911pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFN3Pnflf7Lk6KrUCrXdwU3ftbMEbdq7bXTt4T9oMnk=;
        b=3GxR20l1A3kV14z6TIJmlyG1UzFJ0xZZdX8c/uqp2LYg4snHuUqylNb4B/UEKZi3N4
         6CNSTR9H61jHVlz+yV1d8G0hXTaA/Z2EJM0u1u8sD2JgSUwO3ZO+yXfKY7Yb2kSVqzzJ
         FwE/EinXXQTjF0882qTMt4bQbvi6baVnBi1HdZHxB65PZKG2EnGBONTYb62FVSm2zdzA
         +vZwPmCUKEtZyVts4rii+NPxeLtsjZqD9ntVWMPcx9rw/K3y/aVvvFHnbjk8glfJw74N
         0MEYtX5MvD7qPwZi2Q5oPxjQgmMKz4qGlXbvcd5TewE7jf2Deff1Qyh5tx9VtYat8Eld
         mUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFN3Pnflf7Lk6KrUCrXdwU3ftbMEbdq7bXTt4T9oMnk=;
        b=W6y2ZBQa4er5NfIeP1LkXtVTH+dAKjR8UF/i7KHMuesWNNMFXla60lEyFvAkMTCpVg
         3x5J0Gnp7QnxcGsmcGFH1CXonbZlci1zFTJ/0juFL7KiSfDxDxGP/Hmy6QosyRkAc2xf
         G+b4oc4Dku94z3MhDXJMK8QE9nrpb8nsEEEU5eq/L7PX8al3hGT36B9HUz6tDJ6vJskS
         nUGin7jX/wrxpvfLqk2yK7WXtZHuFAZfcG+eqLLrU11iQ87LKarHECnHjJd1erafxrBy
         qrBxE9nASfVuHI+wGeolbi14QeHcAQbs6VOckIeOmLD2h4xNzRDzXwoKC/e2WylDjEUI
         2/Nw==
X-Gm-Message-State: AFqh2krmegdVeB1ktqiZixUoh5UXAQU5b4uMmeCCcqZ+XRckGVgVrToe
        HtX/XrQtHadPnyAStoMbnGPAaQ==
X-Google-Smtp-Source: AMrXdXtv3X5Fw1PJqm0+RQ7mNmEYpHfgAMiljyMT0W1dC6GzMitviZUt7sOY8MmOgv0LF67eGAMdjw==
X-Received: by 2002:a17:902:b702:b0:194:5d47:b47d with SMTP id d2-20020a170902b70200b001945d47b47dmr3295198pls.1.1674186634502;
        Thu, 19 Jan 2023 19:50:34 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::1739? ([2620:10d:c090:400::5:ccda])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm25873870plb.22.2023.01.19.19.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 19:50:34 -0800 (PST)
Message-ID: <3ed9db5a-f527-2c53-3926-74bd802a3086@kernel.dk>
Date:   Thu, 19 Jan 2023 20:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH-next v3] lib: parser: optimize match_NUMER apis to use
 local array
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, bingjingc@synology.com,
        ebiggers@google.com, james.smart@broadcom.com, houtao1@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
References: <20230120021304.5773-1-lilingfeng3@huawei.com>
 <Y8n1rOLdMGDfOgpe@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8n1rOLdMGDfOgpe@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 7:00?PM, Tejun Heo wrote:
> On Fri, Jan 20, 2023 at 10:13:04AM +0800, Li Lingfeng wrote:
>> Memory will be allocated to store substring_t in match_strdup(), which means
>> the caller of match_strdup() may need to be scheduled out to wait for reclaiming
>> memory.
>>
>> Using local array to store substring_t to remove the restriction.
>>
>> Link: https://lore.kernel.org/all/20221104023938.2346986-5-yukuai1@huaweicloud.com/
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> 
>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> This fixes a sleep-while-atomic splat in blk-iocost, so it'd be a good idea to add:
> 
>  Fixes: 2c0647988433 ("blk-iocost: don't release 'ioc->lock' while updating params").
> 
> The mm tree likely is the best fit but given the splat the block tree can
> work too. Andrew, Jens, what do you think?

I can take it through the block tree once folks are happy with it, as
the buggy patch came through there. Doesn't really matter to me,
however.

Why is it marked for-next though, seems like this is a regression in
this series?

-- 
Jens Axboe

