Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DF633C12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiKVMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiKVMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:08:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3232A24E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:08:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18AD66150E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1FFC433D7;
        Tue, 22 Nov 2022 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669118935;
        bh=v6NsHjzd2SnTcLVVr8sZ0m3lpYwFPx7WXSFWTJ+LPEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0toz47snQknZS31Pj7vosvIW/pnNCUm9XeS9LuoJO16Ph5ZdsQK320+TLljEFWdf
         OZRWnTysdtmxkxcNRYw/KkSCFv+BSsJxqUh6TOYDAaNMZGwLNLYtB3yV7y08bejflp
         zE4MzmGgsefzro8gjAtJxNPAmpjDyBoVDCw2PKpQ=
Date:   Tue, 22 Nov 2022 13:08:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: set DCC setting to spec recommended value
Message-ID: <Y3y71Nt/wCkyM02I@kroah.com>
References: <Y3k0bbM2/5jXfNKQ@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3k0bbM2/5jXfNKQ@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 01:24:21AM +0530, Deepak R Varma wrote:
> The DCCFreq value is used to obtain the DC offset canceller cut-off
> frequency. Upon device power reset, the bits 7-5 of the RegRxBw register
> that represent the DCCFreq setting are set to 0x4, which evaluates the
> cut-off frequency to be 1% of RxBw.
> 
> In the current implementation, first, there is no configuration variable
> defined in the struct pi433_rx_cfg for the user to set this value as
> part of the UAPI. Second, the code simply ignores the value of DCC
> setting and allows it to never change.
> 
> As per the RFM69HCW tech specs, the default value for DCC frequency is
> recommended to be 4% of the RxBw; which requires the DCC setting bits
> to be set to 010. So allow the DCC setting to change to recommended /
> default value for improved rx sensitivity.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> 
> Please Note: The proposed change is compile tested only. I am unable to perform
> device based testing in the absence of the hardware, both the RasPi board and the
> Pi433 device. Please let me know if it is necessary for me to test such patches
> on the real device myself. I will stop sending the patches till I have the hardware
> to test them. Thanks.

For changes like this, you need to test it on the device itself.

thanks,

greg k-h
