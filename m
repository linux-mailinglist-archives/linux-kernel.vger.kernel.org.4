Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7587461C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGCSIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjGCSIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:08:16 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E870E5F;
        Mon,  3 Jul 2023 11:08:16 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2411706b3a.3;
        Mon, 03 Jul 2023 11:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407695; x=1690999695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdlTq9LuY8/LR/KMjs0dLZRjJIwIbTa797xTBtHD1Qc=;
        b=BHd2665OQIReDtHLE84UqaobhS39Z+WVHk/KHHZVG2LnleTjQpk9cE6/JoVtdhapRf
         qUwsRkMnSfDyhTNtaxAShKf9M4DjcntlU3I5XjFWz3fsz/CkIBYjzjwqmf6mFVoiMtbZ
         1f3IkGyRHpMUQKHLdqt322liwsSZ/+oIWeog1Qre4rtH5J78aVaN80gX+hQ3fSCphOW+
         hv3kGSVYfDuFW5RLF0PSBQh1WNU4hJO1NCEtk30BupZI/DqTPQqTftb0zYhcj6Lixued
         qmjOJu/jTQaXIV15HyOXfyjMy+0yQBufp6I8B7wwdhCMV7/WoS6rmAAWmqp21iWKmkJQ
         M4WA==
X-Gm-Message-State: ABy/qLazCnVQuz/p3HrR4zgEtkBWxCRhKwQgYpsaffSdr6AQzYe0ZDzZ
        5Lj7sBfHQYt4T62DUg2plb8=
X-Google-Smtp-Source: APBJJlFoKToqL63bnEKlbggnBe+x+5CLNZA1xYgpfIjsVakeUx6FT+GZoK4g5lUFk/DKykj66llfPg==
X-Received: by 2002:a62:1ac9:0:b0:668:7090:bf18 with SMTP id a192-20020a621ac9000000b006687090bf18mr8899924pfa.34.1688407695533;
        Mon, 03 Jul 2023 11:08:15 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j18-20020a62e912000000b00660d80087a8sm14191383pfh.187.2023.07.03.11.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 11:08:14 -0700 (PDT)
Message-ID: <c4de836a-a2a1-847f-1525-1accb814e45e@acm.org>
Date:   Mon, 3 Jul 2023 11:08:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 0/7] blk-mq: improve tag fair sharing
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <4c9fea33-9c30-4ab9-c210-95e09d323837@acm.org>
 <82d44ba1-4389-079c-935a-cbb49203ca27@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <82d44ba1-4389-079c-935a-cbb49203ca27@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/3/23 06:29, Yu Kuai wrote:
> 在 2023/06/20 23:20, Bart Van Assche 写道:
>> On 6/18/23 09:07, Yu Kuai wrote:
>>> This is not a formal version and not fully tested, I send this RFC
>>> because I want to make sure if people think doing this is meaningful,
>>> before I spend too much time on this.
>> The approach looks good to me but I'd like to hear from Jens and 
>> Christoph what their opinion is about the approach of this patch 
>> series before doing an in-depth review.
>>
> Any suggestions on this topic? It'll be great to hear that if anyone
> thinks it's meaningful to refactor tag fair sharing.

The cover letter of this patch series says "This is not a formal version 
and not fully tested". If a fully tested version will be posted, I will 
help with an in-depth review.

Thanks,

Bart.

