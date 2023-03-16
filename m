Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5DE6BC9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCPIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjCPIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB1E1BE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678956557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQF+VfJcpEoBY5ux7q01aOkEisslQ62cgsWrGcOCzeA=;
        b=EfwC0yUj3kY2pJm58hnrj8yDxkzYw2KBplDJH1PfNhwLOWgNVSP3RAM4U1Qm8pxHkrTF30
        QsCmP1YsBluIVHQy/UVZuq0m8ki+gs62FSSTBmVP7hlIQ8O77dV6vtGRD40k+CTF2gyrrR
        pJF5ocJCDgVAooKG40uT62mIBgPJGE8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-xIucgTPpNKOc0HN_gSX_yw-1; Thu, 16 Mar 2023 04:49:15 -0400
X-MC-Unique: xIucgTPpNKOc0HN_gSX_yw-1
Received: by mail-ed1-f71.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso2028121edh.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQF+VfJcpEoBY5ux7q01aOkEisslQ62cgsWrGcOCzeA=;
        b=Nv4luHrDyiK839HcY0KP+/FjmDcyY7x4iZFVfUt4BTC+oQ9tSDdwLZFSUz/GKkl+q5
         /9oCoPYl5LA7wcRLnaDMGDM6lqH5jlBihhZ2ZKZ3ZG+cNz6m2OUqgr5y2rtOnOApXrM+
         uvqH5qrBZKb9Lo5pTBGNTRs80sYIfISwXWLQBoVcEgxT6ciaOzII2Q90ycZByZpKOD2V
         271/UQ52jR8bfNz+r9YxfuKN0kHP0Q7Wvx2yPveoizdxJ1NDD7PYpCwa4uZCpGToAIBi
         DvMd7pT9uUS1ykYWayVrIYudPmhSNOHN5dqUxeVcKjGsKAUkuo2OmOPLlizm3Mmz87us
         BIkA==
X-Gm-Message-State: AO0yUKVgjl2ruS0bERL6PdXrOTuYny5CmA0VRMe5bh3M9gFVLX+8eBXx
        Dz5uj6pHF0brq+i7INonHKmK0BCzbmX4zNfd1r34eloOV/1KEL57Ae+OmI2EV/KdDx7mt1C945S
        qF2KMH63dNFKCY3ULfGH4uxc0
X-Received: by 2002:a17:907:31ca:b0:92f:e643:e822 with SMTP id xf10-20020a17090731ca00b0092fe643e822mr3072609ejb.37.1678956554158;
        Thu, 16 Mar 2023 01:49:14 -0700 (PDT)
X-Google-Smtp-Source: AK7set986UHmIZ1pfjcoD9S5jCEussbdGvwlVTM/9q1utc4TpF0kSx1gaCcutBDOKagtBqq8vpo49g==
X-Received: by 2002:a17:907:31ca:b0:92f:e643:e822 with SMTP id xf10-20020a17090731ca00b0092fe643e822mr3072589ejb.37.1678956553903;
        Thu, 16 Mar 2023 01:49:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t21-20020a1709066bd500b0092bd1a7f5fdsm3539340ejs.57.2023.03.16.01.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 01:49:13 -0700 (PDT)
Message-ID: <31b1d4a5-3a98-ae3a-b089-f2464fc890f4@redhat.com>
Date:   Thu, 16 Mar 2023 09:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Input: i8042 - Add quirk for Fujitsu Lifebook A574/H
Content-Language: en-US, nl
To:     Jonathan Denose <jdenose@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Denose <jdenose@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
References: <20230303152623.45859-1-jdenose@google.com>
 <e8f5e2aa-d7fa-88ff-6306-4c1ee8feeade@redhat.com>
 <CALNJtpWsvZEdGJFA30cv0cSq43Djm7q+trDQVxx5aRDzg7u3Gw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALNJtpWsvZEdGJFA30cv0cSq43Djm7q+trDQVxx5aRDzg7u3Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/15/23 22:39, Jonathan Denose wrote:
> Hello Hans,
> 
> Thank you very much for your review.
> 
> For my knowledge, what is the timeline for patches in the input
> mailing list getting applied to a maintainer branch after review?

It depends on when Dmitry has time to go through the patch queue. Not a really helpful answer I know, sorry.

Regards,

Hans


> On Mon, Mar 6, 2023 at 5:00 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 3/3/23 16:26, Jonathan Denose wrote:
>>> Fujitsu Lifebook A574/H requires the nomux option to properly
>>> probe the touchpad, especially when waking from sleep.
>>>
>>> Signed-off-by: Jonathan Denose <jdenose@google.com>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Regards,
>>
>> Hans
>>
>>
>>> ---
>>>
>>>  drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
>>> index efc61736099b..fe7ffe30997c 100644
>>> --- a/drivers/input/serio/i8042-acpipnpio.h
>>> +++ b/drivers/input/serio/i8042-acpipnpio.h
>>> @@ -610,6 +610,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>>               },
>>>               .driver_data = (void *)(SERIO_QUIRK_NOMUX)
>>>       },
>>> +     {
>>> +             /* Fujitsu Lifebook A574/H */
>>> +             .matches = {
>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "FMVA0501PZ"),
>>> +             },
>>> +             .driver_data = (void *)(SERIO_QUIRK_NOMUX)
>>> +     },
>>>       {
>>>               /* Gigabyte M912 */
>>>               .matches = {
>>
> 

