Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69626C6C21
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjCWPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCWPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFCF12CEA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679584692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JfTMOmWgVFviT3j1h1ZVlXRJuPtZf94XGhzCpT7TZI=;
        b=OgAv0KtuS+mfUkX0iuY/HoXber4yjQla+3NycUIP6HQKjPZ6nMYo3vTWMZD1hgH1ppxr2s
        g8XRQFQa9zm8NNRUMNZIG7bg0zFzmHLXFWrRIxWFH+0CHBvBDfo0r0/PrhtHbSckbjsbHj
        i9HvWxYX6HToAUpyKBM8ucmtM7hawSY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-ormLaSeSMIiXqcSza_9HpA-1; Thu, 23 Mar 2023 11:18:06 -0400
X-MC-Unique: ormLaSeSMIiXqcSza_9HpA-1
Received: by mail-qt1-f198.google.com with SMTP id h6-20020ac85846000000b003e3c23d562aso88885qth.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679584685;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JfTMOmWgVFviT3j1h1ZVlXRJuPtZf94XGhzCpT7TZI=;
        b=YN9uzcAYrMrwUoxjdIKPXddsynpuHAbVPbvVnr876yFc52hvBXBuAGCGF5rlPesdEF
         DTZ1X5RENx3aeKalODZPC6Qr5FZ1p5WIOxC7/JmdIx1kyVMKq+WRq+2tfJLWP3pjIxUf
         c++P4Kskr0R/Un79v8Fe8E0xC5C0739tcmbkd8Vsrr8Gtfsy5KCyX6MKYpqLtT1/TSgP
         fSkNa6Lhqx5ResiUHSEOfDm8Jmh/eX/chhNCqTUll6USqNQreiHbAU4OFToLbWFrMt97
         uqg+SOJRtu7aLeuxkVDCBecsBzvUfPN9S6sHPIyvO4kvKgND8e2Q6/ie4gBPPykYCM9m
         HLPA==
X-Gm-Message-State: AO0yUKW3K6Z2wA02YWBZLJD7egh9rUgm7WMZSzl0swurPUupC1JT1Gu7
        SYioK6f8ol9igZu8g4B6cjYc+pQv6UdvpryzJ35L4JUAa97WcmSxr0Lz4o6yTh4VWqISU58Ob6p
        +OZQSkIEDz+cqk4GEaNR73BLr
X-Received: by 2002:ac8:5bcc:0:b0:3e1:65f5:4a85 with SMTP id b12-20020ac85bcc000000b003e165f54a85mr13130747qtb.58.1679584685578;
        Thu, 23 Mar 2023 08:18:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set8LNOQxfUqAJQEgzeCPGIWCE6BE+k4IT7L6mRJOClAlDS0h+wmBxg2TVB0f+9BHgFC2x3KR1g==
X-Received: by 2002:ac8:5bcc:0:b0:3e1:65f5:4a85 with SMTP id b12-20020ac85bcc000000b003e165f54a85mr13130718qtb.58.1679584685365;
        Thu, 23 Mar 2023 08:18:05 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a424800b0073b587194d0sm13656463qko.104.2023.03.23.08.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 08:18:04 -0700 (PDT)
Subject: Re: [PATCH] mISDN: remove unused vpm_read_address function
To:     Simon Horman <simon.horman@corigine.com>
Cc:     isdn@linux-pingi.de, nathan@kernel.org, ndesaulniers@google.com,
        kuba@kernel.org, alexanderduyck@fb.com, yangyingliang@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230321120127.1782548-1-trix@redhat.com>
 <ZBsArtzFkgz+05LK@corigine.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bfc6db20-e094-7fd5-21b5-3d0b81fb494f@redhat.com>
Date:   Thu, 23 Mar 2023 08:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZBsArtzFkgz+05LK@corigine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/23 6:20 AM, Simon Horman wrote:
> On Tue, Mar 21, 2023 at 08:01:27AM -0400, Tom Rix wrote:
>> clang with W=1 reports
>> drivers/isdn/hardware/mISDN/hfcmulti.c:667:1: error: unused function
>>    'vpm_read_address' [-Werror,-Wunused-function]
>> vpm_read_address(struct hfc_multi *c)
>> ^
>> This function is not used, so remove it.
> Yes, agreed.
>
> But with this patch applied, make CC=clang W=1 tells me:
>
>    CALL    scripts/checksyscalls.sh
>    CC [M]  drivers/isdn/hardware/mISDN/hfcmulti.o
> drivers/isdn/hardware/mISDN/hfcmulti.c:643:1: error: unused function 'cpld_read_reg' [-Werror,-Wunused-function]
>
> So perhaps cpld_read_reg should be removed too?

Yes, i will add and respin.

Thanks,

Tom


>

