Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B325C6B1C71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCIHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCIHes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77E29143
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678347233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2eI75EI2bEfBrzO7ljqtkrRx9cCPWQmstR3/D9o91c=;
        b=jUOSXKip03sfqBBTnkHtXu608Eoq5MCDn+nmJDbah6gBhnFYdMVmGlgyEsGSSiufBcfz+j
        TNFKfagpawW1IRFzgG1xcgSGb2NOl1E13OC5WoNNpmqV03Es8ZWNvljaOCQQ0kJwQNKatL
        g0QKHs7g3V5cJGB9e69/7wk9mfoIVKs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-ou9OGhXJMQO45h7teyRUKA-1; Thu, 09 Mar 2023 02:33:52 -0500
X-MC-Unique: ou9OGhXJMQO45h7teyRUKA-1
Received: by mail-pg1-f198.google.com with SMTP id s3-20020a632c03000000b0050300a8089aso365641pgs.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2eI75EI2bEfBrzO7ljqtkrRx9cCPWQmstR3/D9o91c=;
        b=ABGVYRG5SMnXcuDysgJ4iIHxrrAN4rs5/10Tkn5Z+Qdh7v8k+oh/JTz/f3BjWcIfTk
         FSa56p1PqxP8i047vxQQIac1sLQgmTUE6x4KNBaMyskYWnJmxQecPtseWE/uQxXNGVxr
         mJzztz9sWX+X+2KQu/CnIMd0qehjB/uP0vY6u6MQ6AhekgEFxv6rZDyr4k15AYr8JBX5
         PW5jUKTuKxC77OF9YU7XMiCmBPIGQQMT1O5L7sTDm1wD90OT0H+eHR3MaJztxC5B10GY
         xiu3PkLXbE2dNHZiXXE+Wr0Nx+nsh5l3SUfwXbMVRYdffUZ41Rh0xm8z9eTPsMTmxoJC
         tqMw==
X-Gm-Message-State: AO0yUKXUjFibq2OEI7uQC8qkCU2aakCf8PKtkKlt9ekR+d6idEQkG83o
        BnAbx4Xdmy4KCSEmOhoeEUktBbky57xWRN9jX+xMLUyPptQ1jnSD7NiB5h5RfIgznx6TBsMxWP4
        Bz6XDGwaCmFkPX4dQiwFNWPxz
X-Received: by 2002:a17:90b:4ac5:b0:233:ca14:6ae8 with SMTP id mh5-20020a17090b4ac500b00233ca146ae8mr22001489pjb.45.1678347231373;
        Wed, 08 Mar 2023 23:33:51 -0800 (PST)
X-Google-Smtp-Source: AK7set/dW6MqQ3ILRER0QVrnho4NKjeKEmnrKxg3LwqOnLbM60mqEDfosx62kAURLpWjFBEbHUW3jw==
X-Received: by 2002:a17:90b:4ac5:b0:233:ca14:6ae8 with SMTP id mh5-20020a17090b4ac500b00233ca146ae8mr22001477pjb.45.1678347231113;
        Wed, 08 Mar 2023 23:33:51 -0800 (PST)
Received: from [10.72.13.99] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q10-20020a63504a000000b004fcda0e59c3sm10102052pgl.69.2023.03.08.23.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 23:33:50 -0800 (PST)
Message-ID: <c8d44e19-6e4c-9c62-2f5e-300013e0adf8@redhat.com>
Date:   Thu, 9 Mar 2023 15:33:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ceph/mds_client: ignore responses for waiting requests
Content-Language: en-US
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     idryomov@gmail.com, jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230302130650.2209938-1-max.kellermann@ionos.com>
 <c2f9e0d3-0242-1304-26ea-04f25c3cdee4@redhat.com>
 <CAKPOu+_1ee8QDkuB4TxQBaUwnHi4bRKuszWzCb-BCY44cp1aJQ@mail.gmail.com>
 <cf545923-e782-76a7-dd94-f8586530502b@redhat.com>
 <CAKPOu+-jCt6NoVaR=z6c-D-PY1skdt6u-2sKkzd8GFDHbsQdxQ@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAKPOu+-jCt6NoVaR=z6c-D-PY1skdt6u-2sKkzd8GFDHbsQdxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/03/2023 15:30, Max Kellermann wrote:
> On Thu, Mar 9, 2023 at 6:31 AM Xiubo Li <xiubli@redhat.com> wrote:
>
>> I attached one testing patch based yours, just added more debug logs,
>> which won't be introduce perf issue since all the logs should be printed
>> in corner cases.
>>
>> Could you help test it ?
> The patch now runs on one of our clusters, and I'll get back to you as
> soon as the problem occurs again. Thanks so far!

Cool, thanks very much.

- Xiubo

