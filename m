Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B514660741
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjAFTjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjAFTjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:39:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A371897;
        Fri,  6 Jan 2023 11:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WDav2tQX4GhlHIZvFHwLD5Ta1F0x4Q4mp0gqLMjRTLo=; b=DyFswvBoG8itxv4n8cpLJSuvb3
        SdDsVEJOuVuUZmwrvH2iU6foOX8Kn1l+a6FhCSCsUn16wMh7pgQpd7mPvhkitb71EgIHiai5jBAuN
        102TfGSJqbJ0VpijiCJAeiI2Mxkb9BiS5z95vTaeBXfiMv+QgQ0hKo3dDrMmwzicEWY7QQv1IH/Iz
        rzLxBt4HXWG0iuB2zPULiFFdxjNZw3LQMTOT8i2cFuO+OwNYWQKBctv3I5qtYePxkKMbpFQD4AAqN
        F1J1aneU3inO7/S+WYFDaLQmNQeCv8sQ9NgM7LfWH+lYPjcHcevgoMeFzCCu+OytAynieJkGjYBha
        Zy/Al2Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDsYV-00HRmd-C8; Fri, 06 Jan 2023 19:39:07 +0000
Date:   Fri, 6 Jan 2023 19:39:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/ceph/addr: use folio_headpage() instead of
 folio_page()
Message-ID: <Y7h425xjvOUt5mI/@casper.infradead.org>
References: <20230106174028.151384-1-sj@kernel.org>
 <20230106174028.151384-4-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106174028.151384-4-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:40:28PM +0000, SeongJae Park wrote:
> -	snapc = ceph_find_incompatible(folio_page(*foliop, 0));
> +	snapc = ceph_find_incompatible(folio_headpage(*foliop));

ceph_find_incompatible() should take a folio.
