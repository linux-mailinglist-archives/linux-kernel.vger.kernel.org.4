Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F92666E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbjALJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjALJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:41:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516ADB4AE;
        Thu, 12 Jan 2023 01:40:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so23003292pjj.2;
        Thu, 12 Jan 2023 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JD7aXx20yuFVaEChzftMgofT1e2ISE8hi8OTWnX7hro=;
        b=HwG6Lief2y8VhqgDJJJQNZrLABvHpikdScCDW5g29qBPNEWo5JskRQ206Z+f7b5ppV
         spqiXP5/yYbc/RTuW/XBwEH/KwQlh1yUgZ7VkL16Qr11WJLRmsLx7NAmTvxL2O8ahqWo
         N9nNypasHrKg8xJ/OMJCG0UEQZqgnNNrxLums961FmhmjIYw/wuapnFlo4pTzSS0dTmg
         ilvWVsfNIB/cN7pNvBQIoGL04zO1GE+kUlEcqLoHEepxVwOj4WeyQAB6POI4MKoBcqgl
         Jnjo13XWeNK8iAi04ArEc0A48wHg+yUfLDxStnR7QMCdlXhCxkdOOcpdM3CeFNFSrVjc
         tt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD7aXx20yuFVaEChzftMgofT1e2ISE8hi8OTWnX7hro=;
        b=MyZOeUdGQUi0/jPSbmcvEVuAyM1F6UK8mwrzihAYxj8buBxGeivjf3iIqu2VcYt5xe
         tPsDDEIK/jxFdXKemc7F6u6IwD9szqJ8oWEzLXTuYlcMbnDRM9pNqpy0YVtJNuMNDKkP
         UHHWzlWayS6vFhHXiodu6naV4JwiAuDe4gPtQuRkPDh8/rxZYnTqvxoRU+k/n1dHj/0T
         lCUputS7v2jhSDwYX9xB9syUQew99vyjpdJ/O7tFADttTzVfqCQ1Dcil+C/gShl0r0qj
         Qefi7sIiFroYxgpF8DbnCV+BRAfR19bzEq9CnAhtg/gBHRiQEJSbTDqnHK1DOjNxfCit
         EhAA==
X-Gm-Message-State: AFqh2kqJOaXHwT79Xd+qR671bZtOy4p4rgLEdpFFzw6+bYeAY5L400Ih
        w4sB4LzzBBFn6oe/r3SNvCE=
X-Google-Smtp-Source: AMrXdXtcqIYIwbdVRX2LJWEytEwLxe60pNNxk70wlfbDpdSKAPA9SeBeqwRec31VKD5afvyOSm1sDg==
X-Received: by 2002:a05:6a21:9985:b0:ab:fb31:be13 with SMTP id ve5-20020a056a21998500b000abfb31be13mr8365079pzb.37.1673516406851;
        Thu, 12 Jan 2023 01:40:06 -0800 (PST)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id l7-20020a655607000000b00477bdc1d5d5sm9814139pgs.6.2023.01.12.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:40:06 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 1B3B7105173; Thu, 12 Jan 2023 16:40:03 +0700 (WIB)
Date:   Thu, 12 Jan 2023 16:40:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] docs/mm: Page Reclaim: add page label to allow
 external references
Message-ID: <Y7/Vc12vnJ1EqEpF@debian.me>
References: <20230110152358.2641910-1-rppt@kernel.org>
 <20230110152358.2641910-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230110152358.2641910-2-rppt@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 05:23:57PM +0200, Mike Rapoport wrote:
> diff --git a/Documentation/mm/page_reclaim.rst b/Documentation/mm/page_reclaim.rst
> index 50a30b7f8ac3..3fccde066436 100644
> --- a/Documentation/mm/page_reclaim.rst
> +++ b/Documentation/mm/page_reclaim.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +.. _page_reclaim:
> +
>  ============
>  Page Reclaim
>  ============

Shouldn't this be better squashed to [2/2] as the latter have the
cross-reference?

-- 
An old man doll... just what I always wanted! - Clara
