Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB6B616025
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKBJni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38AF22B2F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667382155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iA0sGfa+ahBDJMGfDHR9LxRbe1IWFp0fRmP5we1ndrY=;
        b=XfyYE8VqaHLYhYINxp6XKNcJqPmPft61la9Fl2S5mLzUCjgLq78b8MNcIgMXjZWYAu/S4P
        Sf6TJXMSjldOnQ3XaEkVqSMKUGRdXp7MP9qikiKHor9boU6hQmwBFtkFtZrROhcqVnkRtL
        vvsXWPJHCCzuz8+UKmKyrQAQkx6F5fg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-VWV9skfXOmWzolFsxzZN5g-1; Wed, 02 Nov 2022 05:42:34 -0400
X-MC-Unique: VWV9skfXOmWzolFsxzZN5g-1
Received: by mail-qt1-f199.google.com with SMTP id v12-20020ac8578c000000b003a50eb13e29so8667983qta.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iA0sGfa+ahBDJMGfDHR9LxRbe1IWFp0fRmP5we1ndrY=;
        b=EqiHDeutVgNAt/mCbWKbKkS4IAQmOavFQU4//+UcHx/prYo59wc3PwyRIX0ds8Oicj
         DSwfIBEnt+FUBVQuWgvZr3YHCWk5zrxpizb5Vrhk66bj2FGHlar9v4PooYfPx9TMBzu8
         okahSkEt53NrbrhSiTh31vlBuJiQHxRbuX3JxqpwaxzgNSFJb4Lqfp/dThmMfXHSpNNg
         iuV2Z4LgKPxlOjVV5GQ8d2ENvcxh4OTFMp0WF9utCNot+RVGBF5MLU1/LfhUVYar8wVU
         BD7KD+2Sbw0rIrgiX5wxHXxXSkPCq48pgxqSTqwvaTlfKTFeoic3+Zc1icx94G/iLg3T
         BQ2Q==
X-Gm-Message-State: ACrzQf1+yX4xgh3+KRacQBSCuDusD04WVk23aTRdoxfOM8wvb4QR4qAS
        ewBVMSoPsie6D2cTgLk/6AAkxJQudAX/7GWJTA4Zcsn/ie7m4rDb1i1SjQqFENQ9AXq5Wz26noC
        2ZOJhyAqeW4dy9entYRokI1MC
X-Received: by 2002:a0c:e3d3:0:b0:4bb:c033:76fc with SMTP id e19-20020a0ce3d3000000b004bbc03376fcmr19147800qvl.117.1667382154197;
        Wed, 02 Nov 2022 02:42:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4g7XSgjzk5GrqDqTREUMG4zF+wpaO4A5LDwUXjacchdFaECWsUVyjkZbcH8ClLWm8iO8DpNA==
X-Received: by 2002:a0c:e3d3:0:b0:4bb:c033:76fc with SMTP id e19-20020a0ce3d3000000b004bbc03376fcmr19147785qvl.117.1667382153979;
        Wed, 02 Nov 2022 02:42:33 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id bj38-20020a05620a192600b006bb366779a4sm1821377qkb.6.2022.11.02.02.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:42:33 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:42:24 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, arseny.krasnov@kaspersky.com,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, stephen@networkplumber.org,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        frederic.dalleau@docker.com
Subject: Re: [PATCH v2 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Message-ID: <20221102094224.2n2p6cakjtd4n2yf@sgarzare-redhat>
References: <20221101021706.26152-1-decui@microsoft.com>
 <20221101021706.26152-3-decui@microsoft.com>
 <20221102093137.2il5u7opfyddheis@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102093137.2il5u7opfyddheis@sgarzare-redhat>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:31:37AM +0100, Stefano Garzarella wrote:
>On Mon, Oct 31, 2022 at 07:17:06PM -0700, Dexuan Cui wrote:
>>Currently vsock_connectible_has_data() may miss a wakeup operation
>>between vsock_connectible_has_data() == 0 and the prepare_to_wait().
>>
>>Fix the race by adding the process to the wait queue before checking
>>vsock_connectible_has_data().
>>
>>Fixes: b3f7fd54881b ("af_vsock: separate wait data loop")
>>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>---
>>
>>Changes in v2 (Thanks Stefano!):
>> Fixed a typo in the commit message.
>> Removed the unnecessary finish_wait() at the end of the loop.
>
>LGTM:
>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>

And I would add

Reported-by: Frédéric Dalleau <frederic.dalleau@docker.com>

Since Frédéric posted a similar patch some months ago (I lost it because 
netdev and I were not in cc):
https://lore.kernel.org/virtualization/20220824074251.2336997-2-frederic.dalleau@docker.com/

Thanks,
Stefano

