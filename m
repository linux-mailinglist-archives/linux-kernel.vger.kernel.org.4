Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373086F252F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjD2PVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjD2PVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 11:21:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9261FD4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:21:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so18697510b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682781693; x=1685373693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmsvoBssuGlSdWTHgKQYGOqn5idl8k0x6DdrMQvHWIk=;
        b=FUe41iHQuPlOIrKHcccQMMOUtRp/B2Wl+Od97hCj+L2XvAQ8qSx2yIIQW2MEFnjoOR
         ZuLErw+8AabGYu7rFWMySA14illmvKu4+fNJSJk/zPnJO19qPFTpXGXJer+x3XPQ3uYN
         RLStoS5CSJqPaRAPx1g7iszvxzhvteUYDGrfOF1I3oQa5Y+Fgm/D3AmhM+MzQTa0Y4/O
         YGUMDJeuoIszlROXkpzxI6GjAggd0TIu/LOttoK/Bgj2Rzy4YjhSgKNoCK+JhkFkmC+R
         n3QIvsIgBW3IpNMGJ6BxFZLaKBBQ9d2jEg9ZrZ6UMSwuxgKVbQknknDL+x+9EttXRRZv
         Xt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682781693; x=1685373693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmsvoBssuGlSdWTHgKQYGOqn5idl8k0x6DdrMQvHWIk=;
        b=X9Z5Ao7yT3fMmpSAuOCfGh5MBUgX0vH8cd6FPW6gYo/0rxXpFh7HFD/DedP+ziKiD9
         /4Fc5iDIVkD3SJ8iz1NCRDHotDXJAj6zAYPVgKGRJ7n5OA9z8LMoWemG/NkcNCCIGUYi
         DzpLi23L73Oghry5OcMJpBYHQejf6+o3hbtzIwN/6Cn72vCGed+53b4T+hOK9iA6N9uH
         hCMreD6c5mj9eGcBE8GXsoHQgocRIuYmok41ElBOBR9w1L35HevayMDGav8uV1rraZN/
         cIrRMTAXt5200QW8klD9OIXxjWOjCLkYCqnVa46BPW9h0Q9xwr4hTP+6NZEebxo21o0+
         NWrA==
X-Gm-Message-State: AC+VfDyoZ6UPzO5J1z1RZf6K3lyTQonT7Tg+G7pv1xW0vdatD2NS9Jq4
        Me56pgY1ZFAzbSXIRI9ob3I=
X-Google-Smtp-Source: ACHHUZ7AS5UuL6UnudBL3M9IGlyfEFzOd5tmp1u0Ch5/7eRuMkcmkbIQdVyTQtj8AdnBQ27veg8alg==
X-Received: by 2002:a17:903:230f:b0:1a9:80a0:47ef with SMTP id d15-20020a170903230f00b001a980a047efmr15984118plh.20.1682781693075;
        Sat, 29 Apr 2023 08:21:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001a194df5a58sm15080945pli.167.2023.04.29.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 08:21:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 29 Apr 2023 08:21:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: tty_io: remove hung_up_tty_fops
Message-ID: <58974d54-9e02-4800-814f-9206c3cfcc95@roeck-us.net>
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <20230428162718.GA1099174@dev-arch.thelio-3990X>
 <6dca757e-74ac-773d-2a50-4e48b2f56880@I-love.SAKURA.ne.jp>
 <2023042859-kosher-specimen-9a0f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023042859-kosher-specimen-9a0f@gregkh>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 07:31:35PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 29, 2023 at 01:41:02AM +0900, Tetsuo Handa wrote:
> > On 2023/04/29 1:27, Nathan Chancellor wrote:
> > > I see this change has shown up in -next as commit 4c87e9e5479b ("tty:
> > > tty_io: remove hung_up_tty_fops"), where it causes the following warning
> > > for configurations without CONFIG_COMPAT (I used ARCH=arm defconfig):
> > > 
> > >   drivers/tty/tty_io.c:446:13: warning: 'hung_up_tty_compat_ioctl' defined but not used [-Wunused-function]
> > >     446 | static long hung_up_tty_compat_ioctl(struct file *file,
> > >         |             ^~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > I am not sure if you just added that patch for additional test coverage
> > > or for final acceptance but the following diff resolves this warning for
> > > me, perhaps it can be folded in for a v2?
> > 
> > Thank you for reporting. Yes, moving the definition will solve the warning.
> > 
> > I'm testing this patch using my volatile tree before getting merged to a
> > permanent tree.
> 
> How are you adding new stuff to linux-next right now when the tree
> should be "closed"?  And I haven't reviewed this yet, what tree has

That happens all the time, and quite often the "late" additions are applied
to mainline immediately afterwards and end up causing problems there.
I can only hope that this won't happen with this one.

> picked it up?
> 
> Please wait until after -rc1 is out for new stuff, you know this...
> 

This patch is supposed to fix a data race, so maybe it wasn't considered
"new". Just guessing, of course.

Guenter
