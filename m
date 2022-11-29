Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833563BB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiK2I2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiK2I2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:28:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49849100A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:27:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68F60B811B3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF8C433C1;
        Tue, 29 Nov 2022 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669710461;
        bh=Kjks0TSI6O1yYxWH+iF7PLjdCelG6aVkRssHbUmCh5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dddu6IBaI0n7pVLOTm/6w9IpgWtwVpvnAmpJKjBb6PBn/8pDjsYrllu/GL9KuwRO7
         nymXJlsuKHWfivVwmstZeSHe0S0JG6ex/baORYnYnpdDZcUh5VMrmLQZRHLTSqfGVH
         PKpdIiyGIgEsoVZRllUIehzVtd0ChvbWzGLtBtzk=
Date:   Tue, 29 Nov 2022 09:27:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] driver core: fix up some missing class.devnode()
 conversions.
Message-ID: <Y4XCelSURHMMK61T@kroah.com>
References: <20221128173539.3112234-1-gregkh@linuxfoundation.org>
 <9da4f875-7fb3-803f-379e-0352eb824d8f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9da4f875-7fb3-803f-379e-0352eb824d8f@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:33:04AM +0000, Christophe Leroy wrote:
> 
> 
> Le 28/11/2022 à 18:35, Greg Kroah-Hartman a écrit :
> > In commit ff62b8e6588f ("driver core: make struct class.devnode() take a
> > const *") the ->devnode callback changed the pointer to be const, but a
> > few instances of PowerPC drivers were not caught for some reason.
> > 
> > Fix this up by changing the pointers to be const.
> 
> Build fails:
> 
> /linux/arch/powerpc/platforms/book3s/vas-api.c: In function 
> 'vas_register_coproc_api':
> /linux/arch/powerpc/platforms/book3s/vas-api.c:590:31: error: assignment 
> from incompatible pointer type [-Werror=incompatible-pointer-types]
>    coproc_device.class->devnode = coproc_devnode;
>                                 ^
> cc1: all warnings being treated as errors

What did you build this against?  It has to be be against my
driver-core-next tree as that is where the Fixes: commit is.

thanks,

greg k-h
