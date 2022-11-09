Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B56223BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiKIGOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:14:15 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF53315;
        Tue,  8 Nov 2022 22:14:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b11so15808363pjp.2;
        Tue, 08 Nov 2022 22:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhA2GM0MmHVgF5w//IL35OcuY4H3+4INJfbT7ZD2bYs=;
        b=TjZ8RFq/eIuwO/6zg8DWofiyQBOyrb0Ence+A7Yi6MeNz+Gy96a/7h6aR54BKoD1UI
         fHVUNoXlH/QoP+shqZgFFGBD/wHpuNc9pTTYWNHIFpXxq0ti0zekCenfRxFMXCPY24db
         ak5lbljB9t2PXOhqKyt0Mf021sPQw/oGasFJW8RuE6Rv9XtTCAuXCFFte+YsfZ994xo8
         SIi3uir0P8qP37sU7TLu4Luehk4EQkS3bjJ3KBAfHSi6IuNUYcTwO1J9hj0gz57WqWUt
         5Drs7DVeuiS+LK+TbV27iiWlDpjXdoHSF3gFh/EXXcSshtPL5Ip6FyrGhcGARkRNSARk
         PtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhA2GM0MmHVgF5w//IL35OcuY4H3+4INJfbT7ZD2bYs=;
        b=rTFCHQqETuN9K2hrLpPwG6Lel3Xffv76BUbIqqeY1xmfw5HJUX+T3DDLeuAcsSXDVv
         ykW2YSEHyYIgQULClW9H4wRGaOduOyvWKUn9gCy2GRdnH0N6IJ0YIyakiEpZSE9D+4kG
         rGLQIEvaA27xZxDtK1A/imdsT4K1a00SVZqYKp+rjj2W699Fkk54iplRQk+mdBZhjuFI
         5Y2a2TiysZBD97xWlcC8Jmd/pPcHm3ltbAqsI9wn6rw64T6Ya1GjsKMToDUzGWZQqkui
         YeZzE9pyRDCQmnASPIzOVEpy5UOZZYt7NdR7sB2/6eXWaaaAOkK6yWleA+EOFDmr9VIA
         itHA==
X-Gm-Message-State: ACrzQf0enBoEnJU1Q4DIicmerMGkyA4qWw01gtZCWZAa/mVierE3E0Hn
        6GS53AIFV7QijhCyV+yXpYE=
X-Google-Smtp-Source: AMsMyM5AT+y3PXBkhKAlIdJXBwNV7ifDm/jY7CsUvEEIQ/tlI8ze9ACYcaox/LQdFwkIXrXxTBHfiA==
X-Received: by 2002:a17:90a:c201:b0:216:ab2c:25b with SMTP id e1-20020a17090ac20100b00216ab2c025bmr29885616pjt.45.1667974454355;
        Tue, 08 Nov 2022 22:14:14 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b0018544ad1e8esm8131460plc.238.2022.11.08.22.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 22:14:13 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:14:05 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 3/3] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y2tFLQ/w9siSwy+M@hyeyoo>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
 <20221106140355.294845-4-42.hyeyoo@gmail.com>
 <c038e06504733e8dc6830f082c8522c60895fd8e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c038e06504733e8dc6830f082c8522c60895fd8e.camel@perches.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 10:04:25AM -0800, Joe Perches wrote:
> On Sun, 2022-11-06 at 23:03 +0900, Hyeonggon Yoo wrote:
> > dump_page() uses %pGp format to print 'flags' field of struct page.
> > As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> > are set in page_type field, introduce %pGt format which provides
> > human readable output of page_type. And use it in dump_page().
> []
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> []
> > @@ -2056,6 +2056,28 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
> >  	return buf;
> >  }
> >  
> > +static

Thanks for looking at this.

> 
> noinline_for_stack ?

May I ask why,
Does it have issues related to stack consumption?
To Be Honest I'm a bit unsure what is purpose of this attribute.

> > +char *format_page_type(char *buf, char *end, unsigned int page_type)
> > +{
> > +	if (!(page_type & PAGE_TYPE_BASE))
> > +		return string(buf, end, "no type for user-mapped page", default_str_spec);
> 
> Might be better with something like '%pGt: no type..."

Will try something like "0x32()" when it has no type because it is
mapped to userspace.

-- 
Thanks,
Hyeonggon
