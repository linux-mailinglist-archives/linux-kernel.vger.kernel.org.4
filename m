Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63086F6E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjEDOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjEDOzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831A6A63
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43490634D5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D084C433EF;
        Thu,  4 May 2023 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683212001;
        bh=JtHqAGboykoAImyeKUt8Zs/yjaM1bIcB2ckLW3b0W9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUCjHN5Q6rOzRLlP9q72SQRY49uwCXZO+3dVjy/S3qRxQZf50fdET8ACBkDf2F/e2
         tTSSBi1r1lIOxQHEQEY6H+xvRkp9Ikk29ZDJ/eneqKY8Pu8RmgH6o/451+cM9cGWLU
         W9CtZCEbN3AIr02jLo9PEjjJ0P+rMCtiLeaUPtheuLAR0MhcVB/iehGq7WFJk6M6AU
         QMgWe5ZlFBYJ2tj85OAc6M/5ZQGAqY94o2/B1QU2iSDpkSMj78dMfJmt98R7Ta4kl6
         ge4Kmr3yPzBFGqnJNwCajeBkpIBKeDGlYVoNHTZYDKUVxk54PfNXbzLLmwY+QyWYo0
         oJbppP2vdCSGw==
Date:   Thu, 4 May 2023 07:53:18 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v9 0/3] Delay the initialization of zswap
Message-ID: <ZFPG3swMcHW/qxID@google.com>
References: <20230411093632.822290-1-liushixin2@huawei.com>
 <ZFL4Tvm8KKrCfjRr@google.com>
 <9b2b6dac-9a3d-efcb-9706-44f6df1fe2bf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b2b6dac-9a3d-efcb-9706-44f6df1fe2bf@huawei.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 03:11:05PM +0800, Liu Shixin wrote:
> >
> > If it is the zswap_pool alone, it means that we can have a smaller patch
> > to get most of your 18M back.
> You're right, the most came from zswap_pool.

Thanks for the confirmation.

> > I also notice you move a lot of __init function back to normal functions.
> > That would mean those functions wouldn't be able to drop after the
> > initialization phase. That is another reason to move less of the initialization
> > function.
> Thanks for your advice. I've thought about it before, but I thought there is less impact
> for the size of kernel, so I didn't do it.

Let's first agree on the hypothetical patch that only delaying zswap_pool would
have the benefit over V9 on:
- smaller patch, less invasive.
- less kernel text area due to more __init function got free after initialization.

If we can reach that agreement, then we can discuss how we can get there.

I think there is a possibility that the delay initialization of zswap_pool
can fall into the "zswap_has_pool = false" case, so you don't need to have
the initialization mutex.  Simpler.

I have my selfish reason as well. I have a much larger pending patch against
the zswap code so the smaller patch would mean less conflict for me.

I am guilty of giving this feedback late. If you come up with a V10, I will be glad
to review it. Or, if you prefer, I can come up with the smaller patch for you
to review as well. What do you say?

Chris

