Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DFE65A354
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiLaJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLaJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:17:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141235FC0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:17:46 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x37so17405546ljq.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxCpl0YoEChLON3RwXmdSKop5AoTZZptT3NhkKbnI3c=;
        b=IKCFduhp6xQ+Em5nBIBlTGJXJuQ+tqLH3ePjakyfanO9YFUqCHn2PGO1YAlTBZv7GJ
         7Q2hxvdRGIQAz+RGkcu2xdY9kPOHDasAMzKK0EyBW5y+8pepAen3XQ+qiAv6WSsIFtAE
         UXwBFzvx6k+f49BZr8LzCnc7lFPwpVDb/5ZOuR9Bv71eCXCIZViRZKGU89ud/2Aoqubr
         YzpV01vgtnf13UD2GiChB8AyTFzLcXGcfVid4nZc2EyW/2mrN/FdhxvZaXt8RQo6Od9b
         i7KV0elOg+dPglADhwUEfwas041wfcz4w1fOcyJwS21NAVSyWnM9747LqWkJG6Nf+TF9
         GSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxCpl0YoEChLON3RwXmdSKop5AoTZZptT3NhkKbnI3c=;
        b=QbsxxkrTbzPgopg2uyr69On1WBcZIRAN/i26KPK1SIRqgo0kHLytEA1+OYB1TFAc3y
         306xrqQjYHiJROxaq49JSN/gqJYcdFfwt13/o1Ac4YgwESsWOX+n8UOFXNsI0aArNLwj
         MBgMwt/DgGdkXq3yC6zSXihspHDN8bYwvDolH57U7vNyGxwQmFT5XMA1i9xY4qXDhWi/
         qEZYdyQvhnui4oGnqoyV2uPg98rc0vjw2tdHZgK/vbI0cSmZmzPO1zh4nYOo4miDmVvP
         tSEtr1wX/Ykqla3Rt5C72ZYQwYUNOrMbip4oE9ySjnyvGiELstSFG+Okkc2lO3KiKjBE
         emlw==
X-Gm-Message-State: AFqh2koFEEg9D6Sc+sAyl9L0M1k8xWCUUH66twWABaKUtuOT02cRLufZ
        e8CrYmeH75beN7pXUGEg7mU=
X-Google-Smtp-Source: AMrXdXvgB7luwJVYxUdOyfTRh2AbrHR7D0SzwZVboOhFm3jHh2F5jZ22Tkj6hWKLEmumIO5H9d/zhQ==
X-Received: by 2002:a2e:bf2a:0:b0:27f:a95e:94ba with SMTP id c42-20020a2ebf2a000000b0027fa95e94bamr10419415ljr.33.1672478264293;
        Sat, 31 Dec 2022 01:17:44 -0800 (PST)
Received: from pc636 (host-217-213-136-176.mobileonline.telia.com. [217.213.136.176])
        by smtp.gmail.com with ESMTPSA id x12-20020a2e880c000000b0027fe97a7f40sm99286ljh.61.2022.12.31.01.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 01:17:43 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 31 Dec 2022 10:17:40 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/3] mm: vmalloc: Switch to find_unlink_vmap_area() in
 vm_unmap_ram()
Message-ID: <Y6/+NK6gPbn2dLwx@pc636>
References: <20221222190022.134380-1-urezki@gmail.com>
 <20221222190022.134380-2-urezki@gmail.com>
 <Y6VlA8Mbbv7Ug6tW@infradead.org>
 <Y6XaTM+xSlGNjo0e@pc636>
 <20221228154707.432e8900855122712f98037c@linux-foundation.org>
 <Y62Mb8NtZQkTmlfV@pc636>
 <20221229151706.da16baab4cb6c2bc30e3061a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229151706.da16baab4cb6c2bc30e3061a@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 03:17:06PM -0800, Andrew Morton wrote:
> On Thu, 29 Dec 2022 13:47:43 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > [2]
> > commit 8a85ea97b35924ee39d51e00ecb3f6d07f748a36
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Wed Dec 21 18:44:53 2022 +0100
> > 
> >     mm: vmalloc: switch to find_unlink_vmap_area() in vm_unmap_ram()
> > 
> > [3]
> > commit a7c84c673c71cdfad20fe25e5d2051ed229859f7
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Wed Dec 21 18:44:52 2022 +0100
> > 
> >     mm: vmalloc: avoid calling __find_vmap_area() twise in __vunmap()
> > <snip>
> > 
> > It would be good if you could fold [2] into [3] making it as one
> > patch. The problem is that, if we leave it as it is, the bisection
> > mechanism would consider [3] as a buggy patch, because it is not
> > fully accomplished and depends on [2].
> > 
> > Is that OK for you, i mean to squash on your own? 
> 
> I did that.  I updated the "mm: vmalloc: avoid calling
> __find_vmap_area() twice in __vunmap()" accordingly, thanks.
> 
At least bisection part will not detect anything wrong now.

Happy New Year and thank you!

--
Uladzislau Rezki
