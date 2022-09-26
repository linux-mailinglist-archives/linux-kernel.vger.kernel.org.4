Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49915E9BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiIZIQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIZIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:16:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4D11901A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J2vFtnitx+D26/PgyWoBCcjlD+YDNZ3SH4J3QGc5Uzg=; b=ZZyB+905nEZ1UmRzocibfTjXMA
        laO8CNbidDLcD+eEpXS7lFAuiEWk/dlsUOb3Aqfr0dBouObccH84YPq6WfklRsZvvowTJaMxa5YUD
        gFC6OiF3sOorfQRBkjAcVFNYZrlr2L7boTW0LAB6PJksSgHul3Nj0gt/4yWo9TppovrCksY9O15Su
        ew9w7NIGBIBHD7HVh8rEWLAtXHRPVdrUz5WuAxnJmzvKjHTxyGgyDBFPu8acTvsvCKFyIp43WXE60
        ErKCd83VBRdTYysbsp/P/Ko/AhVoE2wGaLGQO+1QY7uKiH/6unQpo0xxHUz8TRO96PqdVt5CYFp52
        a9OiJ5nQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocjHh-0033Mw-G5; Mon, 26 Sep 2022 08:16:13 +0000
Date:   Mon, 26 Sep 2022 01:16:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: New subsystem for acceleration devices
Message-ID: <YzFfzWJYsuhpUiPG@infradead.org>
References: <CAFCwf12P6DckVUJL7V_Z7ASj+8A3yyx9eX5MpZPF47Rzg6CjEA@mail.gmail.com>
 <7hh71uixd9.fsf@baylibre.com>
 <CAFCwf12mjshsf+GC-Y9irvPFT=W4Uis10OnZ4PNN1txjXyzLSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12mjshsf+GC-Y9irvPFT=W4Uis10OnZ4PNN1txjXyzLSA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, there is another interesting thing around on the block:

NVMe Computational Storage devices.  Don't be fooled by the name, much
of it is not about neither computation not storage, but it allows to
use the existing NVMe queuing model model to allow access to arbitrary
accelerators, including a way to expose access to on-device memory.

The probably most current version is here:

https://www.snia.org/educational-library/nvme-computational-storage-update-standard-2022

The first version will be rather limited and miss some important
functionality like directly accessing host DRAM or CXL integration,
but much of that is planned.  The initial version also probably won't
be able to be supported by Linux at all, but we need to think hard about
how to support it.

It woud also be really elpful to get more people with accelerator
experience into the NVMe working group.
