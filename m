Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC4B61A416
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiKDWaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKDWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:30:33 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADFD27164;
        Fri,  4 Nov 2022 15:30:31 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 67E9838F;
        Fri,  4 Nov 2022 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667601031;
        bh=t9edONL7MFXhONo2kSUCFiMSRmYtcZj62ERNPZl82rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrWv5aCJPYyfOba0TRAlDRJHcmQQQGlCDnQBQiW9SyofDfXFC2n87+EqMvXtYCewR
         QLy4usK4VKXt0jp0mnqQIhgrRqOAkYi/6RuulUYoogQDa9FHMa9RhHOWng2Z9BL6nL
         EG6hujDEibcFNbjXHdAulipQS9dy6Ul5636F6Rb4=
Date:   Fri, 4 Nov 2022 15:30:30 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 1/1] hwmon: (pmbus) Add regulator supply into macro
Message-ID: <Y2WShmSmnEjpgVEE@hatter.bewilderbeest.net>
References: <cover.1645437439.git.sylv@sylv.io>
 <58f2ff7b90233fad3d7ae2e9d66d5192e2c1ac01.1645437439.git.sylv@sylv.io>
 <20220222165104.GA255067@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220222165104.GA255067@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:51:04AM PST, Guenter Roeck wrote:
>On Mon, Feb 21, 2022 at 12:09:56PM +0100, Marcello Sylvester Bauer wrote:
>> Add regulator supply into PWBUS_REGULATOR macro. This makes it optional
>> to define a vin-supply in DT. Not defining a supply will add a dummy
>> regulator supply instead and only cause the following debug output:
>>
>> ```
>> Looking up vin-supply property in node [...] failed
>> ```
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>
>Applied to hwmon-next. That should give it some time to mature,
>and we can pull or modify it if it causes any problems.
>

Wish I'd caught this sooner, but unfortunately I've just discovered that 
this does in fact cause breakage on my systems -- having regulator-dummy 
set as a supply on my PMBus regulators (instead of having them as their 
own top-level regulators without an upstream supply) leads to 
enable-count underflow errors when disabling them:

     # echo 0 > /sys/bus/platform/devices/efuse01/state
     [  906.094477] regulator-dummy: Underflow of regulator enable count
     [  906.100563] Failed to disable vout: -EINVAL
     [  136.992676] reg-userspace-consumer efuse01: Failed to configure state: -22

A simple revert solves the problem for me, but since I'm honestly a 
little unclear on the intent of the patch itself I'm not sure what a 
revert might break and hence I don't know if that's necessarily the 
right fix.  Marcello (or others), any thoughts?


Thanks,
Zev

