Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8D626E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiKMIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 03:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 03:47:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1413D1E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 00:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668329181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4nY/wCPQF6OSXmb05LyZM3tb4OCU1/TNqmBCx7L85xI=;
        b=RR0Fcn91JDFbXA9hhMctKWErecf2QsUagUdVnWGAbb3A9OJcJo/AncLr9dpXVLLwIOxo7S
        /leu7EapHeMmPLQvexfRGRkqndglJ2jSFu6g8EKdN829Y3gDajfn+aUlyLdAGI71zH5QcH
        4/ZG4L/XQvPEuU8eKop3y2oJUZ2BmdY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-uBTap92wN7Wfj92GAlg3bQ-1; Sun, 13 Nov 2022 03:46:12 -0500
X-MC-Unique: uBTap92wN7Wfj92GAlg3bQ-1
Received: by mail-wm1-f70.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso7174776wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 00:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nY/wCPQF6OSXmb05LyZM3tb4OCU1/TNqmBCx7L85xI=;
        b=O6gmnyg5nqb/BLxiJitoxwem0TlNcRLaB1LPDxAnL6KrPoqJlveSXlbxII4xhcvdfM
         ve8i1AHXlQLJeW/X0BJH+JgbC5OYbIyfB0R3leILNksL4PQZlGhs9w/U8HSwPX9N8tWr
         Y13D0AvH+0D9tG5RmMNjVWIy7JxHuPTGQBFi4wu+VD2P0VHOOv+s/W1AaTm1jl+TsxMx
         MJfaeGgLH+LlHxEbZtaTJaM6v6qWC7VfrjS/x0D8jt6iGiN5RSPFpYRBDkJhdYW0OD4j
         eI+iEgdHwk2Ih3vX77JhMxOYjyRdaDS8YrQ9KLABGvYlksO/2D3CcPXKOVFgmSI66Y3h
         vOeA==
X-Gm-Message-State: ANoB5pkFOEqfQMDp8DYzlTK1k/pWQe/4YxP2iorAuxqYXtbWBBEfHqSo
        58l7doNFc0/R8e3YHdvyvoeW2wziX2Qy+TirU2J/FE7G/oWDIA+nwY+Mz97NdGUVYp0N5D4p3oY
        uVNs3bsM666c9erBC3wgxCGmA
X-Received: by 2002:a05:600c:3496:b0:3cf:cfea:904c with SMTP id a22-20020a05600c349600b003cfcfea904cmr5347975wmq.33.1668329171456;
        Sun, 13 Nov 2022 00:46:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf64Poy9T+YQ6XAX4DzgZr5znfmzBVgoHz4yN3apFUgJuPNy+KZo052kQMdIGyPq+5cGpeImsQ==
X-Received: by 2002:a05:600c:3496:b0:3cf:cfea:904c with SMTP id a22-20020a05600c349600b003cfcfea904cmr5347964wmq.33.1668329171180;
        Sun, 13 Nov 2022 00:46:11 -0800 (PST)
Received: from redhat.com ([2.55.167.96])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b002417e7f0685sm3960460wrb.9.2022.11.13.00.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:46:09 -0800 (PST)
Date:   Sun, 13 Nov 2022 03:46:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221113034519-mutt-send-email-mst@kernel.org>
References: <20221110144700-mutt-send-email-mst@kernel.org>
 <20221111234219.GA763705@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111234219.GA763705@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:42:19PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 10, 2022 at 03:15:55PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> > ...
> 
> > > Prior to this change pci_device_is_present(VF) returned "false"
> > > (because the VF Vendor ID is 0xffff); after the change it will return
> > > "true" (because it will look at the PF Vendor ID instead).
> > > 
> > > Previously virtio_pci_remove() called virtio_break_device().  I guess
> > > that meant the virtio I/O operation will never be completed?
> > > 
> > > But if we don't call virtio_break_device(), the virtio I/O operation
> > > *will* be completed?
> > 
> > It's completed anyway - nothing special happened at the device
> > level - but driver does not detect it.
> > 
> > Calling virtio_break_device will mark all queues as broken, as
> > a result attempts to check whether operation completed
> > will return false.
> > 
> > This probably means we need to work on handling surprise removal
> > better in virtio blk - since it looks like actual suprise
> > removal will hang too. But that I think is a separate issue.
> 
> Yeah, this situation doesn't seem like it's inherently special for
> virtio or VFs, so it's a little surprising to see
> pci_device_is_present() used there.
> 
> Bjorn


Just making sure - pci_device_is_present *is* the suggested way
to distinguish between graceful and surprise removal, isn't it?

-- 
MST

