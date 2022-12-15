Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBF64DDE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLOPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiLOPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:34:50 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 687A428E3F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:34:43 -0800 (PST)
Received: (qmail 963481 invoked by uid 1000); 15 Dec 2022 10:34:42 -0500
Date:   Thu, 15 Dec 2022 10:34:42 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Max Staudt <mstaudt@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 0/2] media: uvcvideo: Code cleanup for dev->status
Message-ID: <Y5s+kuxCAtS8Eixj@rowland.harvard.edu>
References: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:57:17AM +0100, Ricardo Ribalda wrote:
> There is no need to make a kzalloc just for 16 bytes. Let's embed the data
> into the main data structure.
> 
> Now that we are at it, lets remove all the castings and open coding of
> offsets for it.
> 
> [Christoph, do you think dma wise we are violating any non written rules? :) thanks]

There _is_ a rule, and it is not exactly unwritten.  The kerneldoc for 
the transfer_buffer member of struct urb says:

	This buffer must be suitable for DMA; allocate it with
	kmalloc() or equivalent.

Which in general means that the buffer must not be part of a larger 
structure -- not unless the driver can guarantee that the structure will 
_never_ be accessed while a USB transfer to/from the buffer is taking 
place.

There are examples all over the USB subsystem where buffers as small as 
one or two bytes get kmalloc'ed in order to obey this rule.  16 bytes is 
certainly big enough that you shouldn't worry about it being allocated 
separately.

Alan Stern
