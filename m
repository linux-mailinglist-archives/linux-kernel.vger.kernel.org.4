Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2C64DB95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLOMst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLOMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:48:44 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57C463A8;
        Thu, 15 Dec 2022 04:48:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1F0068AA6; Thu, 15 Dec 2022 13:48:37 +0100 (CET)
Date:   Thu, 15 Dec 2022 13:48:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Max Staudt <mstaudt@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 2/2] media: uvcvideo: Do not alloc dev->status
Message-ID: <20221215124837.GA19113@lst.de>
References: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org> <20221214-uvc-status-alloc-v3-2-9a67616cc549@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214-uvc-status-alloc-v3-2-9a67616cc549@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:57:19AM +0100, Ricardo Ribalda wrote:
> +	/*
> +	 * Ensure that status is aligned, making it safe to use with
> +	 * non-coherent DMA.
> +	 */
> +	struct uvc_status status __aligned(ARCH_KMALLOC_MINALIGN);

This should be ARCH_DMA_MINALIGN, not ARCH_KMALLOC_MINALIGN.

Note that without an __aligned tag on the next member as well, those
next members might get cache corrupted.

>  
>  	struct input_dev *input;

.. and without also aligning the next member you'll might still
corrupt everything adter the DMAed member.

That's the reason why I generall advocate against playing these
__aligned games as they can easily go wrong if someone reorders
the structure.
