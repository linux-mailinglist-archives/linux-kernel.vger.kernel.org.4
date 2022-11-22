Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934356338E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiKVJoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKVJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:44:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE30D2CE;
        Tue, 22 Nov 2022 01:44:29 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGfRP5y2Bz6H7VF;
        Tue, 22 Nov 2022 17:41:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:44:26 +0100
Received: from localhost (10.45.149.88) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 09:44:26 +0000
Date:   Tue, 22 Nov 2022 09:44:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/mbox: Add background operation handling
 machinery
Message-ID: <20221122094422.000032f0@Huawei.com>
In-Reply-To: <20221121214804.zy6i5basztlim66t@offworld>
References: <20220804045029.2905056-1-dave@stgolabs.net>
        <20220804045029.2905056-2-dave@stgolabs.net>
        <20220825134152.00005244@huawei.com>
        <20221121214804.zy6i5basztlim66t@offworld>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.88]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon, 21 Nov 2022 13:48:04 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Thu, 25 Aug 2022, Jonathan Cameron wrote:
> 
> >> +/*
> >> + * Ensure that ->mbox_send() can run safely when a background
> >> + * command is running. If so, returns zero, otherwise -EBUSY.  
> >
> >As above, I'm not sure this is necessary given you should get
> >a sensible error code in response to any such message.
> >E.g. media disabled.  
> 
> So this is necessary to prevent mischief in the polling case
> where you can have windows where the driver is out of sync
> with the hardware - hw finishes async command but driver
> (sleeping poller) has not acknowledged this. In the irq case,
> yeah this would be redundant and not needed.
> 

Ok.  A worked example might be useful for where this matters
at a higher level.  For example, if there is no conflict at
the hardware level what goes wrong in the software as a result
of dropping the protection on the one that we haven't yet detected
as finished...

Jonathan


> Thanks,
> Davidlohr

