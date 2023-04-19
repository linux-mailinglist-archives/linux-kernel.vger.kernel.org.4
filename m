Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705146E77AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjDSKqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjDSKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:45:52 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926AF1BDF;
        Wed, 19 Apr 2023 03:45:50 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-2f67111b2d0so747746f8f.0;
        Wed, 19 Apr 2023 03:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681901149; x=1684493149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3x0k4rJnKaOmkvnCDjyE+jovLY1Kmv7i3ZtuK09oys=;
        b=M7apLshLdCWDQ8ivH2Y5a3cBsud/x+4PkTYM0M5OHISFRw7CCy2k5st/zJCnkNXj0d
         ULn+oQ0DQ8H+j5FC/n+MkJfaOesvVOrNrVuJwEXoZuMZpKBF+pXWj4F4/XIpGBC1kX4a
         RwhW1NYXMMNsnH2ivm/UFwj3QTP1YE4IpF/bosrYv7u6RCu+yuYahr11o8qBGy+5sPUH
         N397apf/Fxikxs+IVS3UgyERh2xiu0TP0lsHDUUtd1lSC0OTNgb/OmJnY8Qy8+VlTLzj
         X/1ApaCl1x8QJ055r2gj5AEsoaHwn1AHG2SjLfiYGXbhbVsGvgBn45Jx7WD2DSVjP7FW
         vmsQ==
X-Gm-Message-State: AAQBX9eK7PacYWqGk3d0DA7bRBwVNQ/6OQ8lXl3dwA5Rmy/bjMeJ0wEr
        PHgQCMFJKc06boPx6NUe2oHhCFNEllg=
X-Google-Smtp-Source: AKy350a455Yk+wWzCcfcpBQdd1niGJgBmD50m/H70Uo03NiG9EIf9Lo+fxiile8UcebRMBEQPqYUbg==
X-Received: by 2002:a5d:6352:0:b0:2f5:7487:7b3d with SMTP id b18-20020a5d6352000000b002f574877b3dmr10467874wrw.1.1681901148946;
        Wed, 19 Apr 2023 03:45:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q1-20020adfcd81000000b002ff77b033b1sm419188wrj.33.2023.04.19.03.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 03:45:48 -0700 (PDT)
Message-ID: <1b060988-fc63-4a86-33b8-88ba61c9358f@grimberg.me>
Date:   Wed, 19 Apr 2023 13:45:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
 <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Before we unload the module we should cleanup the fc resources first,
>>> basically reorder the shutdown sequence to be in reverse order of the
>>> setup path.
>>
>> If this triggers a bug, then I think it is a good idea to have a
>> dedicated test that reproduces it if we are changing the default
>> behavior.
> 
> Right, though I would like to tackle one problem after the other, first get fc
> working with the 'correct' order.
> 
>>> While at it also update the rdma stop_soft_rdma before the module
>>> unloading for the same reasoning.
>>
>> Why? it creates the wrong reverse ordering.
>>
>> 1. setup soft-rdma
>> 2. setup nvme-rdma
>>
>> 2. teardown nvme-rdma
>> 1. teardown soft-rdma
>>
>> I don't think we need this change. I mean it is a good test
>> to have that the rdma device goes away underneath nvme-rdma
>> but it is good for a dedicated test.
> 
> I was woried about this setup sequence here:
> 
> 	modprobe -q nvme-"${nvme_trtype}"
> 	if [[ "${nvme_trtype}" == "rdma" ]]; then
> 		start_soft_rdma
> 
> The module is loaded before start_soft_rdma is started, thus I thought we should
> do the reverse, first call stop_soft_rdma and the unload the module.

They should be unrelated. the safe route is to first remove the uld and
then the device.
