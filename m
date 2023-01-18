Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B6671108
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjARCST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjARCSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE751C74
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674008248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PP8025B7vYjGqOUOci8HcWNNJvoXEzim4g39pJBVbi4=;
        b=Vp2dr/aoU3v6Xoiiy7daHKIfyMyg1S6FYC4ox2FrS77k40dDmNJUicQPJuxv6AJhchg3S+
        uYNkLR18ItsPvWsJvceJFYHZNwPQCRoxnjMAGmhC9gCTAQBbF7LNb0gRQWxhDKbabhEcJB
        KTCeFkthjwDHp9dlIkcXgAyKPgvrHAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-g9rajeCaO32cmZEiYBLGwQ-1; Tue, 17 Jan 2023 21:17:23 -0500
X-MC-Unique: g9rajeCaO32cmZEiYBLGwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 403931871D97;
        Wed, 18 Jan 2023 02:17:23 +0000 (UTC)
Received: from localhost (ovpn-13-29.pek2.redhat.com [10.72.13.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F504C159BB;
        Wed, 18 Jan 2023 02:17:22 +0000 (UTC)
Date:   Wed, 18 Jan 2023 10:17:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, linux-mm@kvack.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        urezki@gmail.com, lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y8dWrydYsYAbnMwT@fedora>
References: <20230113031921.64716-4-bhe@redhat.com>
 <202301132345.KVjvHMFq-lkp@intel.com>
 <Y8QI977QBDbuuGW5@fedora>
 <Y8VMUUOlkwuu5xn6@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8VMUUOlkwuu5xn6@kadam>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/23 at 04:08pm, Dan Carpenter wrote:
> On Sun, Jan 15, 2023 at 10:08:55PM +0800, Baoquan He wrote:
> > > f181234a5a21fd0 Chen Wandun             2021-09-02  3650  	if ((unsigned long)addr + count <= va->va_start)
> > > f181234a5a21fd0 Chen Wandun             2021-09-02  3651  		goto finished;
> > > f181234a5a21fd0 Chen Wandun             2021-09-02  3652  
> > > f608788cd2d6cae Serapheim Dimitropoulos 2021-04-29  3653  	list_for_each_entry_from(va, &vmap_area_list, list) {
> > > e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3654  		if (!count)
> > > e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3655  			break;
> > > e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3656  
> > > 129dbdf298d7383 Baoquan He              2023-01-13  3657  		vm = va->vm;
> > > 129dbdf298d7383 Baoquan He              2023-01-13  3658  		flags = va->flags & VMAP_FLAGS_MASK;
> > > 129dbdf298d7383 Baoquan He              2023-01-13  3659  
> > > 129dbdf298d7383 Baoquan He              2023-01-13  3660  		if (!vm && !flags)
> > >                                                                             ^^^
> > > vm can be NULL if a flag in VMAP_FLAGS_MASK is set.
> > > 
> > > e81ce85f960c2e2 Joonsoo Kim             2013-04-29  3661  			continue;
> > 
> > Right, after the 'continue;' line, only two cases could happen when it
> > comes here. (vm != null) or (vm->flags & VMAP_RAM) is true.
> >
> 
> You're saying VMAP_RAM, but strictly speaking the code is checking
> VMAP_FLAGS_MASK and not VMAP_RAM.
> 
> +#define VMAP_RAM               0x1 /* indicates vm_map_ram area*/
> +#define VMAP_BLOCK             0x2 /* mark out the vmap_block sub-type*/
> +#define VMAP_FLAGS_MASK                0x3
> 
> If we assume that vm is NULL, VMAP_BLOCK is set and VMAP_RAM is clear
> then it would lead to a NULL dereference.  There might be reasons why
> that combination is impossible outside the function but we can't tell
> from the information we have here.

VMAP_BLOCK has no chance to be set alone. It has to be set together with
VMAP_RAM if needed.

> 
> Which is fine, outside information is a common reason for false
> positives with this check.  But I was just concerned about the mix of
> VMAP_FLAGS_MASK and VMAP_RAM.

Thanks, I see your point now, will consider how to improve it.

