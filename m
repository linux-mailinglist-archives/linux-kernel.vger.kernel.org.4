Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B788B727D6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjFHLCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjFHLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:01:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716472710;
        Thu,  8 Jun 2023 04:01:22 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcLn81PWhz67fjT;
        Thu,  8 Jun 2023 18:59:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 12:01:11 +0100
Date:   Thu, 8 Jun 2023 12:01:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 2/4] tools/testing/cxl: Fix command effects for
 inject/clear poison
Message-ID: <20230608120111.00003fd2@Huawei.com>
In-Reply-To: <ZIDYHzw3sVTiOjeX@aschofie-mobl2>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
        <20230602-vv-fw_update-v2-2-e9e5cd5adb44@intel.com>
        <ZIDYHzw3sVTiOjeX@aschofie-mobl2>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 12:18:55 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Mon, Jun 05, 2023 at 02:20:23PM -0600, Vishal Verma wrote:
> > The CXL spec (3.0, section 8.2.9.8.4) Lists Inject Poison and Clear
> > Poison as having the effects of "Immediate Data Change". Fix this in the
> > mock driver so that the command effect log is populated correctly.
> > 
> > Fixes: 371c16101ee8 ("tools/testing/cxl: Mock the Inject Poison mailbox command")
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>  
> 
> Hi Vishal,
> I took a look at this, wondering if we should promote it as a 6.4 fix.
> I came up with a no. It has no user impact of inject/clear usage in the
> mock driver environment.
> 
> Thanks for fixing!
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
Agreed on patch and Alison's comment

FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > ---
> >  tools/testing/cxl/test/mem.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 34b48027b3de..403cd3608772 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -52,11 +52,11 @@ static struct cxl_cel_entry mock_cel[] = {
> >  	},
> >  	{
> >  		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> > -		.effect = cpu_to_le16(0),
> > +		.effect = cpu_to_le16(EFFECT(2)),
> >  	},
> >  	{
> >  		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> > -		.effect = cpu_to_le16(0),
> > +		.effect = cpu_to_le16(EFFECT(2)),
> >  	},
> >  };
> >  
> > 
> > -- 
> > 2.40.1
> >   
> 

