Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFEE5EE405
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiI1SNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiI1SNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:13:32 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A777ABF17;
        Wed, 28 Sep 2022 11:13:32 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d24so12420988pls.4;
        Wed, 28 Sep 2022 11:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SrqLT0kXpAlJD8TZzx8ujBa5nxZPe+zl7PnVUm+RbhE=;
        b=TDLXY43fvsaoQNCtrwuijWEqsIG31bpFMUPXK8AfWOQtIg+Wkhva+/mjAdIi91bXKN
         zldZjVnxPjCiuZx9giK81NVf0ivXssKU/wHZyJbFQpvLbRUZscWS7BU0MQCc/xIJqe+W
         cPtFLYjHqLu/BlN2XDQARvkHtmJFVXzNM7GSedeuaxBaW/NepyEL2U6oQqTM8LKUutQW
         4VCgja+rbWqp3nE/5IL9aS1bzdO5WhGw4YN1boE1bsHX0xvGC+GhjE6qiANXHE70oS6g
         nw2+Sz6zb6ldua/wJmo37gQJ6X88UmBYOyhtLf7mXpOWW4SFRyB8vOE1o4F+kzvINnf3
         q73A==
X-Gm-Message-State: ACrzQf1P+VcKv9EYc4h7VWk/g98uogW38fmg8FQuLXyniiuHYKqhq5Ww
        9/uzvZ/9XKv9NNveojQcv5ZM6AUWepASJQ==
X-Google-Smtp-Source: AMsMyM5phyXRHDoV48KwWkEssjx6POVAM7KislIcpIimObHNjJBChVYQkrXS8krHgOsN/67JiWvhEA==
X-Received: by 2002:a17:90a:4607:b0:202:e22d:4892 with SMTP id w7-20020a17090a460700b00202e22d4892mr11629503pjg.220.1664388811703;
        Wed, 28 Sep 2022 11:13:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cba:f1a9:6ef8:3759? ([2620:15c:211:201:4cba:f1a9:6ef8:3759])
        by smtp.gmail.com with ESMTPSA id p15-20020a1709027ecf00b0016f8e8032c4sm4014341plb.129.2022.09.28.11.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:13:31 -0700 (PDT)
Message-ID: <d7004ae9-ad68-cb61-9ca8-0bf61efa0c21@acm.org>
Date:   Wed, 28 Sep 2022 11:13:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
        axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com
References: <20220923173618.6899-1-p.raghav@samsung.com>
 <CGME20220923173631eucas1p23cceb8438d6b8b9c3460192c0ad2472d@eucas1p2.samsung.com>
 <20220923173618.6899-12-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220923173618.6899-12-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 10:36, Pankaj Raghav wrote:
> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation, and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore.
> 
> Currently, this is not a problem as the targets that support zoned devices
> such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
> and even if they do (such as dm-flakey), they don't modify the
> bio->bi_iter.bi_sector of the cloned bio that is used to update the
> orig_bio's bi_sector in dm_zone_endio function.
> 
> This is a prep patch for the new dm-po2zoned target as it modifies
> bi_sector in the endio callback.
> 
> Call dm_zone_endio for zoned devices after calling the target's endio
> function.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

