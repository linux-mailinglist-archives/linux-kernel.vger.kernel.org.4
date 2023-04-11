Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A146DE5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjDKU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDKU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:29:56 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F703584;
        Tue, 11 Apr 2023 13:29:55 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so8193463pji.1;
        Tue, 11 Apr 2023 13:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681244995; x=1683836995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5UCA+tE3Fq8HXbLn+U+wd27dVODbtTngBjwQ/9PBX0=;
        b=5OoppjsE8o5YGTz5s4twBQSF0GehzVLLUVynqrJj/xzjP8Crws6gI9fEVbZgBg27z2
         rptjMxhn52iQWcafD2ojxWezSKYR5bgug/yK39IqRRzhbrLO56SPPsU38oxppo4BF+mF
         GF7jwZlZTWIdTu7CwF5sHhlAog7KirSItpxwo3GBfuwlAukWAMqdRW0S2LGfp+Ogw+/Z
         it4Ax2h2dniuXm7bMvDpJT2V2LzATVt95WK6DvnXJd04rpd6nsWZMdeqCVk7LIFKfdfT
         TtIBevwik4yWsDqefonx7FFzeANsu0HnCQ+dfpghlPm7II/vG54gWrXzAtDlNVJL0Ht2
         HXFQ==
X-Gm-Message-State: AAQBX9d7QxoRWHiCcq8xOfQ1xBU7kQIPfFtZw7uxcWlNdWc4Skl5Nrbx
        JGLYm+7eIhyw+ALq9vDzxix076JWE5B2rg==
X-Google-Smtp-Source: AKy350ZI+I0EfD8cuUXNEOSBQ+pnMgX7tS3cLWevur0lEL9UKgU+NGS7ChmKBKPSlWOhtqgqK9m52A==
X-Received: by 2002:a17:90b:3b44:b0:237:62f7:3106 with SMTP id ot4-20020a17090b3b4400b0023762f73106mr19020143pjb.17.1681244994537;
        Tue, 11 Apr 2023 13:29:54 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id k60-20020a17090a4cc200b0023f5c867f82sm11386453pjh.41.2023.04.11.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:29:54 -0700 (PDT)
Date:   Tue, 11 Apr 2023 13:29:50 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <ZDXDPuSOSV1EYvPr@snowbird>
References: <20230329202148.71107-1-dennis@kernel.org>
 <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
 <ZCclEE6Qw3on7/eO@snowbird>
 <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
 <ZC/TL2/gLre0B4xH@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC/TL2/gLre0B4xH@snowbird>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 01:24:15AM -0700, Dennis Zhou wrote:
> On Mon, Apr 03, 2023 at 11:50:41AM +0200, Ulf Hansson wrote:
> > On Fri, 31 Mar 2023 at 20:23, Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > Hi Ulf,
> > >
> > > On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> > > > On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> > > > >
> > > > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > > > races with the discovery of attached emmc devices. This is because mmc's
> > > > > probing code sets up the host data structure then a work item is
> > > > > scheduled to do discovery afterwards. To prevent this race on init,
> > > > > let's inline the first call to detection, __mm_scan(), and let
> > > > > subsequent detect calls be handled via the workqueue.
> > > >
> > > > In principle, I don't mind the changes in $subject patch, as long as
> > > > it doesn't hurt the overall initialization/boot time. Especially, we
> > > > may have more than one mmc-slot being used, so this needs to be well
> > > > tested.
> > > >
> > >
> > > I unfortunately don't have a device with multiple mmcs available. Is
> > > this something you could help me with?
> > 
> > Yes, I can help to test. Allow me a few days to see what I can do.
> > 
> > Note that, just having one eMMC and one SD card should work too. It
> > doesn't have to be multiple eMMCs.
> > 
> > >
> > > > Although, more importantly, I fail to understand how this is going to
> > > > solve the race condition. Any I/O request to an eMMC or SD requires
> > > > the mmc block device driver to be up and running too, which is getting
> > > > probed from a separate module/driver that's not part of mmc_rescan().
> > >
> > > I believe the call chain is something like this:
> > >
> > > __mmc_rescan()
> > >     mmc_rescan_try_freq()
> > >         mmc_attach_mmc()
> > >             mmc_add_card()
> > >                 device_add()
> > >                     bus_probe_device()
> > >                         mmc_blk_probe()
> > >
> > > The initial calling of this is the host probe. So effectively if there
> > > is a card attached, we're inlining the device_add() call for the card
> > > attached rather than waiting for the workqueue item to kick off.
> > >
> > > dm is a part of late_initcall() while mmc is a module_init(), when built
> > > in becoming a device_initcall(). So this solves a race via the initcall
> > > chain. In the current state, device_initcall() finishes and we move onto
> > > the late_initcall() phase. But now, dm is racing with the workqueue to
> > > init the attached emmc device.
> > 
> > You certainly have a point!
> > 
> > This should work when the mmc blk module is built-in. Even if that
> > doesn't solve the entire problem, it should be a step in the right
> > direction.
> > 
> > I will give it some more thinking and run some tests at my side, then
> > I will get back to you again.
> > 
> 
> Hi Ulf, is there an update on testing with this patch?
> 

Ping.

Thanks,
Dennis
