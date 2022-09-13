Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4C95B7CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIMWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIMWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252F7437B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663106642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gOOtyxJnrLkhF6TWSyEhuvgGBNrJG/B1dRuNpBEVOPA=;
        b=QVWk/0wS6Aj1LX+bdbraSmJ3571q6LFBC5U5dcJ3jdK7QrD1MFC4dq9YZ+cmm8BeiGSs2S
        VGYIkggLpPjEmFjYXotTgUcGhiAC7azwxLFGpyOJ6GpPnBTwgpVvsge5VJDmlNDdQAmJfN
        2NwcYFR/odautp2TZicZjn760wb6DLo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-_dz0n4VOOuOFsSBzyDPDlA-1; Tue, 13 Sep 2022 18:04:01 -0400
X-MC-Unique: _dz0n4VOOuOFsSBzyDPDlA-1
Received: by mail-ej1-f70.google.com with SMTP id qw34-20020a1709066a2200b0077e0e8a55b4so3020222ejc.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gOOtyxJnrLkhF6TWSyEhuvgGBNrJG/B1dRuNpBEVOPA=;
        b=K6JYwDSAgeGpTNbP6G7Eb/b0Q064faG7AX6RLc3vOW5HvGtEZoAqs47cts5HaLdMoJ
         PX5G4LjwF36Y6vv/gdfZa8bvTgkQ8Rw3RdbVQHLrhiBGRXktgArfnVbh/BwenS9U3vaf
         MsWAM6d4JpIRUpdNj8LAVd1atPcRCtDQ0VJpQBQQPA76STzJ2VXJ1NzIuxy9lv2GYNlB
         PdWuG4fe6BMTg6t7v094/43RcyGgXO32E0tg+kWN5+ZM5WAVaH49azP10oWtmz19er2x
         PwCOl0Fpx8w2eVg0n7JB7/v72SS9DXMIZXF0s8J348g5vAHmDxLz/booIGaKLrEraxXb
         uT/Q==
X-Gm-Message-State: ACgBeo2SCWSLOwQpFnW/55LbyckP94qxPzHEDzcidvRw7bBltuzt07am
        dZ+vVm9J/qJ64mOWB+r/0BIQhAqk67P3vSQUveqvJ/AOnPnmhKlSn42TwrSiKXKxfCqN7LzuZe3
        qAPLzw4KMqm7DMcuc5XdZ11ko
X-Received: by 2002:a17:907:2e02:b0:77b:bdab:674b with SMTP id ig2-20020a1709072e0200b0077bbdab674bmr11087316ejc.159.1663106640146;
        Tue, 13 Sep 2022 15:04:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7McHMcufJ4R7XFrwWuimHGiBDinNccySxkSmt/hdARu+2VPfH//eehUKBoiGwvuH4QAYPOfg==
X-Received: by 2002:a17:907:2e02:b0:77b:bdab:674b with SMTP id ig2-20020a1709072e0200b0077bbdab674bmr11087301ejc.159.1663106639873;
        Tue, 13 Sep 2022 15:03:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0077f324979absm2893589eje.67.2022.09.13.15.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 15:03:59 -0700 (PDT)
Message-ID: <a10cf8af-1f62-ddd2-3975-066dd9494c9f@redhat.com>
Date:   Wed, 14 Sep 2022 00:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND drm-misc-next 4/7] drm/arm/hdlcd: plane: use drm
 managed resources
Content-Language: en-US
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220905152719.128539-1-dakr@redhat.com>
 <20220905152719.128539-5-dakr@redhat.com>
 <Yx9uAe//u/Z9zfmM@e110455-lin.cambridge.arm.com>
 <dc472070-34a8-93e1-2ca3-4847c49f12eb@redhat.com>
 <YyBGRMAcV2Mrliis@e110455-lin.cambridge.arm.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <YyBGRMAcV2Mrliis@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 10:58, Liviu Dudau wrote:
> On Mon, Sep 12, 2022 at 09:50:26PM +0200, Danilo Krummrich wrote:
>> Hi Liviu,
> 
> Hi Danilo,
> 
>>
>> Thanks for having a look!
>>
>> This is not about this patch, it's about patch 3/7 "drm/arm/hdlcd: crtc: use
>> drmm_crtc_init_with_planes()".
> 
> Agree! However, this is the patch that removes the .destroy hook, so I've replied here.

This is a different .destroy hook, it's the struct drm_plane_funcs one, 
not the struct drm_crtc_funcs one, which the warning is about. Anyway, 
as said, we can just drop the mentioned patch. :-)

> 
>>
>> And there it's the other way around. When using drmm_crtc_init_with_planes()
>> we shouldn't have a destroy hook in place, that's the whole purpose of
>> drmm_crtc_init_with_planes().
>>
>> We should just drop patch 3/7 "drm/arm/hdlcd: crtc: use
>> drmm_crtc_init_with_planes()", it's wrong.
> 
> So we end up with mixed use of managed and unmanaged APIs?

In this case, yes. However, I don't think this makes it inconsistent. 
They only thing drmm_crtc_init_with_planes() does different than 
drm_crtc_init_with_planes() is that it set's things up to automatically 
call drm_crtc_cleanup() on .destroy. Since this driver also does a 
register write in the .destroy callback and hence we can't get rid of 
the callback we can just keep it as it is.

> 
>>
>> Do you want me to send a v2 for that?
> 
> Yes please! It would help me to understand your thinking around the whole lifecycle of the driver.
> 
> BTW, I appreciate the care in patches 5-7 to make sure that the driver doesn't access freed resources,
> however I'm not sure I like the fact that rmmod-ing the hdlcd driver while I have an fbcon running
> hangs now the command and prevents a kernel reboot, while it works without your series. Can you explain
> to me again what are you trying to fix?

Sure! DRM managed resources are cleaned up whenever the last reference 
is put. This is not necessarily the case when the driver is unbound, 
hence there might still be calls into the driver and therefore we must 
protect resources that are bound to the driver/device lifecycle (e.g. a 
MMIO region mapped via devm_ioremap_resource()) from being accessed. 
That's why the hdlcd_write() and hdlcd_read() calls in the crtc 
callbacks need to be protected.

However, of course, the changes needed to achieve that should not result 
into hanging rmmod. Unfortunately, just by looking at the patches again 
I don't see how this could happen.

Do you mind trying again with my v2 (although v2 shouldn't make a 
difference for this issue) and provide the back-trace when it hangs?

Thanks,
Danilo

> 
> Best regards,
> Liviu
> 
> 
>>
>> - Danilo
>>
>>
>>
>> On 9/12/22 19:36, Liviu Dudau wrote:
>>> Hi Danilo,
>>>
>>> I have applied your patch series for HDLCD on top of drm-next (commit 213cb76ddc8b)
>>> and on start up I get a warning:
>>>
>>> [   12.882554] hdlcd 7ff50000.hdlcd: drm_WARN_ON(funcs && funcs->destroy)
>>> [   12.882596] WARNING: CPU: 1 PID: 211 at drivers/gpu/drm/drm_crtc.c:393 __drmm_crtc_init_with_planes+0x70/0xf0 [drm]
>>>
>>> It looks like the .destroy hook is still required or I'm missing some other required
>>> series where the WARN has been removed?
>>>
>>> Best regards,
>>> Liviu

