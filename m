Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C3728FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjFIGJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0E1FE6;
        Thu,  8 Jun 2023 23:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A05261560;
        Fri,  9 Jun 2023 06:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD7C433D2;
        Fri,  9 Jun 2023 06:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686290959;
        bh=VymAURH6DqwhMHojBPt5ZuPQYK69zpD8+HmhzERJHQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUcm9vafTjmhcgggePjJmaz/CH0W+mbeHr5qrrQwiB0h1f0JVSlBxyQKzOgMopEnY
         lFRs6FwN6lXiIizorV33KI6IMNKLqQPxpXoK4tRUII5GGb3Z08TYo2zB8FwXnZmiP8
         Hwt8ucnJj7jNCiplSapmsMgpbeFiRHshdQZliN6g=
Date:   Fri, 9 Jun 2023 08:09:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, qemu-devel@nongnu.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        jmarchan@redhat.com, muchun.song@linux.dev,
        James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
Message-ID: <2023060908-pretender-boastful-cbb9@gregkh>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608204927.88711-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:49:27PM -0700, Mike Kravetz wrote:
> This effectively reverts commit 16c243e99d33 ("udmabuf: Add support
> for mapping hugepages (v4)").  Recently, Junxiao Chang found a BUG
> with page map counting as described here [1].  This issue pointed out
> that the udmabuf driver was making direct use of subpages of hugetlb
> pages.  This is not a good idea, and no other mm code attempts such use.
> In addition to the mapcount issue, this also causes issues with hugetlb
> vmemmap optimization and page poisoning.
> 
> For now, remove hugetlb support.
> 
> If udmabuf wants to be used on hugetlb mappings, it should be changed to
> only use complete hugetlb pages.  This will require different alignment
> and size requirements on the UDMABUF_CREATE API.
> 
> [1] https://lore.kernel.org/linux-mm/20230512072036.1027784-1-junxiao.chang@intel.com/
> 
> Fixes: 16c243e99d33 ("udmabuf: Add support for mapping hugepages (v4)")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
