Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958A774D178
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGJJ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGJJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559CB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688981263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kwkHvApEdStfVKInGVUfBcOvlOglFnlYRPePfAzvXw=;
        b=Z0bEgaqUC11J59aPuw20dIEA4o0f21AEhc0nqy3WU2Ra9JYHW1sVEpL8rReusnEcPlseJG
        DKSKrXvZi7+vQ13Xo8If4nXuIrXS+A+9tEKPR0tBbDipjt+CbTmDKYXYq/2vvbmDtfxSoz
        5W/MbPyxqqyJAFdtjVxwy5aO/GOyQk4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-ibukddyLMGWg4o0lITkHGw-1; Mon, 10 Jul 2023 05:27:36 -0400
X-MC-Unique: ibukddyLMGWg4o0lITkHGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 344FA1C03D8F;
        Mon, 10 Jul 2023 09:27:36 +0000 (UTC)
Received: from ovpn-8-31.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0B822166B26;
        Mon, 10 Jul 2023 09:27:28 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:27:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
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
        Hans Holmberg <Hans.Holmberg@wdc.com>, ming.lei@redhat.com
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Message-ID: <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKuqt6QAXic3wuRX@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 11:52:39PM -0700, Christoph Hellwig wrote:
> On Fri, Jul 07, 2023 at 08:59:03AM +0800, Ming Lei wrote:
> > > let's clearly state so. But then, I still not understand why these need
> > > a different naming pattern using the "__UBLK" prefix...
> > 
> > I think __UBLK just meant we don't suggest userspace to use it directly,
> > since the added macros are just for making ranges for DRV_IN and DRV_OUT,
> > so we can check command direction easily be using this start/end info in
> > both sides.
> 
> Folks, please stop coupling a uapi (or on-disk protocol) too tightly
> to Linux internals.  Think of what makes sense as a communication
> protocol, not what is an internal kernel interface.
> 
> REPORT_ZONES is a sensible command, and supported in ATA/SCSI/NVMe in
> one way or another.  In Linux it is a synchronous method call right now
> for one reason or another, and most implementation map it to a
> passthrough command - be that the actual protocol command or something
> internal for virtio.
> 
> So for ublk this is just another command like any other, that needs to
> be defined and documented.  Nothing internal or driver specific.
 
Yes, that is exactly what we are doing.

The added macros of UBLK_IO_OP_DRV_IN_START[END] are just for supporting
more ublk passthrough commands, and the motivation is for running
check(such as buffer direction) in two sides easily.

However, I think it is just fine to delay to add it until introducing
the 2nd ublk pt command.

Thanks, 
Ming

