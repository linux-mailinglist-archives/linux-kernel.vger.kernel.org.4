Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DBD648A87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLIWGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLIWFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:05:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F3A5DD0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:05:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m4so6306526pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pONBt4ouGMWECrV/pVKtVhKSyJGEmp24D89Cnz7EClI=;
        b=R+uvA7fBUnNLK6W5wlSayM3n1/nR4LegBCVue9ysz28nJ+5CqHMcWzLylwoUO2hEnD
         gZY/vGr1l6AruZ9uRvsMeyCufhXeMcsywdh/S2+ZF31N847NXiGzDizifAGtgBDt6rYG
         jWxJjQPEksZA8aC6bwfpuk3zuyoBnA2JvIh4QDp8nbqKFVpjsmc+PGM5Re/Qf0epR+8r
         wQbmnGHGe455pnqyk4hs/pBAuF2P8Wsnh0M+edR1ir80Rcmar7WDDUhprRv+8XGtO98I
         9TzuqX5q9mCI+D+CTIsRcbuNYw1+tp2feJh6+XENKE4xpzXld8JYdIfm3VweBz6Z6eJ6
         BX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pONBt4ouGMWECrV/pVKtVhKSyJGEmp24D89Cnz7EClI=;
        b=fAWTcrmv73iaaCBjp31APagcAeh47lVqpM7LKtyTudz98RNVRj5LYGCOetQK9jfQ0p
         qcQNP4M68dlzs/51zYTEZb+7dRq/Z2t72oZ9YNlSsD5ryii1fhhZoY0VoO7pgHNgaxfJ
         GpW8/a6UxuTBqSSFd96maUN6IFX5R8F305VUEfhZ1TKeA2EZoTUlmkXC6/6myk8dRNhe
         Gs0N7OcBlSgca5mxT0AR6WLQ8CTvSoHBgTfFeTAL8s2H31ZXOM/XiE71BFrPsmLK0ski
         T8kO6FhdD+PG2HzHcXGbm3vHSGjUJff09/ReQzZjLnXm+AYzd/lD7Wjv//Ocdw2zID60
         5cow==
X-Gm-Message-State: ANoB5pnSioIbJthtOZrndvZRuUyE/sp1yltyEmrwt73olqTVo7y9J1ql
        mY+U6NM66OzGC+QJa8jUNX0tHmq+6I8df5QKaVI=
X-Google-Smtp-Source: AA0mqf5DZ7diSuYIB952ODDvuEKgXuTYLnYNDVGmRiy+R0A98pYxRy3aXsGDwcin+KXiTwNrjKUjhg==
X-Received: by 2002:a17:902:d589:b0:189:f740:14e with SMTP id k9-20020a170902d58900b00189f740014emr8547779plh.26.1670623540700;
        Fri, 09 Dec 2022 14:05:40 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b001780e4e6b65sm1772293plx.114.2022.12.09.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 14:05:40 -0800 (PST)
Date:   Fri, 9 Dec 2022 14:05:36 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 13/13] KVM: selftests: Test Hyper-V extended hypercall
 exit to userspace
Message-ID: <Y5OxMBSlzjv3w9YW@google.com>
References: <20221205191430.2455108-1-vipinsh@google.com>
 <20221205191430.2455108-14-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205191430.2455108-14-vipinsh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 11:14:30AM -0800, Vipin Sharma wrote:
> Hyper-V extended hypercalls by default exit to userspace. Verify
> userspace gets the call, update the result and then verify in guest
> correct result is received.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Signed-off-by: David Matlack <dmatlack@google.com>

> ---
[...]
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test Hyper-V extended hypercall, HV_EXT_CALL_QUERY_CAPABILITIES (0x8001),
> + * exit to userspace and receive result in guest.
> + *
> + * Negative tests are present in hyperv_features.c
> + *
> + * Copyright 2022 Google LLC
> + * Author: Vipin Sharma <vipinsh@google.com>
> + */
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "hyperv.h"
> +
> +/* Any value is fine */
> +#define EXT_CAPABILITIES 0xbull
> +
> +static void guest_code(vm_vaddr_t in_pg_gpa, vm_vaddr_t out_pg_gpa,
> +		       vm_vaddr_t out_pg_gva)

nit: Use vm_paddr_t for guest physical addresses.
