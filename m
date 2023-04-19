Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AF6E7B86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjDSOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:07:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF977ED1;
        Wed, 19 Apr 2023 07:07:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b73203e0aso16340248b3a.1;
        Wed, 19 Apr 2023 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681913252; x=1684505252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=swcvyAHBrH0fn2nRLj+Lmm/KAJwlDwM+z4WZ0Q3OGeo=;
        b=m81IWi+PHpP0GfbRLi5Tnn9lzP0V2Hc1sqZsninXMBe4YgAL4VoWB9EGswaN04V9l5
         Wv5ZcKoDVwbQEHomQBy74YJ6JV3XbPdrK17A3BhwGta9nBYlj9ITJ3EkPivbj0xxFnq1
         o9Tfq7Mr+l3F2npScqz2PkIEKn0ZqcLEkEde73Oc4+zShJW7ip6/dz+Z8sTz727ftudg
         y9o9t/WxvcnQm8Hae6JtA6SNBlfaX19/cI15G7IRzh5WHRBlFLDaGc7yCaETqME0SOEw
         RZiMah4F58AOWkqTssoKByaUV9DaRITO0flfgDr42adrCb3sRuRznhS1L3QHkgd1HkEw
         OQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913252; x=1684505252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swcvyAHBrH0fn2nRLj+Lmm/KAJwlDwM+z4WZ0Q3OGeo=;
        b=Yv5kMn5tS3KHL+DJ8fRbZULOvy81Bem4ebxJCb0+3bjPSwtUFf2ioAmxUd7KLiwiQ2
         BAWUCfQ+oaL+NdVjESIsYFAIbaW2dWu2BsgptYvEXHT3V/2rHJICD9MuxRVdpQz78HSQ
         pzLNRi4td/zPqmLca18OIc0CDukCgU1H/qOD6J8s28WD60kSc0e7GtLLeqLiqMmtspe3
         0A2fE1Cnr7fTU5uIp4RFLCo5ppWnLHCZZYdL1AtezDZhJhRuOCoLvy+8PFtqjy16sji+
         WIhWNtwn4XvLZeghjfEmdkclzS9Z8ynU9B4nDckW/z3RwEZF/4SHVMqzojdcu0NIzOoB
         pTxA==
X-Gm-Message-State: AAQBX9dv978ZKZfmBi6lfzlvGTgoS4IOKEA/JS+9WWqmMzFCYFsGgWKO
        cMAfKNmcp6jCCpRWeU+oE5Y=
X-Google-Smtp-Source: AKy350bxXvEqQTaoWoB3cBk9WzzRbWll8iK+O7DsoRDEPE+cjo0em/mmGc6QT0aMq7k9Bj6kjGmyug==
X-Received: by 2002:a05:6a00:2d13:b0:63d:368c:97c2 with SMTP id fa19-20020a056a002d1300b0063d368c97c2mr3175812pfb.8.1681913252054;
        Wed, 19 Apr 2023 07:07:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a22-20020a62bd16000000b0063b59ad4e0dsm10180673pff.118.2023.04.19.07.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 07:07:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ced839c1-ad03-b37d-e5d3-66a4987c6402@roeck-us.net>
Date:   Wed, 19 Apr 2023 07:07:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: k10temp show over 100 degrees temperature on EPYC Milan servers
 from DELL and SMC
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "clemens@ladisch.de" <clemens@ladisch.de>
Cc:     open list <linux-kernel@vger.kernel.org>
References: <CAMGffE=65we13bDe=iOkkefF4PrNBNg96qi=ebU7nCs=GA6cCw@mail.gmail.com>
 <MN0PR12MB6101B5E3BCCB7B3BA28B9269E2629@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <MN0PR12MB6101B5E3BCCB7B3BA28B9269E2629@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 06:33, Limonciello, Mario wrote:
> [Public]
> 
> Hi,
> 
[ ... ]

> 
> It's fixed by this patch that will be going into 6.4.
> https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?h=hwmon-next&id=1dc8e097967b69a56531c9ccb70b854771310e85
> 
> Guenter,
> 
> If you didn't already send your 6.4 PR, can you please add
> Cc: stable@vger.kernel.org to the patch in your tree?
> 

I already added a Fixes: tag but, sure, adding Cc: stable@
make sense. Will do.

Thanks,
Guenter

