Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCAB6E93A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjDTMEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDTMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F530DF;
        Thu, 20 Apr 2023 05:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42DEA64776;
        Thu, 20 Apr 2023 12:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55188C433EF;
        Thu, 20 Apr 2023 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681992288;
        bh=Eq90CI4WN6vboOUFC74i6leDtzHtPyCNTordr31Nh5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiKlQOsw4F4vu42KLc/ZfMNSl8Od8i4py8ZDfpWqtAq8dnzttU1JaITIf7m5ITzfe
         lT7Q4v8RPIwR/85AVtgoN4sXH2sUp/jU2sfl0IOXn3uEobrOvDZmesPYzKJ5EthERu
         NaHgYdv4TtS/llPUZdhNaYpmHvxzqaR2CCFVcTrA=
Date:   Thu, 20 Apr 2023 14:04:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     Y_Ashley@163.com, arnd@arndb.de, dzm91@hust.edu.cn,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: mchp_pci1xxxx: mchp_pci1xxxx_gp: add unwind goto
Message-ID: <ZEEqXqu2JoPlR8ig@kroah.com>
References: <20230409124816.36137-1-Y_Ashley@163.com>
 <BN8PR11MB3668BB25DB6028404F423086E9989@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR11MB3668BB25DB6028404F423086E9989@BN8PR11MB3668.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:43:10AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> > -----Original Message-----
> > From: Xinyi Hou <Y_Ashley@163.com>
> > Sent: Sunday, April 9, 2023 6:18 PM
> > To: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>; Arnd Bergmann
> > <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Smatch reported:
> > 
> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:73 gp_aux_bus_probe()
> > warn:
> > missing unwind goto?
> > 
> > In gp_aux_bus_probe(), when the allocation of aux_bus-
> > >aux_device_wrapper[1] fails, it needs to clean up the allocated resources.
> > 
> > Fix this by revising the return statement to a goto statement.
> > 
> > Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for
> > the PIO function in the multi-function endpoint of pci1xxxx device.")
> > Signed-off-by: Xinyi Hou <Y_Ashley@163.com>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> > ---
> > The issue is found by static analysis, and the patch remains untest.

Despite all the reviewers, this patch is incorrect :(

Please test patches, or better yet, restructure the code to not need to
bail out in such a "deep" call path so that errors like this are not an
issue.

thanks,

greg k-h
