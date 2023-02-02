Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895C68764E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjBBHRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:17:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B05C0E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:17:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so609112wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 23:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIBnqXCOT7grF7zHm3K1+B/15zDsN7km7rQvdhBieEY=;
        b=W6HjqHTXRW8MHjPVGZgv60RTAM5EwEKql3PrzsJpxw+wD5nZ7ZALOFnIQ4QUfCtVw1
         7fjpVzxRCHW/ydZqevrCjgkSBAcZBG3t/dy5glU5g00RQ2SAT3CCL6xB1do9HzHXscCb
         NkpDC7aIxSAYWGlZSu/4gYZIe66kPPvk7ZHDVfSSnqRDfVAR8DdJd9yVNL+O0Q4OVetQ
         YahY+QPEZFPEfADPNlWh87ZuDbvLGBD7yEXzc5iSQ3xGZaemQ6IIydjdgoasuxgdcaH8
         G6lxaxPgT13BEYRqM1F8/Y6kH6CbiU8m7+FqXO8R6i0Dn2ljF1mnSM+F2hd+bGKW+zjv
         aFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIBnqXCOT7grF7zHm3K1+B/15zDsN7km7rQvdhBieEY=;
        b=jrxM8sN49m5iRuR34WJ+MbLob6IjsRI+QsrY+n8e5ne4p0w85mIaW2y4bF7fLg1dkX
         9uI+ujPPtjvNwlfBK2VvUGuC8hDLOHYJZLXzm/CSmiHz1nR+qLonq5pSpGIMDmkgIFlo
         2Hx7v5DqNzK0OdlEXv9aK5gK9nYInFjM653UAAApc/nRJjVBhsC7msWjJs/6vlDffX79
         P77IdGnzJn2fCaSYBSiVIgbnb6q+AfcZODU/qLPZtJuuyB1FrOgjnwrrRq9EluNEYw1Z
         kTRtZ+h8x3yyrTI0frOf+UE7lNTnsbH58NNnQ7JmopGDtexWsW13V44qXflBj4h0xM7X
         XcUA==
X-Gm-Message-State: AO0yUKUTY/jDLyk+mt9WxJs2UDpZ5D9aZZEo9XF3c8rPxtAGrEsoXvQa
        NJmu/yZt7fu1fiQLjxhsObw=
X-Google-Smtp-Source: AK7set8jpkk4g9NQGsC0iRGUQ9IwY9a//VUiD+3v1JE6DJUEjJSZx7A6bGpqoBfebKJJp34EK+ycFA==
X-Received: by 2002:a05:600c:3d1a:b0:3db:2858:db84 with SMTP id bh26-20020a05600c3d1a00b003db2858db84mr4672169wmb.34.1675322270147;
        Wed, 01 Feb 2023 23:17:50 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b003dee8c5d814sm3757706wmo.24.2023.02.01.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 23:17:49 -0800 (PST)
Date:   Thu, 2 Feb 2023 07:17:48 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com
Subject: Re: [PATCH v4 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y9tjnP2r7RqbFd7a@lucifer>
References: <20230201091339.61761-1-bhe@redhat.com>
 <20230201091339.61761-4-bhe@redhat.com>
 <Y9rImPGSF/EQ1Xey@lucifer>
 <Y9sr56DqC+JCXt7z@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9sr56DqC+JCXt7z@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 11:20:07AM +0800, Baoquan He wrote:

[snip]

> > > +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> > > +		if (!count)
> > > +			break;
> > > +		start = vmap_block_vaddr(vb->va->va_start, rs);
> > > +		while (addr < start) {
> > > +			if (count == 0)
> > > +				break;
> >
> > Bit pedantic, but you're using the `if (!count)` form of checking whether it's
> > zero above, but here you explicitly check it, would be good to keep both consistent.
>
> Yeah, sounds good. Will change.
>
> >
> > Given you're checking here, perhaps you could simply drop the previous check?
>
> Well, maybe no. The previous "if (!count)" is checking if count is 0
> after the 'count -=n;' line at the end of the for_each loop. While this
> "if (count == 0)" is checking if count is 0 after 'count--;' at the end
> of while loop. Not sure if I got your point.

You're right, sorry each break is for a different loop :) and I guess the inner
check is feeding the outer one so we're all good.
