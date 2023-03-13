Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365F6B77E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCMMoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCMMoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:44:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834945B413
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:43:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so18703463edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678711419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KBwvnk3MOdnQ4phoEaOd/Sur+/zbQ/JcB41OHqz69Y=;
        b=D4VxQAk8YQwdaIM8f6xYINpHIRnUks7jRb9tsVIwr+xLOKI4eU1WjFT1DR1+Kvez94
         cD8PI9tVU+f53Ogrhgc7pJDdr5FBqWO2GtCkn+RSODiBscpmH4XVR9oyvxG4dXPg+ggf
         WAe+sijyQmoixwKDJa1uFN1nfEf7I5nuLTF4xTkZtZ76rT0RuhX+AJEEdwjEzLgJkWvr
         9XVoGJ2OFoDl2Kmw/pHdF84e637IDCgVcc5RsksII6rVB+TWZaWvdZLwvHEGA2v3VHv/
         BW+ylQCc6njgxEURSSo89hXrd2u2exXL+6LIef1tz8iPDK2FSYFWP3xcaRSOAvQ9Uj2g
         Upug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678711419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KBwvnk3MOdnQ4phoEaOd/Sur+/zbQ/JcB41OHqz69Y=;
        b=E6c0V7O8dbejxgoZb/qqPUNA09wSOZVqr2y+cgx96HnXuFk5QwQPmAztUusohodg+v
         ehonocLCTwoV8UJd7lyf3Qo/sgy7xjDsrRbsA714BCaIqlB22L0OiOIHQM7M4g737AeU
         +2eKlqAxVnAzHcdpdXmU2PDM/p0KmaDgHZs6Oe0dZAvC9HTZpfzOEbRLwm9Ou6YnWLej
         3sPQSutTsEu0waCzonoSGcatTtE+Kf5ud0t++pRn1wthkhLJs1Wx7jgKcvW6ut1vpJJa
         v9rCZ9UetDrT2q0UsBTsXKDEug601dXIYR8WGXX71KXy1s1/RgtOnzFiMHvE8N+7Dkpc
         ElWg==
X-Gm-Message-State: AO0yUKU3q/WBhAJbuBFPTm5/iWv+FTNg+pmYwIv2twa808qC+yRpruSe
        v+Cbe7GYb5iZvF6BxtTnUTuuAw==
X-Google-Smtp-Source: AK7set/XusdDAbHQT5pKgrC7UIBb/UmhxFSKOwIcmIx3IRayQVro5RXMU3oezqx+mZXiWwpX+74xyg==
X-Received: by 2002:a17:906:64d:b0:8b1:77bf:3be6 with SMTP id t13-20020a170906064d00b008b177bf3be6mr32449177ejb.10.1678711419311;
        Mon, 13 Mar 2023 05:43:39 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id gs20-20020a170906f19400b0092babe82cfesm473294ejb.215.2023.03.13.05.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:43:38 -0700 (PDT)
Message-ID: <d3f2cb4d-da47-baec-4d93-4f1a700a07d3@linaro.org>
Date:   Mon, 13 Mar 2023 12:43:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] ext4: Fix reusing stale buffer heads from last failed
 mounting
Content-Language: en-US
To:     Zhihao Cheng <chengzhihao1@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, Lee Jones <joneslee@google.com>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-2-chengzhihao1@huawei.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230310125206.2867822-2-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zhihao,

On 3/10/23 12:52, Zhihao Cheng wrote:

cut

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217171
> Cc: <stable@kernel.org>

Shouldn't have been stable@vger.kernel.org instead? That's what is
advertised at:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

A Fixes tag would be helpful. It would assist the stable kernel team, or
people that have to backport your patch, in determining which stable
versions should receive your fix. Same suggestion is made in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks!
ta
