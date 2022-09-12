Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879535B5C89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiILOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiILOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603193868A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662993760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4CvOh9tTP6mx8NvmQ+rRskXFnhfhDqQRZXhv5skm7I=;
        b=A1/Ixe0iJnutGDX2ZarKTNixbi+cBQ9lt9AgVTdEsPzLnUCM4LV29a40eff6EQ9EqmhBqj
        dQfha+iv/DdSEnXRLwqoYj5yzFC3tq05hDHDKIw1Sp+5Q8T6/Jgr+Hxb+22CtNZPhqzpXU
        m2/fo08Ux+m2IdUzEPGXgVNWz0CN3g0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-LHhFEZmONvGESObkeNd6Dg-1; Mon, 12 Sep 2022 10:42:36 -0400
X-MC-Unique: LHhFEZmONvGESObkeNd6Dg-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adf8b4f000000b002285ec61b3aso1754366wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G4CvOh9tTP6mx8NvmQ+rRskXFnhfhDqQRZXhv5skm7I=;
        b=KJKHtuHpFLI6TOUnlbSKRUAHpurr1J3GbHdfpZmZvkdZpAxL6vlS+pkuyCYitEvtj2
         B3ZN5Nqcsc9/inkk5Nu0q03w6Pcl9paUUtXD+ZG8Schmh+dy8Nf63g9l0Ef0NbqOpj2v
         t/ODy0FzWTrTaYOUN5om+BajvOXcyaALeHGL+vd3RRnLsR9EKp1EIyCUuORHHxuMreBR
         cT40uORrjUp+LqO8/Gx9RlzTiOUKlHCICOyM2EVrn5np8fZubfaATfQh3w4NWMLGnl4R
         vXdmpTitcQQbVDg1KFWdFRll5p/QzCebzSJ+DCJZrO+ry9GYaoau++TFXBojZiJTqy58
         FLJA==
X-Gm-Message-State: ACgBeo1TN/zOy8R+d+v9YvODcMUh0N8A9Bq+gLiXOFhVXDt6m19tJUbH
        ViyK3cWxv9FKp1uBS4yAziGa2N+GYw+GyDLEFMXW3APYaiEdfhBNsnHfzTEAA2WQ5LU92ozXg1u
        ITEJWg4g5gw0KUveN8VjpM2D7
X-Received: by 2002:a5d:6d8a:0:b0:22a:9f79:9452 with SMTP id l10-20020a5d6d8a000000b0022a9f799452mr2031942wrs.620.1662993755273;
        Mon, 12 Sep 2022 07:42:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49PQRjF0EWfk0MYVyKPl9HsvKjNtRcBeAEkJfK+2sOEMrm27CNYFuEhH1+SKqutJIIIbl1IA==
X-Received: by 2002:a5d:6d8a:0:b0:22a:9f79:9452 with SMTP id l10-20020a5d6d8a000000b0022a9f799452mr2031934wrs.620.1662993755071;
        Mon, 12 Sep 2022 07:42:35 -0700 (PDT)
Received: from [172.16.38.252] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id i12-20020a1c540c000000b003b47ff3807fsm5339820wmb.5.2022.09.12.07.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 07:42:34 -0700 (PDT)
Message-ID: <734a2141-448a-8ecd-2924-d6f8bc4d9b2d@redhat.com>
Date:   Mon, 12 Sep 2022 16:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/plane-helper: Add a drm_plane_helper_atomic_check()
 helper
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220912101522.69482-1-javierm@redhat.com>
 <Yx8Ms2jhgwpiDqA6@intel.com> <c6ce4e99-571b-e046-6f03-ab87bd173869@suse.de>
 <Yx8Vo4x7frhbElPq@intel.com> <4002a4d6-04cb-b342-952f-b42ef3188df4@suse.de>
 <Yx8nXZnTDEwuPEvP@intel.com> <d4c00bb6-03be-0348-6a75-c678608114f1@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d4c00bb6-03be-0348-6a75-c678608114f1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ville and Thomas,

On 9/12/22 16:22, Thomas Zimmermann wrote:

[...]

>>>>>>> +
>>>>>>> +/**
>>>>>>> + * drm_plane_helper_atomic_check() - Helper to check primary planes states
>>>>>>> + * @plane: plane to check
>>>>>>> + * @new_state: plane state to check
>>>>>>
>>>>>> That is not a plane state. Also should s/new_// since it's just

Right. What's the proper name? hardware state, modeset state, atomic state ?

>>>>>> the overall atomic state thing rather than some new or old state.
>>>>>
>>>>> Using only 'state' is non-intuitive and has lead to bugs where sub-state
>>>>> was retrieved from the wrong state information. So we've been using
>>>>> 'new_state' and 'old_state' explicitly in several places now.
>>>>
>>>> There is no old or new drm_atomic_state. It contains both.
>>>
>>> I (vaguely) remember a bug where a driver tried
>>> drm_atomic_get_new_plane_state() with the (old) state that's passed to
>>> atomic_update. It didn't return the expected results and modesetting
>>> gave slightly wrong results.
>>
>> As there is no wrong drm_atomic_state to pass I don't think it could
>> have been the case.
>>
>>> So we began to be more precise about new
>>> and old. And whatever is stored in 'plane->state' is then just 'the state'.
>>
>> There were certainly a lot of confusion before the explicit new/old
>> state stuff was added whether foo->state/etc. was the old or the
>> new state. And labeling things as explicitly old vs. new when passing
>> in individual object states certainly makes sense. But that doesn't
>> really have anything to do with mislabeling the overall drm_atomic_state.
>>
>>>
>>> I understand that the semantics of atomic_check are different from
>>> atomic_update, but it still doesn't hurt to talk of new_state IMHO.
>>
>> IMO it's just confusing. Makes the reader think there is somehow
>> different drm_atomic_states for old vs. new states when there isn't.
>> I also wouldn't call it new_state for .atomic_update() either.
>>
>> In both cases you have the old and new states in there and how
>> exactly they get used in the hooks is more of an implementation
>> detail. The only rules you would have to follow is that at the
>> end of .atomic_update() the hardware state matches the new state,
>> and .atomic_check() makes sure the transition from the old to the
>> new state is possible.
> 
>  From what I understand:
> 
> In atomic_check(), plane->state is the current state and the state 
> argument is the state to be validated. Calling 
> drm_atomic_get_new_plane_state() will return the plane's new state.
>

That's my understanding as well.
 
> If you call drm_atomic_get_old_plane_state() from atomic_check(), what 
> will it return?
> 
> In atomic_update() plane->state is the state to be committed and the 
> state argument is the old state before the start of the atomic commit. 
> And calling drm_atomic_get_new_plane_state() will *not* the return the 
> plane's new state (i.e., the one in plane->state) IIRC. (As I mentioned, 
> there was a related bug in one of the drivers.) So we began to call this 
> 'old_state'.
> 
> My point is: the state passed to the check and commit functions are 
> different things, even though they appear to be the same.
>

Agree.

Maybe instead of new and old `current_state` and `commit_state` would
be more clear ?
 
>>
>> I've proposed renaming drm_atomic_state to eg. drm_atomic_transaction
>> a few times before but no one took the bait so far...
>>
> 
> If you really don't like new_state, then let's call it state_tx.
>

I would prefer if for this patch we call it either `new_state` or just
`state` to be consistent with the other helpers. And then we can as a
follow-up change the naming used by all the helpers.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

