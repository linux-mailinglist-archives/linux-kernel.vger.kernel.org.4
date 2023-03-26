Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96B56C98AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCZXZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:25:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4C46B5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:25:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1016668B05; Mon, 27 Mar 2023 01:25:09 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:25:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v7 2/4] mm/zswap: skip invalid or unchanged
 parameter
Message-ID: <20230326232508.GB19631@lst.de>
References: <20230325071420.2246461-1-liushixin2@huawei.com> <20230325071420.2246461-3-liushixin2@huawei.com> <20230326031723.GD3269998@google.com> <20230326045327.GE3269998@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326045327.GE3269998@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 01:53:27PM +0900, Sergey Senozhatsky wrote:
> > > +	if (kstrtobool(val, &res))
> > > +		return -EINVAL;
> > > +
> > > +	/* no change required */
> > > +	if (res == *(bool *)kp->arg)
> > > +		return 0;
> > 
> > Bool kernel param can be any of these letters 'YyTt1NnFf0'. Doing things
> > to kp->arg outside of kernel/params.c is not going to be easy, let's not
> > even try.
> 
> Please disregard my previous email. kp->arg is always true or false
> at this point. I'd still prefer to not do kp->arg in zswap.

The whole parameter handling in zswap is a mess and I don't really
have a good idea how to solve it all.

But for this "paramter not changed" case I think we can helper a lot
by adding a core moduleparam.h helper to encapsule it.  I.e.:

static inline bool param_bool_unchanged(bool val,
		const struct kernel_param *kp)

	return val == *(bool *)kp->arg);
}

and at least keep it out of zswap.
