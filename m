Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7DA68FFA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBIFJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBIFJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:09:15 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37868AD11
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:09:13 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-16a7f5b6882so1195239fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 21:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/o/Yyf5xiwsvzDTnPUP8Nfjf8Wua1HAmbL8JrHSt69k=;
        b=NlYm3Gn+V5OEQSY3dkcLvtlSsw58A7+Yk6JUY6BmyZ4l2JOchPZxe8H9GW8cT/TDCc
         +2M6fhaqM803yz8bAurWer+ohaT4KKmBXR+DEcqQlMlOaQZGqD4BBBKqge5Hsh3GEiOC
         qIyOgdkb2XWQPA961zUvxmOVy/+ZdHYfBNGAozectHWtdkYDuud9t27pv28daqHpX6NY
         +CDE6f97YBcP20oDmWl1ZVnb+xd5MSKzNgPfh5OZZuxZSfHpSYb1q75N4TRVWRvgm/Ww
         MFY7P+PgnfydTsmD6wwbzaIKmVnLtRey1k9xi1dwVJ+EPb5ztjpXOdaV63T5D4QvDflz
         Epmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/o/Yyf5xiwsvzDTnPUP8Nfjf8Wua1HAmbL8JrHSt69k=;
        b=VHsUH70m8+p3K5N9ahy/hZ345wGCuilz4OjO1HbL+lsA0g5AhFkNcKIHuuVnGqvv0r
         bEbPbi01DWXkaG4FFoeEER0lPO89dto+uC07Hg8xcm/NBNzY16XQHxWp2h0WhmjG5oNk
         8W0tYEeRjv7fgccp6f6NqTKa0eylzXHXAiD7Cj4ptMXCXI4CfzWLjLCYFdjh9gDjTJ4F
         kL+oqBmy2AAJ4aWE/fAFALTKlCVnvdt85iBKNVg1lpqtIgHpm/TmE3F6xea8RR8dF6fR
         yykkaB9nipt3Iq9At8297uHQVXsmSsSvoULBITrzFPoSik1DZMpVruaA/XY69yH55XyH
         s4yw==
X-Gm-Message-State: AO0yUKU/24NYmCEgEMsK/o/kI7SjRuFsRor7F52DuOzDRycYGjQv3Et/
        lKhJy/acWigmkuSA4twc5jd4HA==
X-Google-Smtp-Source: AK7set8HsYevPu0auJT0KTbYyyepvGt6ExUkQN0SNUpPOX6LVYvc2rtiYHtJ6sscbNjtFHyW4rjI9Q==
X-Received: by 2002:a05:6870:171b:b0:15e:e50c:1813 with SMTP id h27-20020a056870171b00b0015ee50c1813mr5566253oae.55.1675919352308;
        Wed, 08 Feb 2023 21:09:12 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id zh15-20020a0568716b8f00b00140d421445bsm245162oab.11.2023.02.08.21.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 21:09:11 -0800 (PST)
Date:   Wed, 8 Feb 2023 21:09:04 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page
 refcount
In-Reply-To: <20230125015738.912924-1-zokeefe@google.com>
Message-ID: <ecb2cf3-45f0-8aae-3e1-da4e79de9c27@google.com>
References: <20230125015738.912924-1-zokeefe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023, Zach O'Keefe wrote:

> During collapse, in a few places we check to see if a given small page
> has any unaccounted references.  If the refcount on the page doesn't
> match our expectations, it must be there is an unknown user concurrently
> interested in the page, and so it's not safe to move the contents
> elsewhere. However, the unaccounted pins are likely an ephemeral state.
> 
> In such a situation, make MADV_COLLAPSE set EAGAIN errno, indicating that
> collapse may succeed on retry.
> 
> Fixes: 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>

This was
Reviewed-by: Yang Shi <shy828301@gmail.com>
and now I'll give it a nudge with
Acked-by: Hugh Dickins <hughd@google.com>
since it hasn't appeared in mm-unstable or linux-next yet:
I think its Cc:stable sibling 2/2, already in 6.2-rc, got all the attention.

Thanks!
Hugh

> 
> ---
>  mm/khugepaged.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e23619bfecc4..fa38cae240b9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2712,6 +2712,7 @@ static int madvise_collapse_errno(enum scan_result r)
>  	case SCAN_CGROUP_CHARGE_FAIL:
>  		return -EBUSY;
>  	/* Resource temporary unavailable - trying again might succeed */
> +	case SCAN_PAGE_COUNT:
>  	case SCAN_PAGE_LOCK:
>  	case SCAN_PAGE_LRU:
>  	case SCAN_DEL_PAGE_LRU:
> -- 
> 2.39.1.405.gd4c25cc71f-goog
