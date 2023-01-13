Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77BF6699AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbjAMOOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjAMONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B7BE1E;
        Fri, 13 Jan 2023 06:10:13 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntjwp0l1rz6J9Zg;
        Fri, 13 Jan 2023 22:10:02 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 14:10:11 +0000
Date:   Fri, 13 Jan 2023 14:10:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Fix Payload Length check for Get Log
 command
Message-ID: <20230113141010.000075d8@Huawei.com>
In-Reply-To: <Y8FfNA2Se9UIVJAJ@rric.localdomain>
References: <20230104202954.1163366-1-rrichter@amd.com>
        <20230113115354.00003d5a@Huawei.com>
        <Y8FfNA2Se9UIVJAJ@rric.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Fri, 13 Jan 2023 14:40:04 +0100
Robert Richter <rrichter@amd.com> wrote:

> On 13.01.23 11:53:54, Jonathan Cameron wrote:
> > On Wed, 4 Jan 2023 21:29:54 +0100
> > Robert Richter <rrichter@amd.com> wrote:
> >   
> > > Commit 2aeaf663b85e introduced strict checking for variable length
> > > payload size validation. The payload length of received data must
> > > match the size of the requested data by the caller except for the case
> > > where the min_out value is set.
> > > 
> > > The Get Log command does not have a header with a length field set.
> > > The Log size is determined by the Get Supported Logs command (CXL 3.0,
> > > 8.2.9.5.1). However, the actual size can be smaller and the number of
> > > valid bytes in the payload output must be determined reading the
> > > Payload Length field (CXL 3.0, Table 8-36, Note 2).
> > > 
> > > Two issues arise: The command can successfully complete with a payload
> > > length of zero. And, the valid payload length must then also be
> > > consumed by the caller.
> > > 
> > > Change cxl_xfer_log() to pass the number of payload bytes back to the
> > > caller to determine the number of log entries. Implement the payload
> > > handling as a special case where mbox_cmd->size_out is consulted when
> > > cxl_internal_send_cmd() returns -EIO. A WARN_ONCE() is added to check
> > > that -EIO is only returned in case of an unexpected output size.
> > > 
> > > Logs can be bigger than the maximum payload length and multiple Get
> > > Log commands can be issued. If the received payload size is smaller
> > > than the maximum payload size we can assume all valid bytes have been
> > > fetched. Stop sending further Get Log commands then.
> > > 
> > > On that occasion, change debug messages to also report the opcodes of
> > > supported commands.
> > > 
> > > The variable payload commands GET_LSA and SET_LSA could be also
> > > affected by this strict check, but SET_LSA cannot be broken because
> > > SET_LSA does not return an output payload, and GET_LSA never expects
> > > short reads.
> > > 
> > > Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> > > Signed-off-by: Robert Richter <rrichter@amd.com>  
> > Hi Robert, a few comments inline.  
> 
> Oh, just found your comments here after replying to the other mail
> thread.
> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/cxl/core/mbox.c | 28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index b03fba212799..e93df0d39022 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -170,6 +170,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
> > >  	out_size = mbox_cmd->size_out;
> > >  	min_out = mbox_cmd->min_out;
> > >  	rc = cxlds->mbox_send(cxlds, mbox_cmd);
> > > +	if (WARN_ONCE(rc == -EIO, "Bad return code: -EIO"))  
> > 
> > This is unusual. Why the WARN_ONCE?  How can an error code
> > be bad?  It may well panic.  Fine to have a dev_err() or similar
> > but this seems excessive.  
> 
> This function should only return -EIO if the size is unexpected. The
> mbox_send() function doesn't have a size information and should never
> return with -EIO. I think a comment is need here?

Makes sense.  A comment so we don't forget the reasoning would be great.

Thanks,

Jonathan


