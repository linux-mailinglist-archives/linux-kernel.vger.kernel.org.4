Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D169DF04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjBULjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjBULjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:39:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B15FC7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676979495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lc55WDFRFvw1Vqs+va6mBFAzuHzoJKokLr1Q4rpkAYA=;
        b=DLldV7KvGzOm37fIb99sv+pbpgN1diDX1o5ikjCaUss82D4sUMy9aHaK1xz0C5/IvVa5iD
        TRRUbfeNsRhB2mF3Wb4Q77Vc+QBn8NHwLeF2uQvcOXOcF1nlUD9O1LoNGJPsGnW1pARHxy
        H62/oV+nSP4rqv02WbTKWZ/kPK4Xx1E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-P12RHNW_OgiRhzsFU9gIjw-1; Tue, 21 Feb 2023 06:38:14 -0500
X-MC-Unique: P12RHNW_OgiRhzsFU9gIjw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC11A3C16E88;
        Tue, 21 Feb 2023 11:38:13 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0224C492B05;
        Tue, 21 Feb 2023 11:38:12 +0000 (UTC)
Date:   Tue, 21 Feb 2023 19:38:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@infradead.org, mcgrof@kernel.org
Subject: Re: [RFC PATCH 2/2] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <Y/StIdIVz3iP00UP@MiWiFi-R3L-srv>
References: <20230221060723.26291-1-bhe@redhat.com>
 <20230221060723.26291-3-bhe@redhat.com>
 <CAMuHMdV4efVX8X1KoLJ-3pmzsxnU6TODw3b_37ZK771rfrqi7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV4efVX8X1KoLJ-3pmzsxnU6TODw3b_37ZK771rfrqi7A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/23 at 11:03am, Geert Uytterhoeven wrote:
> Hi Baoquan,
> 
> Thanks for your patch!
> 
> On Tue, Feb 21, 2023 at 7:36 AM Baoquan He <bhe@redhat.com> wrote:
> > ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> > extension, and on ia64 with its slightly unconventional ioremap()
> > behavior, everywhere else this is the same as ioremap() anyway.
> >
> > So here, remove the ioremap_uc() definition in architecutures other
> > than x86 and ia64. These architectures all have asm-generic/io.h
> > included and will have the default ioremap_uc() definition which
> > returns NULL. If any ARCH really needs a specific ioremap_uc() for
> 
> Please make it very clear that this changes existing behavior.
> At first, I had completely missed that.

Sure, I will update log.

> 
> And of course the documentation should be updated to reflect that.

Makes sense, will do.

> 
> > its own usage, one ioremap_uc() can be added in the ARH.
> 
> s/ARH/ARCH/

Will update.

> 
> >  arch/m68k/include/asm/kmap.h   | 1 -
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for reviewing.

