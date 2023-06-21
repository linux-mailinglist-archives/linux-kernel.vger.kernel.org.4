Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ACE7384B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjFUNRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFUNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:17:23 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508310C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:17:22 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39eab4bbe8aso3855301b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687353441; x=1689945441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fveJ7t6dKInkV6jkCt7drrsyoXqW38rNIYDTeWubez4=;
        b=E5HvcT690zg+3SJvbU2ye/7aCf3qOHKmVyWxSZ8zZFFCLcVymtvrkKamjL7GOEDwIF
         W5p00yU/aYFHwRrAYv08KgzzdbAHMwxmFf/QkHGs3VXRTjepf1PAkD6xWULRRCOj3kfJ
         nncOnnlGuNfdUacAr4Xub0PoYo1811vMIVkOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687353441; x=1689945441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fveJ7t6dKInkV6jkCt7drrsyoXqW38rNIYDTeWubez4=;
        b=FWCkQDQYQmp+Uo6kUZcou8Xe/bQ3eG3AXZFissjZisw/T8YDMiup6UkSexoYHYc1iH
         GCr4FDxo1H1acBVhQk9iytRAmh5yo21Cgmy6RpQZrn0ftZ4kmc0bryPCudNgFYGgqyjC
         jCyIEhWeg0Lxrj9YiYFUdJ8CL707KGmbOUx6815EAw/WArtd/Uy8lxDxeXv7LYifa8az
         qBfc5O0MCx/Et0zot4mK8ejlM9NsNRs2GKolvQKA5UW9C0tBGfwlYP39ziNzE4vVTvk2
         SdN1dYqDRqao/7p9ihslfpKq2o1rAoBMk+D+kI9ax/4chYAtRX05nskqD95W/1hoMXxV
         CWxg==
X-Gm-Message-State: AC+VfDzQtAGPPvCHobZ39EWB079z84zzrYJdrC26+TjzUtBSTeGRdFtf
        Io7VLJCa9kyffFq8EBlLUTeR7A==
X-Google-Smtp-Source: ACHHUZ7q8wqmAuAZwE/ilkAlX8mW6biKsOIk7awi7X5/HP2WZyi0pwxE24q2pSrC5SxjG0I6wVKBCA==
X-Received: by 2002:a54:4518:0:b0:39e:de8b:54a2 with SMTP id l24-20020a544518000000b0039ede8b54a2mr8097176oil.29.1687353441344;
        Wed, 21 Jun 2023 06:17:21 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id fr3-20020a17090ae2c300b0024de39e8746sm8952526pjb.11.2023.06.21.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:17:20 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:17:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <AVRomanov@sberdevices.ru>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Message-ID: <20230621131716.GC2934656@google.com>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
 <20230619143506.45253-2-avromanov@sberdevices.ru>
 <20230620103629.GA42985@google.com>
 <20230620111635.gztldehfzvuzkdnj@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620111635.gztldehfzvuzkdnj@cab-wsm-0029881>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/20 11:16), Alexey Romanov wrote:
> If sizeof(unsigned int) >= 32 bits the this will be enough for us. 
> Of course, in rare cases this will not be the case. But it seems that
> zram and kernel already has similiar places. For example, if page size
> is 256 Kb and sizeof(unsigned int) = 16 bits (2 byte), zram will not
> wotk on such system, because we can't store offset. But such case is
> very rare, most systems have unsigned int over 32 bits. 
> 
> Therefore, I think that my idea is still applicable, we just need to
> change the counter type. What do you think?

My gut feeling is that we better avoid mixing in architecture specific
magic into generic code. It works fine until it doesn't. May be Minchan
will have a different opinion tho.

There can be other ways to avoid linear scan of empty sub-pages. For
instance, something like below probably can cover less cases than your
patch 0002, but on the other hand is rather generic, trivial and doesn't
contain any assumptions on the architecture specifics.

(composed/edited in mail client, so likely is broken, but outlines
 the idea)

====================================================================

mm/zsmalloc: do not scan empty zspages

We already stop zspage migration when we detect that target
zspage has no space left for any new objects. There is
one more thing we can do in order to avoid doing useless
work: stop scanning for allocated objects in sub-pages when
we have migrated the last inuse object from the zspage in
question.

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 02f7f414aade..2875152e6497 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1263,6 +1263,11 @@ static bool zspage_full(struct size_class *class, struct zspage *zspage)
        return get_zspage_inuse(zspage) == class->objs_per_zspage;
 }
 
+static bool zspage_empty(struct zspage *zspage)
+{
+	return get_zspage_inuse(zspage) == 0;
+}
+
 /**
  * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
  * that hold objects of the provided size.
@@ -1787,6 +1792,10 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		obj_idx++;
 		record_obj(handle, free_obj);
 		obj_free(class->size, used_obj, NULL);
+
+		/* Stop if there are no more objects to migrate */
+		if (zspage_empty(get_zspage(s_page)))
+			break;
 	}
