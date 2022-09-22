Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD25E6B43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIVSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiIVSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:52:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67DE62D6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:52:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so10004051pgi.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Il1n+p4EYijj6sMX+qTskkavLcV+LCxu/c4N5YGuAz8=;
        b=2K4/5gRHOw+nUVM6Q0jlqIaxrwXepL/8XbhbHtaGBxUIxiEIS3jSiRB6a7G3n4aX6s
         SwqblsFwJZxCUCnK6vPdKIBm071K9yD7o5Ib4nKbD99l37gftYjkjNaGV+IxZA6X/uKM
         cdlmS3FOvAtL0IkjVAJv5Bek2QUSSS4BKxgie8P7lpntt8PNNj/fnzzWqmdQm/gQCH7X
         IQg+s4k6vKpnvJQo8IqtyHl0jsLDhBMCh8BI0zDCSdBbIAt0ssXBR9ezhs+WckhQkvED
         QVavzuyE+YzR1ebk7P7YMDYh//duMfSjordbUO7Clid1RNVbpBbarVwzqT4Nxy8jKmaQ
         EI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Il1n+p4EYijj6sMX+qTskkavLcV+LCxu/c4N5YGuAz8=;
        b=doV4qyFobIBRPpXPDz2kiifYHQ14tFxXJsis0u+hPMMZUczMh37B/pMwB4lLqpTcuU
         F5oSLaOzjSG8e1VfmmZ1zJRCBRccrUrMMNkm5De2RUJAVtus+O7qmRRiSoCJ0X+Blanp
         /XiFzo6K5po54WUfbwMD7EQIMXcRDr19LVN4u876V0EyPRhVx7Tsvxx9ab71tsNhV1ke
         M7Qv/t6xeZEbxAQjrP1bvhxSShVlWfx7jqb7am2fqeIPn0ne1VKzed6tyEnEc4kZYPPI
         dKUgbhpt10WpoSvCz4O5v7vkuD4inmJjHvrGvvKGAVvwc6kDVz8FAH7RDBMyajV/Xsbi
         okhg==
X-Gm-Message-State: ACrzQf3C1923Poi+nOe15uq/LXhvVMunTovAo/dpmo7oO7Rytl2j3Vl4
        /SKoT+e9j7/GxnaYYy2h7hChQA==
X-Google-Smtp-Source: AMsMyM5GN8+12qE4fTmSo6QHNROyAl191fsN/T0krzY3LYnwrkSKgfbUNjXRj5Vy9FjgBJd23x040A==
X-Received: by 2002:a63:5a5e:0:b0:434:b739:206f with SMTP id k30-20020a635a5e000000b00434b739206fmr4188149pgm.82.1663872745268;
        Thu, 22 Sep 2022 11:52:25 -0700 (PDT)
Received: from [10.255.231.119] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001754fa42065sm4441763plk.143.2022.09.22.11.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:52:24 -0700 (PDT)
Message-ID: <db791538-0af2-b7c0-986a-6a9492d0495e@bytedance.com>
Date:   Fri, 23 Sep 2022 02:52:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RESEND PATCH v3] iommu/iova: Optimize alloc_iova with
 rbtree_augmented
To:     joro@8bytes.org, will@kernel.org
Cc:     wangjie125@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        haifeng.zhao@linux.intel.com, john.garry@huawei.com
References: <20220922183114.15135-1-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20220922183114.15135-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Compared with v2, v3 mainly updated the commit message,
and set the upper limit when scanning the linked list.

In the normal case, the performance of this algorithm
is almost the same as before. In extreme cases, this
algorithm is much better than before. And this algorithm
does not bring additional memory overhead.

Comments welcome.

Thanks.
Peng
