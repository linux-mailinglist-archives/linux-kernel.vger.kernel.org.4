Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B3718579
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjEaPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjEaPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1911D;
        Wed, 31 May 2023 08:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA36163360;
        Wed, 31 May 2023 15:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F188C433D2;
        Wed, 31 May 2023 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685545317;
        bh=eYq2I6lJAcfyedeYDZvD+j5uB9PSmSsjDehuQsZ99Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gm39zNicXK0omOersElSqRhHDnO79fhOc7mzV+11zMyMgV3hOIzJ0vik/8l6bWo9h
         GeY9x4ZlnAs2xTtWn82SvJLzpb3bXCSLrlXdaFp5OPU6ug25jlfrFNG+fE48M2FNt+
         3KmXFdcD3xybGqGKxs3oGet8eWc12XCyIYNRQ/fkqi1nxbm8nXdo5qmSDNLZo8aWPE
         2WWoaTdW6x4qNOY1m2BAX1ovKXR4y9gQorCu36Uzhkrzfkd0PQSh7aPyr2BJD4cTdI
         vZNVvJ6eD8Ayao9OT8jWDxLtMYYq0Oe3x83nJlkbCo4Mqnl2M66kyHjqsbjbrLJGOp
         5SdUuLE4FfngQ==
Date:   Wed, 31 May 2023 20:31:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>, kuba@kernel.org,
        andersson@kernel.org, daniel@ffwll.ch, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Add userspace character interface
Message-ID: <20230531150143.GI7968@thinkpad>
References: <20230522190459.13790-1-quic_jhugo@quicinc.com>
 <20230531142803.GH7968@thinkpad>
 <2023053134-unpiloted-why-0f37@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023053134-unpiloted-why-0f37@gregkh>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 03:35:08PM +0100, Greg KH wrote:
> On Wed, May 31, 2023 at 07:58:03PM +0530, Manivannan Sadhasivam wrote:
> > + Jakub (who NACKed the previous submission of UCI driver)
> > Link to previous submission: https://lore.kernel.org/all/1606533966-22821-1-git-send-email-hemantk@codeaurora.org/
> > 
> > On Mon, May 22, 2023 at 01:04:59PM -0600, Jeffrey Hugo wrote:
> > > From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> > > 
> > > I2C, USB, and PCIe are examples of buses which have a mechanism to give
> > > userspace direct access to a device on those buses. The MHI userspace
> > > character interface (uci) is the MHI bus analogue.
> > > 
> > > The MHI bus devices are MHI channels which ferry blocks of data from one
> > > end to the other. With this simple purpose, we can define a simple
> > > interface to userspace - a character device that supports open/close/read/
> > > write/poll operations. Since bus devices can only have a single consumer
> > > we encode a whitelist of MHI channels to be exported to userspace so as
> > > to avoid conflicts.
> > > 
> > > We also make this mechanism open to any device that implements MHI.
> > > Today this includes WLAN (Wi-Fi), WWAN (4G/5G cellular), and ML/AI
> > > devices. More devices are expected in the future.
> > > 
> > > In addition to implementing the framework for uci, we include an initial
> > > usecase - the QAIC Sahara device.
> > > 
> > > Sahara is a file transfer protocol that is commonly used for two purposes
> > > when interacting with a device - transferring firmware to the device and
> > > transferring crashdumps from the device. The Sahara protocol puts the
> > > receiver of the data in control of the transfer. A firmware transfer
> > > operation would have the device requesting the specific firmware images
> > > that the device wants, and the host satisfying those requests.
> > > 
> > > In most cases, including for AIC100, Sahara is used as part of a two stage
> > > loading process. The device will boot a very limited bootloader that does
> > > the base minimum initialization and jump to the next stage. A simple, one-
> > > shot protocol like BHI is used to send the next stage bootloader to the
> > > device. This second stage bootloader contains more functionality and
> > > implements the Sahara protocol. The second stage determines from various
> > > inputs what set of runtime firmware is required to boot the device into an
> > > operational status, and requests those pieces from the host.  With those
> > > images transferred over, the device can funnly initialize.
> > > 
> > > Each AIC100 instance (currently, up to 16) in a system will create a
> > > MHI device for QAIC_SAHARA. MHI_uci will consume each of these and create
> > > a unique chardev which will be found as
> > > /dev/<mhi instance>_QAIC_SAHARA
> > > For example - /dev/mhi0_QAIC_SAHARA
> > > 
> > > An open userspace application that can consume these devices for firmware
> > > transfers is located at https://github.com/andersson/qdl
> > > 
> > > Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> > > [jhugo: Rename to uci, plumb to mhi, rewrite commit text]
> > > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > 
> > The previous attempt on adding UCI driver was NACKed by Jakub. For merging this
> > patch, I need an ACK from Jakub.
> 
> Given that this fails the kernel robot tests, why would anyone ack it
> as-is?
> 

Well, I was referring to the concept of UCI in general. Ofc, the build failure
need to be fixed.

- Mani

> confused,
> 
> greg k-h
> 

-- 
மணிவண்ணன் சதாசிவம்
