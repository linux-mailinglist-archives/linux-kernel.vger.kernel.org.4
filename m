Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5584706F52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEQRZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEQRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DE76A9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684344288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1iAIrTnVwFzq6+c38GVnN7MsYmU1HrrFym557ov8ROI=;
        b=ZEiqnoDnlRCLLl0pfuGfLaECEt9HbzuC9tqjp2BhPSbp4t0e0VDgjy3q/G7l4lsH3pETFn
        UOcn3c5gjHYnKJdd9HiG3KS25RX6nxAWiGdBUl/b7zhPWxFgUpjjhpIsF8jA5Wgwd+Gpgs
        M2MicOt8XNEE4BwtDusyyJ8ejMo++VE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-0sVRUiKlM5OHXYgdEe3mVA-1; Wed, 17 May 2023 13:24:47 -0400
X-MC-Unique: 0sVRUiKlM5OHXYgdEe3mVA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f33f8ffa95so4618755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344286; x=1686936286;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iAIrTnVwFzq6+c38GVnN7MsYmU1HrrFym557ov8ROI=;
        b=dnrCn1kyMUvB+25fXAOpczFIOycLhtAdM++icNoEtx2IOPB86lG4jg4WwyzYMD8iF9
         UsOZMbhwm7nuIOf7rx1jzIqmrdfDq4XdT/l4z9VbysUNH5y9RtC3oSP4wcwjbQGPqspF
         XSI3g8V029rqRSWRdF+WFoAfe/5EW77NxXA/CZAhbrMkhfR9gikZk4LTwp6ozNyDaaLS
         99wUSCIeI1Ht02J/gI/B5gx+3/G3g4A0sc6bBg9yvozn3trtFMvEQ7fgQkULYDG/cYAQ
         P1ranXlh/NHqIybDx6yroO9f5Ag3A3BKmUjOD489t08NnFJajea+1igJrckYIie0Xh2J
         XTtA==
X-Gm-Message-State: AC+VfDwvwQZ9GqeKpCdBV2Aa0RKpo4tg0fbB1KQUDXqctjzwyGdm3p9w
        uUkwhFfkq5OgAllL36hBFixu8ipuvqciDpF49WLw44EvlWo7sYP7q3KuqiJS9zoldGPyWvmyxyQ
        VN4CLBqe6/LGFhs0kxuALoy/U
X-Received: by 2002:a7b:c397:0:b0:3f5:772:f333 with SMTP id s23-20020a7bc397000000b003f50772f333mr8899204wmj.4.1684344286480;
        Wed, 17 May 2023 10:24:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jSHjGc2VCPNPYrXpge4cFfRVbJpvTfkWEcLMmIeIQDCnWRWkea0SDpPuJr/rrRfE4RbIP8g==
X-Received: by 2002:a7b:c397:0:b0:3f5:772:f333 with SMTP id s23-20020a7bc397000000b003f50772f333mr8899194wmj.4.1684344286140;
        Wed, 17 May 2023 10:24:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i9-20020adffc09000000b0030497b3224bsm3347909wrr.64.2023.05.17.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:24:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dana Elfassy <delfassy@redhat.com>
Cc:     eballetb@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dana Elfassy <dangel101@gmail.com>
Subject: Re: [PATCH v2] Input: tests: add test to cover all
 input_grab_device() function
In-Reply-To: <ZGUJoClUZpL71Jw4@google.com>
References: <20230517153145.513095-1-dangel101@gmail.com>
 <ZGUJoClUZpL71Jw4@google.com>
Date:   Wed, 17 May 2023 19:24:44 +0200
Message-ID: <874joaan1f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

Hello Dmitry,

> Hi Dana,
>
> On Wed, May 17, 2023 at 06:31:45PM +0300, Dana Elfassy wrote:
>> Currently input_grab_device() isn't covered by any tests
>> Thus, adding a test to cover the cases:
>> 1. The device is grabbed successfully
>> 2. Trying to grab a device that is already grabbed by another input
>>    handle
>> 
>> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
>> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>> Changes in v2:
>> - Use input_put_device() to decrement the refcount increased by get().
>> - Remove unnecessary struct input_handle test_handle variable.
>
> So this tests something different than what patch description states.
> You are testing that there is no "recursive" grabbing happening (an API
> could be designed to allow the same handle grab device several times).
> This is a good and useful test, but you do want to also use 2nd separate
> handle to see that it gets -EBUSY as well. And ideally we should have

That was my fault since v1 had two different handles but since it wasn't
releasing it, didn't add any value really so I asked Dana to just drop it.

> another test verifying that the 2nd handle can successfully grab the
> device once the first handle releases it.
>

That's the correct approach indeed and would make the test more useful.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

