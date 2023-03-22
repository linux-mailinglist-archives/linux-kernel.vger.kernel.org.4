Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5126C527B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCVRcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCVRcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:32:31 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D63A5A1B0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:32:30 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id x2so1759757vss.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679506349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZOSOo/wFtyltX/eswYULH+hN/Oi2WaK2A4o5DDLI7c=;
        b=ksv5HVJQuWJjwP9EGqGCRj0xp2ku2Fdcd1pinrlC5N/yriKKn5LaXTkjL7esHxcQ2C
         P7NmuR3Z+4WaEc2SWkCvVJjVsZkT5e6qpuinefPUKRjeVVA+AlDglh8goeYBjgESBiYf
         uKTzK0ypuLrdrbdTdRYzVTNOR9l4NCnda8Roc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZOSOo/wFtyltX/eswYULH+hN/Oi2WaK2A4o5DDLI7c=;
        b=Jp1gTneUjj+7Bmi079aBvrhukyPwzeVeUoDpn5FI2Puaag/Fiq1UbPpe2AVo03j9vu
         0oTHuBEw3Vp3vT7TuXYYUAdlffQgUuCrKm7bKJKd58l7yrw4CPzBCD2lVApS9c0Bwl8J
         +zY/h5uZ3viSuJ6cVrpFxbim1AD6GCXPSt2KsSunkEcDQmVLYPOjqcob+F7KYurExjSs
         NW3v5PZzLz5PJ1XieoatE7S+YkX5bUPAcA+ONH4V3gPRc1qvgQ3RJLqW9CoIfajCxYz9
         nI6OeZAkTrlU1jleGHBYrnsS7G5UGIDjJ48VtVrIdfC4uJdo12j7T5c3pu7QygwQSWZn
         fzhw==
X-Gm-Message-State: AO0yUKUFI5cBtFRIDaV6Z5lmcVVeyvDFrwmY7/W1yIZ0iYer6WP8nisx
        2O+rn64XzyJbR4rhL48/MympxHReqXILYXf27TUADw==
X-Google-Smtp-Source: AK7set8wOK9GFMrgIhi2HWlH2N3N14Glxkdpjg7VA4KlNIgfBG4tEza8mrfXsF7sJozXFCS021xanpgz7psDffZl0as=
X-Received: by 2002:a67:c108:0:b0:416:f1ea:1001 with SMTP id
 d8-20020a67c108000000b00416f1ea1001mr122085vsj.5.1679506349520; Wed, 22 Mar
 2023 10:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230321212822.5714-1-mario.limonciello@amd.com>
 <20230321212822.5714-4-mario.limonciello@amd.com> <CANg-bXANgkrF4T4X_VgeVejA2wH3GrUiFORyRC4AZfgYrE+7DQ@mail.gmail.com>
 <a9993ba0-ddfb-5ed3-c997-e9eea797cfc3@amd.com>
In-Reply-To: <a9993ba0-ddfb-5ed3-c997-e9eea797cfc3@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Wed, 22 Mar 2023 11:32:18 -0600
Message-ID: <CANg-bXCWTM6EMZ_4=B1Phv3DbR8ctXnak1da64j=yji3F2YU-g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] i2c: designware: Add doorbell support for Mendocino
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Grzegorz Bernacki <gjb@semihalf.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>, Held Felix <Felix.Held@amd.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So either psp_send_platform_access_msg should return 0 for that case
> (expecting caller to investigate more closely) or psp_send_check_i2c_req
> needs to special case -EIO for more investigation.
>
> I lean upon the latter unless you have a strong opinion.

I'm ok with either, but if you go with the latter, the documentation
will need to be updated in psp_send_check_i2c_req as it states that
-EIO is used for basic mailbox comm errors.

> I would expect ToT should run fine on Skyrim.  I'll adjust as you suggested
> if you can please test it.

Sure! I can test the next version you send out.
