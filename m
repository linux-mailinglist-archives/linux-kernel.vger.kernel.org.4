Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C96D3E58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjDCHpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:45:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68B0461AE;
        Mon,  3 Apr 2023 00:45:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F195FEC;
        Mon,  3 Apr 2023 00:45:49 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F55C3F6C4;
        Mon,  3 Apr 2023 00:45:03 -0700 (PDT)
Date:   Mon, 3 Apr 2023 08:45:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH] perf/arm-cmn: fix regitster offset of
 CMN_MXP__CONNECT_INFO_P2-5
Message-ID: <ZCqD/HlIRgewdnwA@FVFF77S0Q05N>
References: <1680169620-26012-1-git-send-email-renyu.zj@linux.alibaba.com>
 <3b95e362-300a-12af-0d55-76672c60be9f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b95e362-300a-12af-0d55-76672c60be9f@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:34:22AM +0100, Robin Murphy wrote:
> On 2023-03-30 10:47, Jing Zhang wrote:
> > In the CMN700 specification, it is described that the address offset
> > of the mxp_device_connect_info_p0-5 register is 16'h8 + #{8*index}.
> > Therefore, the address offset of the CMN_MXP__CONNECT_INFO_P2-5 macro
> > defined in the code is wrong, which causes the cmn700 topology map
> > incorrect printed in debugfs.
> > 
> > So correct the address offset value to make the cmn700 topology map
> > correct in debugfs.
> > 
> > Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
> 
> Ugh, these offsets are correct for CI-700, so strictly that commit is fine.
> What I failed to notice is that CMN-700 shuffled the mesh_port_connect_info
> registers out of the way, so it's commit 23760a014417 which should have
> added more handling for this difference.

I'm assuming that means that this patch breaks !CMN-700 ?

i.e. a more substantial fix is necessary, and it's not just a matter of
changing the Fixes tag.

Thanks,
Mark.

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> > Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> > ---
> >   drivers/perf/arm-cmn.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> > index 1deb61b..e9f844b 100644
> > --- a/drivers/perf/arm-cmn.c
> > +++ b/drivers/perf/arm-cmn.c
> > @@ -59,10 +59,10 @@
> >   /* XPs also have some local topology info which has uses too */
> >   #define CMN_MXP__CONNECT_INFO_P0	0x0008
> >   #define CMN_MXP__CONNECT_INFO_P1	0x0010
> > -#define CMN_MXP__CONNECT_INFO_P2	0x0028
> > -#define CMN_MXP__CONNECT_INFO_P3	0x0030
> > -#define CMN_MXP__CONNECT_INFO_P4	0x0038
> > -#define CMN_MXP__CONNECT_INFO_P5	0x0040
> > +#define CMN_MXP__CONNECT_INFO_P2	0x0018
> > +#define CMN_MXP__CONNECT_INFO_P3	0x0020
> > +#define CMN_MXP__CONNECT_INFO_P4	0x0028
> > +#define CMN_MXP__CONNECT_INFO_P5	0x0030
> >   #define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
> >   /* PMU registers occupy the 3rd 4KB page of each node's region */
