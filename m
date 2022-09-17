Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29385BB99A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIQQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIQQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:50:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC8A27DC9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:50:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r134so19834977iod.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OD9XT4CR5VyRMAIbcP4aYEY263YSrvWXbcu+RkRlk4I=;
        b=aRVZwMRSorHTW051GLhPP5Qn0nfy4sTH/jVXgVHI2zdJhX3AmR/VWE9Iuzm5lWp2gq
         +valD+bvQ2wXpLZb6szOuIDOjN2wXk1hczGfCJdwLafcqN3YXhvgXEFNZjhtvqC/AW/4
         EP8w8J1PrOytikqdxGIjKCk1/pKpII+4tJBeOVFTyKFHoOvkv0yl/ovrwZlAht2xgnFb
         gpSTV4+AYsHqTqXbGIkbzsKqnobAfG38uw6Bm17b+52rpKqe67akJpGHCmKzvCBf78oH
         l1/kdR3eaVApM2K0W4aIaQPchZYlnFHrfsRLPfBRtIhsN088GAVllZdte1QuA5U5ZQwK
         FQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OD9XT4CR5VyRMAIbcP4aYEY263YSrvWXbcu+RkRlk4I=;
        b=lkBT1b79Bvo0XbJHQkx4dMVqGHrW7Rvhut6Yip2k9UiHux/JADmC+PZ6716J8AbB4M
         K9QtVmiqRqgReJAsgp+fpALR+8cUoL69qGALlmQe760jE6tMpjL38FKbKHOsOLZnmfWS
         y7gmVRY9usClpd0jj6WqHi0/2LjrzOsHTJ7XDsnow7Cy+ulzCQPfQdHqAtd/K3O67SMA
         u1UftwmCdBBnnNMGBZ5oqcskzyBs0ryoqE6DClbIf3/E/PoVutepyd7nkVaSTTiu020p
         XgAhskvO1m6F8zQT5dTgfGcCPPeCnMTB0d2/NoCM90N76Pcw2WXiceX9QaCBNhCL6r3e
         1lTQ==
X-Gm-Message-State: ACrzQf2JbEu8q97kpr3TdTrbe3IFtcfqHUQtoDor9WB2ZMCGyG5E8XGd
        gI26+OXhAlExjnzE6wg3/Z+m5aHuefPn2VXA
X-Google-Smtp-Source: AMsMyM5nlAPcgFEuypzcXVI6oequYsaj02FmYE5rWtc2/Q4m94D0ndSgXO8fPwVmq/KM98zJpYMKFw==
X-Received: by 2002:a05:6602:15ca:b0:66d:9f5:4535 with SMTP id f10-20020a05660215ca00b0066d09f54535mr3999054iow.66.1663433428208;
        Sat, 17 Sep 2022 09:50:28 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t14-20020a92c90e000000b002f5024d8543sm1580861ilp.38.2022.09.17.09.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:50:27 -0700 (PDT)
Message-ID: <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
Date:   Sat, 17 Sep 2022 10:50:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
Content-Language: en-US
To:     Liu Song <liusong@linux.alibaba.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/22 10:40 AM, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
> so when "nr_ctx" is equal to 1, there is no possibility of remote
> request, so the corresponding process can be simplified.

If the worry is the call overhead of blk_mq_complete_request_remote(),
why don't we just make that available as an inline instead? That seems
vastly superior to providing a random shortcut in a driver to avoid
calling it.

-- 
Jens Axboe
