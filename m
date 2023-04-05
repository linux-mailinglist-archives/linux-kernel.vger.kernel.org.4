Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345D76D7C84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbjDEM02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbjDEM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9691F5B9D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680697533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BtaxBOj8mnM7DN2UjknzYp2RwNpAvLMIaj8lPVQZwQI=;
        b=EpvidRlbdUV9x5ix7U5ux7iUMAiJSPliCKARVyO+AF8HlJYHGbzXM4KFfauiUZrtla5P2T
        zNEpYvzOTYHxYMS/mZFjRkczeRzjW3q3TCjcz/oUNmwhJY1af1tgGq6goiG9Sf7ZRNwPzo
        +Q4Q1SBX+RVcZKPQecrJMoRaeNC+gfs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-K5GWBFPYMQO0LIZOvianbA-1; Wed, 05 Apr 2023 08:25:32 -0400
X-MC-Unique: K5GWBFPYMQO0LIZOvianbA-1
Received: by mail-qt1-f200.google.com with SMTP id f2-20020ac87f02000000b003e6372b917dso12299561qtk.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 05:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtaxBOj8mnM7DN2UjknzYp2RwNpAvLMIaj8lPVQZwQI=;
        b=BE/KvD/zsQn3NJe7CQ6cgWSBkFDDM+64dF2/6OWDZOYb98oykaoYS9RfNLqtjhjwXq
         wYEHS1od9zJYjodNf8jlFdiZF9zI3bpBMOUTYkLsbQtd6mQAzNCJY6DO/8/LhTpmkaFY
         /ZagfM1MXIoJ+kGEc9XGvPpp/31kBdsrj3g/yHzwU94i65Cqz41Etau+Eee2ecv9M447
         lQ6gaUpixGFqxLwRNfX+SXd2oZZ57eQwX+jgPq3TFihGOJRD5MlJ/mBz6gKxCq1uZtG0
         s00BgaWx3WJMFmR9MxeUTXYGw+uw2SOVaouVMTbWGD9Uz7d3PQDgvsURN1SpA1kKHWIm
         KPzw==
X-Gm-Message-State: AAQBX9fs/1EDHh03f8+ptY2Kxi9aI+4WRMyzcNwrRLASwYnLoM61ReBw
        2rvXtmW9Y/Kxj/relfQQRHIJLkw/oq5+X9WU7D8WnM5AtQMaZyKNIgohG0WN3Bn0YQK3V/kt+Ye
        2PKaG+0r70WskP50YjhpFbPEWcoVD/F4J
X-Received: by 2002:a05:622a:5c8:b0:3df:50ef:faff with SMTP id d8-20020a05622a05c800b003df50effaffmr3851679qtb.58.1680697531665;
        Wed, 05 Apr 2023 05:25:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350bl30K1aMDtLrpZycNDR3RRPTtKiSsq+aP+ezde4JPUuEqrHjgYildV8mBp+Ypt/84i5OCPDQ==
X-Received: by 2002:a05:622a:5c8:b0:3df:50ef:faff with SMTP id d8-20020a05622a05c800b003df50effaffmr3851658qtb.58.1680697531439;
        Wed, 05 Apr 2023 05:25:31 -0700 (PDT)
Received: from [192.168.1.31] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b25-20020ac87559000000b003e45a39ed74sm3959361qtr.81.2023.04.05.05.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 05:25:31 -0700 (PDT)
Message-ID: <120b6729-c329-ea4d-2f69-f8bc5c2925bf@redhat.com>
Date:   Wed, 5 Apr 2023 05:25:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] nvmem: layouts: sl28vpd: set varaiable sl28vpd_layout
 storage-class-specifier to static
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
References: <20230404163629.1923871-1-trix@redhat.com>
 <cce4b409e20b073431b44a44f7f0a614@walle.cc>
From:   Tom Rix <trix@redhat.com>
In-Reply-To: <cce4b409e20b073431b44a44f7f0a614@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/23 12:09 PM, Michael Walle wrote:
> Am 2023-04-04 18:36, schrieb Tom Rix:
>> smatch reports
>> drivers/nvmem/layouts/sl28vpd.c:144:21: warning: symbol
>>   'sl28vpd_layout' was not declared. Should it be static?
>>
>> This variable is only used in one file so it should be static.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>
> Fixes tag?
>
I am cleaning all of the similar reports by smatch, there is a couple 
hundred.

Because the code works as-is, I do not consider them broken and needing 
fixes tags.

However I do not mind adding then if they are required.

Tom

> Reviewed-by: Michael Walle <michael@walle.cc>
>
> -michael
>

