Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29F672E80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjASBxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjASBxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:53:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70956DB18
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:49:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8514D60684
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B544DC433EF;
        Thu, 19 Jan 2023 01:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674092966;
        bh=fdFF2OaMWXDBkxzhr2snVJKR68kmvzno7bMlUn5Eirc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjIj96GxNIV0MW/vuyH04/n8Eqb8E2EVCjs+0hLQ2jHOTMDjX1NMhwAMeijmBN46A
         xLLSLvnqVIx2Fl4s8WIRhTwGlrDvbvgnk8Kbd1/52ZEMun58Bm1tgiWQ6hD9UaxWCz
         2BjiPPynSKp1uMHWnwSKJXtTKwjcj6k3fPhTou1voD47B0ADwhnHkGVUlhoT7PRsbh
         eFLfPTz1zfa17SZ5pFCkRn5KePPM0iLfNUTUlo1RyPUAPV4On2Jw4cNhzjOdk2kV+f
         6TzUzfGdSAWKHAkwW1Qo+HjyiBeTDQ9h/7x/WT7ZbCBHJAqaMDNF4qYJoNEoC7BoG/
         YniDwLC78ya+Q==
Date:   Wed, 18 Jan 2023 17:49:25 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix to avoid potential memory
 corruption in __update_iostat_latency()
Message-ID: <Y8ihpXw81e2FH2um@google.com>
References: <da57fbad-8242-eb1e-ab2b-322d61d0762d@kernel.org>
 <20230116134755.40119-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116134755.40119-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16, Yangtao Li wrote:
> Hi Chao,
> 
> > Maybe it's betterr to merge these two check condition as below?
> >
> > if (iotype >= NR_PAGE_TYPE) {
> > 	f2fs_bug_on(sbi, iotype != META_FLUSH);
> > 	iotype = META;
> > }
> 
> For normal , only META_FLUSH will be greater than NR_PAGE_TYPE,
> there is no problem with this logic.
> 
> >
> > For CHECK_FS is off case, I guess it's fine to not return and just print
> > warning message for notice.
> 
> But if there is an exception, we don't know the type we originally wanted to count.
> If they are all changed to meta, it is possible to get a wrong statistic. I think
> there is no need to make statistics on this kind of error scene. Just like in the
> next patch, if iostat_lat_type is wrong, we should return directly instead of changing
> the value beyond the range to WRITE_ASYNC_IO.
> 
> So it's no need tp merge these two check condition?

I also prefer to do like Chao's comment. We don't need to expect such exception
at all.

And, it seems we just need to do like:

	enum page_type iotype;

	if (iotype == META_FLUSH) {
		iotype = META;
	} else if (iotype >= NR_PAGE_TYPE) {
		f2fs_warn();
		return;
	}

> 
> Thx,
> Yangtao
