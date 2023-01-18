Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF536727B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjARTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjARTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902285B5A3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674068405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6VHgRLoz21ZdB+avm4AD7iQRbs1S2YR2I/6RIM3KpT8=;
        b=QBUewSnRyabEFpWw3W1eIVgfkrkm6SsBLx0adEBJT68pgJbNAAKRwPf+1fD8HlXG3NANYu
        xj2BwKG1y52zuDLxl3tUrQfHnbekwwSIaMClyRaWPgi6TlbvDGtu18HUYcIhMmOk5DaPEu
        Op76t1e1d05vxw86roXD3Qe5wTzJoKE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-yiH84_ZaN3eJ-FzcOXMuqA-1; Wed, 18 Jan 2023 14:00:04 -0500
X-MC-Unique: yiH84_ZaN3eJ-FzcOXMuqA-1
Received: by mail-ej1-f69.google.com with SMTP id sb39-20020a1709076da700b0086b1cfb06f0so10364087ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VHgRLoz21ZdB+avm4AD7iQRbs1S2YR2I/6RIM3KpT8=;
        b=zEGn9HKsPaCoHJ8SwGaobhq41YiR9ap0tMtyyg5QRIXR0trHXtkzyl6d9LCzdvEh2x
         Q4Zef9TO1a8Cewb/cQYM4vyuHEW+vMeW4SQj8MzVQ+jRHa9D+apvKbbGBuaTveFeCqr7
         YXmT5/kAZEMWNevlk6vWE2UigzOxA/P7rUD0DyOAAkZuWWTZ1ry2N5veCwRlFHihuzAz
         w1a3aHgyqCKaTQ4sTBCGhvLkRz1lVtM5lMVAkY/S+MG1kw8krd0hjFuOpgPTo97ByBlI
         mQiilO92aA5N9fDopPr9j8gCZBdE6fbXofCGtprF5V5J/28FNDbxc990kRKEbtwpsKRh
         wcLw==
X-Gm-Message-State: AFqh2kr+lGG1yJn+xkgTjjrYWlUT3Aiv3arj+R0p3ZaBXeV+bvDcuArw
        CF+s1NxGsoAdI1gfDeJuLtcHQOxyFtPfp+sD/4A++T/zcpsb/Md2tVUUIFedYEIBM8RIBFC2vs/
        3JModKUTdgjFcGzb5BDOribXd
X-Received: by 2002:a17:907:8dca:b0:85f:5d72:1841 with SMTP id tg10-20020a1709078dca00b0085f5d721841mr8927960ejc.39.1674068402937;
        Wed, 18 Jan 2023 11:00:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtsdunAhuQoXTg/VSvgVA6q/ZXPxkW/qMVvnmose4gPIQY/RC2Jhhnm+VqSnkVslMwPuQBExQ==
X-Received: by 2002:a17:907:8dca:b0:85f:5d72:1841 with SMTP id tg10-20020a1709078dca00b0085f5d721841mr8927939ejc.39.1674068402689;
        Wed, 18 Jan 2023 11:00:02 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709061be100b0086f40238403sm5244115ejg.223.2023.01.18.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:00:02 -0800 (PST)
Message-ID: <9830b666-b78c-9794-0d4a-7de31b9fd9b5@redhat.com>
Date:   Wed, 18 Jan 2023 20:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH drm-next 02/14] drm/exec: fix memory leak in
 drm_exec_prepare_obj()
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        daniel@ffwll.ch, airlied@redhat.com, bskeggs@redhat.com,
        jason@jlekstrand.net, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118061256.2689-1-dakr@redhat.com>
 <20230118061256.2689-3-dakr@redhat.com>
 <3c3bd64a-164b-7ff2-ebf0-c8f9c2f94b72@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <3c3bd64a-164b-7ff2-ebf0-c8f9c2f94b72@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 09:51, Christian König wrote:
> That one should probably be squashed into the original patch.

Yes, just wanted to make it obvious for you to pick it up in case you 
did not fix it already yourself.

> 
> Christian.
> 
> Am 18.01.23 um 07:12 schrieb Danilo Krummrich:
>> Don't call drm_gem_object_get() unconditionally.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_exec.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
>> index ed2106c22786..5713a589a6a3 100644
>> --- a/drivers/gpu/drm/drm_exec.c
>> +++ b/drivers/gpu/drm/drm_exec.c
>> @@ -282,7 +282,6 @@ int drm_exec_prepare_obj(struct drm_exec *exec, 
>> struct drm_gem_object *obj,
>>               goto error_unlock;
>>       }
>> -    drm_gem_object_get(obj);
>>       return 0;
>>   error_unlock:
> 

