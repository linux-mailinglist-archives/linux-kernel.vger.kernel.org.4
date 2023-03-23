Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803746C6132
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjCWH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCWH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:59:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7AAF974
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:59:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D07068AA6; Thu, 23 Mar 2023 08:59:27 +0100 (CET)
Date:   Thu, 23 Mar 2023 08:59:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v6 2/2] mm/zswap: delay the initializaton of zswap
Message-ID: <20230323075927.GB20444@lst.de>
References: <20230322102006.780624-1-liushixin2@huawei.com> <20230322102006.780624-3-liushixin2@huawei.com> <CAM4kBBJT1xSGe7KthBvBLstZ43cPP-PDKE7a-6hC5Fn6TneL0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM4kBBJT1xSGe7KthBvBLstZ43cPP-PDKE7a-6hC5Fn6TneL0g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:17:12PM +0100, Vitaly Wool wrote:
> On Wed, Mar 22, 2023 at 10:30 AM Liu Shixin <liushixin2@huawei.com> wrote:
> >
> > Since some users may not use zswap, the zswap_pool is wasted. Save memory
> > by delaying the initialization of zswap until enabled.
> 
> To be honest, I'm not a huge fan of this. Would enabling zswap module
> build instead solve your problem?

making zswap build modular would be a mess.  It is core MM infrastructure
and now we'd need to start dealing with adding and removing it at
runtime as well as module refcounting.
