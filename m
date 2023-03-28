Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87C86CB2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC1A6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1A6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50BB1A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679965055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AW30FnYIjWdLuO0x0jWm9YgXrMh7ej06XUZ+z260h6Y=;
        b=KzVgMA0A4b3Kf0OZHSFJHqx+gDnZI/6U1A7HJ/iWVDpJ9361b0noCfIPU1S89Z0OP3W/QQ
        PSLN3ezMNgwchiI6L63uYRvMiTjZhzX7Ang4FZf3/VFu19gn1BE3wFqaQ7laXqfRf+iYZS
        Z1O7OTnZg2HAqV8MyJvWW33fh2cr2wE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-yNAKvmRdNnif90fNUNSpGA-1; Mon, 27 Mar 2023 20:57:34 -0400
X-MC-Unique: yNAKvmRdNnif90fNUNSpGA-1
Received: by mail-ed1-f69.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so15038661edj.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679965053;
        h=content-transfer-encoding:organization:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AW30FnYIjWdLuO0x0jWm9YgXrMh7ej06XUZ+z260h6Y=;
        b=7FbUraaEK5GP1UYiwfcqSiMhETImts01XmT5cgOGmh0bPjijxhIzKc/XR6shCOLRJE
         gJi25Ziy/tBnw5JUnvvp7al6yvm64siLwArSHKoLVGrtjaIdMcDfOySYllwgM9SRIdor
         C/9pMcYJtcd0+cxr1uoaG9IEBhRklmjtuv4ujdgGpuqO2q+2iXoATSNYtA1/KVrimAvb
         BWIB9gMo6rWpezWIdan3nZN0m7DgPJ+qGI6OmEG5zaUxbm8wQ7fQfmWb+iGGAVIo9C/i
         G2S1GZCHzTsZpMVBIg5+GJNzxwmOuLL6Vm9UFVdFu28VPQbkr4dI+LF5/plZa3IQugZG
         o9eQ==
X-Gm-Message-State: AAQBX9f1SMWSx0rpYYPZgeZI4wwF+P6MHpuuGuuMAsesnwJmITaeCHjd
        tzr2oCSyv/5uiywKqrLcXUt+wu8QsUSnmNwL0vHyDJyi5p4Q7HF9bguAfxQuNHeRKFOpZ+PztX+
        HoVsEC0v+V6jj45rwy5myF0rZ
X-Received: by 2002:a17:906:a117:b0:939:fb22:c4c7 with SMTP id t23-20020a170906a11700b00939fb22c4c7mr15196833ejy.43.1679965053569;
        Mon, 27 Mar 2023 17:57:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZkAeHauFSbfm4BVv5TpPPd9MX5xcz+qhct+xSpNGIVDfnEUB6PnTbKqJ0zbPJu2h3sYMR1Ww==
X-Received: by 2002:a17:906:a117:b0:939:fb22:c4c7 with SMTP id t23-20020a170906a11700b00939fb22c4c7mr15196823ejy.43.1679965053285;
        Mon, 27 Mar 2023 17:57:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b009321cd80e15sm14264240ejd.73.2023.03.27.17.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 17:57:32 -0700 (PDT)
Message-ID: <3e00d8a9-b6c4-8202-4f2d-5a659c61d094@redhat.com>
Date:   Tue, 28 Mar 2023 02:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     daniel@ffwll.ch, Dave Airlie <airlied@gmail.com>,
        luben.tuikov@amd.com, l.stach@pengutronix.de,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        andrey.grodzovsky@amd.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Danilo Krummrich <dakr@redhat.com>
Subject: [Regression] drm/scheduler: track GPU active time per entity
Organization: RedHat
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commit df622729ddbf ("drm/scheduler: track GPU active time per entity") 
tries to track the accumulated time that a job was active on the GPU 
writing it to the entity through which the job was deployed to the 
scheduler originally. This is done within drm_sched_get_cleanup_job() 
which fetches a job from the schedulers pending_list.

Doing this can result in a race condition where the entity is already 
freed, but the entity's newly added elapsed_ns field is still accessed 
once the job is fetched from the pending_list.

After drm_sched_entity_destroy() being called it should be safe to free 
the structure that embeds the entity. However, a job originally handed 
over to the scheduler by this entity might still reside in the 
schedulers pending_list for cleanup after drm_sched_entity_destroy() 
already being called and the entity being freed. Hence, we can run into 
a UAF.

In my case it happened that a job, as explained above, was just picked 
from the schedulers pending_list after the entity was freed due to the 
client application exiting. Meanwhile this freed up memory was already 
allocated for a subsequent client applications job structure again. 
Hence, the new jobs memory got corrupted. Luckily, I was able to 
reproduce the same corruption over and over again by just using 
deqp-runner to run a specific set of VK test cases in parallel.

Fixing this issue doesn't seem to be very straightforward though (unless 
I miss something), which is why I'm writing this mail instead of sending 
a fix directly.

Spontaneously, I see three options to fix it:

1. Rather than embedding the entity into driver specific structures 
(e.g. tied to file_priv) we could allocate the entity separately and 
reference count it, such that it's only freed up once all jobs that were 
deployed through this entity are fetched from the schedulers pending list.

2. Somehow make sure drm_sched_entity_destroy() does block until all 
jobs deployed through this entity were fetched from the schedulers 
pending list. Though, I'm pretty sure that this is not really desirable.

3. Just revert the change and let drivers implement tracking of GPU 
active times themselves.

In the case of just reverting the change I'd propose to also set a jobs 
entity pointer to NULL  once the job was taken from the entity, such 
that in case of a future issue we fail where the actual issue resides 
and to make it more obvious that the field shouldn't be used anymore 
after the job was taken from the entity.

I'm happy to implement the solution we agree on. However, it might also 
make sense to revert the change until we have a solution in place. I'm 
also happy to send a revert with a proper description of the problem. 
Please let me know what you think.

- Danilo

