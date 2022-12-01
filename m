Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5545563F218
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLAN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiLAN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:56:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA97D5C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669902907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q2BKkuspfzaEs1qSoUtOA7ZZ4a78lTB3KCur/PIqHwE=;
        b=P7rWLEB01Foc35zTqCKrqWG//bpw3GbF13LzH4yUw6DSbOdXR049c6rVnz14o1TBqHj9ZK
        H+jD1rQBMwE/lOCORAOjROpWJemxopuzlAdsukyzK5G8tKlUwkwu32i2ozcyXKvYsJ92b7
        GjMXtUQhEZOJ0mlVJVFfwyvvlh2DIj4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-uvTgkqgGNy-cbW4Qkr4twg-1; Thu, 01 Dec 2022 08:55:04 -0500
X-MC-Unique: uvTgkqgGNy-cbW4Qkr4twg-1
Received: by mail-io1-f70.google.com with SMTP id e12-20020a056602044c00b006dfbda66242so1604923iov.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2BKkuspfzaEs1qSoUtOA7ZZ4a78lTB3KCur/PIqHwE=;
        b=WUcVuJ4lYge+UJTxJikD/xuQUVBdFW0eybuyU/x+QSiG3J81bxHC15xyT+Ek4cCqWr
         7YVAViP1UAHrK5sGv7y7tQREmGsVfbV2CpaLzBHvoMzkzGvN60WOrVp/RaMcKSrjVhhn
         tRs5OtpIe5TUnTgmLmS1Gasld7x2DC/KbgkkBFyKSD2RTkNtP80y9D27NPnxsEY1FRg4
         FQLqiTbjm6QEpdDL5IGKXlb1MCBQt1Fkl2ZPkaMDb3+18mTgSp35n26yvMNBSdZev9Qx
         4Wt6QvBCBgMx9AIGXmvXzl6Wz9fOe3zH48IiTwCqdTQOT4/cOzk3CI98Xrix73mz9e+c
         52lA==
X-Gm-Message-State: ANoB5plgwVtlEXuMUi/mVUoAUVXVEXq+hmc0sXd7084lZNfNdPY8x1So
        J5nvckDknAjG9xQGs3xdBjk/7MmqPfTqyI4eIvU1jE9M23IqL/Zk41LnUu4O0BzzkpEx+7dOvmX
        92In3lqcFHd0jpc8dxMi8+O9q
X-Received: by 2002:a02:6202:0:b0:376:91d:b188 with SMTP id d2-20020a026202000000b00376091db188mr31354398jac.49.1669902903769;
        Thu, 01 Dec 2022 05:55:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6f+zMmFejFa7H5SbKq8y0kuY/dgAPTlCDteiRUq7+DZpnAX8KlbGN1sO5K3anDocH/3wHXpQ==
X-Received: by 2002:a02:6202:0:b0:376:91d:b188 with SMTP id d2-20020a026202000000b00376091db188mr31354383jac.49.1669902903504;
        Thu, 01 Dec 2022 05:55:03 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id l6-20020a05660227c600b006cfdf33825asm1652098ios.41.2022.12.01.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:55:03 -0800 (PST)
Date:   Thu, 1 Dec 2022 08:55:01 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        cth451@gmail.com
Subject: Re: [EXT] Re: [PATCH] net: atlantic: fix check for invalid ethernet
 addresses
Message-ID: <Y4iyNRhkFmG/Avco@x1>
References: <20221130174259.1591567-1-bmasney@redhat.com>
 <Y4ex6WqiY8IdwfHe@lunn.ch>
 <Y4fGORYQRfYTabH1@x1>
 <Y4fMBl6sv+SUyt9Z@lunn.ch>
 <7ed83813-0df4-b6ac-f1d2-a28d8011b1aa@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed83813-0df4-b6ac-f1d2-a28d8011b1aa@marvell.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 09:07:49AM +0100, Igor Russkikh wrote:
> 
> >> That won't work for this board since that function only checks that the
> >> MAC "is not 00:00:00:00:00:00, is not a multicast address, and is not
> >> FF:FF:FF:FF:FF:FF." The MAC address that we get on all of our boards is
> >> 00:17:b6:00:00:00.
> > 
> > Which is a valid MAC address. So i don't see why the kernel should
> > reject it and use a random one.
> > 
> > Maybe you should talk to Marvell about how you can program the
> > e-fuses. You can then use MAC addresses from A8-97-DC etc.
> 
> Hi Brian,
> 
> I do completely agree with Andrew. Thats not a fix to be made in
> linux kernel.
> 
> The boards you get have zero efuse. You should work with Qualcomm on
> how to update mac addresses of your boards.

OK, I'll work to track down someone within Qualcomm that can help us
program the MAC address into the boards that we have. In the mean time,
we'll go with the systemd unit approach to set a MAC address.

Thank you all!

Brian

