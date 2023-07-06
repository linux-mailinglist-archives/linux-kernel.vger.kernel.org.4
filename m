Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251EE74A39F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGFSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjGFSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:13:12 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE611BEC;
        Thu,  6 Jul 2023 11:13:11 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-51452556acdso799877a12.2;
        Thu, 06 Jul 2023 11:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667191; x=1691259191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nswtB4vZ8VNtDa5BPx00Cl/IjX72X4BUKIHp85uPhUE=;
        b=lrZsCrizh/TeUdwM6UJI5E5BYAbvVgfc8lJrdM7mRyOzZLEwVLTw7AIfUyk12rE2/N
         ZuHZ7W/pgAZUBnHon9T6gyldbT4Ay1FyAoi+6VR6Df8gLDRAOtnFQpVwDykyYmaVh4z8
         zDNF6TYIolP9X2jFdsgPk4IdziPrs1naB2NRryrKDitN8zq4iZAJ0LW3VQ7dcVinj/6T
         VGHzlbU4wzjr65UIp/5EeW9HZkftfxdoWyiVcSbWGFH4sfdHOpIwRqDMIP4cU4O1wKDj
         JReBGg+wzTXzmH/7yGxfl0+FltgHNJmwAJDQgw6k78EeMqnzKowSZb1A9SIO9EWueOoF
         AYUg==
X-Gm-Message-State: ABy/qLYMHkpV3FDH9RLt1EQpUlN0IRWzfh/PtDdF/oJNGNzkrQ9Ysqn5
        FMmBDjCqgoB37Bj4wI5OJaw=
X-Google-Smtp-Source: APBJJlFrf4Nj/8dpztQi6qoWSOuUG6PQVmLxG/Hc9wEsGT5qKBJW2yjRLX4ngRzNWrMwcAk87HXzVg==
X-Received: by 2002:a05:6a20:324e:b0:12e:3442:32fb with SMTP id hm14-20020a056a20324e00b0012e344232fbmr2028276pzc.16.1688667191107;
        Thu, 06 Jul 2023 11:13:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a75c:9545:5328:a233? ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d50500b001aae625e422sm1729086plg.37.2023.07.06.11.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 11:13:10 -0700 (PDT)
Message-ID: <3b5caa0e-e63b-3652-cd64-e6cdb9323242@acm.org>
Date:   Thu, 6 Jul 2023 11:13:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 4/7] blk-mq: precalculate available tags for
 hctx_may_queue()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <20230618160738.54385-5-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230618160738.54385-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 09:07, Yu Kuai wrote:
> +static void blk_mq_update_available_driver_tags(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct blk_mq_tags *tags = hctx->tags;
> +	unsigned int nr_tags;
> +	struct tag_sharing *tag_sharing;
> +
> +	if (tags->ctl.share_queues <= 1)
> +		nr_tags = tags->nr_tags;
> +	else
> +		nr_tags = max((tags->nr_tags + tags->ctl.share_queues - 1) /
> +			       tags->ctl.share_queues, 4U);
> +
> +	list_for_each_entry(tag_sharing, &tags->ctl.head, node)
> +		tag_sharing->available_tags = nr_tags;
> +}

Since READ_ONCE() is used to read the available_tags member, WRITE_ONCE()
should be used to update that member, even if a spinlock is held around
the update.

Thanks,

Bart.
