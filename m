Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A80628E83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiKOAkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKOAkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:40:02 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63411AD95;
        Mon, 14 Nov 2022 16:40:01 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id q1so11765748pgl.11;
        Mon, 14 Nov 2022 16:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9WtyFjfUCr3EXsv59jM0Uq8xTAz5w+9nR4N7uzysOg=;
        b=vn4cdZ7U8kBsNsO+Pi5HfO9LqYqEQvW4eUbb6TkNnfFTLapA16EYNcFXZ10xJFh2HG
         JSnt6QJztDJ0A/bITWpVx//JXR//kFXBTuXHZ0Ffe7g+wFUAXlu7lbq3Nwyn0wZTJySI
         lmvjV2zw1fFljLJsj53qD9mnxhBgfdOAYQxqm0nJJurvbk0PCs5GSgRrMtXvosywCPkx
         6lGc/95fncfrGTXSBsF/HnpjCND9cGJpL1wKGLBgfVHQ4Cghn45fpKug/yaLtgLfiFNg
         EM87LpIjNY5V1BA+f8q+xaFK1AExqw/FRJtB0995En+BqkPubgp+RLoybd+cbuLcGxFv
         wz2Q==
X-Gm-Message-State: ANoB5pkbe1Iy/KR/CuUFATFa/CXazbbxlPdOgmtA0vTHucQzGUNWakk/
        HHpZXoviAoZYA1+sMOAWq+xrJzs/sXo=
X-Google-Smtp-Source: AA0mqf7fhCduzJzmk0XAdVLf8vaZzU3QksDMtaJkAD1rKSXJ5IcBeuc9UF+9PGVFEonMbATAqOpNPg==
X-Received: by 2002:aa7:9902:0:b0:56e:8ed7:569f with SMTP id z2-20020aa79902000000b0056e8ed7569fmr16006453pff.19.1668472800948;
        Mon, 14 Nov 2022 16:40:00 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:637b:9535:5168:c84f? ([2620:15c:211:201:637b:9535:5168:c84f])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm7326858pfa.9.2022.11.14.16.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 16:40:00 -0800 (PST)
Message-ID: <ffeb482e-9369-621d-7537-e48c8436de76@acm.org>
Date:   Mon, 14 Nov 2022 16:39:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 3/7] null_blk: initialize cmd->bio in __alloc_cmd()
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
        yukuai3@huawei.com
References: <20221006031829.37741-1-kch@nvidia.com>
 <20221006031829.37741-4-kch@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221006031829.37741-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 20:18, Chaitanya Kulkarni wrote:
> The function __alloc_cmd() is responsible to allocate tag and
> initializae the different members of the null_cmd structure e.g.

initializae -> initialize?

> cmd->tag, cmd->error, and cmd->nq, Move only member bio that is initialized
> from alloc_cmd() into __alloc_cmd().

Thanks,

Bart.

