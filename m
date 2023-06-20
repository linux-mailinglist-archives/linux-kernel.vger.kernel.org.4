Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B015737057
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjFTPUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjFTPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:20:37 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634C91731;
        Tue, 20 Jun 2023 08:20:21 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b516978829so38925465ad.1;
        Tue, 20 Jun 2023 08:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274420; x=1689866420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkZu9jCa+XfTRWAAYoCY/vLwn0a63A/ySsQ0zgyB474=;
        b=L0x1BAnwFa8BFZQ4hToy/iV50n0NLNAGN7MOypsL4GO1AriFND1yIEozdfCZIctNx/
         21OTi383nSISxDKCRVbHVpB1ySmJnwNvxSZlluZSU4A6zj2yDerr1CVLU0nSVxXlPe05
         n4aEa9gPY6VV2U17l1obZsilbmsgHYy4PlwNcI1PgZh1s4mIAsLPYuvkrnyqGoATADT5
         4tAZ2JTMsKsyDCA714rZZOw7aKWS4Kcn5l49oco3fdeUjiuwwqmthHsc8xxmUQoEoEtl
         i2nW57UQtJYo+J/u9vxWJSynv+VqeQ0rLr2++P7zxFJ3Ab0sxliT1fTIiNv8tYi1lBCx
         ia7w==
X-Gm-Message-State: AC+VfDykkyVwiZBeDcddNgKebKIpVnmphIusevo+CDvFpvzl0Jd2zbj7
        c8nc0PFmL98jlfAiOSlApg3ugK7IZ+0=
X-Google-Smtp-Source: ACHHUZ4MBCV85dCRuk8kuCC6OKtP+c8S5PbvkPPSGNSbIMj9FbJf+UpfzIjIHJMl61Q9dF+caejt3Q==
X-Received: by 2002:a17:902:f693:b0:1b0:577c:2cb with SMTP id l19-20020a170902f69300b001b0577c02cbmr17114944plg.25.1687274420516;
        Tue, 20 Jun 2023 08:20:20 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i1-20020a170902c94100b001ae7fad1598sm1786314pla.29.2023.06.20.08.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:20:19 -0700 (PDT)
Message-ID: <4c9fea33-9c30-4ab9-c210-95e09d323837@acm.org>
Date:   Tue, 20 Jun 2023 08:20:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 0/7] blk-mq: improve tag fair sharing
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        Christoph Hellwig <hch@lst.de>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
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
> This is not a formal version and not fully tested, I send this RFC
> because I want to make sure if people think doing this is meaningful,
> before I spend too much time on this.
The approach looks good to me but I'd like to hear from Jens and 
Christoph what their opinion is about the approach of this patch series 
before doing an in-depth review.

Thanks,

Bart.
