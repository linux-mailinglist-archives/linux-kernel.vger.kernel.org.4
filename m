Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC068A89E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 07:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjBDGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 01:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDGuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 01:50:09 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5430E8D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 22:50:07 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 641E467373; Sat,  4 Feb 2023 07:50:02 +0100 (CET)
Date:   Sat, 4 Feb 2023 07:50:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Message-ID: <20230204065001.GA18482@lst.de>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com> <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:06:32PM -0800, Ira Weiny wrote:
> -	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
> +
> +	return (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) ||
> +		(addr >= __fix_to_virt(FIX_KMAP_END) &&
> +		 addr < __fix_to_virt(FIX_KMAP_BEGIN));

Isn't the second check inverted?

