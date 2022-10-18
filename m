Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8571E60287E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJRJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJRJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:38:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F2B7CA9C;
        Tue, 18 Oct 2022 02:38:19 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ms80D3MQlz6HJ8p;
        Tue, 18 Oct 2022 17:37:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:38:17 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 10:38:16 +0100
Date:   Tue, 18 Oct 2022 10:38:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mbox: Wire up irq support
Message-ID: <20221018103815.00003cb2@huawei.com>
In-Reply-To: <20221018030010.20913-3-dave@stgolabs.net>
References: <20221018030010.20913-1-dave@stgolabs.net>
        <20221018030010.20913-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Mon, 17 Oct 2022 20:00:10 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> With enough vectors properly allocated, this adds support for
> (the primary) mailbox interrupt, which is needed for background
> completion handling, beyond polling.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Whilst I get the need for an example, I'd rather this didn't
go in until we have that background handler in place.

Unused infrastructure tends to rot or not be quite what is
needed.

Follow up comment below.

Jonathan


>  static void cxl_pci_free_irq_vectors(void *data)
> @@ -562,6 +588,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  
>  	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
> +		cxl_pci_mbox_irqsetup(cxlds);

Ah. That rather wrecks my previous suggestion :)

>  		cxlds->has_irq = true;
>  	} else
>  		cxlds->has_irq = false;

