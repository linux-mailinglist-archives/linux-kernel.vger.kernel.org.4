Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E1274A19B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjGFPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjGFPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A32C1BE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688658756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRxt/NiYUgXmWV4fU8al0zRW2xGKMvH1kCizqQUlA4w=;
        b=dcRLPyN0hCF47Lu8xVqBcOLpEdMD79WTcXaaV299k39qII0lUzBHXiOG7ZJUoU9N0Dv8IG
        JmopjTlTT7B1bq+o0uafJ5orNBvzNG5biDsCmEjGxl7it38KDHd7mDvO6jk21pQABmfaNa
        zkEcMPIUQCkHk6UXMTGQ5PQ6V1Tc7ZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-qIZFIJqXMZOrmSexx1Bp_A-1; Thu, 06 Jul 2023 11:52:35 -0400
X-MC-Unique: qIZFIJqXMZOrmSexx1Bp_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbb18e9bd9so5142175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688658754; x=1691250754;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRxt/NiYUgXmWV4fU8al0zRW2xGKMvH1kCizqQUlA4w=;
        b=j5sOQjTfOkFMbWyJKeWgzqOGoGXpE17O8YR15Qk1A9Gw5DyBWfE1+WFpkTjIPqVNoF
         QgmZGuE2A4rRX8Ms8sUABVsXvtzhkUAhMK762aED5W/mZ/6uSs8AEsPQsdDsAHsUt+JO
         GApAK3PQpv96PQ04xW4p7xePuFTXRFA2dpb+VXEePTu+NPk1WTmxfDQ04YomUC7CYZ/H
         NQyMblmj/dZDPimuj06cNhfNYa2nOWUW1s9jy7f1/3MktqRgdS/sviUfSQ4L5J/2gBkY
         pBm1VZ639j1TSBRHGx1oh/fXLWrsGmS20hmYUWbCP16L8VqthY1N2xAyfv8kxnoDqeRB
         368g==
X-Gm-Message-State: ABy/qLaSx62Omv21HSma6+oSi0aBxygg1PxAd0+aHoi09252qmpM0zYw
        bi081xroyLwp/YF+TVMbL6gE4xqcxwDYEeGivfBjLb3iVj2q6fw7895PpCmR5R787e+jkWjpdiF
        yhTefUDc+5VNfXUG3POoc24RL
X-Received: by 2002:a05:600c:470e:b0:3fa:94ea:583c with SMTP id v14-20020a05600c470e00b003fa94ea583cmr5689127wmo.8.1688658754384;
        Thu, 06 Jul 2023 08:52:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHXRw0efno7C2fsVwB/UBBH508hAt9zGq2PeqHV7LtAjoXuI1o+g7kP3ECiR8lQmbiALoTLPA==
X-Received: by 2002:a05:600c:470e:b0:3fa:94ea:583c with SMTP id v14-20020a05600c470e00b003fa94ea583cmr5689103wmo.8.1688658754011;
        Thu, 06 Jul 2023 08:52:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bcb97000000b003fbaade072dsm2484157wmi.23.2023.07.06.08.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:52:33 -0700 (PDT)
Message-ID: <41329726-6861-f777-e7b1-e4b510ab4af5@redhat.com>
Date:   Thu, 6 Jul 2023 17:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH drm-next v6 02/13] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
To:     Donald Robson <Donald.Robson@imgtec.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jason@jlekstrand.net" <jason@jlekstrand.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "bskeggs@redhat.com" <bskeggs@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "alexdeucher@gmail.com" <alexdeucher@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "airlied@redhat.com" <airlied@redhat.com>
References: <20230629222651.3196-1-dakr@redhat.com>
 <20230629222651.3196-3-dakr@redhat.com>
 <8d01cb3add315277c86cf4b28d6901fed1977448.camel@imgtec.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <8d01cb3add315277c86cf4b28d6901fed1977448.camel@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donald,

On 7/6/23 17:45, Donald Robson wrote:
> On Fri, 2023-06-30 at 00:25 +0200, Danilo Krummrich wrote:
>>
>> +#ifdef CONFIG_LOCKDEP
>> +typedef struct lockdep_map *lockdep_map_p;
>> +#define drm_gpuva_manager_ext_assert_held(mgr)		\
>> +	lockdep_assert(lock_is_held((mgr)->ext_lock) != LOCK_STATE_NOT_HELD)
>> +/**
>> + * drm_gpuva_manager_set_ext_lock - set the external lock according to
>> + * @DRM_GPUVA_MANAGER_LOCK_EXTERN
>> + * @mgr: the &drm_gpuva_manager to set the lock for
>> + * @lock: the lock to set
>> + *
>> + * If @DRM_GPUVA_MANAGER_LOCK_EXTERN is set, drivers need to call this function
>> + * to provide the lock used to lock linking and unlinking of &drm_gpuvas to the
>> + * &drm_gem_objects GPUVA list.
>> + */
>> +#define drm_gpuva_manager_set_ext_lock(mgr, lock)	\
>> +	(mgr)->ext_lock = &(lock)->dep_map
>> +#else
>> +typedef struct { /* nothing */ } lockdep_map_p;
> 
> lockdep_map_p conflicts with an identical typedef in maple_tree.h when CONFIG_LOCKDEP is
> not set (it's being pulled in by mm.h in drm_vma_manager.h). I'll just comment the line
> out for now.

Good catch! I got this trick from maple_tree.h and intended to move it 
to the lockdep header in a separate patch to avoid such collisions. 
Unfortunately, I forgot about it. Gonna fix it up.

- Danilo

> 
>> +#define drm_gpuva_manager_ext_assert_held(mgr)		do { (void)(mgr); } while (0)
>> +#define drm_gpuva_manager_set_ext_lock(mgr, lock)	do { } while (0)
>> +#endif
>> +

