Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5462AFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKPAQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKPAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:16:49 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12CE221
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:16:48 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFNwnfa002480;
        Tue, 15 Nov 2022 16:16:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=OQLI4EDoVwOr7/gs4v6zYvhxEc+H3IWBKnn/Bw7lN6w=;
 b=HquLrZJoiQjZlIx5rYoZxCf0NJ/S+2SyR4Ij0gA3nz1VPMcmFI4wcZvxhpheCr5BX7Xq
 t48THcqw3+dxULgyA4oEDp62YX/h3VfDw0KYxOwoHyeSQHxd22BavX9Gyz1eJB2vseVf
 c3BVYBUW0wnEF7+NDQmmGDUKEVga0MKe0VKbfJL22zswrp8DXAo7gS9wmnpx9CAo2iJA
 KdIQh/qCrOpuQdKcwZhv6ttpVCtx/EXWQzWqa5hU564+r+cgFz2F6IiAAXQXhM/Fdm8Q
 T40+THkU+zxsFzveB+KCfyx3DLNpS3d1tsWO9ToFLHR76h3bRgaL7hxoa1E5mGRibq0m Tw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3kvmwsr20b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 16:16:37 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Nov
 2022 16:16:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Nov 2022 16:16:35 -0800
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 67CA25C68EB;
        Tue, 15 Nov 2022 16:16:35 -0800 (PST)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 2AG0GXKP011918;
        Tue, 15 Nov 2022 16:16:33 -0800
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Tue, 15 Nov 2022 16:16:33 -0800
From:   Arun Easi <aeasi@marvell.com>
To:     Aashish Sharma <shraash@google.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH] tracing: Fix warning on variable 'struct
 trace_array'
In-Reply-To: <20221107160556.2139463-1-shraash@google.com>
Message-ID: <41b8a9ba-955b-cf80-118f-f0c2bad619ae@marvell.com>
References: <20221107160556.2139463-1-shraash@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: ibREQ7sqMrxC3K9MBB78BehLVs7AyhRk
X-Proofpoint-GUID: ibREQ7sqMrxC3K9MBB78BehLVs7AyhRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022, 8:05am, Aashish Sharma wrote:

>
> ----------------------------------------------------------------------
> Move the declaration of 'struct trace_array' out of #ifdef
> CONFIG_TRACING block, to fix the following warning when CONFIG_TRACING
> is not set:
> 
> >> include/linux/trace.h:63:45: warning: 'struct trace_array' declared
> inside parameter list will not be visible outside of this definition or
> declaration
> 
> Fixes: 1a77dd1c2bb5 ("scsi: tracing: Fix compile error in trace_array calls when TRACING is disabled")
> Cc: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> ---
>  include/linux/trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index b5e16e438448..80ffda871749 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -26,13 +26,13 @@ struct trace_export {
>  	int flags;
>  };
>  
> +struct trace_array;
> +
>  #ifdef CONFIG_TRACING
>  
>  int register_ftrace_export(struct trace_export *export);
>  int unregister_ftrace_export(struct trace_export *export);
>  
> -struct trace_array;
> -
>  void trace_printk_init_buffers(void);
>  __printf(3, 4)
>  int trace_array_printk(struct trace_array *tr, unsigned long ip,
> 

Looks good. Thanks!

I was wondering why I did not see this when I compiled the kernel without 
TRACING (for 1a77dd1c2bb5). Apparently, I had linux/trace_events.h 
included, which does exactly this. Anyway, makes sense to move this 
outside the #ifdef block.

Regards,
-Arun
