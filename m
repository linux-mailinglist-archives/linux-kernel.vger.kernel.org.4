Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6AC72DFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbjFMKhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjFMKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C2010F3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686652538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GH4XZj5m0XTC5S2VHTP89+wVOAuXYRuG9tQUg+YjYM=;
        b=CjhVE676dcvrE9ecTROMJ2cF1f0rx2zz01DKY94q+qxh0M9HbpA36hZjo4gAZ3R1Mf2TwL
        BMrfNBdcZh8qkHKHxiNsu+n+MeDmwzQDiWhxgI9XfEZCcFWBpJK25uUJR7YQ8VkB8smYOz
        kRm4kmqLxunoUWE0BhLmr0vsSICBfMQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-vNdDoCvYMFeCrFDlvx7X4Q-1; Tue, 13 Jun 2023 06:35:36 -0400
X-MC-Unique: vNdDoCvYMFeCrFDlvx7X4Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f6224e3d54so3878911e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652535; x=1689244535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GH4XZj5m0XTC5S2VHTP89+wVOAuXYRuG9tQUg+YjYM=;
        b=C0OsYerrdetlsvikm7NTzGYxy6PaEnt6K+IfURH6w7RNrEEgAh2e4mLWTsK3St/IZi
         X19SJj7rlgyYrWlhEl90E39ybYp731rWh4W+IUMvMpvNl4ia1wgYazOfhuUsIlM6NzOi
         HCYFh212IwEWXcUvYA86K9Vt75t+O93X6qD8+seMRKhF9DZXd6tdbYW1HJ32jqH7Iw6i
         FL8MhtSC+9k6mqmtuo6+3Yjla5/XIoiDhbKVxgq2ZRhRcCpl86NtzcEo5GxJ0DxLNok1
         4nE/f6/vVOIAdVpsSw3l2iGc+0OS3PrO2Xus1yg571o0IMjsrzQ7mdwuiPmimNeYCZVp
         PWpg==
X-Gm-Message-State: AC+VfDxY7XF6BB/nR1CDIHGIFXRRVXfPZZe5x/HyGcldMsVCs9EoOR+g
        X4DhzMfXkVHwYzymLSJdARHNWJtk5/cAUKYIEzAjJJPaYM2QfRZak8Hr0T2+yNXGiQTAle8OOqG
        cL/FBo3NufD/oXe+mN6noMd22
X-Received: by 2002:a05:6512:2f5:b0:4f6:7e3:ac87 with SMTP id m21-20020a05651202f500b004f607e3ac87mr6704869lfq.14.1686652535333;
        Tue, 13 Jun 2023 03:35:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49tqyzU3LAS27DBj0mSC99QBr+94hhOak2EInHe8jPlySbTiaAJVenzCvEGEjUTMpDHM7g+A==
X-Received: by 2002:a05:6512:2f5:b0:4f6:7e3:ac87 with SMTP id m21-20020a05651202f500b004f607e3ac87mr6704858lfq.14.1686652535020;
        Tue, 13 Jun 2023 03:35:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e22-20020a056402149600b00501d73cfc86sm6208249edv.9.2023.06.13.03.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:35:34 -0700 (PDT)
Message-ID: <a4b83ff7-2fcd-e4e0-7657-2b78b804feaa@redhat.com>
Date:   Tue, 13 Jun 2023 12:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] TPMI updates for SST
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612224033.2382527-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230612224033.2382527-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/13/23 00:40, Srinivas Pandruvada wrote:
> This series contains two fixes. Patches are on top of
> review-hans branch of 
>  https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
> 
> Since these are unlreased products, I didn't mark for stable.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> Srinivas Pandruvada (2):
>   platform/x86: ISST: Reset default callback on unregister
>   platform/x86: ISST: Fix usage counter
> 
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 ++
>  2 files changed, 3 insertions(+)
> 

