Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6381600CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJQKtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1241C5C962
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666003744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/nMNEaPKxeRLF9iYIA/lWfiQRPiF46bzjnNuOgshhw=;
        b=N3z+21q67k0olIIhZIxfPdWscP7mTJDJLfWvAvCVln/TUR+0AbldhZ1483WcYqeNjFt2Zi
        mTob68EzIvsxT1pYpyN55udzf1Lb3EeASJGM3Xbe8SWQWbuLuzoruhJnjnuSrE2HKkAUXP
        rk1CMnDRUySDHNii/SISyZgug6myZis=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-8fc3-DaSN9yDTwthBRdrwQ-1; Mon, 17 Oct 2022 06:49:03 -0400
X-MC-Unique: 8fc3-DaSN9yDTwthBRdrwQ-1
Received: by mail-ed1-f71.google.com with SMTP id r18-20020a05640251d200b0045d4f995adeso4158783edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/nMNEaPKxeRLF9iYIA/lWfiQRPiF46bzjnNuOgshhw=;
        b=YLQc/x3LRdwmlzAfNVlCD7xx3MNi/O99ibXZ32gpj68GC1jrL1jo4/0Ok/6GUYqAw2
         MzNoAMaC3FD8YrKFlDmQWu71ofylTVW+wn7bHjOjWbxTOBaOABznPiCdmFu9Ed99qofS
         9hp6lFX8NlM2YMYg0ZPaYFHy5QF0qSm9p4O6rmX7vWOC2+h9Drf9ATHU5l0B+2N4bYD/
         tVcpFeN5RHFiAITXYvfA/KkbfiqI5O6SvfWyHrkZodEQL8jBXgovhxvSYAyW0j3apqCo
         lnIeLtzAG8GXvnsiVQU7+nxGcS3thl0wDtrBObaeQ1uymxY5zQCHPOy21gGOyH9zyleS
         0AKg==
X-Gm-Message-State: ACrzQf03M9SM11JE26/Jq7TGjmsiSLDCRhauQcYQmp+ExDQvz3dLNlJR
        Luux7jLANYMZPaGaQQcaG5MndlrOyKFK/87D+SwGKQS4Yx3bW8hO2dD3Gio/VpnaOOTHVLTwSva
        DouZFMCZXlvy7a8OFLUHn5nBx
X-Received: by 2002:a17:907:5cb:b0:791:96ec:f436 with SMTP id wg11-20020a17090705cb00b0079196ecf436mr1015571ejb.100.1666003741353;
        Mon, 17 Oct 2022 03:49:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7c3EMA0MVgt3p82joEQtl8gApzcnvyxUU7Hnm/b0T7BgEdfbcRhkDbH1n2jx1vpWgjXJUySQ==
X-Received: by 2002:a17:907:5cb:b0:791:96ec:f436 with SMTP id wg11-20020a17090705cb00b0079196ecf436mr1015559ejb.100.1666003741150;
        Mon, 17 Oct 2022 03:49:01 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ky15-20020a170907778f00b0078bfff89de4sm5880962ejc.58.2022.10.17.03.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 03:49:00 -0700 (PDT)
Message-ID: <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
Date:   Mon, 17 Oct 2022 12:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com> <877d0ysv1e.fsf@intel.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <877d0ysv1e.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/17/22 10:39, Jani Nikula wrote:
> On Mon, 17 Oct 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>>> With 6.0 the following WARN triggers:
>>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>>
>>>         drm_WARN(&i915->drm, min_size == 0,
>>>                  "Block %d min_size is zero\n", section_id);
>>
>> What's the value of section_id that gets printed?
> 
> I'm guessing this is [1] fixed by commit d3a7051841f0 ("drm/i915/bios:
> Use hardcoded fp_timing size for generating LFP data pointers") in
> v6.1-rc1.
> 
> I don't think this is the root cause for your issues, but I wonder if
> you could try v6.1-rc1 or drm-tip and see if we've fixed the other stuff
> already too?

6.1-rc1 indeed does not trigger the drm_WARN and for now (couple of
reboots, running for 5 minutes now) it seems stable. 6.0.0 usually
crashed during boot (but not always).

Do you think it would be worthwhile to try 6.0.0 with d3a7051841f0 ?

Any other commits which I can try before I go down the bisect route ?

(I'm assuming this will also affect other users, so we really need
to fix this for 6.0.x before it starts hitting Arch + Fedora users)

Regards,

Hans



> [1] https://gitlab.freedesktop.org/drm/intel/-/issues/6592

