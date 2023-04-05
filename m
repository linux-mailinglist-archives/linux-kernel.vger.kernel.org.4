Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487C36D7637
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjDEIEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjDEIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:04:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98E49E5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:04:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-947cd8b2de3so31871066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680681864; x=1683273864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1qeWL9csSccLs6fLdE0uQkmoTpVTl/CNeE7DAxN2MXc=;
        b=Xhq2FpN6Mn9U+EjSMWm81/rOkL0bCFC+/2wjeKRsitvqUzxRSPfp9fuoLeyBFssxEy
         uDCSbz1YbvYjEPswqb3S2GTeD5WrMfOxja6ExrIKkGQLeADhlgbB7YOPra4MuzjHMrmj
         ZXdFh+JVuRGjSQyYZanQX5QlEVziDHiVidIiylGL7f0MyJUhqMsMEyHDcOQ7gNiV1wC+
         ahUaXralaKBaRSz4fOK+iGVNv27U4eaNu+zC6QxXTv6Jps/OaYMBUjv3ab9gY0hKw4g7
         NAydS21zEz4TOSL9DVk3uvDj3K8Lk9ct3FFtJCd1yGfrC7kCaSATBwW4q2DaUE7YXwsp
         DLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680681864; x=1683273864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qeWL9csSccLs6fLdE0uQkmoTpVTl/CNeE7DAxN2MXc=;
        b=KgDR7W3s4hSYKcKRIoTkVcGCzalDtuLncAgXpx9kGGpXVtuhSEbI2FNRnD2eYl5i3z
         ETcVxBfYgh1MMaMhhEjPJYPzDa8m2PgONkPKdKadJV8JVxRD9WjwGGJVWk47stfAd+iM
         p/6MStPJ7LSt9CtYAOr5i7ucJbJTJFVUTTGHXvwcaqBm5P9Wwh4FffDmBtE8XzawaqTv
         HuPwe5Gfet421BJpOWRHjonH/fJkbtLqH2uOzve8m8dl5a0kfrazVLIqzIgEH6zd/Apn
         m3L2rsYss16LqwLrflWzruISpP30guz9khZja0MLLOnZ9zmME+97ywd7HBsE2YDv752V
         EZIQ==
X-Gm-Message-State: AAQBX9fUD+rz/32/exjtfhbdhg/vYRpxQWXYy97bAd3CiVvC/XYtjytI
        l+nm/dpbV/NS+bZq82mqUd+Q8g==
X-Google-Smtp-Source: AKy350bF5rLJogTrsY1f6blQnOqzcwkAlbB5v+pmHg+Ta3p4lfp6J5hb3yzzRk5ijVMDrTT8n0Y6cA==
X-Received: by 2002:a05:6402:2026:b0:4fd:2533:f56 with SMTP id ay6-20020a056402202600b004fd25330f56mr1005988edb.39.1680681864506;
        Wed, 05 Apr 2023 01:04:24 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a65-20020a509ec7000000b004fbf6b35a56sm6955177edf.76.2023.04.05.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:04:23 -0700 (PDT)
Date:   Wed, 5 Apr 2023 08:04:20 +0000
From:   Quentin Perret <qperret@google.com>
To:     David Dai <davidai@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [RFC PATCH 2/6] kvm: arm64: Add support for get_cur_cpufreq
 service
Message-ID: <ZC0rhEHTlz6dHKC0@google.com>
References: <20230330224348.1006691-1-davidai@google.com>
 <20230330224348.1006691-3-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330224348.1006691-3-davidai@google.com>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 Mar 2023 at 15:43:37 (-0700), David Dai wrote:
> This service allows guests to query the host for frequency of the CPU
> that the vCPU is currently running on.

I assume the intention here is to achieve scale invariance in the guest
to ensure its PELT signals represent how much work is actually being
done. If so, it's likely the usage of activity monitors will be superior
for this type of thing as that may allow us to drop the baked-in
assumption about vCPU pinning. IIRC, AMUs v2 (arm64-specific obv) have
extended support for virtualization, so I'd suggest looking into
supporting that first.

And assuming we also want to support this on hardware that don't have
AMUs, or don't have the right virt extensions, then the only thing I can
think of is to have the VMM expose non-architectural AMUs to the guest,
maybe emulated using PMUs. If the guest uses Linux, it'll need to grow
support for non-architectural AMUs which is its own can of worms though.

Thanks,
Quentin
