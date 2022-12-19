Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89056650802
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiLSHRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiLSHRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A395A9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671434187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BdWW4mbATFocYlfd/RqNiXq7z60CEKDBIQVxKlktu5Q=;
        b=iVOS83LCEfVnXIMmcMJlJsE+543CDtN0a3MQDAbNpHtCGtsndwMkEhUSC/8n/3msM3MfQo
        pO7RJZJzYYHFdVcGt0BXX/6tUMRMhqKmotvjMV1mW9cNFbMMC/v5+vD0k6Gdq72DnWpMxH
        XLhrk17nsFGCm1Ug3DcNg9gT1NTH7wk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-FyoKMx-XPI-HEcyT7J2yAQ-1; Mon, 19 Dec 2022 02:16:22 -0500
X-MC-Unique: FyoKMx-XPI-HEcyT7J2yAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B11A2A59557;
        Mon, 19 Dec 2022 07:16:22 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 017562026D4B;
        Mon, 19 Dec 2022 07:16:20 +0000 (UTC)
Date:   Mon, 19 Dec 2022 15:16:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 5/7] mm/vmalloc: skip the uninitilized vmalloc areas
Message-ID: <Y6APwfb9v2t3xUhv@MiWiFi-R3L-srv>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-6-bhe@redhat.com>
 <Y52w/w3IqJ0SCI6I@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y52w/w3IqJ0SCI6I@lucifer>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/22 at 12:07pm, Lorenzo Stoakes wrote:
> On Sat, Dec 17, 2022 at 09:54:33AM +0800, Baoquan He wrote:
> > @@ -3617,6 +3617,11 @@ long vread(char *buf, char *addr, unsigned long count)
> >  		if (!vm && !flags)
> >  			continue;
> >
> > +		if (vm->flags & VM_UNINITIALIZED)
> > +			continue;
> 
> This comes immediately after asserting that vm _might be null_. This surely must become:-
> 
> if (vm && vm->flags & VM_UNINITIALIZED)
>         continue;

You are right, will fix it in v3. Thanks for careful reivewing.

