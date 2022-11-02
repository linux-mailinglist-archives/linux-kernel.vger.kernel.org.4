Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D31617301
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiKBXqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKBXpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:45:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5F193
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:44:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y13so117832pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fae7R4asXuAhnZRQbDhAUUiqdf8KffVDMSIbnVzQ284=;
        b=KAhyFkm2kBJ7UxLyeT1kw+/IixN8m1v+/lj85dSYExqSyGbXmSjNkWqK0AkNQDpAXr
         BlvhqCz55hxjd5giSG2bYdKcmlih7M4imgurWTuz8Q4xZ71EGSambnjoO5KJFdSc+2bg
         vr8H7h4lKicMawf89A25FFxqAp+F87KmjHjG7+N5Z7Csgska9EpqnMuGImrS6BtKUfYm
         6/m71rbI30nrrniGQRHUwidU5nHdpGQxAVtgJ+mdNaUoA+A+Lctzpv9u429YlvofXxur
         kmO+GwXmlc5SIz93r4l0VUHgjiijMaplRNDl5WqIuW6qljuJK9pgjg9ITmI8w2UF7d3p
         E/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fae7R4asXuAhnZRQbDhAUUiqdf8KffVDMSIbnVzQ284=;
        b=grWpSL9156GjdCd1hYqeE/ZHK8KfW6GbYTNkIj5wPaubRyooBASn5dXJX6zLwMU/cs
         H5Gj+tfSRWJXvAwIORPja19QjtvB4uGuH1e0rPq/fBp4QxSlG/YekfXbsAg1ONx2IvnA
         CSUc0uU+Vvrp4E5QYHaWpiYovZBQlopzRkK2WKxMPDuGxCasVAma41i7GcLPyxrNVGi+
         3/+F6+u6Hw1UpsFWU/g3klUX97GOgx16WqVbQjkbMOoRtVpJ5uMkcKKzvSGYLLORUgIC
         yfu5GKdX9FAk1PDjB6nRpcsyzjMXqAKrvJsis6hCl5/ltelXe6Db8wlnz2HIXAzqp5jr
         S3Uw==
X-Gm-Message-State: ACrzQf0iMZKGNlqoKCBLPsIyGcve0TOosNkb3FnPMm1ls6J3dxP3N+Zh
        nDJFXndk5a6nwDiakfMWrc7Z1Q==
X-Google-Smtp-Source: AMsMyM7Skq+LiQwc4p37pSLLv4dvHJacOam7OiDQlpW/Zh2JX96Fp2zX7SD73rjR9gfRaw76YadE6g==
X-Received: by 2002:a62:8141:0:b0:56b:c435:f003 with SMTP id t62-20020a628141000000b0056bc435f003mr27504886pfd.15.1667432676524;
        Wed, 02 Nov 2022 16:44:36 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b189-20020a621bc6000000b0056b818142a2sm8999521pfb.109.2022.11.02.16.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 16:44:36 -0700 (PDT)
Date:   Wed, 2 Nov 2022 23:44:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/7] KVM: selftests: Use SZ_1G from sizes.h in
 max_guest_memory_test.c
Message-ID: <Y2MA4DKCOTiBnAn8@google.com>
References: <20221102232737.1351745-1-vipinsh@google.com>
 <20221102232737.1351745-5-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102232737.1351745-5-vipinsh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022, Vipin Sharma wrote:
> Replace size_1gb defined in max_guest_memory_test.c with the SZ_1G from
> linux/sizes.h header file.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
