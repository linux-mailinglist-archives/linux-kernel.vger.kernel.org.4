Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB66DAD9A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbjDGN3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbjDGN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B042C46B7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680874101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fb/gXjXq+a+avDKrHo1L2LCNyXQObTnjNH+xOJlnmkU=;
        b=VLRdgdOEpT7lqIHPqHgTpPQKwXpqvc7OtGQDvobKgMyxvzN6hoLmtycHsIGqjj3vjlv0Yz
        IJJzJJnosAsx/NyZpn+5tA99JBMcKKYwlYJKhWNfOdCMm5pOW1rFqY/f9rpV9DEB0iCl3w
        FV/PO+qgvYkBTP/GZeJbAH4EW7+fUAU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-MRhnTRsBM3KTiJTJjGTMOA-1; Fri, 07 Apr 2023 09:28:20 -0400
X-MC-Unique: MRhnTRsBM3KTiJTJjGTMOA-1
Received: by mail-ed1-f71.google.com with SMTP id m17-20020a509991000000b0050463defdabso2345779edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874099; x=1683466099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb/gXjXq+a+avDKrHo1L2LCNyXQObTnjNH+xOJlnmkU=;
        b=FviPyX8vEep8J48ly7Hn8Fy58FZ+4cvcYYljsYdw5z7/wmyu77xeZzQPrXah0AUxPK
         IE8AoJZKfmmusAGjnU2N1VmpYalaS8+fyWNvpzUMZ8FVv2pVsCC3s5RK/er1EjQT9Jtk
         QaWUYL/VXWPia4vR8B3qRLfRxm7VyXhjpgkQb/Rqka/1tagMvlLUTAlT9k4DLiQlLhc0
         T2YrQJYVmvDMWTgFuDCSOSvC1gzL0EO0QZdYGKbemCD90hhX1U3Ndv+fQEWOw8k0Xz8B
         80VsR3dRatMunACI0GjgRfU/4tSJNA8p0kmQbYhrkpcW03ZLb/qn2gPnzjzjJ+qTtB3M
         ajrQ==
X-Gm-Message-State: AAQBX9c7gzdMnCnLvjaikclR33e4gv2aSGTEhCaIFCvtfK9RclIOGkOd
        aq+PN5j45Zj84wIz1QkyfUlO2pBHcd7aJykqcE2fhMueIjfFTcQqchbSQPs9JriCaTDwFYOr/Q+
        vLTfYAObjQE6sUk8RxkYXM+/q
X-Received: by 2002:a17:907:2c75:b0:92c:5f1:8288 with SMTP id ib21-20020a1709072c7500b0092c05f18288mr2206371ejc.13.1680874099631;
        Fri, 07 Apr 2023 06:28:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ylw9trW6c6Q5GE7em27RpA4qj8eK0s6lHEwkDW+HYX888mkXsEtwuoWLCA18zXUYQR69lvvg==
X-Received: by 2002:a17:907:2c75:b0:92c:5f1:8288 with SMTP id ib21-20020a1709072c7500b0092c05f18288mr2206354ejc.13.1680874099384;
        Fri, 07 Apr 2023 06:28:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hr15-20020a1709073f8f00b009477ba90a85sm2049827ejc.69.2023.04.07.06.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 06:28:18 -0700 (PDT)
Message-ID: <b705ba9b-5002-e884-6527-e45b6a6fa678@redhat.com>
Date:   Fri, 7 Apr 2023 15:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: intel-uncore-freq: Add client processors
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330145939.1022261-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230330145939.1022261-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/30/23 16:59, Srinivas Pandruvada wrote:
> Make Intel uncore frequency driver support to client processor starting
> from Alder Lake.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  .../platform/x86/intel/uncore-frequency/uncore-frequency.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> index 00ac7e381441..32e2515ee366 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> @@ -204,6 +204,13 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);

