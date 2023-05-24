Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4461C70F6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjEXM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjEXM43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:56:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38199
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:56:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d41763796so639573b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684932987; x=1687524987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/g7tBS5u6Von8EKmDLctwcChKzRVNgl5GIylDauKPQ=;
        b=X5JIciBwn1ojpj7ZLSlq5M9BXCDaq1QZbmRr3XOn3BnnM5ivOyhS/6fYEZ71F+hwX9
         SuVVYcnO3kuNX3tzXLKWMqZYYoh5Dac2cfAgVmqE/7SThLehyQjyt1po+HU20w5ttIR7
         qc+bGiCxrisIYeMRfDyxhehMyMjIKkNxYuaA5W+QFhaC0EJdxe4XyxJqaRZeFdyFI6W/
         B5OK+JreMF8Zt4H1V+gwnPZU0tvcvA63DG7ORAlZkmv6akVhCl+a6HqD4FI89CO6CMAn
         fY2Wn/fCFGQ+nl1U2CfrcjkfmpWPsN/s/YYtdaBe1ik1cggWzeHQV/4OxuEEENHRRbcd
         8Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684932987; x=1687524987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/g7tBS5u6Von8EKmDLctwcChKzRVNgl5GIylDauKPQ=;
        b=L3I7jBjmYBpeavY89NiPbz98MPBfBWJO0Jue7f0NI+MmOr/1Trmtwo/pITla5qi3Me
         CudJLLNorOTjPikvOsyTxMfdRJiIlsHzJ4nUuAhuDzUg8kVTB/TeLhWDhBBAY78nuIAO
         BoU9Sdm0GD65AVQp4ooNID3fHScYNv5kYYKHT0U9Ml413N758boDxZE7LoO7lHrZlEFb
         XI4cNnQvmkcHBimEDWjtVUE92vGcyaq02K8VwP1RyCzdh/LgvB8yyP9HmSaDihTl1/Wm
         EOUHg/J1OkVDetqurp56omnHKKVhkkzJPBK+2sxaUcV1Hnj7j2aYOI4xqtyUQv3TTSjT
         /N6g==
X-Gm-Message-State: AC+VfDz4I0MbDu6UOj2cjNiXoGXzwMyp9LDxH5E4ctuM8SQ6oIY6lB2R
        CSt62lBT4Rcjy6kSifB/Bow=
X-Google-Smtp-Source: ACHHUZ4TEVvly0Ml+koYFbnHhIW11Y44PieE+NHbnKorGQLPAgDmlgSvgBiCxv3SOjfsqK7+oKydRQ==
X-Received: by 2002:a17:902:f681:b0:1ad:e8f5:7c7b with SMTP id l1-20020a170902f68100b001ade8f57c7bmr21146312plg.62.1684932987287;
        Wed, 24 May 2023 05:56:27 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([221.158.187.64])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b0019a6cce2060sm8649195plx.57.2023.05.24.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 05:56:26 -0700 (PDT)
Date:   Wed, 24 May 2023 21:56:02 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/slab: add new flag SLAB_NO_MERGE to avoid merging per
 slab
Message-ID: <ZG4JYr14RpNQb8li@debian-BULLSEYE-live-builder-AMD64>
References: <20230524101748.30714-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524101748.30714-1-dsterba@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 12:17:48PM +0200, David Sterba wrote:
> Add a flag that allows to disable merging per slab. This can be used for
> more fine grained control over the caches or for debugging builds where
> separate slabs can verify that no objects leak.
> The slab_nomerge boot option is too coarse and would need to be enabled
> on all testing hosts. 

Hello David,

There is no users nor interface to set this flag, I guess you're going
to use it by modifying source code, when debugging?

Does introducing new slub_debug option (i.e. slub_debug=N,pid_namespace)
work for your use case? (there are some boot-time slub_debug options described in
Documentation/mm/slub.rst)

> There are some other ways how to disable merging,
> e.g. a slab constructor but this disables poisoning besides that it adds
> additional overhead. Other flags are internal and may have other
> semantics.
>
> A concrete example what motivates the flag. During 'btrfs balance' slab
> top reported huge increase in caches like
> 
>   1330095 1330095 100%    0.10K  34105       39    136420K Acpi-ParseExt
>   1734684 1734684 100%    0.14K  61953       28    247812K pid_namespace
>   8244036 6873075  83%    0.11K 229001       36    916004K khugepaged_mm_slot
> 
> which was confusing and that it's because of slab merging was not the
> first idea.  After rebooting with slab_nomerge all the caches were from
> btrfs_ namespace as expected.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  include/linux/slab.h | 3 +++
>  mm/slab_common.c     | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h

Thanks,

-- 
Hyeonggon Yoo

Doing kernel stuff as a hobby
Undergraduate | Chungnam National University
Dept. Computer Science & Engineering
