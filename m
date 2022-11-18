Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5462EED2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbiKRIBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKRIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:01:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD686A1AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KQNE2xd9tPn0Zb+jKbifQFfOM1ctrKpJPYI8m278BgE=; b=STi4dfBwrwhIaA6LQJCigXd/CS
        QJd+ZKlBmAivBILmPYix3Bojwl11I7oysAfqyycSgTjfUBzj5uvir5xD0lpGJuJk/eU7UJK0y0j8g
        /bs9y8EFW8cHZLWbR8lBRBgaPwv3MrU65OYE+NzKodQt31mzucr8gtXATlRFynUBWAUeyUmaUtVLB
        fw6SW67c2V3NERVa/mtEFfx5w5cV1fhorDMo6IZYHr6scYXnaeeP2pByG03vbTn3EMcPjeIIeLovj
        jleiqGne2VVPnKAhBAsbSPqCbVPPg261JoPjMP5FWwYN7YQ+vrje9JG3sFvDLs0cnyP0Xbbxu3xG1
        BN6hz7qw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovwJq-0024WM-Tv; Fri, 18 Nov 2022 08:01:50 +0000
Date:   Fri, 18 Nov 2022 08:01:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y3c77o95A9vKQ745@casper.infradead.org>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109033535.269229-4-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:35:34AM +0800, Baoquan He wrote:
> Currently, vread() can read out vmalloc areas which is associated with
> a vm_struct. While this doesn't work for areas created by vm_map_ram()
> interface because it doesn't allocate a vm_struct. Then in vread(),
> these areas will be skipped.
> 
> Here, add a new function vb_vread() to read out areas managed by
> vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> and handle  them respectively.

i don't understand how this deals with the original problem identified,
that the vread() can race with an unmap.
