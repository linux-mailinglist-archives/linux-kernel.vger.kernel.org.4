Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D106871F1A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFASUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjFASUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:20:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3036F1A1;
        Thu,  1 Jun 2023 11:20:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685643640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNltx9NDvm+OFNXI1L4w30XEBvloNgIO3y8bVWYDrIM=;
        b=BdVhrvQlOYVHGgHmU7sjV76MXVHPlm6F5z2GWHVOlu6kGKpdOFrMw3ROtpALV4V1iVa7rB
        Yuzws9M/Hm6Z4xtl2jRUzIyCagWemy+W8G7LDvmM0CTFcwoCVNLW3imu5SUSC61ecWutvq
        ih7SLxsWOdMZ/SjFdA196XLzIvcWjYY6DNiuKFfzRMBInSe13ZSriLZef/BKzNYAmoavtp
        nsCOmZTxcIFMu8Fc0Sv/7fMhxrToLBoJiVLYgQvQnm9F0o1+p3jzUqTAyhSLcmH0DTD480
        ai8ngFYungyu7xaS3bZXNdGNmkBVLGH3XYRYGUA597XfgsS84EUbc6uAin8sjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685643640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNltx9NDvm+OFNXI1L4w30XEBvloNgIO3y8bVWYDrIM=;
        b=e8b2hcjpsAod9hIu5JWZDiQuGBbkRWTcJggRVunU9vsqsYDXfYYbO1Qp58L+EVMjX3D1hy
        8ufBpd4dTHzJNtBQ==
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steven Noonan <steven@uplinklabs.net>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
In-Reply-To: <87mt1jeax1.ffs@tglx>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <87mt1jeax1.ffs@tglx>
Date:   Thu, 01 Jun 2023 20:20:39 +0200
Message-ID: <87h6rrdoy0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2023 at 12:26, Thomas Gleixner wrote:
> On Thu, Jun 01 2023 at 13:45, Muhammad Usama Anjum wrote:
>> We are thinking of saving and restoring the timestamp counter at suspend
>> and resume time respectively.

I assume you talk about suspend to disk here, right? Suspend to RAM
definitely does not have the problem at least not on any halfways
contemporary CPU.

>>  In theory it can work on Intel because of
>> TSC_ADJUST register. But it'll never work on AMD until:
>> * AMD supports the same kind of adjust register. (AMD has said that the
>> adjust register cannot be implemented in their firmware. They'll have to
>> add it to their hardware.)
>> * by manual synchronization in kernel (I know you don't like this idea. But
>> there is something Windows is doing to save/restore and sync the TSC)
>
> Synchronizing TSC by writing the TSC MSR is fragile as hell. This has
> been tried so often and never reliably passed all synchronization tests
> on a wide range of systems.
>
> It kinda works on single socket, but not on larger systems.

Here is an example where it falls flat on its nose.

 One of the early Ryzen laptops had a broken BIOS which came up with
 unsynchronized TSCs. I tried to fix that up, but couldn't get it to sync
 on all CPUs because for some stupid reason the TSC write got
 arbritrarily delayed (assumably by SMI/SMM).

 After the vendor fixed the BIOS, I tried again and the problem
 persisted.

 So on such a machine the 'fixup time' mechanism would simply render an
 otherwise perfectly fine TSC unusable for timekeeping.

We asked both Intel and AMD to add TSC_ADJUST probably 15 years
ago. Intel added it with some HSW variants (IIRC) and since SKL all CPUs
have it. I don't know why AMD thought it's not required. That could have
spared a gazillion of bugzilla entries vs. the early Ryzen machines.

Thanks,

        tglx

