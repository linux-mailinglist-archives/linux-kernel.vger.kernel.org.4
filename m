Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A478F6BF557
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCQWvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:51:18 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD2D2956
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:51:17 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id cp21-20020a17090afb9500b0023c061f2bd0so4676085pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679093477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4VE1iHzPcbBwBz+W0Z9mQD/JqfyWws+rYI7qgbnqJ24=;
        b=X76aa+88Lm0L9+nU2RY+oehLL+uZeQVHQ3lC33fRrcs4GJusd37CvBwg1npPcZuoaQ
         geREk9EiZdCWI05TYiItxbL4xwUD0KX4ewcUdMQxy6mozPkZZ9hdUB5ZX48FQcJHEIgE
         D406GoLPyRJ72qWqM0BvN0tFwhzqrdH5hMXwPMv4L3Ag0G0Db+OJcUvN7XaIEeNC0fqT
         nGimFLuSMn1Iy3Lkf/Yhppd3jHT/h9XrqhtKWczlD0dYnYyORTiqHdsqw+r7ZZX10edv
         IVQQzB1vyTsZOy44ltfKd3dH7zBB/8zfkdtZzPilYnqCIp9BGBKAv8vrcEBGxPbC+Rhr
         n89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VE1iHzPcbBwBz+W0Z9mQD/JqfyWws+rYI7qgbnqJ24=;
        b=fGZEYUoakfXiJM48uty/+UEm+SShnv9PakcsGyL9K+OOimltG+fiKdK4EVX18RjDgG
         QANFtwXVHADr3NXIhTWDVHIsp0i3riUPMlV2907upzPzYtKlfDtfoq/8Jo/1ZBgLCXOx
         YGQdohKeTLfk4M9AMAZfdZb5mbM+57QSIhaXmBo9x5bZMw0OAEn1G8+GWt2nzHoBMwwk
         0dXS8lQEnCPWjtjcj7n9To8aCYvQpvKwAzd3xPM1ydYnBZGhRUA+9tSp97xjPK/M8g6s
         GAJiXH26Kill7Vz1Vbp7sRfD2tbG7O2vTlOtF5WbU5bWR0KeX8SU+VICu3WVmx9G7H1I
         I7eA==
X-Gm-Message-State: AO0yUKUC05DkkoHJ89hO62xhH2MtEMW/l/oLFT1rSTsazKcOMqrshM1f
        FiU3jzUlEFozPH42zyQFfiRqK0lX0M0=
X-Google-Smtp-Source: AK7set975D5NqLPdB4ZrC43vRYKFxW38+uf7o5sjFi/RTDild/JZiSzUxzFBE+SLKor52v495Stt9b2HaPI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:a0b:b0:23b:419d:8efe with SMTP id
 gg11-20020a17090b0a0b00b0023b419d8efemr2761563pjb.3.1679093477360; Fri, 17
 Mar 2023 15:51:17 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:51:15 -0700
In-Reply-To: <20230211014626.3659152-8-vipinsh@google.com>
Mime-Version: 1.0
References: <20230211014626.3659152-1-vipinsh@google.com> <20230211014626.3659152-8-vipinsh@google.com>
Message-ID: <ZBTu40/IYurmQi5N@google.com>
Subject: Re: [Patch v3 7/7] KVM: x86/mmu: Merge all handle_changed_pte* functions.
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023, Vipin Sharma wrote:
> @@ -1301,7 +1283,7 @@ bool kvm_tdp_mmu_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  	/*
>  	 * No need to handle the remote TLB flush under RCU protection, the
>  	 * target SPTE _must_ be a leaf SPTE, i.e. cannot result in freeing a
> -	 * shadow page.  See the WARN on pfn_changed in __handle_changed_spte().
> +	 * shadow page. See the WARN on pfn_changed in handle_changed_spte().

I was just starting to think you're an ok person, and then I find out you're a
heretic that only puts a single space after periods.  ;-)
