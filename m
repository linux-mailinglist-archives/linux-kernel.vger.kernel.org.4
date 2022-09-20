Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF9D5BE567
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiITMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiITMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:13:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9757437A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:13:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2216D68AA6; Tue, 20 Sep 2022 14:13:06 +0200 (CEST)
Date:   Tue, 20 Sep 2022 14:13:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v5 2/5] Revert "frontswap: simplify
 frontswap_register_ops"
Message-ID: <20220920121305.GA4237@lst.de>
References: <20220915035003.3347466-1-liushixin2@huawei.com> <20220915035003.3347466-3-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915035003.3347466-3-liushixin2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 11:50:00AM +0800, Liu Shixin wrote:
> This reverts commit f328c1d16e4c764992895ac9c9425cea861b2ca0.
> 
> Since we are supported to delay zswap initializaton, we need to invoke
> ops->init for the swap device which is already online when register
> backend.

Why do we "have" to do it.  Retroactively supporting functionality on
previously enabled swap devices seems rather odd, and the amount of
cruft added for it here absolutely does not seem to be worth it.
