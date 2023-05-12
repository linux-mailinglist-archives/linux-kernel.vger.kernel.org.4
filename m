Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A9700726
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjELLsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjELLr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:47:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AD510E64;
        Fri, 12 May 2023 04:47:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so49714765e9.3;
        Fri, 12 May 2023 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683892076; x=1686484076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXEuubAD2ylpSm0XW/VsQ5NAN84WtuZdifOUHdM1vXM=;
        b=NGCMMwvEgTQEr/PZ3lmzvsbRiLFqnHTE2CaLQCrCowLA7XiADoYbo1OnVBWu7Jtqex
         qyICyXNmWK8es7afwlwrz7ERydFjFUiqNQrALHNKhCDgLbH/1Z1fK7oP2SFJuwgRMuCb
         bTil47oh3tNtdLHeLw4Kg5pezp2K/vPCpHsSGQJh48EOeFeBGpghDu2dxmC71FVLGQLc
         11bsQN2QcdOKN3H3OXNh8K+vwH1+fqrg9pB2HyycLFSy8Gg7YVuu+I0k4qkW6e1QpQB8
         Q+NxgqYpN3b8zvzBU4p8pXhm4SqKjclfnOv3wk93SRrBAq+vBWfnTjoPiE55jDgb9sDV
         Bt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683892076; x=1686484076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXEuubAD2ylpSm0XW/VsQ5NAN84WtuZdifOUHdM1vXM=;
        b=ZUNe5+KARZ15a6sLDQHoWFiAN7OR6nGSw9/1PE7pQjpshhgiFrwzstmpBPgfBJZnRJ
         NE+X/wKiY8slWQEmRmwElzw39QWrFKBzMpsnAuOejorqS5xman93jh9LgccDOaE6T94N
         R7Pahna2mML/4es49Ipp9R5SVrUQlJdazZRaJV1Y2jWtY8rLPv8hayYAr4L5+5wsNEm7
         G/jVIncBNTUspwsgk8BaGAp7R1hSlb8PVFbEYdRUjpUbHADLOcMHMQe7uYt9Pw2c7R0x
         QnxqKVF7UozNHoPu8PemX4Lq9qEPi11qt6ANErik83TPZhKPsVYIyVBKcilOcu9mFomk
         vJ5A==
X-Gm-Message-State: AC+VfDwpICVHSvy74R0Q9Bs6njC0dcivngPxBG5/QOrUI6n/M96NPstw
        U3LXDMG/7Be1nLYopQ22Mck=
X-Google-Smtp-Source: ACHHUZ60B+ieNe1nULKJ2MvCtbcPC+kY67aa2GuVMFH7ZEYDEXVQ/7Va92r6yyDcsLYeEuXdnOSI6w==
X-Received: by 2002:a7b:c7d7:0:b0:3f4:286f:1d99 with SMTP id z23-20020a7bc7d7000000b003f4286f1d99mr9904164wmk.32.1683892075342;
        Fri, 12 May 2023 04:47:55 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id y5-20020a1c4b05000000b003f429d59e37sm11260987wma.34.2023.05.12.04.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:47:54 -0700 (PDT)
Date:   Fri, 12 May 2023 13:47:45 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pjones@redhat.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Cannot boot an i386-UEFI thinkpad lenovo tablet-2
Message-ID: <ZF4nYQT31qDH_9qb@Red>
References: <ZFnoXiZGGhuWDl2S@Red>
 <af88a590-e20a-0669-c0d8-e073cc6e109f@intel.com>
 <ZFqvCeNxKJDOYDaT@Red>
 <055b41e9-b345-03fe-755c-cdcb08e4098b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <055b41e9-b345-03fe-755c-cdcb08e4098b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, May 09, 2023 at 01:48:26PM -0700, Dave Hansen a écrit :
> On 5/9/23 13:37, Corentin Labbe wrote:
> > Le Tue, May 09, 2023 at 07:01:02AM -0700, Dave Hansen a écrit :
> >> On 5/8/23 23:29, Corentin Labbe wrote:
> >>> The tablet has only one port, so I use a hub for keyboard and USB key.
> >>> Immediatly after booting Linux, all hub port light goes to off.
> >> If it's dying in the installer, can you boot it to a shell or rescue
> >> media?  Are you getting any kernel messages on the screen before the
> >> installer?
> >>
> > Sorry my sentence was not precise ("after booting linux"),
> > 
> > It die after pressing enter on grub menu.
> > No kernel message, nothing new on screen.
> > Only visible change are USB light off.
> > 
> > I have really no clue.
> 
> A lot of distros set the 'quiet' option to _keep_ the kernel from
> spewing messages at boot.  Ubuntu sets "quiet splash", for instance.
> 
> Going into the grub menu and killing the 'quiet' and replacing it with
> 'debug' is a good place to start.  earlyprintk=vga can also help if
> things are still blank at that point.  I thought we used to have an
> earlyprintk=efi, but it seems to have vanished at some point.
> 
> But, you've got a bit of oddball hardware.  It's from the _far_ extreme
> end of 32-bit-only hardware.  The fact that it had Windows on it isn't a
> great sign.  There could be a BIOS bug that trips Linux up but Windows
> is perfectly happy with.  There was definitely a sad period of time
> where folks were not interested in fixing issues like that.

Thanks for your hints.
I have already disabled quiet and unfortunatly, none of earlyprintk= changed anything.
