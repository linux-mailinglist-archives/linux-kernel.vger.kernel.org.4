Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47025E6D82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIVVBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIVVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:01:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E2D69F5;
        Thu, 22 Sep 2022 14:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1248CE2346;
        Thu, 22 Sep 2022 21:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF7C433D6;
        Thu, 22 Sep 2022 21:01:01 +0000 (UTC)
Date:   Thu, 22 Sep 2022 17:02:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arun Easi <aeasi@marvell.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH v3 1/1] tracing: Fix compile error in trace_array calls
 when TRACING is disabled
Message-ID: <20220922170204.08f91a68@gandalf.local.home>
In-Reply-To: <yq15yho3y0s.fsf@ca-mkp.ca.oracle.com>
References: <20220907233308.4153-1-aeasi@marvell.com>
        <20220907233308.4153-2-aeasi@marvell.com>
        <yq15yho3y0s.fsf@ca-mkp.ca.oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 21:32:59 -0400
"Martin K. Petersen" <martin.petersen@oracle.com> wrote:

> Steven,
> 
> Can you please review Arun's patch?

Sorry, was busy running a conference ;-)

> 
> > Fix this compilation error seen when CONFIG_TRACING is not enabled:
> >
> > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
> > drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function
> > 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'?
> > [-Werror=implicit-function-declaration]
> >  2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~
> >       |                         trace_array_set_clr_event
> >
> > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
> > drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function
> > 'trace_array_put' [-Werror=implicit-function-declaration]
> >  2869 |         trace_array_put(qla_trc_array);
> >       |         ^~~~~~~~~~~~~~~
> >  
> 

The patch looks good to me.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
