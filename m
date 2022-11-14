Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885CA628620
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiKNQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiKNQzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D37623155
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:55:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l12so20261926lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jF4OEMg7hvxESynrdb7E7hlSL43JmsocPVZddDgOiFo=;
        b=WPSMFOwi31MUOeiJ+cTpsjM6/C8lQSMPFHbPZidZM4PyIy4mYN6toDVXotHbjJ1BMS
         RfXfJYsMMwYyQ3B4BfrrpntdrA2TE5rrEWiCLGSqrbQHAnIu1R97zU02lxfmrORIFQdf
         qP5sNq0M2msLGA5nV6fPTD7iEOpIbuJj98kFQo48IN5vdeXoBasVqygOG0xNWW2NCg10
         Eq1NvhRkwZileB83g6k4q0j/9MsKlVOYlwPxQWXCJGfUr1EtCAcx1WT9Kt8DtCgb8Xcf
         V9xaicQ6d3cGr8Mv356ed7ukt5s/GTkjgO8H1Ydn7N+wXz0EH3t11PI9jKJZN0tP5v1G
         Trow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF4OEMg7hvxESynrdb7E7hlSL43JmsocPVZddDgOiFo=;
        b=ePwRzsH/7RCLJjTiv1lQEdS+8v/+69c0YLZP1DP4zbVeojiEJsIqIUgkcZUOj+pO18
         V2HOqrfXD+9BqdTsSWk4tXggNzKplAsN0o1aKtV9XVQQW75Q0BZr5aylXLhok5VoXFSg
         ekfl8RpCpPttpGaRixMT1EHZ1wE+fgzWE1afvilk2G0Ee7us2WDRrlb+Lxl3FvEHvxAB
         raGCJclq459qEQqpUDLILx1cUZXmKZsICHGb5BX0d5tEXRvQ1Snwme1X1tpGwTeTuCnY
         yqlQddP78o0520sSjm+7o11nDFhcAUq5cX9OrrDTGKr5OZ9KSg7u7doptqcJaJaJaLkq
         qFvg==
X-Gm-Message-State: ANoB5pltFP/esd9yn7CxS1lhcslMc8FwNYKh8pqBCxiee5SwWQNeFsH9
        zng74FfIASJSvKs+a4ke42c=
X-Google-Smtp-Source: AA0mqf4K2zCpjFD9TxbzRAt0ef7UbBn+a4/pF5tiqZWrNz6kkC2bEPdlzX9anp13FqgtVhMKYrDOzw==
X-Received: by 2002:a19:6548:0:b0:4b4:107e:368 with SMTP id c8-20020a196548000000b004b4107e0368mr5143542lfj.370.1668444909709;
        Mon, 14 Nov 2022 08:55:09 -0800 (PST)
Received: from pc636 (host-90-235-25-77.mobileonline.telia.com. [90.235.25.77])
        by smtp.gmail.com with ESMTPSA id s5-20020a056512214500b0048b26d4bb64sm1881632lfr.40.2022.11.14.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:55:09 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 14 Nov 2022 17:55:06 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/7] mm: vmalloc: Add alloc_vmap_area trace event
Message-ID: <Y3Jy6rSAiHco5q7v@pc636>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018181053.434508-2-urezki@gmail.com>
 <20221114105325.57d27b6f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114105325.57d27b6f@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 18 Oct 2022 20:10:47 +0200
> "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > It is for a debug purpose and for validation of passed parameters.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/trace/events/vmalloc.h | 56 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 include/trace/events/vmalloc.h
> > 
> > diff --git a/include/trace/events/vmalloc.h b/include/trace/events/vmalloc.h
> > new file mode 100644
> > index 000000000000..39fbd77c91e7
> > --- /dev/null
> > +++ b/include/trace/events/vmalloc.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM vmalloc
> > +
> > +#if !defined(_TRACE_VMALLOC_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_VMALLOC_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +/**
> > + * alloc_vmap_area - called when a new vmap allocation occurs
> > + * @addr:	an allocated address
> > + * @size:	a requested size
> > + * @align:	a requested alignment
> > + * @vstart:	a requested start range
> > + * @vend:	a requested end range
> > + * @failed:	an allocation failed or not
> > + *
> > + * This event is used for a debug purpose, it can give an extra
> > + * information for a developer about how often it occurs and which
> > + * parameters are passed for further validation.
> > + */
> > +TRACE_EVENT(alloc_vmap_area,
> > +
> > +	TP_PROTO(unsigned long addr, unsigned long size, unsigned long align,
> > +		unsigned long vstart, unsigned long vend, int failed),
> > +
> > +	TP_ARGS(addr, size, align, vstart, vend, failed),
> 
> The above is passed in via (from patch 4):
> 
> 
> @@ -1621,6 +1624,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		size, align, vstart, vend);
>  	spin_unlock(&free_vmap_area_lock);
>  
> +	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
> +
>  	/*
>  	 * If an allocation fails, the "vend" address is
>  	 * returned. Therefore trigger the overflow path.
> 
> > +
> > +	TP_STRUCT__entry(
> > +		__field(unsigned long, addr)
> > +		__field(unsigned long, size)
> > +		__field(unsigned long, align)
> > +		__field(unsigned long, vstart)
> > +		__field(unsigned long, vend)
> 
> > +		__field(int, failed)
> 
> I would drop the failed field...
> 
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->addr = addr;
> > +		__entry->size = size;
> > +		__entry->align = align;
> > +		__entry->vstart = vstart;
> > +		__entry->vend = vend;
> 
> And instead have:
> 
> 		__entry->failed = addr == vend;
> 
> Why pass in a parameter that can be calculated in the trace event logic?
>
It can be. A condition about when it is failed or not is taken on upper
level because it might be changed afterwards. So a trace event is not
aware about it thus no need in adaptation.

But i do not have a strong opinion here. I can prepare a patch to
eliminate it.

What is your preference?

--
Uladzislau Rezki
