Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E673B8C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFWN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFWN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:29:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0F1715;
        Fri, 23 Jun 2023 06:28:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QndL036jMz6J7Yh;
        Fri, 23 Jun 2023 21:26:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Jun
 2023 14:28:57 +0100
Date:   Fri, 23 Jun 2023 14:28:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <Terry.Bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v6 25/27] cxl/pci: Disable root port interrupts in RCH
 mode
Message-ID: <20230623142856.000004c5@Huawei.com>
In-Reply-To: <7c11f087-72ee-eb18-cdcb-774d7848dcef@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
        <20230622035126.4130151-26-terry.bowman@amd.com>
        <20230622141255.00006d13@Huawei.com>
        <7c11f087-72ee-eb18-cdcb-774d7848dcef@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 11:33:30 -0500
Terry Bowman <Terry.Bowman@amd.com> wrote:

> Hi Jonathan,
> 
> On 6/22/23 08:12, Jonathan Cameron wrote:
> > On Wed, 21 Jun 2023 22:51:24 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> The RCH root port contains root command AER registers that should not be
> >> enabled.[1] Disable these to prevent root port interrupts.  
> > 
> > I'm a little dubious about a 'because the spec says' so argument.
> > If we can describe the path by which spurious interrupts turn up then
> > great - if not then fair enough.
> >   
> 
> This was added to follow the spec. The RCH downstream port contains
> root port control pci express capability for enabling and disabling root
> port interrupts. The interrupts are (should be) disabled by default at
> powerup according to the PCI spec. We know SW does not enable because
> the RCH downstream port is not enumerated or managed by a port driver. I
> cant say this patch is absolutely necessary but was not comfortable with
> removing it either and want to avoid undefined behavior.
> 
Maybe we should just abuse firmware authors and blame them for potentially
having changed the default :)

Fine as is.

Jonathan

> Regards,
> Terry

