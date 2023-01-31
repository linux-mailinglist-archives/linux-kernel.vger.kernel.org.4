Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67621682AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjAaK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjAaK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:56:35 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC705F753
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:56:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e6so6441299plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3X/JPSAMxaumHwXU7/zVYT40JHHRpmkjY6WOHD6OKd0=;
        b=PVt2vZzdU6fgxkv8Qbvrt0xJQM23r+9fgnjxJYbwfPVBHrWRyQdMhUVMeo0GEHQdyx
         mcRWXclZQfufexKnKHbjF2+If7fKno26gAsYO1RH2YqznHzKH5/90o5ZXg05NjGFs/oQ
         vX8ET7qSWrQGDPkYZq/9n0OOmjlPJ2mAJ3SSIlyM1ebZECvKmoVw5mlVjhXxa7ZbTlaO
         8VgEQcfaTKMOmQVwMj4EbsQ056qa0UayEKc3eXTwHOzOAt6P/S0u7Kx8KH2PqttNXhGx
         YhzCnie6mqwXylURVaB4mLnudcy/y7GbQnQPRju4UwFXwvkhxmxVOASgNMZCdluoMc/Q
         zKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X/JPSAMxaumHwXU7/zVYT40JHHRpmkjY6WOHD6OKd0=;
        b=qxi9tQ8gPXUFtkXSu0KRJF6PtqwDG16QSMjQymYI9y5jSv4MEDm8fcC35tj9LePJSv
         x9hwWytLT0oXh8nPDKuayGIMSHrsWr2Yvd4QLBDxpoK28QttaKE8PO0H1iXQZqrM7p3T
         tbcLpwdR4cJdOb7+rk1qXv3wyFfqcIY5oWy3lXSgGJ5qMwAsTAzNIa41DpZDNMbS/3+5
         iBvIng7GjOph4eYNcGp23xFgAeIM/XyBhUA7MCnwUpgeL2nf8ASdHIB49ViYVH0QSE2J
         5EnWHi5MAWuXKt0zN9cEQTr0KhJsD8/5LbhWHA0U29Fq3xAwvORMqpRaJKJglEt9K2V/
         k57w==
X-Gm-Message-State: AFqh2krOFuvw4171gDuI4cB2qwF373dAJyR79DspZDT8Xr04kXRj0xp9
        2aiyRSEd1f++1gGHDQbYqpgBk89wAceM5g==
X-Google-Smtp-Source: AMrXdXsfNlCil8R6x0eQvi1kwnfe7p8obMAXmhy013ASXzk/TruclEVhrzZjlhjshbpou3gaYIpBBQ==
X-Received: by 2002:a17:902:b10d:b0:190:e63a:ea91 with SMTP id q13-20020a170902b10d00b00190e63aea91mr45123037plr.0.1675162594213;
        Tue, 31 Jan 2023 02:56:34 -0800 (PST)
Received: from min-iamroot ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902f69300b001898ee9f723sm9506591plg.2.2023.01.31.02.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:56:33 -0800 (PST)
Date:   Tue, 31 Jan 2023 19:56:29 +0900
From:   Hyunmin Lee <hn.min.lee@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH] replace BUG_ON to WARN_ON
Message-ID: <20230131105629.GA1195431@min-iamroot>
References: <20230127115844.GA1124261@min-iamroot>
 <Y9eYbPuq5Nw9Njxf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9eYbPuq5Nw9Njxf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 12:14:04PM +0200, Mike Rapoport wrote:
> Hi,
> 
> On Fri, Jan 27, 2023 at 08:58:44PM +0900, Hyunmin Lee wrote:
> > Replace unnacessary BUG_ON to WARN_ON. These BUG_ONs verify aruguments of a function. Thus, the WARN_ONs return an EINVAL error when their condition is true.
> 
> Some users enable panic_on_warn, so for them WARN_ON will still crash a
> machine.
> 
> I think a simple if() will be sufficient.
>  
> > Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
> > Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> > Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> > Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  mm/vmalloc.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 74afa2208558..9f9dba3132c5 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1587,9 +1587,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	int purged = 0;
> >  	int ret;
> >  
> > -	BUG_ON(!size);
> > -	BUG_ON(offset_in_page(size));
> > -	BUG_ON(!is_power_of_2(align));
> > +	if (WARN_ON(!size))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (WARN_ON(offset_in_page(size)))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (WARN_ON(!is_power_of_2(align)))
> > +		return ERR_PTR(-EINVAL);
> >  
> >  	if (unlikely(!vmap_initialized))
> >  		return ERR_PTR(-EBUSY);
> > -- 
> > 2.25.1
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
Hi Mike,

Thank you for your advice.
Would you please give feedback about the below opinion?
- Printing warning messages is helpful to inform what happened in the system to the users.
- When a simple if() is used instead of WARN_ON, the if() should print a warning message.
- The condition of the simple if() should also have unlikely() for optimization of system performance.
- WARN_ON is a macro doing like thoes easily. It has a notifying function and unlikely optimization.
- Eventhough WARN_ON will still crash like BUG_ON by some users who enable panic_on_warn, it is their intention. They should accept the crash by WARN_ON.
- Therefore, using WARN_ON looks like natural and efficient.

Best,
Hyunmin
