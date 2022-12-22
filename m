Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB122654344
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiLVOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:41:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC95A454
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:41:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so3056442lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y8q7yCOMFgnvKGyTp7h3zj10DGyq90Tq72pzXwBz32s=;
        b=JKp/m0Cz9g+KRBmrZ/zb9sY+rbC+Z3MKRfAhzZXDV3M0CkvZ0MtVmXHIJVLK6xNIux
         SiXkQz/4OrIVReFWaudjX+Q/K5ngnuWoqoa3giU7d3QNHzuaVX3ZJmyB5jxHNgHXL518
         FgRSGoDcZWdL1XJhH0WBXvo2Z0rIDRTEwaWAfoQhpyx/1cUsOjHmqS/5xxE8wX+kAPlQ
         yytA/9ncZGE49NskaeCGz2uQ+PYzeXnU13mZOdOww/V9xcRntA/UR35Hq59+HvsTRdJs
         9EYjcKy6/fMsxGcUVXjd3ajvUtpRXkbJpa26mam0cJ920JbNThdqWjgF8CNeNnxk7Alz
         Q2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8q7yCOMFgnvKGyTp7h3zj10DGyq90Tq72pzXwBz32s=;
        b=eqLhwsGbImmPgB8dmPb6IDs7qtM+ImI5Oh2PJ53m2uwyxcp51l9B+6k8XndooWIUUL
         SHAtpug9TEPKabjwPvMAnW2W6dS1DsyctwbyFmITWvvd4bhgvAAOgPqSHo3qlJsw4aO6
         ZBvBghpJvXo11l5fUutVF2ehGJ++sGucRZ1TkL0PCXR0T4R6itl8IwleSZ6zE1FScjxp
         BheKa4TzSnbrWoM0AeW3ERaiq+2PQzbMVEcCdzytMuNIZFZD+qHao2oXaUM/q0r1W2xe
         D4Mf8Z7dAU24j9uVeKsXZJMPd/BEmUMo29RUXey2n9PqdC89+ZW4d2U++4DPdjWc8ez/
         uOsQ==
X-Gm-Message-State: AFqh2kpMuLFN9fcr5AemrZIEdr7n6DWhpMg64K0ocNdK3s08/2YyvAv5
        kjMfC60NrznS7VsJ3g3VF18=
X-Google-Smtp-Source: AMrXdXvinT8dSllKaVAXZCxs9aPvOnFv4m4qU/eR7WOf1jlIEExyVF0VtYqBpvRaGk+5TAkMt4hSSA==
X-Received: by 2002:a19:5218:0:b0:4bc:4ad0:4148 with SMTP id m24-20020a195218000000b004bc4ad04148mr1482686lfb.8.1671720092395;
        Thu, 22 Dec 2022 06:41:32 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b004aac23e0dd6sm90078lfb.29.2022.12.22.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:41:31 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 22 Dec 2022 15:41:29 +0100
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6RsmcvZ8Ru211Jk@pc636>
References: <20221221174454.1085130-1-urezki@gmail.com>
 <Y6QbvYfvhUI3J7S+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6QbvYfvhUI3J7S+@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A sorry.  I need more coffee, this is not the cover letter, but the
> patch that introduceѕ find_unlink_vmap_area.
> 
Sorry. I should post it with a cover latter to make it less confusing.

> > -	spin_lock(&vmap_area_lock);
> > -	unlink_va(va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	if (!list_empty(&va->list)) {
> > +		spin_lock(&vmap_area_lock);
> > +		unlink_va(va, &vmap_area_root);
> > +		spin_unlock(&vmap_area_lock);
> > +	}
> 
> As mentioned before, I'd much rather move this into the callers.
> 
Agree. There is only one caller, it is the free_vmap_block().
Will fix in the v3.

> > +	va = find_unlink_vmap_area((unsigned long) addr);
> > +	return __remove_vm_area(va);
> 
> This can drop the va local variable now.
>
Do you mean like:

struct vm_struct *remove_vm_area(const void *addr)
{
    might_sleep();
    return __remove_vm_area(
        find_unlink_vmap_area((unsigned long) addr));
}

?

Thanks for review!

--
Uladzislau Rezki
