Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4D61F5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiKGO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiKGOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:25:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D942723EB2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667830743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U68CLR334kyZoY8qCweNZexBFdDOPZAvKMDK2Ti7NZQ=;
        b=asNR77Y6zU1VIRyqqaGu0iagp1x6OLN3FJR3NqlXzWWjlpkXcydyqgyq+PuRcfr4d86qQu
        r9yYD0FnBz3pxGCX3l8jjkgR31s9IiZByTa22larLbQ4I+iOntEuuqG3qK23NIdXfWiMjC
        hxEm3KRB42hr8nUnW3qx6jKUr7Yf+Kg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-303-wWpg-lCcOHCnT4bBB8kDdw-1; Mon, 07 Nov 2022 09:19:01 -0500
X-MC-Unique: wWpg-lCcOHCnT4bBB8kDdw-1
Received: by mail-ed1-f69.google.com with SMTP id z15-20020a05640240cf00b00461b253c220so8369391edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U68CLR334kyZoY8qCweNZexBFdDOPZAvKMDK2Ti7NZQ=;
        b=qX+glSggBzNDt123yYdEaKTj2D4Lv1f9zYGGyeAQUNplHigMRWn8xsUG1clJxZ5KvM
         ZjTQxdBfGcmgDf+JE2PKFhLG3cHG0G3swZb7tF3/YsZf3n1Rbc/j+VcDN1UQFWbA+cKz
         ukjvoaiwz7AdHEemKEOCoaON8bVHOtqDwRWjb1CyEzgxTEoY8nEpRcjAL0t5gUg+d7n5
         BW9GElEmbOi30HcpehOFHLMd/TdK1C+nXZUjAwh4CAzxcGKnowPTPcg14kBBbTl/cMuF
         QvqR/em5qTSGClV903LIt/U/5ErVe2lAeJus1L2Y3YqJ8sS8xJcstP1c2W+2QX3qU2FJ
         PaQw==
X-Gm-Message-State: ACrzQf34UF3g3IzFNdSuzZxaUiIm0jJkZsgjxZThmpCbQQpSZyMutiMh
        WiJoVALhKMLvO4AvtnsNdtKG3awNXo0SzGT5LzIdWs9tJaB0UROPcdS+VUsl/YnHkutkou1ifGT
        FIlVQDqKEyPPQELBNqCvm0rYj
X-Received: by 2002:a17:907:c24:b0:7ae:41b3:6a67 with SMTP id ga36-20020a1709070c2400b007ae41b36a67mr14385392ejc.254.1667830740699;
        Mon, 07 Nov 2022 06:19:00 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4BZOozD31Eg06Ce5Ylz6+N24tE2cVlXVTsExCcd7iPfGAYKjSORYml+179Jw5jY4rCmf4dCQ==
X-Received: by 2002:a17:907:c24:b0:7ae:41b3:6a67 with SMTP id ga36-20020a1709070c2400b007ae41b36a67mr14385371ejc.254.1667830740499;
        Mon, 07 Nov 2022 06:19:00 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906249200b0073d9a0d0cbcsm3487097ejb.72.2022.11.07.06.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:19:00 -0800 (PST)
Message-ID: <b10a7c4d-43a7-98f2-db65-8f907d4159da@redhat.com>
Date:   Mon, 7 Nov 2022 15:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/9] Extend Intel On Demand (SDSi) support
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 11/1/22 20:10, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is now known as Intel On Demand. The
> following patches do the following:
> 
> 1. Identify the driver/tools as Intel On Demand. Only text descriptions are
> changed. Kconfig and filenames remain the same.
> 2. Perform some attribute cleanup by preventing the showing of files when
> features are not supported.
> 3. Adds support for a new GUID. GUIDs are used to identify the layout of
> the On Demand registers in sysfs. Layouts are described in the
> documentation on github [1].
> 4. Add support for reading On Demand meter certificates in sysfs.
> 5. The rest of the patches modify the existing tool to support discovery
> and reading of On Demand registers and the meter certificate.
> 
> [1] https://github.com/intel/intel-sdsi/blob/master/os-interface.rst

Sorry for the long silence, I have not done any pdx86 patch review
the last 2 weeks due to personal circumstances.

I will try to get this reviewed at the end of this week or the beginning
of next week.

Regards,

Hans




> 
> David E. Box (9):
>   platform/x86/intel/sdsi: Add Intel On Demand text
>   platform/x86/intel/sdsi: Hide attributes if hardware doesn't support
>   platform/x86/intel/sdsi: Support different GUIDs
>   platform/x86/intel/sdsi: Add meter certificate support
>   tools/arch/x86: intel_sdsi: Add support for reading state certificates
>   tools/arch/x86: intel_sdsi: Add Intel On Demand text
>   tools/arch/x86: intel_sdsi: Read more On Demand registers
>   tools/arch/x86: intel_sdsi: Add support for new GUID
>   tools/arch/x86: intel_sdsi: Add support for reading meter certificates
> 
>  .../ABI/testing/sysfs-driver-intel_sdsi       |  47 +-
>  drivers/platform/x86/intel/Kconfig            |   8 +-
>  drivers/platform/x86/intel/sdsi.c             | 134 ++++-
>  tools/arch/x86/intel_sdsi/intel_sdsi.c        | 458 ++++++++++++++----
>  4 files changed, 513 insertions(+), 134 deletions(-)
> 
> 
> base-commit: 225469d4acbcb873358d7618bad6e0203b67b964

