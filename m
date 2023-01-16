Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27F66C072
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjAPN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjAPN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:57:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF86422785
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:55:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v23so25492516plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=147jSvlJn5xlSD2sUs0kYKU5A8XzMbwpiBCjTNuI7UQ=;
        b=RJAFWHjuvZK/dAbe6GnD6KJxIkse2okjfKOmy0E0QmeeTYuRgtpe5HYs9Z6UnS9Mf2
         cbBM6Riu6PuvpQO+ovTAbQRyUGDSiXB03qZtzQHu+cdvbtYanb1ERT7LFng2Z7nl8tz8
         ZTGUU0wpHVIw8/vNoZ5gKPDvnM0yFkIrUbifnhV5ynDfzBVXiuRAy+Q8ISWHN6WVYXzK
         pKG3Q+zeA0Sbg1A/qPe+DL8OsEyLbjhDyoxpFTsVHtvnafoGcIqxxXZMaO0Wd9i6BDRy
         HjmgJoAGOapftq5GBQI03vrGwPq6618OLSUIbkh2J732odRmWORQsH/CRgys8R339uBa
         C+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=147jSvlJn5xlSD2sUs0kYKU5A8XzMbwpiBCjTNuI7UQ=;
        b=xle5LGswR88O2NlMjcNWMrnXesthukgPlTBDvRidFEcpq53+WqX4Cj5IhyvcGXtuGt
         OWm1G3di/cWYt+kp7Z6UP0YjXZoagSUGc49GUEkJ/OQY0F2K/bp2YjMs3ZEIgLsx3C66
         IVmD1Kb+HFoEpOJkR9syz9zQqVn/f8rayBKUi7FDRnObE+9FuaJqZrwVmLY3M7dx2VF8
         q21MFWmempjuJ0k9P6lNflPrHVndViwe4iSzl6zgtcFRjO9HHkeC9Hr5Hn3E7vUllftl
         nv1F57BnHih2l9bheZ86mkPxdlo070ywSYzPFTiy/h94B0VS3mmiSZ0Pc+hyZL/KksoT
         2fkg==
X-Gm-Message-State: AFqh2kpvzlfPoytF2xmNN//WQ/jEMmxmA/nYxJ58bF93dqp3xELwkqq/
        m4wvb+ipU/5wYorx6ygpCx+FMg==
X-Google-Smtp-Source: AMrXdXv13YFxiAXJNMAadUbS9Q6PE3PbLzHNMejVH0EJDX2xGGWu77aDgVBYSYbhLk0HyJCFwtCzlw==
X-Received: by 2002:a05:6a20:3a9e:b0:9d:efc1:116c with SMTP id d30-20020a056a203a9e00b0009defc1116cmr21242624pzh.6.1673877322173;
        Mon, 16 Jan 2023 05:55:22 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c10-20020a63d14a000000b004468cb97c01sm15901902pgj.56.2023.01.16.05.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 05:55:21 -0800 (PST)
Message-ID: <e01e469f-488a-8f2d-008f-8427289d2ff3@kernel.dk>
Date:   Mon, 16 Jan 2023 06:55:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] io_uring: Split io_issue_def struct
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>,
        Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     asml.silence@gmail.com, dylany@meta.com, io-uring@vger.kernel.org,
        leit@fb.com, linux-kernel@vger.kernel.org
References: <20230112144411.2624698-1-leitao@debian.org>
 <20230112144411.2624698-2-leitao@debian.org> <87v8lbcwz9.fsf@suse.de>
 <Y8UseW5sTqu72M2U@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8UseW5sTqu72M2U@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 3:52 AM, Breno Leitao wrote:
> On Thu, Jan 12, 2023 at 05:35:22PM -0300, Gabriel Krisman Bertazi wrote:
>> Breno Leitao <leitao@debian.org> writes:
>>
>>> This patch removes some "cold" fields from `struct io_issue_def`.
>>>
>>> The plan is to keep only highly used fields into `struct io_issue_def`, so,
>>> it may be hot in the cache. The hot fields are basically all the bitfields
>>> and the callback functions for .issue and .prep.
>>>
>>> The other less frequently used fields are now located in a secondary and
>>> cold struct, called `io_cold_def`.
>>>
>>> This is the size for the structs:
>>>
>>> Before: io_issue_def = 56 bytes
>>> After: io_issue_def = 24 bytes; io_cold_def = 40 bytes
>>
>> Does this change have an observable impact in run time? Did it show
>> a significant decrease of dcache misses?
> 
> I haven't tested it. I expect it might be hard to came up with such test.
> 
> A possible test might be running io_uring heavy tests, while adding
> enough memory pressure. Doing this in two different instant (A/B test),
> might be a unpredicable and the error deviation might hide the benefit.

I think what you'd want is two (or more) io_uring ops being really
busy and measuring dcache pressure while running that test. I don't
think this is very feasible to accurately measure, and I also don't
think that is an issue. The split into hot/cold parts of the op
definitions is obviously a good idea. For ideal setups, we'll never
be using the cold part at all, and having a smaller op definition
for the fast path is always going to be helpful.

-- 
Jens Axboe


