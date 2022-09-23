Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB75E769C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiIWJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIWJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF6812EDB7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663924564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ep2LcsdKEgsIs6aTOfGI5dO+1JAPu67k1k4S8GmmVo=;
        b=J0m8r+8OkwhhrQdomsRV1KSfjuAp0dPGN6VbaZ2mFo3Rg8NDYRFfjpqwsFcC5QSgAz+6qY
        CO49q5VtXJrprxIC6N5LNX51ULtdqVceKVUxfAsdYNiYXSwBROR0XtWcZul8MzjRLbUJdq
        m3XyFOkXS7eeykK4yj+CzP7Mt4TMMds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-301-xDq5j3ooMpepRmMDBZhZ7g-1; Fri, 23 Sep 2022 05:16:03 -0400
X-MC-Unique: xDq5j3ooMpepRmMDBZhZ7g-1
Received: by mail-wm1-f69.google.com with SMTP id 5-20020a05600c028500b003b4d2247d3eso3463029wmk.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+Ep2LcsdKEgsIs6aTOfGI5dO+1JAPu67k1k4S8GmmVo=;
        b=7P+ZGXO7g5JXVm0eEnIsqxorm0tiLPngXcMRZQd9N60TBI9esSKqS3cn5m8Ldrhu1V
         aFJDFrju3ogOMsZMEVSkBDMDCFjcJlTTzNRi83YGGH0Hlb6ajTqQjYFucQrgXtPKjaVn
         CgZCzyBPJwvhmYhooIBeEHdQxuBK4dHBHjsdBjmCzlY9FYwyzYqAq2RBd5EkyNez5clg
         L1+4TxMb3kSa/L9MoRAYAQGgXPlmK5ynpSWRgjaE5qmsslKzgcxcnJcvqruh7rMuxs6E
         gQGbVisYL+i+ZgFMDVT8k36AbgGEJ3IQD0BFo/Nn77Xhs0D084GROjP+NbXR6nVjzyR8
         8kJg==
X-Gm-Message-State: ACrzQf3BKRcUFFMjgcbP7G/mU/RuYFnTfgN1LVs0Ake8ahHtcl1SRefZ
        KDeo2wT7wNtQ1DcOSVXZIyakZS9hEwoTe4LVIDBD6fNJVxMKVaZ3h8T+qKlISRUCrI0rUgJL2lI
        GVaochAnVML9UKd2QdauYsWB2
X-Received: by 2002:a05:6000:1446:b0:22b:968:446 with SMTP id v6-20020a056000144600b0022b09680446mr4404249wrx.493.1663924562123;
        Fri, 23 Sep 2022 02:16:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7F3z+Gwjzc07MWPiMCmk12QqRaTKvW+HCfQ8Z5AVFjSyhCeNr6oTPhOMgxzk/EfvjW1wZMOA==
X-Received: by 2002:a05:6000:1446:b0:22b:968:446 with SMTP id v6-20020a056000144600b0022b09680446mr4404236wrx.493.1663924561935;
        Fri, 23 Sep 2022 02:16:01 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q16-20020adff510000000b00228c375d81bsm7020309wro.2.2022.09.23.02.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:16:01 -0700 (PDT)
Message-ID: <7ccc4b30-0f85-6870-0c60-9897fdb374b9@redhat.com>
Date:   Fri, 23 Sep 2022 11:16:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/ssd130x: Use drm_atomic_get_new_plane_state()
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220923083447.1679780-1-javierm@redhat.com>
 <Yy1271xW1SOlL41e@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yy1271xW1SOlL41e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ville,

On 9/23/22 11:05, Ville Syrjälä wrote:
> On Fri, Sep 23, 2022 at 10:34:47AM +0200, Javier Martinez Canillas wrote:
>> The struct drm_plane .state shouldn't be accessed directly but instead the
>> drm_atomic_get_new_plane_state() helper function should be used.
>>
>> This is based on a similar patch from Thomas Zimmermann for the simpledrm
>> driver. No functional changes.
>>
>> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>

Thanks.
 
> I wonder how many naked obj->state dereferences are still
> left in places where they should be using the get_{new,old}()
> stuff. Might have to write a bit of cocci to find out...
> 
> 
> Btw on a somewhat related note, I've been thinking about bringing
> for_each_crtc_in_state() & co. back (got removed in commit
> 77ac3b00b131 ("drm/atomic: Remove deprecated accessor macros"))
> but this time without any object state iterator variable. Now that
> we're more often just plumbing the full atomic state through I
> think there are bunch of places that don't need the object state(s)
> within the loop at all, so having to have those variables around
> makes the whole thing a bit noisy. Also IIRC we had to add some
> (void) casts into the current macros to hide some compiler warnings
> about unused variables. Could get rid of at least some of those extra
> casts again.
> 
> I don't suppose there's anyone interested in doing that so I don't
> have to? ;)
> 

Maybe you can add an entry in Documentation/gpu/todo.rst, explaining
this and putting yourself as a contact? 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

