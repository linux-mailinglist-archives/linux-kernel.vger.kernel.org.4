Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BFB6734F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjASJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjASJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:59:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902D5B93
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674122324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/momIUR2szqCPj9H+fBG6myi5w9QCPaKV1+9SFndQ8g=;
        b=g4DxCHNOL5wG3reYusFIRGRovJbItuE/fm4whU+KMdhWxNXw5Gtjc7c1xM5gFeDd7Q0D7P
        w+YzNF5AunX+12hjvWs6Uhar5yF3JQ3m4kel9tslDd3rkWUMlK51yCmfLMzHU9ZAIvYGWs
        fBepcMS1eQJ+YoVYi4cU5ba6faey8Rk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-DlX1DRYmPfuXXKh4PopmCA-1; Thu, 19 Jan 2023 04:58:43 -0500
X-MC-Unique: DlX1DRYmPfuXXKh4PopmCA-1
Received: by mail-ej1-f71.google.com with SMTP id hq7-20020a1709073f0700b0086fe36ed3d0so1242483ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/momIUR2szqCPj9H+fBG6myi5w9QCPaKV1+9SFndQ8g=;
        b=eJ0CtOn/i0EvAD/fMgMTy/7FH+S8YKK5NTOM/66mKQC7fe6M5W5v2+qT9PwU1VxN1s
         ddZL1/UrJEUJDe4mh8xKUrD3q740j5KiXNeyvethIMFP/hrYSuXPsXBhUY6Ou2du3Yf1
         g0iw6phsG3VhWeeAgbRjEFChraeWZNNm8/1ekQ8gA5CJYpttCz/JcoEZ4Y1EQPbiijat
         jaMp2Irj2ecK+klD6Pt3DQUVS1rNp5TWm34COUnyC9ZGySxg0t0WI1iGb9ioXQIZobl8
         zmX6frCyTW03KrmIkxpXNfg3jgoZNQv5VMGlP4UOVoEgyxaD+idzaV42vm7RbA6ZSFL5
         8G6Q==
X-Gm-Message-State: AFqh2krGd7ohHWG3VvR6a3VI/oS8DlqS1PwgVHiF6OTZvySoNQm0teeA
        roGgjWzZL4t3/anI/9Ol5N+W0TXYSZtcb9aodHCSlS8uDtOfQnuUjLtYZXOFR8cDvxrgx9gTrUo
        cXF/SVTzxl2dgEATTDPKuXpjQ
X-Received: by 2002:a17:906:af8f:b0:7c1:5098:9074 with SMTP id mj15-20020a170906af8f00b007c150989074mr6754236ejb.0.1674122322245;
        Thu, 19 Jan 2023 01:58:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVDbY66af6io2q35fqGU70CrzU1S62qvQZqQ28yCSWei2oqAym961mTfxPhQo+zo2aGO463g==
X-Received: by 2002:a17:906:af8f:b0:7c1:5098:9074 with SMTP id mj15-20020a170906af8f00b007c150989074mr6754220ejb.0.1674122322035;
        Thu, 19 Jan 2023 01:58:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906315600b007ae10525550sm15929016eje.47.2023.01.19.01.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 01:58:41 -0800 (PST)
Message-ID: <02c3fd27-011e-f8ad-d798-a134fa8ac061@redhat.com>
Date:   Thu, 19 Jan 2023 10:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/2] Expand APU2 driver to 3/4/5/6 models
Content-Language: en-US, nl
To:     Philip Prindeville <philipp@redfish-solutions.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-x86_64@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Ed Wildgoose <lists@wildgooses.com>,
        Andres Salomon <dilinger@queued.net>,
        Andreas Eberlein <foodeas@aeberlein.de>,
        Paul Spooren <paul@spooren.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <20230113231139.436943-1-philipp@redfish-solutions.com>
 <44e0ef20-d6d3-4c87-1828-f88dbc08e942@redhat.com>
 <343F820D-69E1-4120-89DA-980FC78E3656@redfish-solutions.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <343F820D-69E1-4120-89DA-980FC78E3656@redfish-solutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/19/23 08:17, Philip Prindeville wrote:
> 
> 
>> On Jan 17, 2023, at 3:25 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Philip,
>>
>> On 1/14/23 00:11, Philip Prindeville wrote:
>>> From: Philip Prindeville <philipp@redfish-solutions.com>
>>>
>>> Extend PCEngines APU2 driver to derivative models APU3, 4, 5
>>> and 6.
>>>
>>> Of the five, the APU5 is the most dissimilar.  The APU2 is not
>>> derivative of the APU1, and we call that out in the leds-apu
>>> driver.  We also clarify the expanded compatibility of the
>>> pcengines-apuv2 driver in the Kconfig menu.
>>>
>>> We correct some line labeling for GPIO lines 4-6, and we add
>>> appropriate definitions to the GPIO lines for the APU5 which
>>> is mapped out differently.
>>>
>>> The majority of the work was done by Ed Wildgoose.  Philip
>>> Prindeville took over the effort to upstream the fixes and
>>> made some minor cleanup.
>>
>> Thank you both for your work on this.
>>
>> In would really like to hear back from Enrico what he thinks
>> about these patches. FWIW I'm fine with merging these as is.
>>
>> Also note that Enrico is listed as maintainer for the 
>> pcengines-apuv2.c file in MAINTAINERS, so you really should
>> have Cc-ed him on this.
>>
>> Enrico, can you take a look at this series please? You can find
>> the 2 actual patches here:
>>
>> https://lore.kernel.org/platform-driver-x86/20230113231139.436956-1-philipp@redfish-solutions.com/
>> https://lore.kernel.org/platform-driver-x86/20230113231140.437040-1-philipp@redfish-solutions.com/
>>
>> Regards,
>>
>> Hans
> 
> 
> I tried to copy Enrico on earlier revisions of this patch but they bounced so I stopped including him.

Weird I don't think I have received any bounces for Enrico.

Regards,

Hans




>>> Philip Prindeville (2):
>>>  x86: Support APU5 & APU6 in PCEngines platform driver
>>>  x86: Further PCEngines APU4/5/6 cleanup
>>>
>>> drivers/leds/leds-apu.c                |   2 +-
>>> drivers/platform/x86/Kconfig           |   4 +-
>>> drivers/platform/x86/pcengines-apuv2.c | 118 ++++++++++++++++++++++---
>>> 3 files changed, 107 insertions(+), 17 deletions(-)
>>>
>>
> 

