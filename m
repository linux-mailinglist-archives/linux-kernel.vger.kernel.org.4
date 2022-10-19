Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9260A6050F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJSUAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJSUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:00:17 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB9133306
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:00:15 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b79so15298611iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkGSfzxuPqiv8jR4T7CtRiwV1wyj0mQrlEAoXZ0EoXw=;
        b=XUMZ375mzaOVGXeWKKcCjhUzZAljDwE73XZz0aFswHX1rnTAFW8dPAFg2ZFWTbIKxy
         TqM6Zz1bjamC2ga4aCFlTC13gNWdE69PBbbem2JhaklQbk2ADEzRzVLuLjAqyi+hHx/s
         1C/OwbhyCtTDdQt5kVRZcpE29nIf2hcq0+je4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkGSfzxuPqiv8jR4T7CtRiwV1wyj0mQrlEAoXZ0EoXw=;
        b=LB6cYFzwJnKjRsytv6xDYxq1ym/gdKzVB/TBwE7fDENJzHcXbeTCMZEQ9plaz9/dcb
         w0WcBthA0xfCj7DWMxI0RRGQVDK4UjWQFcJDCn1gqDRsmiKkqkGb9iE0P71kdN6d0WPA
         +5aL1H1KLcoDEtV4SQuyMQTU63eqCKF8fFrHINStQUt0eFicZZ5GdYfQ974ExDN4JfmY
         IdHXg35xEP9/3YzKzQUnZULevIfLHz0ee5KYPqInhzfQRHTX6cld0jP7KDIC6BkkA6iC
         6giAV4g8RpfUodhPbaGZXNevKMaDlv6B+i4S3qTCsp1rjA7ESr/bX7KSoAFSJNwVt3/y
         ubNA==
X-Gm-Message-State: ACrzQf0X7H2YgciYLacwDj7Nc8x4h+MAdbUXSYlauFmXwmfD+HYFtI0S
        /REfp5nOSKWc25P/AT5uGgtA+MN0K7VQdA==
X-Google-Smtp-Source: AMsMyM4mGBB8gdgRloqmh+Zglblraja5eZ8VOw7mJ8h5GZQiv74PiQh6o5iVuBWAqAlVSzV9mng0HA==
X-Received: by 2002:a05:6638:338a:b0:363:bcaf:1017 with SMTP id h10-20020a056638338a00b00363bcaf1017mr7678347jav.176.1666209614769;
        Wed, 19 Oct 2022 13:00:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n44-20020a02712c000000b00359ae384ffbsm2486673jac.19.2022.10.19.13.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 13:00:14 -0700 (PDT)
Message-ID: <efe5a0a4-775e-bc6b-27c2-aa506f5613fa@linuxfoundation.org>
Date:   Wed, 19 Oct 2022 14:00:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Alexander Deucher <Alexander.Deucher@amd.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 6.1-rc1 drm/amdgpu regression
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

I am seeing the same problem I sent reverts for on 5.10.147 on
Linux 6.1-rc1 on my laptop with AMD Ryzen 7 PRO 5850U with Radeon
Graphics.

commit e3163bc8ffdfdb405e10530b140135b2ee487f89
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Fri Sep 9 11:53:27 2022 -0400

     drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega

I see that the following has been reverted in Linux 6.1-rc1

commit 66f99628eb24409cb8feb5061f78283c8b65f820
Author: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date:   Tue Sep 6 15:01:49 2022 -0400

     drm/amdgpu: use dirty framebuffer helper

However I still see the following filling dmesg and system is unusable.
For now I switched back to Linux 6.0 as this is my primary system.

[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring gfx
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring gfx
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring gfx

Please let me know if I should send revert for this for the mainline
as well.

thanks,
-- Shuah
