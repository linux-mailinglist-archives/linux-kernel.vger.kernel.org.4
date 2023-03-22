Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775656C4EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCVPFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCVPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:05:31 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343F64865
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:05:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id n2so23013467qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rB368t/nydD6WH/cMLlFJuGK99aN+ScRI5LJ5IOVeo=;
        b=Jb3zISwQhXBZzizyXFBukl8CpUrXx2BxGv9Su1VoGLxyTy2CzHGtf+OrIN+URu+Ocs
         ljNm1pgdKQQrolTiTR8P2jTPNlEBfxg8mpWANm2OeYCKoviI2cIuJVHedg/CEpmvyIG0
         GirxCLiUPA37H8NNnr+VC4a0IspzpjLtYpz+N+dXIg7Zrp9PyYwb70DF9GCPCEV1Kwas
         l5aoK7wo3MqFXCMVBl/4jYFKbTt9VL9hiLCHXs4LGTL8UIIlqyfYbG8bvt/gK4yEzx9Q
         JARrGDm8nNNmfKgrvhb0uvnXyPPzADMoniy0GJX7wvJ5G8+8QYUoqj+3R9SAnnx0UC4D
         20Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rB368t/nydD6WH/cMLlFJuGK99aN+ScRI5LJ5IOVeo=;
        b=oJh+nR56BH7yk84yL2PjkY5fspeEt/iBqCH9cg/9d7fxgkZ8hH73eN5wfLFR3phcs5
         5HgOb8iAUPU80FZx6bFTLnlMjjoyArmrNm60ZxmeoCDCfxDH9IzyVUq/gWM7oFQFOMj+
         50OuA++2u4Xa6ado6yyOL/OrlVmV1fQX1mSWPSvLrRakVQiB7YizLibBuv0ErazLbOXS
         6XTAPk+MabU8HonydopDObJXzTqX2YF/+a0yl+F/aaOkK1QOHQhHPdiTnrPTLTBqolz1
         +5UpEfMZIPkbXPr7mK2RETcHxh69d2YA+5Sv3/BlB0CjSgif3NfiaEifzgzKOGKds1Fy
         ryfA==
X-Gm-Message-State: AO0yUKUTr37A4aUgM8epaOJ53xK/dijfrvuvt7NXw6jzZlBY0mnW2Ws3
        X4Br8n639SRWtva7eZMUXAQ=
X-Google-Smtp-Source: AK7set+Tq8viTsA6biPlL35ZSG9Q2o3MW/I++pB5GfUje3apGWK6xwxoit8t07UsoWNw6sMFmgP+Ig==
X-Received: by 2002:ac8:574c:0:b0:3e2:78f0:d27b with SMTP id 12-20020ac8574c000000b003e278f0d27bmr6251924qtx.60.1679497529472;
        Wed, 22 Mar 2023 08:05:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d184-20020a3768c1000000b0074688c36facsm5992743qkc.56.2023.03.22.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:05:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 22 Mar 2023 08:05:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com
Subject: Re: Change of behaviour when console=null and ttynull driver is used
Message-ID: <755a8541-adf5-4454-9bd5-9ea439a5a4ea@roeck-us.net>
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <ZBRiRu7hlwxSKHBg@alley>
 <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:33:32AM +0100, Guillermo Rodriguez Garcia wrote:
> Hi Petr,
> 
> El vie, 17 mar 2023 a las 13:51, Petr Mladek (<pmladek@suse.com>) escribió:
> >
> > On Thu 2023-03-16 11:29:26, Guillermo Rodriguez Garcia wrote:
> > > Hi all,
> > >
> > > We have several embedded systems where pass console= or console=null
> > > in production to disable the console.
> > >
> > > Later we check for this in user space: in our inittab we check if fd0
> > > is "associated with a terminal" (test -t 0); if so, we are in
> > > development mode and we open a debug shell; otherwise (console
> > > disabled) we just start the application.
> > >
> > > Recently [1] this behaviour has changed and now if we pass console= or
> > > console=null, the new ttynull driver is used. This breaks the check we
> > > were doing (test -t 0 always true now).
> > >
> > > [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
> >
> > This is actually exactly the problem that the change tried to solve.
> > Some systems failed to boot when there was no console and they tried
> > to write something at stdout.
> 
> Well, I did not have any problem before this change.
> 
> I understand that some systems had a problem (many others didn't, and
> setting console= or console=null has been standard practice for a long
> time). Since this change in behaviour could (and did) break things in
> user space, perhaps it should have been made opt-in...
> 
> >
> > > Is there a way to get the previous behaviour? If not, is there an easy
> > > way for userspace to detect whether the console device is a "real" tty
> > > or ttynull (other than trying to parse the kernel boot args, which
> > > would be a bit fragile).
> >
> > A solution would be to check that /proc/consoles has ttynull as the
> > only registred console, for example:
> >
> > grep -q ttynull /proc/consoles && test `cat /proc/consoles | wc -l` -eq 1
> >
> > Would this work for you, please?
> 
> I was trying to avoid something like this as it feels like userspace
> now needs to have too much knowledge of what the kernel is doing
> internally, however I guess this is the best option.
> 
> The suggested check seems to work but now I am seeing a different
> (related?) issue: when I try to reboot from the console (using
> busybox's reboot command), the system reboots normally if I am using a
> "normal" console (e.g. console=ttyXXX), however when using
> console=ttynull, the command takes 20-25 seconds to complete. I am not
> sure why this would happen; if I understand correctly, for userspace
> ttynull is just like a regular tty driver, so why would there be a
> difference?
> 

I think we may have seen something similar, causing us to revert the
upstream patches in ChromeOS. We did not try to find out what exactly
caused the problems.

Guenter
