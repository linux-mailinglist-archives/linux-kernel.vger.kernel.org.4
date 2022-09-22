Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0F5E6753
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiIVPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIVPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:40:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB3B5156;
        Thu, 22 Sep 2022 08:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7582CE21C9;
        Thu, 22 Sep 2022 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A17CC433D6;
        Thu, 22 Sep 2022 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663861210;
        bh=CjXzU/QKPi6MbdicAsACYEjce6oRRvoaOkrD96MRx4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRWME4Hzf2sruEkbYrvgvqdR+Fv0OL+SZlH+hF6UTJeP3qv9zY1EWTUrlR/UUL5g8
         jctg0+io9B+URiN4yNV65uoYp7gBGfpk4O+RpUFJWTVkMlByCw5G4QtMqfqmQ93o88
         6YDJF6CQ+cbnBE1oSR6BiAb+k76fT71LepY1GA2P5pVUG8Ktn4Y+G3x0/6hH80zYeo
         cOwToJT7JfBVdmiaAAqDRyVorhjdxWkLoRMFMFFNysHbcAqVJIUP4J91WxEKYOkz7k
         6X4TRXFOnt6S4yqskdtl9B/qQOH57gBhcDvKG09H0XC50JHxYInn6xtUY1WpGO2a52
         ujWnh/0e70Xdw==
Date:   Thu, 22 Sep 2022 16:40:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-next@vger.kernel.org, bagasdotme@gmail.com,
        zengheng4@huawei.com
Subject: Re: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place  of the SIMPLE_DEV_PM_OPS() in
 pci1xxxx's gpio driver
Message-ID: <YyyB1at426/JLB3V@spud>
References: <20220915094729.646185-1-kumaravel.thiagarajan@microchip.com>
 <YytAbfmMfxNsIjcy@spud>
 <Yyx3AMaETK2GsBHl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyx3AMaETK2GsBHl@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:53:52PM +0200, Greg KH wrote:
> On Wed, Sep 21, 2022 at 05:48:45PM +0100, Conor Dooley wrote:
> > On Thu, Sep 15, 2022 at 03:17:29PM +0530, Kumaravel Thiagarajan wrote:
> > > misc: microchip: pci1xxxx: use DEFINE_SIMPLE_DEV_PM_OPS() in place  of the SIMPLE_DEV_PM_OPS() in pci1xxxx's gpio driver
> >                                                                     ^^
> > FYI, double space in the subject here, rather a mouthful though and
> > surely everything after SIMPLE_DEV_PM_OPS() is redundant?
> > 
> > > build errors listed below and reported by Sudip Mukherjee
> > > <sudipm.mukherjee@gmail.com> for the builds of
> > > riscv, s390, csky, alpha and loongarch allmodconfig are fixed in
> > > this patch.
> > 
> > allmodconfig has been broken for a while now, and this patch appears
> > to have been sitting for a week & a second fix has shown up at:
> > https://lore.kernel.org/all/20220919094250.858716-1-zengheng4@huawei.com/
> > 
> > I do note that Zeng Hang's patch does slightly more than this one does,
> > but idk about about the PM APIs /shrug.
> > 
> > Has this just slipped under the radar since so many of us were
> > attending conferences etc the last while or are you looking for
> > Kumaravel to do something more here?
> 
> I've taken this change now, sorry for the delay.  Was not looking at
> patches while at conferences.

Great, thanks Greg!
