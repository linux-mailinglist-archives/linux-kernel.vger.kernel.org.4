Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892336FC2A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjEIJUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjEIJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FBA97
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683623978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZWNrPjJClNk2tTJqQsLsON3RxLFqVAdo0C0Uzamz98=;
        b=S8B8uMniZg9VXWSAs59uZloOsEXMWVTK9xfLmCIZN/ojT+q/QB9STpHPYkBe1OFAImMRYo
        OUm+yFo1dfovG9+jP993FFVV+njN+FqHS1g/L9+1o9A0pRrK7Cy1lnWvmDgl+8IZhtjEpO
        Hf4JtRplQIDQhN/DTODNAnVAJfHnQd0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-ak6yng4zNeyaoOyG5xoEBQ-1; Tue, 09 May 2023 05:19:36 -0400
X-MC-Unique: ak6yng4zNeyaoOyG5xoEBQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-969c36898d4so93807866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683623975; x=1686215975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZWNrPjJClNk2tTJqQsLsON3RxLFqVAdo0C0Uzamz98=;
        b=j+G51pfY/5n5Lu2fP7qFMPpQIctaZqFJwFch4VEetbHemhpZIKlSmqFkFUBR2A0AvZ
         8EZnbY/zojR8k2f614OHbCSlOyYiN6btj3mNBMh0TTwE5hFx3/Md/B49SLqzIASaQyGT
         wQk29jtd4RDNDLWMGiRp+ngfL1ogW1R+EzVsQB2jCiXdejgYrqboz9PfS++NaZUpc6V6
         uZ+TJVqAalhRXbREQ+Y7euc4JK1TJCzKVVCxAOpD3FnEOfIJ/RJSUSvOZ03cAINlpdY9
         tEYFNpi+SBEimRncm2ORbmJP4L/T5RvsyLW/C5CH2Nz7T1C9UEMH7M/K2Ch66Ki7/A6r
         wNnA==
X-Gm-Message-State: AC+VfDyxP/8iGlc66sLaiK8mg4ZUUcDxC3FtlvO6jiH6oDJF1w0ytMer
        iMPcdapLELdV5LRmjghiu3B+CU/HJv8Va2QN+GiP29U3hj3QuyDHNgqHLY5KRm3wJU85yrODfy8
        3QP9lQ2b8f0gKgh9sHWKMirVK
X-Received: by 2002:a17:907:5c5:b0:95f:56e8:1c3c with SMTP id wg5-20020a17090705c500b0095f56e81c3cmr11216028ejb.17.1683623975516;
        Tue, 09 May 2023 02:19:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5j287DFP8IHyRW9PPepnhjkGMk46wbQKsdzIHLY7OYt3AXaqK3kmnbU5pPVWrjfQbMf0Exsg==
X-Received: by 2002:a17:907:5c5:b0:95f:56e8:1c3c with SMTP id wg5-20020a17090705c500b0095f56e81c3cmr11216009ejb.17.1683623975155;
        Tue, 09 May 2023 02:19:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? ([2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b009660449b9a3sm1080351ejp.25.2023.05.09.02.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 02:19:34 -0700 (PDT)
Message-ID: <5a8bba97-00dd-5a02-f378-944dbc075909@redhat.com>
Date:   Tue, 9 May 2023 11:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] Uncore frequency scaling using TPMI
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230418171340.681662-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230418171340.681662-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/18/23 19:13, Srinivas Pandruvada wrote:
> Implement support of uncore frequency control via TPMI (Topology Aware
> Register and PM Capsule Interface). This driver provides the similar
> functionality as the current uncore frequency driver using MSRs.
> 
> Previously I posted only 1/3 and got reviewed and addressed with
> this submission. The other two patches were links in the submission.
> 
> But it is better that all three patches considered together.
> I know this is close to merge window for 6.4, so it is fine to differ.
> 
> Srinivas Pandruvada (3):
>   platform/x86/intel-uncore-freq: Uncore frequency control via TPMI
>   platform/x86/intel-uncore-freq: Support for cluster level controls
>   platform/x86/intel-uncore-freq: tpmi: Provide cluster level control

Thank you for your patch-series, I've applied the series
(with the updated 1/3) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





> 
>  .../pm/intel_uncore_frequency_scaling.rst     |  57 ++-
>  .../x86/intel/uncore-frequency/Kconfig        |   4 +
>  .../x86/intel/uncore-frequency/Makefile       |   2 +
>  .../uncore-frequency-common.c                 |  51 ++-
>  .../uncore-frequency-common.h                 |  16 +-
>  .../uncore-frequency/uncore-frequency-tpmi.c  | 418 ++++++++++++++++++
>  .../intel/uncore-frequency/uncore-frequency.c |   1 +
>  7 files changed, 545 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> 

