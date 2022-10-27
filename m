Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0060F002
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiJ0GTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJ0GTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:19:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EDC26A;
        Wed, 26 Oct 2022 23:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 042DEB824D1;
        Thu, 27 Oct 2022 06:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383ECC433C1;
        Thu, 27 Oct 2022 06:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666851568;
        bh=97io0iD7x3xDP0OdnQRfJLbmmR7TtbnuQI2GxsDp8VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DutYNNvof0bKkFgXEutmVwmkguACXmutjGNhoH45fZmBaMtpBjPogn6T1r0z4PH92
         k4t4dDDzsqx0BJScTVz41WVlQBOC/4hhwA2parFw8NaXa5XUCn7DEFpvhMjZU49yj3
         NiuMtIEOQRZTV2eI6eWWQ5drUaGGvc6m3qWZL0VQ=
Date:   Thu, 27 Oct 2022 08:20:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Harktman <gregkh@google.com>
Subject: Re: [PATCH 1/3] usb: host: add xhci hooks for USB offload
Message-ID: <Y1ojJo635jkKNogx@kroah.com>
References: <20221027004050.4192111-1-albertccwang@google.com>
 <20221027004050.4192111-2-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027004050.4192111-2-albertccwang@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:40:48AM +0800, Albert Wang wrote:
> From: Howard Yen <howardyen@google.com>
> 
> This change is to provide USB offload function which allows to offload some
> xHCI operations on co-processor. This is especially designed for USB audio
> usecase. The co-processor is able to manipulate some USB structures in his
> own memory, like SRAM.
> 
> There are several offload_ops introduced by this patch:
> 
> struct xhci_offload_ops - function callbacks for offlad specific operations
> {
> 	@offload_init:
> 		- called for vendor init process during xhci-plat-hcd
> 		  probe.
> 	@offload_cleanup:
> 		- called for vendor cleanup process during xhci-plat-hcd
> 		  remove.
> 	@is_usb_offload_enabled:
> 		- called to check if usb offload enabled.
> 	@alloc_dcbaa:
> 		- called when allocating vendor specific dcbaa during
> 		  memory initializtion.
> 	@free_dcbaa:
> 		- called to free vendor specific dcbaa when cleanup the
> 		  memory.
> 	@alloc_transfer_ring:
> 		- called when vendor specific transfer ring allocation is required
> 	@free_transfer_ring:
> 		- called to free vendor specific transfer ring
> 	@usb_offload_skip_urb:
> 		- called to check if need to skip urb enqueue
> }
> 
> The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_offload_ops.
> For example, offload_init ops will be invoked by xhci_vendor_offload_init()
> hook,is_usb_offload_enabled ops will be invoked by
> xhci_vendor_is_usb_offload_enabled(), and so on.
> 
> Signed-off-by: Howard Yen <howardyen@google.com>
> Link: https://lore.kernel.org/r/20210119101044.1637023-1-howardyen@google.com
> Signed-off-by: Greg Kroah-Harktman <gregkh@google.com>

Sorry, but no, I did NOT sign of on this patch for submission here.

And if you read the link above, you will see that I explicitly rejected
this commit for inclusion.

What changed from this previous series?  Is any of the issues raised
there now resolved?  If so, how?  If not, why not?

thanks,

greg k-h
