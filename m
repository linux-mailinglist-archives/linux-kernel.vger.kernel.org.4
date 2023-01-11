Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE5665E46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjAKOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAKOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:47:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDAAB1D8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673448424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqQG3JNDEO/kYh+NKLKhH0hkiW/AMpJ9IC5B2BkCg3U=;
        b=HVOLMGmBFEYMf6Fn/Y3FyHxkOcVaox+tDPEsSafJ+FCPSNMoTM1wgKWzkIphu0pTxPhTfm
        RRdfClGkZCeU24zK7R2QVDqWyql9OaPFTLd1syGOrtb/YEaGtEF/MhubMLFjo82Gf7kp5F
        0HP1dk49YCUH+rfl7VjRnV8Tgyk5DTM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184-1WN0SXLBMs2vFCbi426blA-1; Wed, 11 Jan 2023 09:47:03 -0500
X-MC-Unique: 1WN0SXLBMs2vFCbi426blA-1
Received: by mail-wr1-f71.google.com with SMTP id i2-20020adfaac2000000b002bc40f98167so2002185wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqQG3JNDEO/kYh+NKLKhH0hkiW/AMpJ9IC5B2BkCg3U=;
        b=a52HQQnOwOJo7EvOnkURjhLzTN1WoiEjK/eYB/dYHluJVln+PwgC1g3hbBbagfU1bB
         ypzUvTZ3gZDjVbEGhIL5FM+Ioe17lSVoB+kVMbJMznprhPKG06npVgikmGEn3g1MpQT3
         4L+Yz/UIV7f0vvJYf9uH+apTyl4VtUVf5Q62Gws0woCq2xiYU84KFA7L1Bz1iIDmleQX
         rCr2DpkfRlp0lzuXG+xo2We3tXseK7fEli5I1Vn5qUpt/Ad4d6roGUv0KofGvDTUDrgL
         k5BTDPBfB6FYRSGwPTkOz0dsyYXtCMceuX+iYaaX6QKeThIeiJI6gs5+g1NAbP+lKDdH
         Xq+Q==
X-Gm-Message-State: AFqh2kpNpn4NaOaBoqvv1knHV53ieGqbsQa5rDoHiaD22MNJ9rgkgBiW
        BygSnUwkYLemVEd79Dm2NYdKxuz1JzgxXYRr0T2DNG+F6aGNIymL0Y2HTcdTTRnAfAypdccKQRT
        UzPVabKX36uh86zXkmrX2TQL5
X-Received: by 2002:adf:e19e:0:b0:298:879c:6d01 with SMTP id az30-20020adfe19e000000b00298879c6d01mr21079051wrb.23.1673448422311;
        Wed, 11 Jan 2023 06:47:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsOrD+2HxVk6X54PaT7UB5tkpWPYUTRf4aLbtvfN8wp1GhchDL7ITanmLjNJu+ZW3wn9gKCVw==
X-Received: by 2002:adf:e19e:0:b0:298:879c:6d01 with SMTP id az30-20020adfe19e000000b00298879c6d01mr21079042wrb.23.1673448422046;
        Wed, 11 Jan 2023 06:47:02 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d488b000000b002bc7e5a1171sm7099749wrq.116.2023.01.11.06.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:47:01 -0800 (PST)
Message-ID: <667c1b8e-b46c-c830-8f01-9e97e64e4e4e@redhat.com>
Date:   Wed, 11 Jan 2023 15:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/1] selftests/filesystems: Grant executable permission
 to run_fat_tests.sh
Content-Language: en-US
To:     Pengfei Xu <pengfei.xu@intel.com>, skhan@linuxfoundation.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heng Su <heng.su@intel.com>, akpm@linux-foundation.org
References: <cover.1673424747.git.pengfei.xu@intel.com>
 <dfdbba6df8a1ab34bb1e81cd8bd7ca3f9ed5c369.1673424747.git.pengfei.xu@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <dfdbba6df8a1ab34bb1e81cd8bd7ca3f9ed5c369.1673424747.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pengfei Xu,

On 1/11/23 09:15, Pengfei Xu wrote:
> When use tools/testing/selftests/kselftest_install.sh to make the
> kselftest-list.txt under tools/testing/selftests/kselftest_install.
> 
> Then use tools/testing/selftests/kselftest_install/run_kselftest.sh to
> run all the kselftests in kselftest-list.txt, it will be blocked by
> case "filesystems/fat: run_fat_tests.sh" with "Warning: file run_fat_tests.sh
> is not executable", so grant executable permission to run_fat_tests.sh to
> fix this issue.
> 
> Fixes: dd7c9be330d8 ("selftests/filesystems: add a vfat RENAME_EXCHANGE test")
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---

Indeed, thanks for fixing this.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I wonder how I didn't get this when running the test with:

make TARGETS="filesystems/fat" kselftest

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

