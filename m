Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3860B355
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiJXRDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiJXRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6B1A6513
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44EFA61407
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C123CC433D7;
        Mon, 24 Oct 2022 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625873;
        bh=J9pT4nyGeEtb9WbnqsO0aJ6Tb24OwN80e5SPk1Da/xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGtUmlhNApE1czrXF/24y3XSZlsttXNQPQH8WWReLPbEPUy1M617Ph8mZ4vHL7VOy
         22BMhUxomhdnmAbtPi87r1UqndX1TD6eUv1qjia4u5XBYBcRiy8nJAXKDSGsNdUPKn
         SJ1iy9w6rfVuCE5saEoZWZsLZz+QVEMhYrDR34wqf/2zYuC3+iU7+jw9jTaKSjJ1aC
         AcP+SezpGhNg2gTrbO/7BYay2w8+JURPd2mz+e8VxV51R7+wJZDuG16RVKlLrckCWF
         A/QQgunLljwKdYPD2kqzMBjNayA306jJRLuCXvlC6DKK+Y5zq0YPS5B/DvCa7RKLx+
         ugeb3+RnzhLig==
Date:   Mon, 24 Oct 2022 18:37:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     shaoqin.huang@intel.com
Cc:     David Hildenbrand <david@redhat.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: Re: [PATCH v4 0/3] Add tests trying to memblock_add() or
 memblock_reserve() 129th region
Message-ID: <Y1axQhbZlZ3lXion@kernel.org>
References: <20221011062128.49359-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011062128.49359-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:21:19PM +0800, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> These tests is aimed for testing the memblock_double_array() can work normal. It
> will using the dummy_physical_memory_init() to add the valid memory region into
> the memblock.memory, and this memory region will be choosed when
> memblock_double_array() to allocate the new memory region to double the regions.
> Thus the new memory.regions or reserved.regions will occupy the valid memory
> region, and the memory.max and reserved.max also being doubled. Check all of
> these changed stuff, to make sure it actually success.
> 
> Changelog:
> ----------
> v4:
>   - Increase the MEM_SIZE to SZ_32K. And makes the calculation process in
>   memblock_add_many_check() more simpler.
> v3:
>   - Avoid to allocated multiple memory region from dummy_physical_memory_base(),
>   split the memory into different part instead.
>   - Some comments improvement.
> v2:
>   - Modify the get_memory_block_base() to dummy_physical_memory_base().
>   - memory_add() the memory which is allocated from dummy_physical_memory_init()
>   instead of some faked memory.
>   - Add more comments to illustrate the test process.
>   - Add a function dummy_physical_memory_cleanup_many() to free multiple memory
>   which is allocated from dummy_physical_memory_init().
> 
> Shaoqin Huang (3):
>   memblock test: Add test to memblock_add() 129th region
>   memblock test: Add test to memblock_reserve() 129th region
>   memblock test: Update TODO list
> 
>  tools/testing/memblock/TODO              |  11 +-
>  tools/testing/memblock/tests/basic_api.c | 184 +++++++++++++++++++++++
>  tools/testing/memblock/tests/common.c    |   7 +-
>  tools/testing/memblock/tests/common.h    |   6 +-
>  4 files changed, 196 insertions(+), 12 deletions(-)

Applied, thanks!

-- 
Sincerely yours,
Mike.
