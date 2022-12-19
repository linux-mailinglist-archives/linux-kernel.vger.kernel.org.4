Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1F65135B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiLSTg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiLSTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:36:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31CCDE5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=e+FXZ5wpPaeHanRbasiTVnh7zMisjpFCOPnjQFMGEtY=; b=s9FHKfcDlHJUpRRpWkxpS8oK75
        nYLRIiDEUWGUsjaVw6tEXHRyhrhevcTOQ6dbGIjrP+iQgwiLnllEg5vxCpEEfKqHCsxPA/fm67efA
        xAly+uib54I5jomt3A/7dBBmt6Pg+5wYSFHdqFDgn06+ZEaw/peatpmuh9qWi4SgKNfIN3OiaLdjY
        uX4oDNcD1dfp8LLu3NsA4/Qp4AGReGWFxNLvb3/Xc8LwSxUrgK3KmEAdZ/4j7A+jmqHlr3NawdXNL
        NRqCBt1tE1CPT4lRjYEuPQOCP+UMcwfqESNG9GSq3U4Oj8Py8Ejxyq19HX21H3OyyouCpV6MPB/2a
        R0xJeV2w==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7LvJ-00162Q-4J; Mon, 19 Dec 2022 19:35:41 +0000
Message-ID: <82feabee-0446-b913-adbb-0e96ecb10c94@infradead.org>
Date:   Mon, 19 Dec 2022 11:35:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC v3 3/4] mm, printk: introduce new format %pGt for page_type
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-4-42.hyeyoo@gmail.com>
 <Y6AycLbpjVzXM5I9@smile.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y6AycLbpjVzXM5I9@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/22 01:44, Andy Shevchenko wrote:
> On Sun, Dec 18, 2022 at 07:19:00PM +0900, Hyeonggon Yoo wrote:
>> %pGp format is used to print 'flags' field of struct page.
>> As some page flags (e.g. PG_buddy, see page-flags.h for more details)
>> are set in page_type field, introduce %pGt format which provides
>> human readable output of page_type.
>>
>> Note that the sense of bits are different in page_type. if page_type is
>> 0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
>> page_type is 0xffefffff. Clearing a bit means we set the bit.
>>
>> Bits in page_type are inverted when printing page type names.
> 
> ...
> 
>> +#define __def_pagetype_names						\
>> +	{PG_slab,			"slab"		},		\
>> +	{PG_offline,			"offline"	},		\
>> +	{PG_guard,			"guard"		},		\
>> +	{PG_table,			"table"		},		\
>> +	{PG_buddy,			"buddy"		}
> 
> Wondering if it will be more robust to define a helper macro
> 
> #define DEF_PAGETYPE_NAME(_name)	{ PG_##_name, __stringify(_name) }
> ...
> #undef DEF_PAGETYPE_MASK
> 
> In this case it decreases the chances of typo in the strings and flags.

I'd say Yes.  (and #undef DEF_PAGETYPE_NAME methinks; or change both to _MASK)

-- 
~Randy
