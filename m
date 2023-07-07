Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7C74A84A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGGBAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGGBAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC71BE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688691564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=plFvq/1YE9RIKcun0whNCfUMtxt+BsAmK2bAw6JNeBc=;
        b=LEpHsrYTxmJlye+HeQblZso7w9bMq+YbfLdYdcWEYXDR2dAAz70/UW8UCCZR6S8otAaEz1
        0Q44CKGa+F9qJ8lvJbzflbqGBf57FpY2SjoHE50DyDlRC5UpFBpqgPeDDHlapthpCwHBoE
        p14gXXeAQ71pOuPilc9oLFdpLzli6EE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-LCO3QH6hO7ygV79XmCZCcg-1; Thu, 06 Jul 2023 20:59:19 -0400
X-MC-Unique: LCO3QH6hO7ygV79XmCZCcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C57E080269A;
        Fri,  7 Jul 2023 00:59:18 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E530E145414F;
        Fri,  7 Jul 2023 00:59:09 +0000 (UTC)
Date:   Fri, 7 Jul 2023 08:59:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, ming.lei@redhat.com
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Message-ID: <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Fri, Jul 07, 2023 at 08:50:01AM +0900, Damien Le Moal wrote:
> On 7/6/23 22:09, Andreas Hindborg wrote:
> > From: Andreas Hindborg <a.hindborg@samsung.com>
> > 
> > Ublk zoned storage support relies on DRV_IN handling for zone report.
> > Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.
> > 
> > Also add parenthesis to existing opcodes for better macro hygiene.
> > 
> > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > ---
> >  include/uapi/linux/ublk_cmd.h | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index 4b8558db90e1..2ebb8d5d827a 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -229,12 +229,22 @@ struct ublksrv_ctrl_dev_info {
> >  	__u64   reserved2;
> >  };
> >  
> > -#define		UBLK_IO_OP_READ		0
> > +#define		UBLK_IO_OP_READ			0
> >  #define		UBLK_IO_OP_WRITE		1
> >  #define		UBLK_IO_OP_FLUSH		2
> > -#define		UBLK_IO_OP_DISCARD	3
> > -#define		UBLK_IO_OP_WRITE_SAME	4
> > -#define		UBLK_IO_OP_WRITE_ZEROES	5
> > +#define		UBLK_IO_OP_DISCARD		3
> > +#define		UBLK_IO_OP_WRITE_SAME		4
> > +#define		UBLK_IO_OP_WRITE_ZEROES		5
> > +/*
> > + * Passthrough (driver private) operation codes range between
> 
> This is unclear... Here, what does "driver" refer to ? If it is the ublk
> kernel driver, than these commands should not be defined in the uapi
> header file, they should be defined in drivers/block/ublk.h. However, if
> these are for the user space driver, like all the other operations, then

Like normal IO, these passthrough requests needs userspace to handle too,
usually they just belong to specific ublk target, such as report zones.,
so here it is part of UAPI.

But yes, we should document it clearly, maybe something below?

	Ublk passthrough operation code ranges, and each passthrough
	operation provides generic interface between ublk kernel driver
	and ublk userspace, and this interface is usually used for handling
	generic block layer request, such as command of zoned report zones.
	Passthrough operation is only needed iff ublk kernel driver has to
	be involved for handling this operation.

> let's clearly state so. But then, I still not understand why these need
> a different naming pattern using the "__UBLK" prefix...

I think __UBLK just meant we don't suggest userspace to use it directly,
since the added macros are just for making ranges for DRV_IN and DRV_OUT,
so we can check command direction easily be using this start/end info in
both sides.


Thanks, 
Ming

