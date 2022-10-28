Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F86119F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJ1SN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJ1SN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:13:27 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56F22EE05;
        Fri, 28 Oct 2022 11:13:27 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id ay12so3321473qtb.12;
        Fri, 28 Oct 2022 11:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWNya/+hVsv+hcMdBZq4/CVUI24kPOML1PJ3BWEQBhk=;
        b=olmwRiIA1GclNr6Q3ofnM3rn2Lk3d69gcmwvVQ5dD1qNfEVQ4dGpaGMsAnKaaudMQ9
         2SxZG9mxtsVAT9dSHLqk1DXBL1qU6PaDjj+6Fx4+KH97A6t2i4evmiu1QAmCDNZF9NwD
         GmC+SUffTUQisCePA94sxhYlK9hFYm6TQK3B0Zun8wn1CXgOPHevZP9o5Rhd2brV4O+s
         2rzvqoQ+YesCaiBxE7Vsi42O3pkmVAMnBpNSW1x0TLzyYPfM5JUZb8cP7bszboloGIGi
         njKmBvofETgCmTlGt8RqgH2GZhmwgrH24dKvPJE9pTpDbRy2mYvK8ZAzFSRuoStNGYuQ
         656g==
X-Gm-Message-State: ACrzQf2Uee6kpxIYwXz67vxD0twY4Yy8xiLGuizR5WJ1C7PhWWmlivFu
        +Q1oLWYX70FJRVmbO4zR1s/Pj8BPwwDjIjm/HfTNsxBF
X-Google-Smtp-Source: AMsMyM70hVQRXusxL/PQW7PcpGjxtNoTI2TrSJEbPliAaAMzcth8GPBNdiF+P8bG30NgjTIgq63vE9L47vs//YZX83M=
X-Received: by 2002:a05:622a:44d:b0:39c:f7a4:5ee0 with SMTP id
 o13-20020a05622a044d00b0039cf7a45ee0mr721807qtx.48.1666980806041; Fri, 28 Oct
 2022 11:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221018112240.25647-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20221018112240.25647-1-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 20:13:15 +0200
Message-ID: <CAJZ5v0hsWw2juPzLooVfDgykTwdepjgGSQGezhYeFBQN8yza_Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: hfi: Improve the type of hfi_features::nr_table_pages
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 1:16 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> A Coverity static code scan raised a potential overflow_before_widen
> warning when hfi_features::nr_table_pages is used as an argument to
> memcpy in intel_hfi_process_event().
>
> Even though the overflow can never happen (the maximum number of pages of
> the HFI table is 0x10 and 0x10 << PAGE_SHIFT = 0x10000), using size_t as
> the data type of hfi_features::nr_table_pages makes Coverity happy and
> matches the data type of the argument 'size' of memcpy().
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index a0640f762dc5..239afe02e518 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -137,7 +137,7 @@ struct hfi_instance {
>   * Parameters and supported features that are common to all HFI instances
>   */
>  struct hfi_features {
> -       unsigned int    nr_table_pages;
> +       size_t          nr_table_pages;
>         unsigned int    cpu_stride;
>         unsigned int    hdr_size;
>  };
> --

Applied as 6.2 material, thanks!
