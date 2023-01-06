Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892A2660998
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjAFWhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAFWhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:37:00 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EF76ECE;
        Fri,  6 Jan 2023 14:36:58 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id b2so3191978pld.7;
        Fri, 06 Jan 2023 14:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ta2lEkN5kGxTKM6DO1j7OMg4sGm8eJ8eSltnioRMtI=;
        b=ThRw5sJxZlRyPhodng3Ew/vyy+aEzQky3D49ywAjWkIPSMuKW5nDyKXRfBooWFqA9h
         qDHMQ/e3s9GI3SpAbHAuD1sk05fyYA8VtJjzXzPPNF3vypk6+lX/LKHcao4V8+1Jcbxq
         7AwwY2OMKAoI+oobzqnq2UUJs4Sm6KonJA1oO2ZHyYZDRB2/bSlm/HlEHGRbvKu7x5Hq
         RGeh9fj6GVJpRQI7NNQt6vdRsB608y9oWEaYx6GFkK98g4VR8DtC30oNjuBWhelVBVjZ
         7unaYebj2SxUu545PHBlL+RVMcQR/kV2n0SBnd5jwtF4CVZINZj86iANOUC1u2PAMM3R
         6KvQ==
X-Gm-Message-State: AFqh2kqPYz+1ZN8f0SOjbd4Kkzv4l/Yh/tkZ7OdT2GauQrTt0Nc7acyp
        JsrDABVfQN2HSASbHdoIGho=
X-Google-Smtp-Source: AMrXdXvx9hEsKsGVd1MGjXgFFib0cGo/BvdB3EmgdQG2Q+U3IMxgohrZP/fJyOzM+mjRgn5vTXWY8g==
X-Received: by 2002:a17:902:ab8d:b0:192:f45d:92b9 with SMTP id f13-20020a170902ab8d00b00192f45d92b9mr8998981plr.29.1673044617680;
        Fri, 06 Jan 2023 14:36:57 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:23c3:f25b:a19d:c75a? ([2620:15c:211:201:23c3:f25b:a19d:c75a])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902bd9200b00186b7443082sm1384960pls.195.2023.01.06.14.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:36:57 -0800 (PST)
Message-ID: <271c3316-e464-9dc6-f703-26a5986a00de@acm.org>
Date:   Fri, 6 Jan 2023 14:36:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, snitzer@kernel.org, dm-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com>
 <20230106083317.93938-3-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 00:33, Pankaj Raghav wrote:
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	return sec & (bdev_zone_sectors(bdev) - 1);
> +}
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;
> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}

A nit: 'sector_t sector' is much more common in the block layer than 
'sector_t sec'. Please consider changing 'sec' into 'sector'.

Thanks,

Bart.

