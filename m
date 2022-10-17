Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE052600C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJQKJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiJQKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:09:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A04444A4;
        Mon, 17 Oct 2022 03:09:00 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrXgj34M9z67P77;
        Mon, 17 Oct 2022 18:05:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 17 Oct 2022 12:08:58 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 11:08:57 +0100
Date:   Mon, 17 Oct 2022 11:08:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mbox: Wire up basic irq support
Message-ID: <20221017110856.00001dee@huawei.com>
In-Reply-To: <Y0yAX1fTCHhKKzeb@iweiny-desk3>
References: <20221014194930.2630416-1-dave@stgolabs.net>
        <20221014194930.2630416-3-dave@stgolabs.net>
        <Y0yAX1fTCHhKKzeb@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 15:06:23 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Fri, Oct 14, 2022 at 12:49:30PM -0700, Davidlohr Bueso wrote:
> > This adds support for mailbox interrupts, which are needed, for
> > example, for background completion handling.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
...

> > +				     IRQF_SHARED, "mailbox", cxlds))
> > +			dev_dbg(dev, "Mailbox irq (%d) supported", irq);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -441,7 +464,9 @@ struct cxl_irq_cap {
> >  	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> >  };
> >  
> > -static const struct cxl_irq_cap cxl_irq_cap_table[] = { NULL };
> > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {

Trivial patch mangling point but better to have the NULL on separate line
in previous patch to reduce the diff here.

> > +	{ "mailbox", cxl_pci_mbox_get_max_msgnum }

trailing comma needed as we definitely expect to add more entries!

> > +};
> >  
> >  static void cxl_pci_free_irq_vectors(void *data)
> >  {
> > -- 
> > 2.37.3
> >   

