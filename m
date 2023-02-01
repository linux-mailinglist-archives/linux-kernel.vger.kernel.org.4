Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515B96871F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBAXaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBAXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:30:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CABF5BAF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:30:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso160161pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6SYrumTQi6REC/0Kg8GGJ9ai7j8NzfqfHjmPrhKN8c=;
        b=FGgtsNHRSFdU6Dy1HUKp1/7zN/8I9LIvSkEV6Y6IJFqTWyI8cUZ/XPCS4ul1gHJH6a
         chbPak31LSa03fX7gS80bfFp7N9iCbQOcrrR49NC3nwTLi00TUSigsGEuAJkwGnLsYOa
         9zuTZ1YVFTJz40Dh6SpMSqC/4UcOmE7ML9/PCmgANL3HnpkKge3gecjVVCbadwpOAlKh
         kGIQRWTH9+w3y14KD2+j9fOMhvpZXPbTkOS3spMiLwl12Dgo7YFQbd2XB4jTOUs69O3w
         Z0R31VGXYrQQrYEfipGO/Ox2trH4uenwqZTeLdcLcfUcJ4OPxN0qN+Nu/tVglO3Pg3As
         xfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6SYrumTQi6REC/0Kg8GGJ9ai7j8NzfqfHjmPrhKN8c=;
        b=UqSY3+uA4SFE3njx8PhZdZAJ/mmxaiwsOnwKvhx4zHf+f72GecvuQsyWvUXSz4jmDq
         aE84yLdkg9YXsx/kdpmCC6t6gqUrZJqOnixJn4obbybfnzruOKBeKFTY1ahlZ9xp7OPk
         cEwEDOj6ovyuxoX33TCC4Qs6z8O9dXrLnE1N0Pn6hsOKTyg9VzxdTO5tF8Exuv+eCtG2
         PsFlQ/JFYWplXaFLD9n7JbeJNupL1oQe3BeBYU2efl+mAzhNBVpN7H0zykg3d+U43q52
         q5uDv3lHxBEi/RZQU83cUxF3NSj7W7Ytr4zllfIaYVLEEeLejoFyGM/HsA+p+uBRHbZh
         KavA==
X-Gm-Message-State: AO0yUKXd32FSJ3/QI8o+yZW+JaG4HQAUWkADhtpicEzInyW7PQo3MJXr
        ja3mMKD8oBBhlKCqbFR+Mu/sUzfEA32YpY6SXzA=
X-Google-Smtp-Source: AK7set9GlhWkjCgaQfUB3BbtcGj5g3zKTIFRpWuG6x/uv5U5atadFD6yQHYQh5TTw9+c81Zc8H1SDw==
X-Received: by 2002:a17:902:eb09:b0:198:af4f:de0e with SMTP id l9-20020a170902eb0900b00198af4fde0emr134910plb.14.1675294211989;
        Wed, 01 Feb 2023 15:30:11 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b0019339f3368asm12411642plh.3.2023.02.01.15.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:30:11 -0800 (PST)
Date:   Wed, 1 Feb 2023 23:30:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: move KVM_CAP_DEVICE_CTRL to the generic check
Message-ID: <Y9r2AGx2vR8VW4cC@google.com>
References: <20221229123338.4142-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229123338.4142-1-wei.w.wang@intel.com>
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

On Thu, Dec 29, 2022, Wei Wang wrote:
> KVM_CAP_DEVICE_CTRL allows userspace to check if the kvm_device
> framework (e.g. KVM_CREATE_DEVICE) is supported by KVM. Move
> KVM_CAP_DEVICE_CTRL to the generic check for the two reasons:
> 1) it already supports arch agnostic usages (i.e. KVM_DEV_TYPE_VFIO).
> For example, userspace VFIO implementation may needs to create
> KVM_DEV_TYPE_VFIO on x86, riscv, or arm etc. It is simpler to have it
> checked at the generic code than at each arch's code.
> 2) KVM_CREATE_DEVICE has been added to the generic code.

I think it's worth adding a link to the v1 patch, as that thread provides the
context for how KVM ended up unconditionally advertising the feature, e.g. instead
of trying to be more precise.

Link: https://lore.kernel.org/all/20221215115207.14784-1-wei.w.wang@intel.com

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
