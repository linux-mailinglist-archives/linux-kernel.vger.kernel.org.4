Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0031C5E70B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiIWAiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIWAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1D106A07
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663893493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zk1+EgBiZaGHGemzxW1+05s07p+KTnrxlBzg9GZkgF4=;
        b=RL3gRldBFbP/CGZeyF6+Gr6fxnHUaqnHAM8NbwVbD5rINNVHVXnFMhetdA1V8rDL4IkSEr
        7zPWwlIsgZbGD05J0Q+p4C1AvKqybuTUd1pMxUbbJ6EeoBulaMVBvktoLNX/19LKbbmNcj
        UAvQS75odQ44VXaHqIstc9Qi0BMZvRA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-Hbh2bazNPWqKme8RzUCvqA-1; Thu, 22 Sep 2022 20:38:08 -0400
X-MC-Unique: Hbh2bazNPWqKme8RzUCvqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8651C85A5A6;
        Fri, 23 Sep 2022 00:38:08 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4727240C6EC2;
        Fri, 23 Sep 2022 00:38:08 +0000 (UTC)
Date:   Thu, 22 Sep 2022 20:38:06 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <Yyz/7gWdP+ftQdIO@lorien.usersys.redhat.com>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Sep 22, 2022 at 10:49:54PM +0300 Andy Shevchenko wrote:
> Currently the approximation is used which wastes the more memory
> the more CPUs are present on the system. Proposed change calculates
> the exact maximum needed in the worst case:
> 
>   NR_CPUS	old		new
>   -------	---		---
>   1 .. 1170	4096		4096
>   1171 .. 1860	4098 ..	6510	4096
>   ...		...		...
>   2*4096	28672		19925
>   4*4096	57344		43597
>   8*4096	114688		92749
>   16*4096	229376		191053
>   32*4096	458752		403197
>   64*4096	917504		861949
>   128*4096	1835008		1779453
>   256*4096	3670016		3670016
> 
> Under the hood the reccurent formula is being used:
>   (5 - 0) * 2 +
>     (50 - 5) * 3 +
>       (500 - 50) * 4 +
>         (5000 - 500) * 5 +
>           ...
>             (X[i] - X[i-1]) * i
> 
> which allows to count the exact maximum length in the worst case,
> i.e. when each second CPU is being listed. For backward compatibility
> for more than 1170 and less than 1861 CPUs the page size is preserved.
> 
> For less than 1171 and more than 1 million CPUs the old is being used.

The memory is not really wasted since it's probably temporary in userspace
and in the kernel it _is_ temporary and is only the length of the kasprintf
string, which is most of the time much less.

But that said, it is more accurate than the previous estimate.

I was wondering if you were going to try to come up with a suitable
compile time macro :)

I tested 2, 8192 and 16k since the kernel does not want to build for other
reasons with NR_CPUS at 32k.

Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Phil Auld <pauld@redhat.com>


> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: described better the advantage for 1171..1860 CPUs cases
>  include/linux/cpumask.h | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 1b442fb2001f..12cf0905ca74 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -1122,6 +1122,21 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
>   *
>   * for cpumap NR_CPUS * 9/32 - 1 should be an exact length.
>   *
> + * for cpulist the reccurent formula is being used:
> + *   (5 - 0) * 2 +
> + *     (50 - 5) * 3 +
> + *       (500 - 50) * 4 +
> + *         (5000 - 500) * 5 +
> + *           ...
> + *             (X[i] - X[i-1]) * i
> + *
> + * which allows to count the exact maximum length in the worst case,
> + * i.e. when each second CPU is being listed. For backward compatibility
> + * for more than 1170 and less than 1861 CPUs the page size is preserved.
> + *
> + * For less than 1171 and more than 1 million CPUs the old is being used
> + * as described below:
> + *
>   * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up
>   * to 2 orders of magnitude larger than 8192. And then we divide by 2 to
>   * cover a worst-case of every other cpu being on one of two nodes for a
> @@ -1132,6 +1147,39 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
>   */
>  #define CPUMAP_FILE_MAX_BYTES  (((NR_CPUS * 9)/32 > PAGE_SIZE) \
>  					? (NR_CPUS * 9)/32 - 1 : PAGE_SIZE)
> +
> +#define __CPULIST_FOR_10(x)		(((x + 1) / 2 - 0)     * 2)
> +#define __CPULIST_FOR_100(x)		(((x + 1) / 2 - 5)     * 3)
> +#define __CPULIST_FOR_1000(x)		(((x + 1) / 2 - 50)    * 4)
> +#define __CPULIST_FOR_10000(x)		(((x + 1) / 2 - 500)   * 5)
> +#define __CPULIST_FOR_100000(x)		(((x + 1) / 2 - 5000)  * 6)
> +#define __CPULIST_FOR_1000000(x)	(((x + 1) / 2 - 50000) * 7)
> +
> +#if NR_CPUS < 1861
> +#define CPULIST_FILE_MAX_BYTES	PAGE_SIZE
> +#elif NR_CPUS < 10000
> +#define CPULIST_FILE_MAX_BYTES			\
> +	 (__CPULIST_FOR_10(10) +		\
> +	  __CPULIST_FOR_100(100) +		\
> +	  __CPULIST_FOR_1000(1000) +		\
> +	  __CPULIST_FOR_10000(NR_CPUS))
> +#elif NR_CPUS < 100000
> +#define CPULIST_FILE_MAX_BYTES			\
> +	 (__CPULIST_FOR_10(10) +		\
> +	  __CPULIST_FOR_100(100) +		\
> +	  __CPULIST_FOR_1000(1000) +		\
> +	  __CPULIST_FOR_10000(10000) +		\
> +	  __CPULIST_FOR_100000(NR_CPUS))
> +#elif NR_CPUS < 1000000
> +#define CPULIST_FILE_MAX_BYTES			\
> +	 (__CPULIST_FOR_10(10) +		\
> +	  __CPULIST_FOR_100(100) +		\
> +	  __CPULIST_FOR_1000(1000) +		\
> +	  __CPULIST_FOR_10000(10000) +		\
> +	  __CPULIST_FOR_100000(100000) +	\
> +	  __CPULIST_FOR_1000000(NR_CPUS))
> +#else
>  #define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7)/2 > PAGE_SIZE) ? (NR_CPUS * 7)/2 : PAGE_SIZE)
> +#endif
>  
>  #endif /* __LINUX_CPUMASK_H */
> -- 
> 2.35.1
> 


Cheers,
Phil


-- 

