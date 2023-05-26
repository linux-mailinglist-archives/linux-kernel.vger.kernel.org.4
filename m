Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069D37126CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbjEZMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEZMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:38:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296D99;
        Fri, 26 May 2023 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lNfxSHS1UMaBMZLwessrox7ClcoojfQo4u1G/gCVpRk=; b=F8i1N0MhDb2OY0IY6jpteaJjel
        J+wgVsNwzbjVDy7D+oUdf56HV2XHl1ftpFFdeSNi4anvtzKDqtEvTvhUyW0hht2K1BNkcIYn/RCOa
        pFuadvx3d8q7hjK1Wpnip457c4/5PzOodTRcehh57MNN8Dqtl4iBNPS2I4Wht4ZhXlhkypo21wOWL
        zLYK5HJBJglOPbpotAWAk12sisYMojHMPav90HJkeECpSTPMIXgtqMfzmL4duyRKQ8WJItqg0iGs3
        7Sh5BAZyWmVsPPZgz5Fx2pC7wch4F/7ZxuuxYr1IYLKgnQZMbmoQk5PDUunf4SO4R+IPyoSDN9j7w
        naClZciw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Whg-002VDl-2Y;
        Fri, 26 May 2023 12:37:56 +0000
Date:   Fri, 26 May 2023 05:37:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared
 memory
Message-ID: <ZHCoJEkVinvsB2lZ@infradead.org>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <20230523091350.292221-2-arnaud.pouliquen@foss.st.com>
 <ZG2yw0xZ6XGGp9E5@infradead.org>
 <18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 04:01:14PM +0200, Arnaud POULIQUEN wrote:
> > As per the discussion back then: don't just blindly do the same dumb
> > thing again and fix the interfae to actually pass in a page array,
> > or iov_iter or an actually useful container that fits.
> > 
> 
> I suppose your are speaking about this discussion:
> https://lore.kernel.org/all/20221002002326.946620-3-ira.weiny@intel.com/

Yes.

> 
> If I'm not mistaken, I should modify at tee_shm_register_kernel_buf API and
> register_shm_helper inernal function, right?
> 

> What about having equivalent of shm_get_kernel_pages in an external helper (to
> defined where to put it), could it be an alternative of the upadate of the
> tee_shm API?

I think the fundamentally right thing is to pass an iov_iter to
register_shm_helper, and then use the new as of 6.3
iov_iter_extract_pages helper to extract the pages from that.  For
the kernel users you can then simply pass down an ITER_BVEC iter
that you can fill with vmalloc pages if you want.

