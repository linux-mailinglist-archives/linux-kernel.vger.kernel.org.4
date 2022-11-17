Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB962E4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiKQS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKQS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:56:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A86688F8D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668711305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ib+z4LYCW5CoTqQqR59vxmOP/VcqCP1xatXfReClms=;
        b=fAjQHgxmicAyd2t7yER1I2eMOF/yJzozukGeafZVDrKNkFRkJKsg0JaWx/KVBNVvSgNSyX
        eBbtRxPeDSAjbK6m7GMUbveZYSPNnk2Ezy0Mq7+bmbq/nWajBQGPHu+csVzT/ZFB1U2qa+
        KddKUTZQ2ue7yTRsK4n+zB70ybeQVFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-mWe7J9vDPxuYzeN_XkzXIg-1; Thu, 17 Nov 2022 13:55:03 -0500
X-MC-Unique: mWe7J9vDPxuYzeN_XkzXIg-1
Received: by mail-wr1-f72.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so968215wrg.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ib+z4LYCW5CoTqQqR59vxmOP/VcqCP1xatXfReClms=;
        b=OLTdpSJ+21kwgms41ksQZW1kqVUcbfckUKYz5VkG65MDgfqLlibZiJDHTEvLcAfnlX
         HWam3E/giGdhV+4a5UeuYxWVFk4/F7coVAF6kI0/yhGZwOPkfH58p1ZISvyUU4DPOY/T
         FU8c2ADLPRb0bLTiOQMyvfnUfznIzRk/b8qUctkpYzAsOeZoDnPh+tP4ggsVBOnMBTgp
         sUhVi7rnVQXHHrmK5qDMnKdpztTya7sibgzUrtfzTRkHJKUimPgNxJKSY+WIqRZWp/rh
         6YoRDdOQjQKwVIb8J5OezYPhPpkJTYgsf7lM/CqpbOgInj0v7KD/oGZrU5olTkg9jVFL
         h5ZQ==
X-Gm-Message-State: ANoB5pkllxbijiLSpiv+WJ7+RMbBy0PixPwhirbPh/5F20ykC9ctDbeM
        xVwemeBU+K6E5k5sh5vUpZATyOv535fZBMWjzF0nHzX/t97Jpnam7swls91LziScBLMbtT+s5Rl
        UShnfN7fdEVfPjmU1b7cbpPfD
X-Received: by 2002:a05:6000:18f:b0:241:a046:91ff with SMTP id p15-20020a056000018f00b00241a04691ffmr2305502wrx.23.1668711302854;
        Thu, 17 Nov 2022 10:55:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf49F36rPsugeoEVN8qVjZWHBSltr+YLPcfR65ls1jmoPsJTWQ8KTfPjqx5rW1DW4udiPFO9dw==
X-Received: by 2002:a05:6000:18f:b0:241:a046:91ff with SMTP id p15-20020a056000018f00b00241a04691ffmr2305488wrx.23.1668711302578;
        Thu, 17 Nov 2022 10:55:02 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d6803000000b00228d67db06esm1676538wru.21.2022.11.17.10.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 10:55:01 -0800 (PST)
Message-ID: <eb33b5c1-cd36-ecf9-57df-c8755e438548@redhat.com>
Date:   Thu, 17 Nov 2022 19:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/4] driver core: Add fw_devlink.timeout param to stop
 waiting for devlinks
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, John Stultz <jstultz@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116120159.519908-1-javierm@redhat.com>
 <20221117151949.3cbc6cwphnv4scze@halaney-x13s>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221117151949.3cbc6cwphnv4scze@halaney-x13s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 11/17/22 16:19, Andrew Halaney wrote:
> On Wed, Nov 16, 2022 at 01:01:59PM +0100, Javier Martinez Canillas wrote:
>> Currently, the probe deferral timeout does two things:
>>
>> 1) Call to fw_devlink_drivers_done() to relax the device dependencies and
>>    allow drivers to be probed if these dependencies are optional.
>>
>> 2) Disable the probe deferral mechanism so that drivers will fail to probe
>>    if the required dependencies are not present, instead of adding them to
>>    the deferred probe pending list.
>>
>> But there is no need to couple these two, for example the probe deferral
>> can be used even when the device links are disable (i.e: fw_devlink=off).
>>
>> So let's add a separate fw_devlink.timeout command line parameter to allow
>> relaxing the device links and prevent drivers to wait for these to probe.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> (no changes since v1)
>>
>>  .../admin-guide/kernel-parameters.txt         |  7 ++++
>>  drivers/base/dd.c                             | 38 ++++++++++++++++++-
>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a465d5242774..38138a44d5ed 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1581,6 +1581,13 @@
>>  			dependencies. This only applies for fw_devlink=on|rpm.
>>  			Format: <bool>
>>  
>> +	fw_devlink.timeout=
> 
> Just thought about this, but I think this should be called
> fw_devlink_timeout. Generally the $MODULE.$PARAM syntax is reserved for
> things that can be specificed with module_param().
> 
> The advantage is if you accidentally type say fw_devlink_timeut=10 the
> kernel logs will indicate it has no clue what that means. Including the
> "." makes the kernel assume that maybe a future module name fw_devlink
> will be loaded, and at that time will see if that module has the
> parameter mentioned. A little thing but I think work changing in v3.
> 

I was actually on the fence on this one but the reason why I did the .timeout
was that the other fw_devlink param [0] is defined as fw_devlink.strict=<bool>
so I wanted to keep this one consistent with that.

https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

