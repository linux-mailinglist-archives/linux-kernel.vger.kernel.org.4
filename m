Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16B765434C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiLVOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiLVOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:43:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0B2CC97
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:43:46 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b13so3051803lfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GckSvoHjqniPPLdJ5J0xd5iuOwjkMlztGiQNOCi8koM=;
        b=aqmE+hzQIOMqTYVwp0p0Lf3htEdBdlXTV0IFo4kaMzM1kWqbTxeqk1ZFDfb4mdziib
         PnFpa2ELQRwPEAtbUBMbItXx9JnIpZXo4MjvgNwibCa02I6VkLVaGgy87VSfw6QSD2CT
         ppB8MH1F18QMs+id4axaVyAY+Vfm8xprNpUMkufs5mnvKZ85vRfbWunbDFPTYRO66FcP
         Y//n7ngNFIOewCHjXtQKRM+xWaV21Ikz37ULjSNFdAK0L165D3BgLkntKHTgOZSyVjB/
         VVWSgtelywgjTXWt23QHOTLBbd1ziOK6pTNV74PxbDg4W/zHYBGBwve/XbAKMXrakUbk
         7MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GckSvoHjqniPPLdJ5J0xd5iuOwjkMlztGiQNOCi8koM=;
        b=LSLSTrkknRjSsr43fGP7/45rOzbqCRQ95RsvxFb71emem9O0+KimK+u9Xa41a7U81P
         Lxbox8Vgs44Y52NYLJnr0oTeu72MIwRZWinMxSh0LW84pHdtMXzcaonsxsZ6CTN5QLba
         YsIUanj3wEh3pdv8ItB1+S9BM/X/8Qd7d2LwUssiNj3f3nNaChewgoDwkwNdInRVK0tV
         vVoG+MOiIG9VQifJJI/BYbCF0EBu1LqpOBvJcR51qtjlA4Q2YO6ezyTEwdgyGgi0KA2H
         3A9fdRnyWsYS6Jiq74S1KIDsdjPCoHSr+fTyrwEXPxMzs4NYVBQNGwkowAu3ZD8sRXsA
         UCTg==
X-Gm-Message-State: AFqh2krVyeeqrdG6e20HytRWh0McB9gXf1hu1wxzu0pOhs+e+T6v5MyI
        ICY6rP9Oiv+Pc9kGxiX70v5MsJrFCm8=
X-Google-Smtp-Source: AMrXdXsctb6dAddiZL45gcBeQjmvOyvVDI0YyEO7TIXBY+cL+FRnHSbPXaoFoiFQ4JpXCU6f3SnYoQ==
X-Received: by 2002:a05:6512:2506:b0:4b5:b46d:e60 with SMTP id be6-20020a056512250600b004b5b46d0e60mr1839610lfb.27.1671720225323;
        Thu, 22 Dec 2022 06:43:45 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id v4-20020ac258e4000000b004a2c3fd32edsm87946lfo.144.2022.12.22.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:43:44 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 22 Dec 2022 15:43:42 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6RtHp9RAKS76doY@pc636>
References: <20221221174454.1085130-1-urezki@gmail.com>
 <Y6RBpl62gDoJiEu+@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6RBpl62gDoJiEu+@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 07:38:14PM +0800, Baoquan He wrote:
> On 12/21/22 at 06:44pm, Uladzislau Rezki (Sony) wrote:
> > Currently __vunmap() path calls __find_vmap_area() two times. One on
> > entry to check that area exists, second time inside remove_vm_area()
> > function that also performs a new search of VA.
> > 
> > In order to improvie it from a performance point of view we split
> > remove_vm_area() into two new parts:
> >   - find_unlink_vmap_area() that does a search and unlink from tree;
> >   - __remove_vm_area() that does a removing but without searching.
> > 
> > In this case there is no any functional change for remove_vm_area()
> > whereas vm_remove_mappings(), where a second search happens, switches
> > to the __remove_vm_area() variant where already detached VA is passed
> > as a parameter, so there is no need to find it again.
> 
> I like this patch. This takes off the va->vm clearning too. Finally I
> don't need to worry about the va->flags clearing during unmapping
> when reading out vmap_block areas.
> 
Thanks. This patch was one of the reason to help out with the per-cpu
busy areas tracking/reading of your work :)

--
Uladzsislau Rezki
