Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C66F624C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEDAME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEDAMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:12:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3649F5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 17:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B3C62D0D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AC0C433EF;
        Thu,  4 May 2023 00:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683159120;
        bh=7vQ5LtU82wHXy4yqeGR03FmQei9dn4hIyS7S4R5ZW4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp1mKLKJrv+lOUYMAgOQ2vCR+mAWQ1yUjC+1eZMv6423cUtI/pqYxKQmbxUz6xMNB
         HBZa+gd0cYPefotDmhuRUOUb/BYglfd4aEikWoR2aT3HGtNAoZIpfGYZVDiMZOMlJh
         VnfBcAUQMpx0NFoQU+ek65mAiDwJ1YM3EpgFMXRa3w2Krrqjv1CEgd7bn/7hAbQlks
         B5b05e1egjpTqgyb99INaR4/OrXJUDxD6HixJthRdi6FN6ldYzL/sQfnh+QMVqM/DE
         miTpi37l+6I+bYeO42zdpC60AKQyJPNehJraaEX0LBlXYS9IvFmXKPBHZXFyf6THLY
         G1++9/5+L1jsg==
Date:   Wed, 3 May 2023 17:11:58 -0700
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
Message-ID: <ZFL4Tvm8KKrCfjRr@google.com>
References: <20230411093632.822290-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411093632.822290-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shixing,

On Tue, Apr 11, 2023 at 05:36:29PM +0800, Liu Shixin wrote:
> In the initialization of zswap, about 18MB memory will be allocated for
> zswap_pool. Since some users may not use zswap, the zswap_pool is wasted.
> Save memory by delaying the initialization of zswap until enabled.

Sorry I am late to this discussion. I notice you are already at V9.
Anyway, I am curious how much of the 18MB was came from the zswap_pool
alone and how much of it came from the other part of the initialization.

If it is the zswap_pool alone, it means that we can have a smaller patch
to get most of your 18M back.

I also notice you move a lot of __init function back to normal functions.
That would mean those functions wouldn't be able to drop after the
initialization phase. That is another reason to move less of the initialization
function.

Chris

