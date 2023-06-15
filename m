Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A3730F09
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbjFOGFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbjFOGEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2582702
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B018063094
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC04AC433C8;
        Thu, 15 Jun 2023 06:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686809061;
        bh=r2n6JouoTAE9HvQILwKK9NyKgBEJyXm/vErfVJyYT+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbHk/kATkoGvjSqhDogIkIc4zEYl9h9/OoS2QAmW6o2TNy7F5mET1Wnc2Njj/Qopm
         kQmCqdFon55M2i/GrnZIp8/FzCzRv7PixXvgdTfWDi0P0TcggG4bQ+9FpzH6PgtLzB
         LZhVf2eA5PoZSQBAEfRsfsehGItnijFg9WUK1sTw=
Date:   Thu, 15 Jun 2023 08:04:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <2023061554-defective-islamist-fab5@gregkh>
References: <20230518091614.137522-1-xiafukun@huawei.com>
 <86c6040d-17ab-fb01-2b75-717d82ba9345@huawei.com>
 <2023061444-latticed-discuss-fa70@gregkh>
 <c8e7106c-872f-4d18-f4d8-de4c450fc587@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e7106c-872f-4d18-f4d8-de4c450fc587@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:43:34AM +0800, Xia Fukun wrote:
> 
> On 2023/6/15 4:09, Greg KH wrote:
> 
> > 
> > How did you test it?  How have you verified that the previous failures
> > were caught this time?
> > 
> 
> My testing method is to apply the patch, compile the kernel image,
> and start the QEMU virtual machine. Then compile and execute the code
> mentioned in the patch that triggers out-of-bounds issues.
> 
> In addition, the following operations will be performed to verify the
> functions mentioned by Peter Rajnoha <prajnoha@redhat.com>:
> 
> # echo "add fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc" >
> /sys/block/ram0/uevent
> 
> # udevadm monitor --kernel --env
> monitor will print the received events for:
> KERNEL - the kernel uevent
> 
> KERNEL[189.376386] add      /devices/virtual/block/ram0 (block)
> ACTION=add
> DEVPATH=/devices/virtual/block/ram0
> SUBSYSTEM=block
> SYNTH_UUID=fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed
> SYNTH_ARG_A=1
> SYNTH_ARG_B=abc
> DEVNAME=/dev/ram0
> DEVTYPE=disk
> DISKSEQ=14
> SEQNUM=3781
> MAJOR=1
> MINOR=0

So you have not run this on any real systems?  Please try doing that
(boot your laptop, your server, your server farm, etc.) with it and do a
lot of testing that way.

To only use qemu means it has not really been tested at all, which now
explains why you didn't find the previous problems with this patch
series as this is a kernel path that is HIGHLY dependent on the hardware
involved (i.e. it wants real hardware, not emulated ones.)

thanks,

greg k-h
