Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AAF61E537
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKFSEj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Nov 2022 13:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 13:04:36 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D026F8;
        Sun,  6 Nov 2022 10:04:36 -0800 (PST)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 224DBA01AD;
        Sun,  6 Nov 2022 18:04:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 76E7230;
        Sun,  6 Nov 2022 18:04:06 +0000 (UTC)
Message-ID: <c038e06504733e8dc6830f082c8522c60895fd8e.camel@perches.com>
Subject: Re: [RFC v2 3/3] mm, printk: introduce new format %pGt for page_type
From:   Joe Perches <joe@perches.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Date:   Sun, 06 Nov 2022 10:04:25 -0800
In-Reply-To: <20221106140355.294845-4-42.hyeyoo@gmail.com>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
         <20221106140355.294845-4-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: btrbetsb33g9g991fgia9znt4oaqtubf
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 76E7230
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/TDiNWGzwXgd/sBaXkZIB0ArMrI/YeeY0=
X-HE-Tag: 1667757846-282636
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-11-06 at 23:03 +0900, Hyeonggon Yoo wrote:
> dump_page() uses %pGp format to print 'flags' field of struct page.
> As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> are set in page_type field, introduce %pGt format which provides
> human readable output of page_type. And use it in dump_page().
[]
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -2056,6 +2056,28 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
>  	return buf;
>  }
>  
> +static

noinline_for_stack ?

> +char *format_page_type(char *buf, char *end, unsigned int page_type)
> +{
> +	if (!(page_type & PAGE_TYPE_BASE))
> +		return string(buf, end, "no type for user-mapped page", default_str_spec);

Might be better with something like '%pGt: no type..."

