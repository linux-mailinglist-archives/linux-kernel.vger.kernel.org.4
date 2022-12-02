Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4A640393
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiLBJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiLBJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D881D0FF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669974169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wLl4vtYCGhwohXxITZQq5I6CY9K6KjTKaeRzYrEEpY=;
        b=GVyMkVrxHuH6ntzuBs4aff9tewyssz9Vp2M/M4P1m+LoXlEEKm8kH2GbKgdYtd2OJeF+vE
        RyWKS65gp9qEqlF88IMqgTPxdZZiUdCeYdKGVDv6WMLCE2WO1AivtqZxglgo1HaZW+Wknk
        BK4lxk/HK8Xti52QOHJO/Z22nhzgWSQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-459-u6Q-wNZ_MAaB1hlSrtmJJQ-1; Fri, 02 Dec 2022 04:42:47 -0500
X-MC-Unique: u6Q-wNZ_MAaB1hlSrtmJJQ-1
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso2238093wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 01:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wLl4vtYCGhwohXxITZQq5I6CY9K6KjTKaeRzYrEEpY=;
        b=rzWZ13xN0mK1/VvRMYfJCAWypYaD952XIlaWJhTauFBptrFU9/TM+IRYurXtLqtGsD
         7cjm6nwknWeS/yE1gFfVCJSPxl1AgTt/MuUGeB1YP+u+D26VZyojHNhncFkxt3Hl8V45
         TXSv5fBEmcfNecqfssrmiowWi/Xb0GfbwSV8I8CrT1Cyef4lsh4VmvMhmbR92OpzdMIZ
         7MAr2ToS4xRFka0olq4C7mBmG5zMl+nhkCSgGuYuAfQQK1VS0D37vGFNhzILjQ61Y5+G
         73+Nj7IP5QLwm02+HxELL5qiIERvNA45qFfuEdfC7xwPRmonO5j1JsAr/hSclEHhwQj1
         Eg7g==
X-Gm-Message-State: ANoB5pmrW+u0s85kvLL2Y35o3cmajxgWk4w9YDOMiRwyoyoIKIgrG543
        JYxKl0cN4g7D+9nGhXZgA7xBgVFPJF4g/jwaaPhVSxRgqZlANyEaChSbvg2d03SIRkiT9uKR8Kl
        X+TKMMI5n5FCAXx0nBCA7e70z
X-Received: by 2002:a5d:6947:0:b0:242:17a5:ee80 with SMTP id r7-20020a5d6947000000b0024217a5ee80mr14530215wrw.628.1669974166727;
        Fri, 02 Dec 2022 01:42:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6UdJV/mDJpmRG4muvnS79yLQAxAfJtB+81SwOHAcWOxkps8MZJhxfA5YRNqhJp3giA0N1wyw==
X-Received: by 2002:a5d:6947:0:b0:242:17a5:ee80 with SMTP id r7-20020a5d6947000000b0024217a5ee80mr14530202wrw.628.1669974166476;
        Fri, 02 Dec 2022 01:42:46 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020adff745000000b002383fc96509sm6488257wrp.47.2022.12.02.01.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 01:42:46 -0800 (PST)
Message-ID: <3805ed81-2315-4eca-3ea6-b391c1659cc7@redhat.com>
Date:   Fri, 2 Dec 2022 10:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] KVM: Mark KVM_SET_MEMORY_REGION and
 KVM_SET_MEMORY_ALIAS as obsoleted
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergio Lopez Pascual <slp@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221119085632.1018994-1-javierm@redhat.com>
 <Y4T+SY9SZIRFBdBM@google.com>
 <a6a59b75-2ee2-ab9b-3038-2590df17d031@redhat.com>
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a6a59b75-2ee2-ab9b-3038-2590df17d031@redhat.com>
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

Hello Sean and Paolo,

Thanks for your feedback.

On 11/30/22 15:28, Paolo Bonzini wrote:
> On 11/28/22 19:30, Sean Christopherson wrote:
>> E.g. KVM_{CREATE,GET,SET}_PIT are good examples of obsolete ioctls; they've been
>> supplanted by newer variants, but KVM still supports the old ones too.
>>
>> Alternatively (to marking them deprecated), can we completely remove all references
>> to VM_SET_MEMORY_REGION and KVM_SET_MEMORY_ALIAS?  The cascading updates in api.rst
>> will be painful, but it's one-time pain.
> 
> Yes, we should.
>

Ok. I'll do that and post a v2 then.
 
> Paolo
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

