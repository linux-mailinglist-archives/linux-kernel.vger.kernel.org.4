Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA3574A355
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjGFRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGFRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:43:25 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF9199F;
        Thu,  6 Jul 2023 10:43:24 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6686c74183cso805067b3a.1;
        Thu, 06 Jul 2023 10:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665403; x=1691257403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvr87+AoFHtLDIGSAaHcjJ1+wzEBB57fnk42Q9ycDPM=;
        b=iT3cqAUyeddBFL0B6nVA3Pc0XPU+ywwMJdAd1cC4Tdng4DKneYXB2a7GrgdDDlft9v
         pBvPC77ob9prP0ndf6RksRAGsUxy6O1U7I55XSlYgPxuB04F8qgfN3sQGFHjy0LAFbVX
         ECaHDdVPbdDdHcgLy1TW7benDS8w95gkz2HNQ3zufHbprz+YyxJ4OPAPig2iIgtBOvHf
         MIXStGjGg/M02EbpbtvTyQR84gaLGRSROkNgwceRGTAi9wjb59ghn3Q+XtzYwiy438aP
         F+WFQsJqziG1J8cX9z/e3D7kHObgGe63tMMTB8LWWx4Au1V3R+eKAKSdj4FFxTCSUo7Y
         xKTQ==
X-Gm-Message-State: ABy/qLYg5iiF4r3Vts1UosTKi9triyWSc4DtxxEy+wQY79sj74NAtLbx
        x+dBf0H3Avt6hr6BgmcrCr8YH8IZ+8g=
X-Google-Smtp-Source: APBJJlFT8+yVY72w0coTpH7C50FL8y6paconZ8kFZwdk59CxZVH3kJ2t3K+PRP0Ctwzz6T+cjMDYuw==
X-Received: by 2002:a05:6a20:1d0:b0:126:43f7:e270 with SMTP id 16-20020a056a2001d000b0012643f7e270mr2432486pzz.59.1688665403403;
        Thu, 06 Jul 2023 10:43:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a75c:9545:5328:a233? ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b00671eb039b23sm1554122pfo.58.2023.07.06.10.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 10:43:22 -0700 (PDT)
Message-ID: <57406ab6-deb7-1802-dc9b-7c847b0a261a@acm.org>
Date:   Thu, 6 Jul 2023 10:43:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 1/7] blk-mq: factor out a structure from blk_mq_tags
 to control tag sharing
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <20230618160738.54385-2-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230618160738.54385-2-yukuai1@huaweicloud.com>
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
> Currently tags is fair shared, and the new structure contains only one
                  ^^^^^^^       ^^^^^^^^^
                  are fairly    .  The
> field active_queues. There are no functional changes and prepare to
                                                       ^^^^^^^^^^^^^^^
                                               . This patch prepares for
> refactor tag sharing.
   ^^^^^^^^
   refactoring

Please make the subject of this patch shorter, e.g. "Refactor struct
blk_mq_tags". Otherwise this patch looks good to me.

Thanks,

Bart.
