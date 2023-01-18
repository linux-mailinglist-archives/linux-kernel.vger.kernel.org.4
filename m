Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA3671DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjARNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjARNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:33:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE95897E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 404D160CE8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301ECC433D2;
        Wed, 18 Jan 2023 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674046811;
        bh=dB/NGvr4e6SBdFkWga9MCfi5s6KUAAvOMvgaNcolWvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vty3EysI6HXVcUWI7fHJz2My1cDucFgzu/mlSBVgU1GSZr5+maIpBQLab2rTn3Qs+
         DQLySWUTpYWu/JaE+Y/bdSCorJsN0Q7U2lS7y3rgt3wTaNaAD/hooTGc9CYDhJ15Zd
         E4wE+ImnFwRtLIOHT6JqdGAZcsJpR+Qrcy9COw88=
Date:   Wed, 18 Jan 2023 14:00:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Adrien Thierry <athierry@redhat.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: fix enum vchiq_status return types
Message-ID: <Y8ftWHG8Ek6Mjb3I@kroah.com>
References: <20230117163957.1109872-1-arnd@kernel.org>
 <3a69e1fc-c266-d75c-32e3-9b5f655a8258@i2se.com>
 <d4e9fd51-6d22-d304-3eb0-e76c15dcb1da@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e9fd51-6d22-d304-3eb0-e76c15dcb1da@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:33:15PM +0530, Umang Jain wrote:
> Hi,
> 
> On 1/18/23 5:08 PM, Stefan Wahren wrote:
> > Hi Arnd,
> > 
> > Am 17.01.23 um 17:39 schrieb Arnd Bergmann:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > gcc-13 notices a type mismatch between function declaration
> > > and definition for a few functions that have been converted
> > > from returning vchiq specific status values to regular error
> > > codes:
> > > 
> > > drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:662:5:
> > > error: conflicting types for 'vchiq_initialise' due to enum/integer
> > > mismatch; have 'int(struct vchiq_instance **)'
> > > [-Werror=enum-int-mismatch]
> > > drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1411:1:
> > > error: conflicting types for 'vchiq_use_internal' due to
> > > enum/integer mismatch; have 'int(struct vchiq_state *, struct
> > > vchiq_service *, enum USE_TYPE_E)' [-Werror=enum-int-mismatch]
> > > drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1468:1:
> > > error: conflicting types for 'vchiq_release_internal' due to
> > > enum/integer mismatch; have 'int(struct vchiq_state *, struct
> > > vchiq_service *)' [-Werror=enum-int-mismatch]
> > > 
> > > Change the declarations to match the actual function definition.
> > > 
> > > Fixes: a9fbd828be7f ("staging: vchiq_arm: drop enum vchiq_status
> > > from vchiq_*_internal")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > thanks for fixing this.
> > 
> > Greg applied a series [1] from Umang which completely removes this enum
> > completely. This series has been applied to today and will likely cause
> > a conflict tomorrow in linux-next.
> 
> Yes, the series was applied today.
> 
> Has this patch (By Arnd) already applied to linux-next? I am not sure if I
> understand where the conflict will get originated ..

I've applied Arnd's patch to my staging-linus branch and it will go
there for 6.2-final.  I'll handle the merge into my other branch when
that happens.

thanks,

greg k-h
