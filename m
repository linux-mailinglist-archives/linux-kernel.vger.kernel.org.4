Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221846D2F59
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDAJS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C633AF26;
        Sat,  1 Apr 2023 02:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97C160BED;
        Sat,  1 Apr 2023 09:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D2C433EF;
        Sat,  1 Apr 2023 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680340702;
        bh=L/sME2FIr0aX8i+u4x8Bk/GKIj9HRuPD+w8rKgEAVik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0TXJDBUVkZ+12qcMwHwVgcP21I0COj4wuNnwgFCE+HVhenYDrRiTneLgrVsARzJif
         YH3BbJAsRF8DNh/K8YW7SG1g/LGTcWM3cPY7wwv1wO47HHVIdrNycjJNhvtUP0Kmzp
         ZoOgUIRIvI58d/21uLnrwFC3Iy8CHITmSb59luYo=
Date:   Sat, 1 Apr 2023 11:18:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
Subject: Re: BUG FIX: [PATCH RFC v3] memstick_check() memleak in kernel
 6.1.0+ introduced pre 4.17
Message-ID: <2023040127-untrue-obtrusive-1ea4@gregkh>
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
 <4d80549f-e59d-6319-07fd-1fbed75d7a1c@alu.unizg.hr>
 <ZCfO90WwyS6JwaHi@kroah.com>
 <ZCfQQDkw3D_BXJaZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCfQQDkw3D_BXJaZ@kroah.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:33:36AM +0200, Greg KH wrote:
> On Sat, Apr 01, 2023 at 08:28:07AM +0200, Greg KH wrote:
> > On Sat, Apr 01, 2023 at 08:23:26AM +0200, Mirsad Goran Todorovac wrote:
> > > > This patch is implying that anyone who calls "dev_set_name()" also has
> > > > to do this hack, which shouldn't be the case at all.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > This is my best guess. Unless there is dev_free_name() or kobject_free_name(), I don't
> > > see a more sensible way to patch this up.
> > 
> > In sleeping on this, I think this has to move to the driver core.  I
> > don't understand why we haven't seen this before, except maybe no one
> > has really noticed before (i.e. we haven't had good leak detection tools
> > that run with removable devices?)
> > 
> > Anyway, let me see if I can come up with something this weekend, give me
> > a chance...
> 
> Wait, no, this already should be handled by the kobject core, look at
> kobject_cleanup(), at the bottom.  So your change should be merely
> duplicating the logic there that already runs when the struct device is
> freed, right?
> 
> So I don't understand why your change works, odd.  I need more coffee...

I think you got half of the change correctly.  This init code is a maze
of twisty passages, let me take your patch and tweak it a bit into
something that I think should work.  This looks to be only a memstick
issue, not a driver core issue (which makes me feel better.)

thanks,

greg k-h
