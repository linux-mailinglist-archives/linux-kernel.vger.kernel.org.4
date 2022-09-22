Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6485E6D30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIVUlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIVUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:41:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80982107DF0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:41:42 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x18so7066381qkn.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=XCWyUNMR/qHR/wRRKwbF4sNfBbE7BPdpZQu+th99Ws0=;
        b=ht1BrKGRdKB4QGd+t56Swp9evOS68+GViZGfTyCtwMooP2j31xdd/mTvv9z41t702c
         vCTuog7uALpzp8LdSSB/gXZl3kDutRn0xdkViMLmO/kMKdpX5jf5Xfu4qFeOnaHX54Fo
         4Q7tr7JIauxwih1hgqtGxN+/MGopNBsfFYiywvlsRpZrMd9N4BkhNssYDyeNwPTABeFB
         9GjDWF51k9OzotwKAN+ERLbPbgPXMrCIhWPYUeuFfYzzWsi/elVBEgICRUS0wkEb35VL
         ruq7cX+VXZ4iVvVu3OsOPKAUhE9Kslkr7D0ANzastK6A9FsonVcN7pIRknNz2uTr/WoO
         R8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XCWyUNMR/qHR/wRRKwbF4sNfBbE7BPdpZQu+th99Ws0=;
        b=d1ASfoNAKW+OewgAg2kqSX2o9dDu4U91sYslq6ofFLrXgihpHrp3gexY5UcUTc0lH3
         +n5bOUj/vZkxqO9/G+3LnzTNwM3gmAFiF6JXCRSrXcv4F1MLvHAw3CuJDgM/uY7El6gL
         HdCDtbGDRLoq1xNNOvOXO0n41vnCeZnP/b1LDaWZ8Rx9f5SahyStbInOfncYLg/ICpU7
         KALkEt5sRY8xazDNnEDQdH7DkcmyKTFhHUdkv3i78N3J+xwYeaxXetXoT84TyxRtTPnM
         lPX2rQQNcg50JzSeotHAskBgUhqZmsSvbsc0ouTHg5pGqqVtCrz2b+EoyuCVAervaExF
         kX3Q==
X-Gm-Message-State: ACrzQf2+0fId9DZ+84jnk+ESAPUkatAwsIifgPVNn+NPWEKDWXDrqmjB
        vCFhHC2RAQ5ZOoZZTjhnnzM=
X-Google-Smtp-Source: AMsMyM46SlmDpZMkgClvm5Umrzpe6MbZ1iXFXD6c1wFq78T6GRVCrYhIKu8P5Yzv2EOs9LNtBqrVlQ==
X-Received: by 2002:a37:a80b:0:b0:6cb:dc5f:2ded with SMTP id r11-20020a37a80b000000b006cbdc5f2dedmr3551422qke.320.1663879301492;
        Thu, 22 Sep 2022 13:41:41 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:ae35:fb4e:91a4:b6a8])
        by smtp.gmail.com with ESMTPSA id o10-20020ac8698a000000b0035a6f972f84sm3726536qtq.62.2022.09.22.13.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:41:41 -0700 (PDT)
Date:   Thu, 22 Sep 2022 13:41:40 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Phil Auld <pauld@redhat.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <YyzIhDDEiemWjLgI@yury-laptop>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 + Petr Štetiar <ynezz@true.cz>,
 + Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Sep 22, 2022 at 10:49:54PM +0300, Andy Shevchenko wrote:
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

1861

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

The defs below will be nicer if you make it like this:

  #define __CPULIST_FOR_10(x)  (((x + 1) / 2 - 0)     * 2)
  #define __CPULIST_FOR_100(x) __CPULIST_FOR_10(10) + (((x + 1) / 2 - 5) * 3)
  #define __CPULIST_FOR_1000(x)	__CPULIST_FOR_100(100) + (((x + 1) / 2 - 50) * 4)
  ...



> +#if NR_CPUS < 1861
> +#define CPULIST_FILE_MAX_BYTES	PAGE_SIZE

The comment says:
  for more than 1170 and less than 1861 CPUs the page size is preserved.

Which doesn't look correct. Looks like it should be:
  for less than 1861 CPUs the page size is preserved.

Or I miss something?

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

I'm OK to take this in replace for Phil's version, but the commit that
introduces CPULIST_FILE_MAX_BYTES is already in mainline: 7ee951acd31a8
("drivers/base: fix userspace break from using bin_attributes for cpumap
and cpulist"). Can you rebase it on top of v6.0-rc6?

Greg, since Andy's version is more precise, I'd like to send a pull
request with it in -rc7. Can you drop Phil's patch so I'll go with
this one?

Thanks,
Yury
