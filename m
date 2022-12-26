Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED682656112
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiLZITN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLZITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:19:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32921BA2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:19:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay40so7219148wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4eGuO+JRo1jyO7gXeRlpcOp8BRbSkAn9HLImegppvE=;
        b=QAZAofIXfl8YMBQGrTtYNMukjhISYq8OwCMGDZ5c4DUGIPrH7iio874KhxqOXNkeQ5
         Uc7soXSSM0JYWyKbUX/7/vVGEYCw2RtjeVzuyqFfQqCrVeOgcLjj7JquGBQ+UCupS0Fg
         9K5hZgd9a5qWxwgDqnOEnuRmYfhsVD7woQTEhQ39qRLVFe/OuG9HaE/JE2WjwuRLkNUq
         4gqkmt4M9Pa0PsmoS66DaXWmYzfzXzG/XCEMJQLE87FP/txq25P4Gz1pZAuhD0OMcEF4
         xB2GCNpuN12mIsiyBgy2K2gDD9Hbdy0MD5kgRCjH5s18gdkPHCEzqcIHee4GUuN7W7AC
         jBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4eGuO+JRo1jyO7gXeRlpcOp8BRbSkAn9HLImegppvE=;
        b=I0fK6yUJi0dsYGn09g9JdrR4XSVqN/NM5FcCRroGIYeFbGmA++/LpmiiV03chJ+5ng
         vKn7y7eM4Go1J7pWEGonUh8kGQqEFf+tgVVY+qd8aYYGlPUExJNpXQG5GSbOxt/0rEJD
         9F9F6utZ8otI/315aXTD2VWbz4oMBVOWiro/MrKn1CkwoiZfSeFrvfebpIpdA2YKDZa4
         X8Y4NWvdOhUAjJ6D6Nw0LIB9iz47cW6+qcxqilBsMYBgjGFPevdujqOFB9MV7PtYNggH
         LLJOtMPnOVJj/V9X3F4rqT1WujHWDeK6rPSp7qSEfBMu1uK6EYaJulhIdu9eWi12HUSr
         CCMw==
X-Gm-Message-State: AFqh2krN1q4lQzYDHVp83HOplGDoTzRbt7ptyYcMzDlal3vzhxEzctoo
        Ti1JDHRntpNCXwSuihhPIpE=
X-Google-Smtp-Source: AMrXdXsU5qtRgYezUKj3b32U+swfASWrOPQPwrQ6dV2/URG8Pp3iaHdVRPCFf2KF6MCv8gv5ETD9aA==
X-Received: by 2002:a05:600c:35d1:b0:3d3:58d1:2588 with SMTP id r17-20020a05600c35d100b003d358d12588mr12609788wmq.41.1672042746607;
        Mon, 26 Dec 2022 00:19:06 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003c6bbe910fdsm22632255wmc.9.2022.12.26.00.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 00:19:05 -0800 (PST)
Date:   Mon, 26 Dec 2022 08:19:05 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 3/4] mm: mlock: update the interface to use folios
Message-ID: <Y6lY+RB/LXY6V5tH@lucifer>
References: <cover.1672038314.git.lstoakes@gmail.com>
 <555c36b91c4b34a5972f2614395e3c3831e8102f.1672038314.git.lstoakes@gmail.com>
 <Y6lYIfVAf+EZa/Lb@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6lYIfVAf+EZa/Lb@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 08:15:29AM +0000, Matthew Wilcox wrote:
> On Mon, Dec 26, 2022 at 07:08:46AM +0000, Lorenzo Stoakes wrote:
> >  			goto out;
> > -		page = pmd_page(*pmd);
> > +		folio = page_folio((struct page *)pmd_page(*pmd));
>
> I do not like this fix.  Better to fix m68k to:
>
> #define pmd_page(pmd)	(struct page *)NULL
>

I actually completely agree with this, and felt it was essentially an issue with
the fact m68k aren't doing this cast, but I thought perhaps it'd be out of scope
for this series to make the change there.

However now you're suggesting the same thing it seems like it isn't out of scope
at all :)

Will spin a v3 moving the fix there.
