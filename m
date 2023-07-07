Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C018174AEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjGGK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjGGK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:27:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F34C10E2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:27:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1D89D75;
        Fri,  7 Jul 2023 03:28:29 -0700 (PDT)
Received: from [10.163.48.50] (unknown [10.163.48.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17F733F740;
        Fri,  7 Jul 2023 03:27:45 -0700 (PDT)
Message-ID: <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com>
Date:   Fri, 7 Jul 2023 15:57:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
To:     Pintu Kumar <quic_pintu@quicinc.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     pintu.ping@gmail.com
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 00:03, Pintu Kumar wrote:
> CMA allocation can happen either from global cma or from
> dedicated cma region.
> 
> Thus it is helpful to print cma name as well during initial
> debugging to confirm cma regions were getting initialized or not.
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
> ---
>  mm/cma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index a4cfe99..4880f72 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -436,8 +436,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	if (!cma || !cma->count || !cma->bitmap)
>  		goto out;
>  
> -	pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)cma,
> -		 count, align);
> +	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> +		(void *)cma, cma->name, count, align);
>  
>  	if (!count)
>  		goto out;

LGTM, cma->name is an identifying attribute for the region for which the allocation
request was made. But how about using cma_get_name() helper instead ? Very few call
sites have been using the helper.
