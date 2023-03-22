Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107426C4ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCVPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:03:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3619F3B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:03:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t19so8858791qta.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0Btx/EZW0wMrBf1+ilSPw5oV13MN+9GTbuqYu9u0e8=;
        b=LlZC8s70sAWzLPhyS2mcDSA0SfEqaftFmV/7+BRInYOpwRNpfa2WqNVvWHu2H4qpxB
         Vus7Pl5pPg/euWUgeKCUC7spznu+f6svEulYBjL224iYx5XhBDMrJjB7OK8K/9lW0KaV
         mvuqM8zQR7JbOraTZaHpvzeesxBmqN1yXCS6eVRZeB7zst/vYgOU6FtBsLtTnygoxt0r
         ugaVhGjsB94St1HBy1Gy30ZlB7ea1owoVuATlmIkowdyUxm+8p8jUThSv6zWSbXYEtbT
         Nk2jfK9AXQB4a2pZ1LehdJEWNCSpTNo3n45k79JjbJnanuLmJ68t5HEl6gN1PzF5pcW8
         dMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0Btx/EZW0wMrBf1+ilSPw5oV13MN+9GTbuqYu9u0e8=;
        b=iaFxTuufWMnE8GbH8EnwK6JuxbLf7ieHr0Ic5aTyADl51Em70D3e/pHbW5uSidkbAo
         cejnquQjaK6xU2vITfB2CE+KQjEcw17miI/gkPwId5M7FwPsTj5B3HYUO23WnEcnnJqR
         LX49RBJEwes+4FFg3asgXvt5p1eFVKEAul2sqOWjRU9piaGNaLTBw20gma9sZKI9alzU
         hEICqf93eAHQuB6+Ja0whUM2+zJMJR7f/AB25ykMELxXxULfyymPk6C4f6U8/20ycBXM
         PlK5uZeNPXM8D/liJcB3YFttZKxmttBKeGMxlvIKj6kof0SS3IKNks0Vd3t2Efzfyyp5
         dWUA==
X-Gm-Message-State: AO0yUKWpS5oECg4cdKTq5iu2vp8Ha5IhitsyFG5CiKrrfzd0DaIYi6fe
        qWiAqmiIel/Ux1wYYSNHSyM=
X-Google-Smtp-Source: AK7set95BhWfzAOMeamsxcWKmk9PgFGS6XvbDnG+Bu3xj6vx7ROF5ZK2c2AZwo7oQFBwcDXCpy6KPQ==
X-Received: by 2002:ac8:5f0b:0:b0:3bf:c575:3f42 with SMTP id x11-20020ac85f0b000000b003bfc5753f42mr6989678qta.33.1679497405787;
        Wed, 22 Mar 2023 08:03:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020ac84709000000b003e0c94a6af0sm6003774qtp.53.2023.03.22.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:03:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 22 Mar 2023 08:03:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com
Subject: Re: Change of behaviour when console=null and ttynull driver is used
Message-ID: <5728f99f-47af-402a-b477-5645074c1862@roeck-us.net>
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <83c9306a-dbfe-819a-16d8-6242437b2810@roeck-us.net>
 <CABDcavbOXRSh_cjV54CqmwgeJGeDP-rUkerZL5Lj73ax67Q9LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABDcavbOXRSh_cjV54CqmwgeJGeDP-rUkerZL5Lj73ax67Q9LQ@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:23:28AM +0100, Guillermo Rodriguez Garcia wrote:
> El jue, 16 mar 2023 a las 14:40, Guenter Roeck (<linux@roeck-us.net>) escribió:
> >
> > On 3/16/23 03:29, Guillermo Rodriguez Garcia wrote:
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
> > > Is there a way to get the previous behaviour? If not, is there an easy
> > > way for userspace to detect whether the console device is a "real" tty
> > > or ttynull (other than trying to parse the kernel boot args, which
> > > would be a bit fragile).
> > >
> > > Thank you,
> > >
> > > (If possible, please CC me in any replies)
> > >
> > >   [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
> > >
> >
> > Let me know if/when you find a solution. In ChromeOS we have to carry
> > reverts of commit 48021f981308 ("printk: handle blank console arguments
> > passed in.") and commit 3cffa06aeef7 ("printk/console: Allow to disable
> > console output by using console="" or console=null") to handle the
> > same problem (the above mentioned commit didn't work and had odd side
> > effects).
> 
> The kernel seems to specifically check for "" (empty string) or "null"
> and in this case uses the ttynull driver. But apparently we can use
> any other invalid string (e.g "invalid") to get the previous behaviour
> (no console).
> 
> I am still checking if this has other side effects.
> 

Interesting. I'll check if that works for ChromeOS; that would be better
than having to carry the reverts.

Thanks,
Guenter

> Best regards,
> 
> Guillermo Rodriguez Garcia
> guille.rodriguez@gmail.com
