Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1CF6660E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjAKQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjAKQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227F36374
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673455432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxRYFvZ1+BeTGMrTtJZgEBUI9joLdvIfL1k/Gm7E0+s=;
        b=TmbgmCvjRLNInAY+VsvVbgx1rWtUTb/har4ZotZRXI5n5JrWUYa505Ui1R7wLRHY4JeOUu
        06x5uAadA3cYLMUxsBsSL1KWATKzNCAKYgCVEumdfgX/FwtJQYdtIHEDspMCQcIPApO4xS
        /hjKK2wcafuEwmpvGgFGa853wpckZMc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-_CDbt5TbPmq4FZWxS8Yx-Q-1; Wed, 11 Jan 2023 11:43:48 -0500
X-MC-Unique: _CDbt5TbPmq4FZWxS8Yx-Q-1
Received: by mail-wm1-f71.google.com with SMTP id p34-20020a05600c1da200b003d990064285so10982026wms.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxRYFvZ1+BeTGMrTtJZgEBUI9joLdvIfL1k/Gm7E0+s=;
        b=eRXKxIm5g9kLlm+QBSd0ge5k7sEGWufooov7K/B5gS12av6dKY6TkBkJ5rJ+XtnSbc
         yD+wi7Q6BfFlucga9V7nWd7CGOupsoRDMKBEzyyMzEy14tPwqlL3GYKToIFNuxBL9EH3
         cWW20QCVuSBTmu+CpwDDrr4WS9LLmOJFJbwoqFX/lmWOGRBxua9ZqjyNmZCiu/dOsHR3
         zVN8GsXXWH+dcvsMfmWgi5Z0tVNiw3mV0/i1Zf/djDVOdisTQ0kI4E4rH7NLDf+AbR1B
         qqcexNMYCThGK76G8mlhsipzRefo6+JDQrZd/zCUQ+4CookvuDzOd4wfV489Aoo4YwJz
         t9qQ==
X-Gm-Message-State: AFqh2kqnprbaP2yzw1DaOmscGodRZx7dOym5JpaQa/V6H5AkTdI8/hCi
        p+CN03E9lWp+RDykx6uZeqA/jTGQZTIagFhkq7RKR/RxIHpCFS7JfK2TiZLTu7/P7Elaj+d+Lqc
        C0AzRY69lUn1dwwil4d3x7yra
X-Received: by 2002:a05:600c:a51:b0:3d2:3376:6f38 with SMTP id c17-20020a05600c0a5100b003d233766f38mr51935574wmq.20.1673455427719;
        Wed, 11 Jan 2023 08:43:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt8bs5GVHKAAyzPrAmLCp/tLubFFeFPYbGqzxKyfH2/luqZIN7to1nvrwQTAx8OXJqYX3VBcw==
X-Received: by 2002:a05:600c:a51:b0:3d2:3376:6f38 with SMTP id c17-20020a05600c0a5100b003d233766f38mr51935564wmq.20.1673455427564;
        Wed, 11 Jan 2023 08:43:47 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003d9aa76dc6asm27673760wmc.0.2023.01.11.08.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:43:47 -0800 (PST)
Message-ID: <dc578554-570d-9496-6661-4c9bcd3e2496@redhat.com>
Date:   Wed, 11 Jan 2023 17:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/11] video/aperture: Only remove sysfb on the default
 vga pci device
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Aaron Plattner <aplattner@nvidia.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-11-daniel.vetter@ffwll.ch>
 <2102a618-2d5e-c286-311f-30e4baa4f85b@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2102a618-2d5e-c286-311f-30e4baa4f85b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 17:20, Thomas Zimmermann wrote:

[...]

>>
>> diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
>> index ba565515480d..a1821d369bb1 100644
>> --- a/drivers/video/aperture.c
>> +++ b/drivers/video/aperture.c
>> @@ -321,15 +321,16 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
>>   
>>   	primary = pdev == vga_default_device();
>>   
>> +	if (primary)
>> +		sysfb_disable();
>> +
> 
> There's another sysfb_disable() in aperture_remove_conflicting_devices() 
> without the branch but with a long comment.  I find this slightly confusing.
> 
> I'd rather add a branched sysfb_disable() plus the comment  to 
> aperture_detach_devices(). And then add a 'primary' parameter to 
> aperture_detach_devices(). In aperture_remove_conflicting_devices() the 
> parameter would be unconditionally true.
>

Or just remove that long comment since there's already kernel-doc for the
sysfb_disable() function definition.

This feels to me that any approach to parameterize this will lead to code
that is harder to read.

Since is just a single function call, I would just duplicate like $subject
does to be honest.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

