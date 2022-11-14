Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B479627D39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiKNMAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiKNL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:59:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1515713
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668426996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3w5yQu6+bnmhTRV4iI0QGMo1Zmd1XXNiki4K9/359KE=;
        b=L4BHzJ8wA+wyrYZdZBFzu+4oZnZPXKyJL/iZV6qlLFrcqkIn566iPdRj+u94OP+Oatp1aS
        +XtKmfjAQ6lfrfHYEPRRckQ8G3tJIsw8OXdI1FVZkRIPbNpT7IfhLAMis2NLky1qA/FNbg
        uQyrkNt2E2SiZwhVO65dfkS7VlCcJ4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-nJiKd3AJOhCghKRGa2yOIw-1; Mon, 14 Nov 2022 06:56:35 -0500
X-MC-Unique: nJiKd3AJOhCghKRGa2yOIw-1
Received: by mail-wm1-f70.google.com with SMTP id z18-20020a05600c221200b003cf7fcc286aso2849836wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3w5yQu6+bnmhTRV4iI0QGMo1Zmd1XXNiki4K9/359KE=;
        b=Wsw8rBrHgJKeElwxWaqGrSvFzX/jsMVO0bOWlM33y5dJHsMyfJO9aeFeGDLaBluHlH
         h9z/4hpq2xSeG1eoYzL/W+T1Uf09qYB1gzTIli43hjKkT6y4hYi+qLukFHhfIej7urhB
         YiGG6Bp+N8forkhbiq5f7x3/vT9zJaLW6EoEoGqFIfOKagr/CTtwWF66S99EWYYINtrw
         rwynXox7JSN4zg10P7wj3oufhp4O4mSdnssQO3azEyw22T4fKaszvmAMlayOAA5Bp0AU
         iaCJMJY5KpKXaupJyZWjPdKhyesYApYri6tBTbtllAcIcFhD6Dec1rjiDdM40tT91qWI
         Xx0A==
X-Gm-Message-State: ANoB5pnpIcfHPqT6WsDs69c3gOdPKXvob+elCqet6kCFHvIxNt2DWrUE
        0zRNsfhzoHS9/ACR0AUeAG9psVz/DJ5lNeIU7GXjR0MZEVLxoitGoEgLD7V4JAOzRM3FvHK8fTb
        +XFb2n7Bj7vZgqWWbdiPWJkMq
X-Received: by 2002:adf:cf12:0:b0:236:611d:b6b9 with SMTP id o18-20020adfcf12000000b00236611db6b9mr7674372wrj.190.1668426993796;
        Mon, 14 Nov 2022 03:56:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf43LETANuGPh3OVYo5kOK+95wTdLcqmrl4YgxmDJPUP7x241G7hOVt3+D9AScUhpRzEgZwAOQ==
X-Received: by 2002:adf:cf12:0:b0:236:611d:b6b9 with SMTP id o18-20020adfcf12000000b00236611db6b9mr7674359wrj.190.1668426993589;
        Mon, 14 Nov 2022 03:56:33 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003c7087f6c9asm18823551wmo.32.2022.11.14.03.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 03:56:33 -0800 (PST)
Message-ID: <9d53f7f9-b77b-21ff-500a-88f3a7fcee80@redhat.com>
Date:   Mon, 14 Nov 2022 12:56:32 +0100
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
 <354820e8-939c-781a-0d76-c1574c43b7f3@redhat.com>
 <Y3IonmwrJ3aqDbAw@kroah.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y3IonmwrJ3aqDbAw@kroah.com>
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

On 11/14/22 12:38, Greg Kroah-Hartman wrote:
> On Mon, Nov 14, 2022 at 12:13:15PM +0100, Javier Martinez Canillas wrote:
>> Hello Greg,

[...]

>> I even gave an example about general purpose distributions that build as
>> much as possible as a module. What more info do you think that is missing?
> 
> Exact systems that this is failing on would be great to have.
>

The exact system is a Snapdragon SC7180 based HP X2 Chromebook with latest
Fedora Rawhide image (kernel version 6.1-rc4). The reason why is timing out
is that the arm_smmu driver is built-in (CONFIG_ARM_SMMU=y) but it depends
on gpucc-sc7180 clk driver that's built as module (CONFIG_SC_GPUCC_7180=m).

 >>> failing on the current value?  What drivers are causing the long delay
>>> here?  No one should be having to wait 10 seconds for a deferred delay
>>> on a real system as that feels really wrong.
>>>
>>
>> Not really, it depends if the drivers are built-in, built as modules, in
>> the initramfs or in the rootfs. A 10 seconds might not be enough if these
>> modules are in the root partition and need to wait for this to be mounted
>> and udev to load the modules, etc.
> 
> How does it take 10 seconds to load the initramfs for a system that
> requires deferred probe devices?  What typs of hardware is this?
>

That could depend on may things. The dependency of the systemd unit files,
whether NetworkManager-wait-online.service is enabled or not, etc. It can
really take more than 10 seconds on some systems to load all the modules.
 
[...]

>>
>> A nice feature of the probe deferral mechanism is that it was simple and
>> reliable. Adding a timeout makes it non-deterministic and more fragile IMO.
> 
> deferred probe was never simple or reliable or determinisitic.  It was a
> hack we had to implement to handle complex hardware situations and
> loadable drivers.  Let's not try to paper over driver bugs here by
> making the timeout "forever" but rather fix the root problem in the
> broken drivers.
>

I don't understand how adding a 10 secs timeout would make it more robust than
just letting the driver core to attempt probing the deferred drivers again for
every driver (or device) that gets registered.
 
> So, what drivers do we need to fix up?
> 

So what exactly needs to get fixed on the arm_smmu and gpucc-sc7180 drivers
mentioned? Yes, we could built both of them as =y and make sure that drivers
are registered and probed before the initcalls are done, but if we do that,
we will need to have most of the drivers built-in in the Fedora kernel. That
does not scale for all the platforms that we need to support.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

