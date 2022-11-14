Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28247627C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiKNLSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiKNLR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA822B3E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668424399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbzB3Do9hchyukoNcrfWbxKENZKnp4VNTslba0IU/uA=;
        b=K+islHkrVqzjvla9HNLLvpIXCjQlPUM+BBixvKIbhEpVtDRWQaP7qZKxO4KEtlNuJLNYC7
        3QQ5W9GUfoAdDrDc/rSgWjWHi7uOgWp/eoMXFqv5t7Gw7fwBTWcUZcIUK+gihFuJVulT/L
        G9tZhenzeHteIwU42mnv9jb1zP6n1uU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-72JTf4ftPgSugdqM7ixLAQ-1; Mon, 14 Nov 2022 06:13:18 -0500
X-MC-Unique: 72JTf4ftPgSugdqM7ixLAQ-1
Received: by mail-wr1-f69.google.com with SMTP id u13-20020adfa18d000000b00236566b5b40so1867608wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbzB3Do9hchyukoNcrfWbxKENZKnp4VNTslba0IU/uA=;
        b=D08rlZC7UTYxieYBJEi4/UZIV0xlCkljOysNmsS+r+4zVDBOP9C5ygEZiFlPhqtC03
         rQkVZrApqh13qI7LBNDDLVi6Xs3zIS+bs+QbQ8tsOTh7a3fP9vIalhBOIRwOCupXjrnz
         zvJOwTvCfTxlIP4vfGZlDSBUaLaIaXHCzQj9lMmdavtHggv+HjntOVzO+nJT8Coa6aan
         UxIOqOsfA8yDhud8pq+zpZPZcDdL//eyiJMok9ieW1PdXtZhaK/zUW+KQzD2HjgSib5h
         hOV1qandqSMkILcXpPVfOK+iYVRxR/EXOUUD8mx3iNDafHrH3ywXJUViSEAEgL31k8Bd
         B2bA==
X-Gm-Message-State: ANoB5pk7HPHjCjabH+8YT0DMeWubDxtVvUqwexf8STiKWffALjHCGKO8
        E6aokXisiNDmh82JAUrYouu4BK99N4zsFQMlZcYvmmqwdPmgFfZoVL7hKiHrvFcqVW2If7vK2BL
        6bOw0Vqo3sx1gZMHOuSTeuk8U
X-Received: by 2002:a05:600c:358e:b0:3cf:6a4c:af8b with SMTP id p14-20020a05600c358e00b003cf6a4caf8bmr7826357wmq.115.1668424396789;
        Mon, 14 Nov 2022 03:13:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5SnBq9f8LQoQTVPB1Cy9WLBO+DAbfC5qXOSP1fGSvEj0DqvYgJ51U16zg2nmtGs/cEbl9Cpw==
X-Received: by 2002:a05:600c:358e:b0:3cf:6a4c:af8b with SMTP id p14-20020a05600c358e00b003cf6a4caf8bmr7826341wmq.115.1668424396576;
        Mon, 14 Nov 2022 03:13:16 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b003a3170a7af9sm13160967wms.4.2022.11.14.03.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 03:13:16 -0800 (PST)
Message-ID: <354820e8-939c-781a-0d76-c1574c43b7f3@redhat.com>
Date:   Mon, 14 Nov 2022 12:13:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] driver core: Disable driver deferred probe timeout by
 default
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221114104333.3695531-1-javierm@redhat.com>
 <Y3IeUADalX6WDnuO@kroah.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y3IeUADalX6WDnuO@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Thanks a lot for your feedback.

On 11/14/22 11:54, Greg Kroah-Hartman wrote:

[...]

>>
>> This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
>> "driver core: Set default deferred_probe_timeout back to 0."") and set to
>> 10 seconds instead. Which was still less than the 30 seconds that was set
>> at some point to allow systems with drivers built as modules and loaded by
>> user-land to probe drivers that were previously deferred.
>>
>> The 10 seconds timeout isn't enough for the mentioned systems, for example
>> general purpose distributions attempt to build all the possible drivers as
>> a module to keep the Linux kernel image small. But that means that in very
>> likely that the probe deferral mechanism will timeout and drivers won't be
>> probed correctly.
> 
> What specific "mentioned systems" have deferred probe drivers that are

The "mentioned systems" are the ones mentioned in the paragraph above:

"to allow systems with drivers built as modules and loaded by user-land to
probe drivers that were previously deferred."

I even gave an example about general purpose distributions that build as
much as possible as a module. What more info do you think that is missing?

> failing on the current value?  What drivers are causing the long delay
> here?  No one should be having to wait 10 seconds for a deferred delay
> on a real system as that feels really wrong.
>

Not really, it depends if the drivers are built-in, built as modules, in
the initramfs or in the rootfs. A 10 seconds might not be enough if these
modules are in the root partition and need to wait for this to be mounted
and udev to load the modules, etc.

Also, it may even be that the module alias is not correct and then users
have to load them by explicitly have /etc/modules-load.d/ configs and so
on.
 
> Why not fix the drivers that are causing this delay and maybe move them
> to be async so as to not slow down the whole boot process?
>

Yes, these drivers could be fixed to report a proper module alias or the
dependencies can be built-in or added to the initramfs and that does not
change the fact that by default the kernel shouldn't make assumptions
about when is safe to just timeout instead of -EPROBE_DEFER.

Because with modules the kernel has no way to know when all the modules
have been already been loaded by user-space or more drivers are going to
be registered in the future.

Also, that's how probe deferral always worked since the mechanism was
introduced. It's just recently that the behavior was changed to timeout.

A nice feature of the probe deferral mechanism is that it was simple and
reliable. Adding a timeout makes it non-deterministic and more fragile IMO.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

