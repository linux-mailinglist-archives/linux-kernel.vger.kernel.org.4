Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9DB667EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjALTFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjALTEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5A186BC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673549037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S2aFXYUUXHkge7W8/MGCCgS8I5Wxqc/SFMDSZCJN888=;
        b=ZYnU2/SJiKj9/7UV2fsLg3YaxS/DQXPYOZXYrARlWnKCvJ70yPPj+1Ledc7D1RpphZzOIP
        p1oPY0kzOS8Yj/+nVhlzGrzYI8wSeo5nc1hOHY3KX9AhcdZ9ctH6ccb9hYeHErvyqrJgvp
        SnLLSaUUCnFvbqiIwUR9Lgt73E9DtWY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-Bt75mUcfMs2E0m-2y8z0hA-1; Thu, 12 Jan 2023 13:43:55 -0500
X-MC-Unique: Bt75mUcfMs2E0m-2y8z0hA-1
Received: by mail-ed1-f69.google.com with SMTP id v8-20020a056402348800b0048db0688c80so12896455edc.15
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2aFXYUUXHkge7W8/MGCCgS8I5Wxqc/SFMDSZCJN888=;
        b=srvFkzO4TpiH55EA1PXO0rKd6XBOB8f8j7G4S8GxDVlqfKtaz5aEFL3Zq5D7ak1MWd
         SmR3R3ufIA1eCKRpTIHJDS0VS9ZIjcQxuJhV2nP0EU3P2E5A1RVqaVF5r2PaW+CVooFR
         n5onozuy020oG8S8qbcvbeXRKZZLPvzi26562R2vH6rG5pWKsm5vBgrdx+kcqbBMZwzG
         qFz9UwuQKCfz6nd3h7uJRmBqTuQFGi6IIWpbLLPT95ZX35SGpHBAEvbQdS0U7iVF/m4J
         nmvEXGsPLqazpM+kRGeFT3jq4aES2iDlOyLFWyWhWDa654t63ZMSpWBw1CanhVkMFJpZ
         Gedw==
X-Gm-Message-State: AFqh2kpggXD/qWY5HOgHBnHo7ghZgXPizia/XfJ4MZmSorTkfzd/GyWd
        bWdVe/TPkl9JNAll7QvArJ2YnSPYqym4f9qMp1vhFqF4jU5LBgqC+ibU1ENMAD5YSnO8lzl177p
        JUVmWVVLGOMbNTWNJl3N7hu5K
X-Received: by 2002:a17:906:a290:b0:7ee:1596:4b6 with SMTP id i16-20020a170906a29000b007ee159604b6mr393332ejz.59.1673549034450;
        Thu, 12 Jan 2023 10:43:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsRlj7neXrGXw6dCYS6B4d2fCmsk9AoOi2yIWAldI7LP7ysnCa+1pA5KqHh1T2kqcpHUONGGw==
X-Received: by 2002:a17:906:a290:b0:7ee:1596:4b6 with SMTP id i16-20020a170906a29000b007ee159604b6mr393324ejz.59.1673549034323;
        Thu, 12 Jan 2023 10:43:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b007c073be0127sm7699073ejh.202.2023.01.12.10.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 10:43:53 -0800 (PST)
Message-ID: <4ad4fcf9-06b5-857c-f5a4-3db72b6f0e1a@redhat.com>
Date:   Thu, 12 Jan 2023 19:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/2] simatic-ipc: enable one more board
Content-Language: en-US, nl
To:     Henning Schild <henning.schild@siemens.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221222103720.8546-1-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221222103720.8546-1-henning.schild@siemens.com>
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

Hi,

On 12/22/22 11:37, Henning Schild wrote:
> This series is rather trivial. It renames a few variables to use the
> product names as known by end users and enables the current driver
> to pick up on a board they also work for.

Thank you for your patch series, I've applied this series
to my fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this series in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> 
> Henning Schild (2):
>   platform/x86: simatic-ipc: correct name of a model
>   platform/x86: simatic-ipc: add another model
> 
>  drivers/platform/x86/simatic-ipc.c            | 3 ++-
>  include/linux/platform_data/x86/simatic-ipc.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

