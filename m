Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452E76C5D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCWDQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCWDQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:16:36 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C792F04B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:16:36 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h11so10951894ild.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679541395;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4ANTevdvrdXUlaIGqmAv9gYDUg3WsO2URDMeMh1u6M=;
        b=Y+SR3cZTAEHHNf4hc0P+zMrnmAY+jfz8X0hzIdnI4gdY8fsPT8oWJMkMlBPg2pi68h
         z0L94HghgWyun1N6+nPvsVxwQhWSaCRU1NuT4jIYP5yxkdZ+XkGqDhEtVz33zsDCV5VH
         Ol42btU+2Pl3BAFN56ctQyX2d1g5i9qi+7QmzlQ7m066YIG4VMyc4Q8C9dS+8okUlCpY
         ow77jCmSaoPQoY8toHS2ka1dc5DOwa0pjWLkZ6ePa2E4aivfOmuF1YbZ10xGS5a+UIlo
         p4LkpoYK9/Q8DDkADDNI5tQt5f1RR2mRmLHWWTwJw0L0jqGqV5ZWaD3/KsduMaeRgUZc
         SQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679541395;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4ANTevdvrdXUlaIGqmAv9gYDUg3WsO2URDMeMh1u6M=;
        b=hY1GP8t+JqTliDgC7HUvu6ny/A/DC4ZIPgBRZPNm6MFuW0yHLAPBJgBB3Pz74wKaMm
         3/dTmtPofN438wRCmWGCUIvUAWIfHHKDi2EFOsKhMdFG1+t4gDbCL02rcNvha4qtYrCl
         Pex4bFyf1BKyvUg/LjiAbgK6b3VYQtOTitctXRDETgwOuOdrYew5Q1kr+J010riomfo+
         YukKn9Gsu3RXy5kvUq+PuM+HrB+Fmr77VLWLNBUI8FcrQL/MD9RlMMAJqdob2VyrCgMG
         BW88ongRJ9gvLLTE33ItByFnva8FwxX5wqUwX+pxTfkPMeoMDlPBL2bkAheP4Km9zHEM
         2PMg==
X-Gm-Message-State: AO0yUKXqqVHxPzeXk8SYLFxekUgt9ip+3InJr+yjbjwsrISigbWvXuxm
        kCE1Fi/GayYhWj9csHPovjA=
X-Google-Smtp-Source: AK7set9T8MAi4dTw/odKryrjs/xnjPXj8aO+cFKcDimoqk63klzk9AqIuLaSpi70NduVNov3vlerGA==
X-Received: by 2002:a92:ca8c:0:b0:323:338:cc2c with SMTP id t12-20020a92ca8c000000b003230338cc2cmr5122769ilo.22.1679541395506;
        Wed, 22 Mar 2023 20:16:35 -0700 (PDT)
Received: from MBP (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id y3-20020a929503000000b00315972e90a2sm4831044ilh.64.2023.03.22.20.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 20:16:35 -0700 (PDT)
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com> <87sfdw8yru.ffs@tglx>
 <m2r0tgmze9.fsf@gmail.com> <87mt448p0e.ffs@tglx>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
Date:   Thu, 23 Mar 2023 11:10:29 +0800
In-reply-to: <87mt448p0e.ffs@tglx>
Message-ID: <m2zg84nomr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On Thu, Mar 23 2023 at 01:55, Schspa Shi wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> Which requirement? The is_static_object() call takes the address of the
>>> actual object and has nothing to do with the tracking object at all.
>>>
>>
>> This is for the fellowing test case, actually we calls
>> debug_object_free() from a static object in our selftest, if we don't
>> report any thing when call debug_object_free from a static object, we
>> there is no such issues.
>
> That's an artifical and completely pointless test case. As I told you
> before the memory subsystem will warn when it's tried to free a static
> object. debug_objects_free() is invoked from the memory subsystem *free*
> functions.
>
> What is the value of another warning?
>
> Nothing at all.
>
> So why would we add extra code just to keep track of something
> completely redundant?
>

OK, there is really no need to do this extra check. And should I
submit a new patch version with your change =F0=9F=98=83?

> Thanks,
>
>         tglx


--=20
BRs
Schspa Shi
