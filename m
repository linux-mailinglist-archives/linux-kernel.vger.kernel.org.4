Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A816998FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBPPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjBPPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:35:21 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D084CC85
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:35:17 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id j5so2278907vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJA+qcGtvNmBUK8XsZ2gzL9ZEMJQhfdJVtR4kcq7g0c=;
        b=Ad6cFTncox4EglfztVUDvFfHGovhG38Tphf/y+N6eDxOxDB9lEi3Vs137q2Xb9/GDJ
         airJEgeEMH5qybrzhr7JdeQudngjy+Ns+F6hiwXpR/Ka7PXx+Nzj5EWr3bE4Y0i+tEix
         Jn47L5fyYHvJwOfoJDQ0y6s8rVUjHeOO3cR7D13RDLqSfm/FJTcGdeg+a7ArD62Y626k
         Ph1PSSfofM6NdEFTwRjFFt+SNiENP6JQKIApr78JzoCki9Iu0euFFGhoYHVkiUYWQQvo
         enFdjzujOFbjfdKMSP+GTJiqysmXBjiLjwlMBGnKwc1M0NTGnhSt4iYNTHwOzdurFE4J
         +gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJA+qcGtvNmBUK8XsZ2gzL9ZEMJQhfdJVtR4kcq7g0c=;
        b=w6Ip9xC9lmQWrOedpK6Z4z5QzMjE87qdlTl94BABmZR0c/Ff1QsERkLx951g6mqg58
         zVzOdP7UULnieFErlu4Zs8Q3/hEapredIQps97zuNtCBUk+zcUoKcUL4jDPXZGEjnC92
         pzm8mKgqzbSF7CeWqixV7X33O9J1tvHhINKNitzBQX92FwGR2Z2bxy1TKNrICQ1KUwTS
         puQHLU0eWYg6/SirBdCOAzveiCuie9xin5GCo1zSyTHagom8EB/WXrSyZxs8EvxOuuK8
         9wYnIQZixOFF9oayUVARG6Q7KD7eracloONTZdfh5irH2GiYyztR34PG4mr3lXG0/SBF
         OIYQ==
X-Gm-Message-State: AO0yUKVwoEth3gu0LuWZ6NAJILqWyro/2OBkBrMPBmtxdVh6flSA6uIG
        BhGJDzZoen4/7l3s+YPWnCKDrVtQa+HclljyyupiWKI3Gw/kTeFM
X-Google-Smtp-Source: AK7set/S2uCPWRYPe2ieLdf9ktnIQXjrn8SbyZ2+axh5QF6EER41YjaNzCme3SOWYtkD5vqvF36MSQ0Pqkj4EI8+izI=
X-Received: by 2002:a05:6102:48:b0:414:1a64:8672 with SMTP id
 k8-20020a056102004800b004141a648672mr239924vsp.28.1676561716614; Thu, 16 Feb
 2023 07:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20230216013542.138708-1-mike.kravetz@oracle.com>
In-Reply-To: <20230216013542.138708-1-mike.kravetz@oracle.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Feb 2023 21:05:05 +0530
Message-ID: <CA+G9fYtiaXsPJjEUDg42=DMA8-Jxo_0p0ZPbpfuKzCCtAZ933g@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: check for undefined shift on 32 bit architectures
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 at 07:06, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Users can specify the hugetlb page size in the mmap, shmget and
> memfd_create system calls.  This is done by using 6 bits within the
> flags argument to encode the base-2 logarithm of the desired page size.
> The routine hstate_sizelog() uses the log2 value to find the
> corresponding hugetlb hstate structure.  Converting the log2 value
> (page_size_log) to potential hugetlb page size is the simple statement:
>
>         1UL << page_size_log
>
> Because only 6 bits are used for page_size_log, the left shift can not
> be greater than 63.  This is fine on 64 bit architectures where a long
> is 64 bits.  However, if a value greater than 31 is passed on a 32 bit
> architecture (where long is 32 bits) the shift will result in undefined
> behavior.  This was generally not an issue as the result of the
> undefined shift had to exactly match hugetlb page size to proceed.
>
> Recent improvements in runtime checking have resulted in this undefined
> behavior throwing errors such as reported below.
>
> Fix by comparing page_size_log to BITS_PER_LONG before doing shift.

This proposed fix tested and confirmed that reported issues were fixed.

>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYuei_Tr-vN9GS7SfFyU1y9hNysnf=PB7kT0=yv4MiPgVg@mail.gmail.com/
> Fixes: 42d7395feb56 ("mm: support more pagesizes for MAP_HUGETLB/SHM_HUGETLB")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
>  include/linux/hugetlb.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index df6dd624ccfe..8b45720f9475 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -781,7 +781,10 @@ static inline struct hstate *hstate_sizelog(int page_size_log)
>         if (!page_size_log)
>                 return &default_hstate;
>
> -       return size_to_hstate(1UL << page_size_log);
> +       if (page_size_log < BITS_PER_LONG)
> +               return size_to_hstate(1UL << page_size_log);
> +
> +       return NULL;
>  }
>
>  static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
> --
> 2.39.1


--
Linaro LKFT
https://lkft.linaro.org
