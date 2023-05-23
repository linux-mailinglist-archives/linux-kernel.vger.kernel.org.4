Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACA70DF91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbjEWOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjEWOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBFE9;
        Tue, 23 May 2023 07:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FB0062747;
        Tue, 23 May 2023 14:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08C9C433D2;
        Tue, 23 May 2023 14:43:48 +0000 (UTC)
Date:   Tue, 23 May 2023 10:43:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daejun Park <daejun7.park@samsung.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
Subject: Re: [PATCH v6] f2fs: add async reset zone command support
Message-ID: <20230523104347.61149ecd@rorschach.local.home>
In-Reply-To: <ZFqWr3sSYMsHtHAC@google.com>
References: <CGME20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
        <20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
        <ZFqWr3sSYMsHtHAC@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 11:53:35 -0700
Jaegeuk Kim <jaegeuk@kernel.org> wrote:

> On 05/08, Daejun Park wrote:
> > v5 -> v6
> > Added trace_f2fs_iostat support for zone reset command.
> > 
> > v4 -> v5
> > Added f2fs iostat for zone reset command.
> > 
> > v3 -> v4
> > Fixed build error caused by unused function.
> > 
> > v2 -> v3
> > Modified arguments to be correct for ftrace parameter.
> > Changed __submit_zone_reset_cmd to void return.
> > Refactored the f2fs_wait_discard_bio function.
> > Fixed code that was previously incorrectly merged.
> > 
> > v1 -> v2
> > Changed to apply the optional async reset write pointer by default.  
> 
> Don't add the history in the patch description.

Well, you can (and should) ...

> 
> > 
> > This patch enables submit reset zone command asynchornously. It helps
> > decrease average latency of write IOs in high utilization scenario by
> > faster checkpointing.
> > 
> > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > ---

But it must go below the three dashes above. That will keep 'git am'
from adding it to the change log.

-- Steve


> >  fs/f2fs/f2fs.h              |  1 +
> >  fs/f2fs/iostat.c            |  1 +
> >  fs/f2fs/segment.c           | 84 +++++++++++++++++++++++++++++++++++--
> >  include/trace/events/f2fs.h | 24 +++++++++--
> >  4 files changed, 104 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index d211ee89c158..51b68a629814 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1175,6 +1175,7 @@ enum iostat_type {
> >  	/* other */
> >  	FS_DISCARD_IO,			/* discard */
> >  	FS_FLUSH_IO,			/* flush */
> > +	FS_ZONE_RESET_IO,		/* zone reset */
> >  	NR_IO_TYPE,
> >  };
> >  
