Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C711672E597
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbjFMOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjFMOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11798172B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686666072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZEUY4eFrIiW2hJOSDRcVK2BXCKkst+J0Ig7f66lGys=;
        b=ZajmTeyfD10j/c7K5H5ggbyDwsJsBvCJMNgXnXAriOJO470lsSTOcwVjYWHSGtM08XllzZ
        4Tlm7eYCAH0665dfQ1ujh9EW41Z3S1ibYyHNKEiI8GdEO4lb+rmMdeVLMQTNlXLAIA7tmA
        0DhDYdB6Lsba1Qc6880wkiqfnF/9yBQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-XNmXmiENOhix3nSWu-zn-w-1; Tue, 13 Jun 2023 10:21:11 -0400
X-MC-Unique: XNmXmiENOhix3nSWu-zn-w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-977e50b0120so607060366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666044; x=1689258044;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZEUY4eFrIiW2hJOSDRcVK2BXCKkst+J0Ig7f66lGys=;
        b=bj7tR2dai1JuJS6ToMC95oKkfeJoox7PhGvrw8CVgfi0+jnjgtTaypbhLY2Ne0eQD1
         RGFzoAhm9gmf2HrLOOi2Ijgu8SZj932vcBtPkkNMFEzUb9FjZj4gkTs8badlomHaWR7i
         u86mLpwQtkv9dcXhzSyhw1wCnIM4TXVL2d/+eg+h7zoC1efSLeJxH/WImYpA6Jifxm50
         LEpGoL4bqb3jZpLeumC7unY029ViJhHSNi1kfZr7vvhRXfTCJAStAg/vCovkMn3EqYsf
         GbyEsLZVRKjws3/vboGG1G8YqPvrYSZy8NpL2Hhtrrbn67rqXInjppzibbSjNziajv1R
         TPGQ==
X-Gm-Message-State: AC+VfDyhx30QaqbXh+D9IMvJ+VgWI5RboVI/iw38u1/ITR1Lz8GbYAPj
        0iNpyDjtVOVolnCfBfTTS+EP1IPNDdUeswnfKdLiE5uLho/wozi789d0OkL5wcqAqNijImwF1AL
        AoP+SMOd0dINlQWJIqQf9suB7
X-Received: by 2002:a17:907:809:b0:977:cbaf:bc56 with SMTP id wv9-20020a170907080900b00977cbafbc56mr13671262ejb.43.1686666044425;
        Tue, 13 Jun 2023 07:20:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ad5nom20kLaHoCm86c18wBjHdHRHf+yMBQw0AQn5oLgUB+K/pfcP4C4uj6QCUmqL4FWtcyQ==
X-Received: by 2002:a17:907:809:b0:977:cbaf:bc56 with SMTP id wv9-20020a170907080900b00977cbafbc56mr13671233ejb.43.1686666044074;
        Tue, 13 Jun 2023 07:20:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e24-20020a170906081800b009786c8249d6sm6855650ejd.175.2023.06.13.07.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 07:20:43 -0700 (PDT)
Message-ID: <67ffef18-fae4-cb84-ff75-c4eed92a8755@redhat.com>
Date:   Tue, 13 Jun 2023 16:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH drm-next v4 00/14] [RFC] DRM GPUVA Manager & Nouveau
 VM_BIND UAPI
Content-Language: en-US
To:     Donald Robson <Donald.Robson@imgtec.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
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
        "airlied@gmail.com" <airlied@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230606223130.6132-1-dakr@redhat.com>
 <f5723444623b41d58f93c3f0ab662e9b37105765.camel@imgtec.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <f5723444623b41d58f93c3f0ab662e9b37105765.camel@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donald,

On 6/9/23 13:56, Donald Robson wrote:
> On Wed, 2023-06-07 at 00:31 +0200, Danilo Krummrich wrote:
>>
>> Christian König (1):
>>    drm: execution context for GEM buffers v4
>>
>> Danilo Krummrich (13):
>>    maple_tree: split up MA_STATE() macro
>>    drm: manager to keep track of GPUs VA mappings
> 
> I have tested the drm GPUVA manager as part of using it with our new
> driver.  The link below shows use of the drm_gpuva_sm_[un]map()
> functions.  I think this is based on the v3 patches, but I have also
> tried it locally using v4 patches.  We will be submitting this
> driver for review soon.

That's awesome - thank your for taking the effort!

> 
> https://gitlab.freedesktop.org/sarah-walker-imgtec/powervr/-/blob/dev/v3/drivers/gpu/drm/imagination/pvr_vm.c
> 
> In a previous incarnation, I used the drm_gpuva_insert() and
> drm_gpuva_remove() functions directly.  In some now abandoned work I
> used the drm_gpuva_sm_[un]map_ops_create() route.
> 
> The only problem I encountered along the way was the maple tree init
> issue already reported by Boris and fixed in v4.  One caveat - as
> our driver is a work in progress our testing is limited to certain
> Sascha Willem tests.
> 
> I did find it quite difficult to get the prealloc route with
> drm_gpuva_sm_[un]map() working.  I'm not sure to what degree this
> reflects me being a novice on matters DRM, but I did find myself
> wishing for more direction, even with Boris's help.

I'm definitely up improving the existing documentation. Anything in 
particular you think should be described in more detail?

- Danilo

> 
> Tested-by: Donald Robson <donald.robson@imgtec.com>
> 
>>    drm: debugfs: provide infrastructure to dump a DRM GPU VA space
>>    drm/nouveau: new VM_BIND uapi interfaces
>>    drm/nouveau: get vmm via nouveau_cli_vmm()
>>    drm/nouveau: bo: initialize GEM GPU VA interface
>>    drm/nouveau: move usercopy helpers to nouveau_drv.h
>>    drm/nouveau: fence: separate fence alloc and emit
>>    drm/nouveau: fence: fail to emit when fence context is killed
>>    drm/nouveau: chan: provide nouveau_channel_kill()
>>    drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm
>>    drm/nouveau: implement new VM_BIND uAPI
>>    drm/nouveau: debugfs: implement DRM GPU VA debugfs
>>

