Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6BD74CDA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJGwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGJGwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:52:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B463B8;
        Sun,  9 Jul 2023 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0WJwmYqGqfC5+F7X8O+8MxIciM7Dnfe4X3/zGG+C5NM=; b=iU4lk5jzwQZah8E0ji7rSHbjxI
        ++1tF3GKKf7Za5Vx+eTSlYJvNobHySd/+D5glJC0omq0h3xJKlFMOIFhjy86yVJmY9hUeezj6Ro12
        KGnaVeMWzPhgQBsbJPOpBAoyEF0yXAWLAKbKUrqHd+IHv2/22MXOBL4EYg0aK/faTTJUxe1rYepgx
        XYyRGwZemGjTiCgqDHqWcB7Iph1ybeIxIzxPKiqeLtHYLL2mqBJBYTnqv4fCmfbWTM+0+RpQOaRgL
        WlOaGUYITW9gOPAwXOLdgP7etwjsWEultGqoJ3iEM76+d3iFeAdY9dhEtOY8SX/jMaIpKmu4n4TFy
        uIGKFtXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIklD-00AdNW-09;
        Mon, 10 Jul 2023 06:52:39 +0000
Date:   Sun, 9 Jul 2023 23:52:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Message-ID: <ZKuqt6QAXic3wuRX@infradead.org>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 08:59:03AM +0800, Ming Lei wrote:
> > let's clearly state so. But then, I still not understand why these need
> > a different naming pattern using the "__UBLK" prefix...
> 
> I think __UBLK just meant we don't suggest userspace to use it directly,
> since the added macros are just for making ranges for DRV_IN and DRV_OUT,
> so we can check command direction easily be using this start/end info in
> both sides.

Folks, please stop coupling a uapi (or on-disk protocol) too tightly
to Linux internals.  Think of what makes sense as a communication
protocol, not what is an internal kernel interface.

REPORT_ZONES is a sensible command, and supported in ATA/SCSI/NVMe in
one way or another.  In Linux it is a synchronous method call right now
for one reason or another, and most implementation map it to a
passthrough command - be that the actual protocol command or something
internal for virtio.

So for ublk this is just another command like any other, that needs to
be defined and documented.  Nothing internal or driver specific.
