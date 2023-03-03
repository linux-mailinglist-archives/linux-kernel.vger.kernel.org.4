Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9C6AA055
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCCTvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjCCTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:51:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028095FE8F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:50:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72B9E21D64;
        Fri,  3 Mar 2023 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677873054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oi/Dc6KdT1oRSvAHPhZ8feRgUthVwWLJjDowTGLD+9g=;
        b=tb6rpy1ho2utbbrh5ZB/0Wp5HxLnJSqZjnZhd3Wm6auX8oYZ0wx65gfD0JgXp38C7KdZu8
        JWkF+I4RKGTLHf4hYf4kVjMT76O0ILVG4ZO5sQmdi2sJ0oM3UrZK5PSleUZ8LBiaiqtQoT
        ZW2LOGJ551WE0/L5hAD9VUnUltbAG2I=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 72D4D2C141;
        Fri,  3 Mar 2023 19:50:53 +0000 (UTC)
Date:   Fri, 3 Mar 2023 20:50:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v4 2/3] mm, printk: introduce new format %pGt
 for page_type
Message-ID: <ZAJPnG2LqjvXkC/Z@alley>
References: <20230130042514.2418-1-42.hyeyoo@gmail.com>
 <20230130042514.2418-3-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130042514.2418-3-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-01-30 13:25:13, Hyeonggon Yoo wrote:
> %pGp format is used to display 'flags' field of a struct page.
> However, some page flags (i.e. PG_buddy, see page-flags.h for more details)
> are stored in page_type field. To display human-readable output of
> page_type, introduce %pGt format.
> 
> It is important to note the meaning of bits are different in page_type.
> if page_type is 0xffffffff, no flags are set. Setting PG_buddy (0x00000080)
> flag results in a page_type of 0xffffff7f. Clearing a bit actually means
> setting a flag. Bits in page_type are inverted when displaying type names.
> 
> Only values for which page_type_has_type() returns true are considered
> as page_type, to avoid confusion with mapcount values. if it returns false,
> only raw values are displayed and not page type names.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>   # for vsprintf part

I am sorry for the late review. It has somehow fallen through cracks.

Best Regards,
Petr
