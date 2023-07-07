Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3221D74AA19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGGExI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjGGExD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1C1171D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688705535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7pwbnzYY/p7uGUW3A3qN56fgcKfDOKQ6q9IAzS1rSE=;
        b=jA3eZWQjeQNv/+U/l/tSwATH0vcTAe7B31mm7DOok+xcEPtGl+JFVblK2yjzgoXyGl9NJO
        rN1Fi1ihH6anBNwuR+ywoH5/lQSKnCazKSrPF0dOOoIkLEtDkE3XU7d3EfwTP+L+FB5gBz
        F+9EOSk6oCV6UUnVHZhli7/TV40911s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-DClvOqqvOneubNECKINg2A-1; Fri, 07 Jul 2023 00:52:12 -0400
X-MC-Unique: DClvOqqvOneubNECKINg2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7D4581D9EC;
        Fri,  7 Jul 2023 04:52:11 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 185B5145414B;
        Fri,  7 Jul 2023 04:52:09 +0000 (UTC)
Date:   Fri, 7 Jul 2023 12:52:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, agordeev@linux.ibm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <ZKeZ9i3bSPOWJ3ZM@MiWiFi-R3L-srv>
References: <20230707085437.28b9c898@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707085437.28b9c898@canb.auug.org.au>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/23 at 08:54am, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mm tree got a conflict in:
> 
>   arch/s390/kernel/perf_cpum_sf.c
> 
> between commits:
> 
>   51f513fd9659 ("s390/mm: do not include <asm-generic/io.h> directly")
>   b378a9826143 ("s390: include linux/io.h instead of asm/io.h")

Thanks, Stephen.

Hi Alexander,

Since commit b378a9826143 acted to fix all places of <asm-generic/io.h>
direct including, my patch of commit 51f513fd9659 better be dropped?

> 
> from Linus' tree and commit:
> 
>   c594d5c4b630 ("s390: mm: convert to GENERIC_IOREMAP")

I forgot dropping the hunk in arch/s390/kernel/perf_cpum_sf.c and that
cause the conflict. Sorry about the inconvenience.

Thanks
Baoquan

> 
> from the mm tree.
> 
> I fixed it up (I just used the former) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell


