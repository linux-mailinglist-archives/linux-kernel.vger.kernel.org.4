Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0986F009D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbjD0GCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbjD0GCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:02:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74914173B;
        Wed, 26 Apr 2023 23:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682575338; x=1714111338;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=TaD0LcGHpdRH/tGdYYK5vlO/eU+LwrtT1ex8GOGuMAA=;
  b=XG3L2Xz0gNjP0lFd8ObzsPaDYYMYFy7ySSM3MCEgNRAG/Kkk9cx1m8VG
   vydCzDqVLZ9usshuSugZ140SmTjZsdftoghVdi6zRWX5FS2VUlitWHlG5
   0y/4PEsHwAS5KQEvcNuK54HXUphZGvIzPm4MUQnqKy0QutndBLuVyOLRn
   OKltLmENXDZs7djMGycb9H3OLMuA/9T+k7SeyzlpLJ/i5WQuk+uro6Vtd
   PFg+E8FQBhr07aGbZFAf0569Df2+HXRag5Lah7dOUcIoaWKVfC+Y1QJUo
   eoRVWOXFEFISVjeKSoqx/KbaGs8EXrtjyVc89dkmP+FGIUFo+ZbPzSlyK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="350171578"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="350171578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 23:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="724751263"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="724751263"
Received: from pboudier-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 23:02:10 -0700
Message-ID: <f149f4ce-bd2e-b192-920f-1e2599e5b16f@intel.com>
Date:   Thu, 27 Apr 2023 09:02:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH] perf symbols: Fix return incorrect build_id size in
 elf_read_build_id()
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, leo.yan@linaro.org,
        eranian@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230427012841.231729-1-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230427012841.231729-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/23 04:28, Yang Jihong wrote:
> In elf_read_build_id(), if gnu build_id is found, should return the size of
> the actually copied data. If descsz is greater thanBuild_ID_SIZE,
> write_buildid data access may occur.
> 
> Fixes: be96ea8ffa78 ("perf symbols: Fix issue with binaries using 16-bytes buildids (v2)")
> Reported-by: Will Ochowicz <Will.Ochowicz@genusplc.com>
> Link: https://lore.kernel.org/lkml/CWLP265MB49702F7BA3D6D8F13E4B1A719C649@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM/T/
> Tested-by: Will Ochowicz <Will.Ochowicz@genusplc.com>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

As an aside, note that the build ID on the ELF file triggering the bug was
62363266373430613439613534633666326432323334653665623530396566343938656130663039
which is 80 ASCII characters, which would have been a 20 byte binary number i.e.

$ echo -en "0000: 62363266373430613439613534633666\n0010: 32643232333465366562353039656634\n0020: 3938656130663039" | xxd -r | od -c -A d 
0000000   b   6   2   f   7   4   0   a   4   9   a   5   4   c   6   f
0000016   2   d   2   2   3   4   e   6   e   b   5   0   9   e   f   4
0000032   9   8   e   a   0   f   0   9
0000040

So perhaps a mistake in the creation of the build ID on that ELF file.

In any case, for the fix:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/symbol-elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 41882ae8452e..059f88eca630 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -903,7 +903,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>  				size_t sz = min(size, descsz);
>  				memcpy(bf, ptr, sz);
>  				memset(bf + sz, 0, size - sz);
> -				err = descsz;
> +				err = sz;
>  				break;
>  			}
>  		}

