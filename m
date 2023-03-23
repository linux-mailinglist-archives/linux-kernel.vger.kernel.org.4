Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB286C622F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCWIrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCWIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:47:30 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2ABD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:47:28 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x6so2944287ile.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679561247;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw3ZQAxjNdASizR+OYS7EtovhtSucsPRdDKQ/E9foLg=;
        b=GRWSDdCm9yKOK0bqoYMwuKK1+ptFDM0yuhrK/3OQfNEqA6U7MdIn39AyZgmx907tQC
         8VAhvKMNe+polZfYfzU9oQRBiKK0IxdXvU3UuG+Pz/fnlorrwSpakukzLEbuCK9Xp9ag
         WQstUZm+AFgqeXo2vgd86Xq6RuJgrz29BBNRQGilzWdb3NPLyxV5Dql4A0rNCpjvmFWp
         yb4c/slpw81QyFFRxxGo+U8PIUYyzkriggJNIKbaF6wfHUG/O1rKd2H/9rxsxveIzGhR
         1jUeZ7Y8V1JoeNge3uiTEGZ7YCGmGAcYkTqodfojYaVIjhGX8v3THqEG0/jcwS9Ty+yK
         T8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679561247;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw3ZQAxjNdASizR+OYS7EtovhtSucsPRdDKQ/E9foLg=;
        b=JJ0cGX5VrvbmKHeSQFzERfMUw4avNbp0Jvo2iwZBcg3ObxUpqUXonT/7ngJ23/lWYM
         t8sKZQTMUy2k7FVsao5+0EXyDLYiUwKIrNAck6bbpqp4FMV3ypPv6f77x6HGLsx6Vh6d
         mAMA+SEck8X/mMSc6IYAz0l0zpZBUnpHOjCAaRWJqebLR/LanQvQGcErBNGoS1qWq4+r
         5RLbFPILNbCIxX5ppTJ2DbvCRXLBc7KtMwkonC+2K//NA7PShN0aEa4zjOGqWLfUauWp
         69Bz3NXplSwyYD1ybLGeRmt+hy7UpVk0SMkDmVOPN983AW0kSu27qIRqfCu71ntuecWn
         KFqQ==
X-Gm-Message-State: AO0yUKUdTvAY1Tk/7YSHGTlOVrtkxuLfM9W1gU2kO3gSkxYfXazCm15n
        HpwWmWZ9X3f+V6apYr5AzuCBlSiFZWx5IQ==
X-Google-Smtp-Source: AK7set88q3i2JrwNmfiOYoV9tVwhzBWa2jSD3MTRpcNom5H1LLefaQB8TxFtSxigTTch0v5xQWz6Eg==
X-Received: by 2002:a92:d98a:0:b0:325:b002:89b4 with SMTP id r10-20020a92d98a000000b00325b00289b4mr5390126iln.25.1679561247448;
        Thu, 23 Mar 2023 01:47:27 -0700 (PDT)
Received: from MBP (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id j189-20020a0263c6000000b0039deb26853csm5915306jac.10.2023.03.23.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 01:47:27 -0700 (PDT)
References: <20230303161906.831686-1-schspa@gmail.com>
 <20230303161906.831686-2-schspa@gmail.com> <m2sfdwnoi8.fsf@gmail.com>
 <87h6ub9a4w.ffs@tglx>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] debugobject: add unit test for static debug object
Date:   Thu, 23 Mar 2023 16:44:21 +0800
In-reply-to: <87h6ub9a4w.ffs@tglx>
Message-ID: <m2a603onvq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, Mar 23 2023 at 11:16, Schspa Shi wrote:
>> Schspa Shi <schspa@gmail.com> writes:
>>>  MAINTAINERS                    |   5 ++
>>>  lib/Kconfig.debug              |  14 ++++
>>>  lib/Makefile                   |   2 +
>>>  lib/test_static_debug_object.c | 125 +++++++++++++++++++++++++++++++++
>>>  4 files changed, 146 insertions(+)
>>>  create mode 100644 lib/test_static_debug_object.c
>>
>> What do you think about this test case? Should we need it ? There are
>> some platform compatibility issues here that need a little optimization.
>
> What does it buy over the existing self test. Nothing AFACIT aside of
> extra code.
>

It checks the race of the is_static_object() call in the previous
BUG. This test can used to make sure the new fix patch works. The
existing self test have no ability to check this.

> Thanks,
>
>         tglx


-- 
BRs
Schspa Shi
