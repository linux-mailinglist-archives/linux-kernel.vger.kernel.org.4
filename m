Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74F6218B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiKHPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiKHPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:46:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4321853EFF;
        Tue,  8 Nov 2022 07:46:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E06FCE1BD8;
        Tue,  8 Nov 2022 15:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA77C433C1;
        Tue,  8 Nov 2022 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922366;
        bh=DZsjrJI0/NXHowKMtK9SYTyubsi9Lc1SR872ceeBNU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqxQDRy5bGuQgAuXXCGJcdX85KKTp8Q8RzXYVTmmQpXCz7DjZXcaqcG0JAXIUznMa
         eBtdRyLhgzsCcKhw0n+gfMiVN0E9GxzILMJD6f3BNJ0Cbn15NFsexe8HAB5o67cHZf
         DxzJpycPhig+vI5bADAn5MSoYKTZDmhu/850Isz8/phlCgeQ1lkio0FMvDeiL5zA5a
         ClUOW8u08P0BvMBLLa1sx70MMAFDyy/4xNCV6+e4tkL1D3cNogZfsInooH1B04pcFs
         vj/8IZGkIY99oO8efAlllg0wdmebiSvYmp/yQ04VolzXFWvTOk4fAQPjsKkuote4mo
         uY7i/cUlQudmQ==
Date:   Tue, 8 Nov 2022 08:46:03 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <Y2p5u8N+Hou/5v53@kbusch-mbp>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <7a14c467-e67e-eede-4ebc-d8105cc3bcd5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a14c467-e67e-eede-4ebc-d8105cc3bcd5@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 03:50:33AM +0000, Chaitanya Kulkarni wrote:
> On 11/7/22 09:28, Gerd Bayer wrote:
> 
> > We believe this to be a race-condition somewhere, since this sequence does not produce the panic
> > when executed interactively.
> > 
> 
> You can try and bisect the code to point out at exact commit.

Bisect doesn't work without a known good commit point.
