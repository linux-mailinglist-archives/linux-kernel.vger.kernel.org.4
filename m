Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0468A706B93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjEQOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjEQOua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:50:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBB40C0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:50:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-530a5ad74e0so543338a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335028; x=1686927028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDsdBMwmB7I2Qp688+UBcj3KD8alKjVIKuHiZri9HMU=;
        b=Vf+7S2HoSpfs2i91kZKs1dMajBCg4atRbZ1RdHfApDlXNjHAhHxRwez5A5qZNHe2jv
         V0o4IUUnS336MnI4yymhfCjVauEsGe8mKhzMo8rb46v3D64L7OyYpQlYBvNELH3PaE7V
         FcnaP5aDFfMfOWo+P5kJmjS+zZS//6/Lt34MqwTss3nyMeKmrbr/uI1dWi2bjbV1Ndkb
         cXCzjRfg6Nl1KV49v8ID5U6rveTZCkiD26mW7/h36IwbzqwvRsQvuzCVGjs+Ty2qNsgc
         EckxMnZV0hHOddy4Jc7+/6qYUYqXK1JZAUlL8AN2bGd8+Yo9N1QiKq7D6OW3Ya6pVVVF
         89AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335028; x=1686927028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDsdBMwmB7I2Qp688+UBcj3KD8alKjVIKuHiZri9HMU=;
        b=dEFRuqZxd0iiYXi3kGP7OzCbgnKhpDP8sHcO3Bt7bekemVObKFL0jfoQjb16qrKjMa
         lBi/gykTAb94djNC9ppjbL8DfNZ4454hyfqP6pLpSGjQGxrW+qquThVAe6rJ7rWolxWQ
         ZpcXrFGGUIMiRJHrhdhPS+VfdaMNuRWFzgyOxqnnYZd1km4sKZm0mVCTDULca2fdWjkQ
         mfZnl77y/ZzszLrPHdgQ7Z1o0aYS3zm/VMtruDRk98t5wAlW32XQ6pWH6Jb7PCeXNXsH
         Uq/ibrJM8gv8zXYvY5faUsRBjLj/A6hTuhJJunQnhMTWvVaUtA6ltsYihwouKZXMJ0dQ
         u3iw==
X-Gm-Message-State: AC+VfDxGFdcb5dV5R8COCsp1n90JDjfUwVbvr90Dt0Q96wxMQTcDoM8h
        1Dqgsiv3xUMMwodHQQ3OXQ7wFqYUgeA=
X-Google-Smtp-Source: ACHHUZ75/t5JCGUIwclJmPSmeF9uOB4McX3h8rZmEZLvYDyHDz2kKHj8Q6kfck2kxY5E1pOs7Hb99X7Mh6A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6cc8:0:b0:52c:b46d:3609 with SMTP id
 h191-20020a636cc8000000b0052cb46d3609mr10657615pgc.12.1684335028469; Wed, 17
 May 2023 07:50:28 -0700 (PDT)
Date:   Wed, 17 May 2023 07:50:26 -0700
In-Reply-To: <ZGNO5gYKOhhnslsp@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com> <20230513003600.818142-4-seanjc@google.com>
 <ZGNO5gYKOhhnslsp@yzhao56-desk.sh.intel.com>
Message-ID: <ZGTpsvZed+r3Low1@google.com>
Subject: Re: [PATCH v3 03/28] drm/i915/gvt: Verify hugepages are contiguous in
 physical address space
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023, Yan Zhao wrote:
> hi Sean
> 
> Do you think it's necessary to double check that struct page pointers
> are also contiguous?

No, the virtual address space should be irrelevant.  The only way it would be
problematic is if something in dma_map_page() expected to be able to access the
entire chunk of memory by getting the virtual address of only the first page,
but I can't imagine that code is reading or writing memory, let alone doing so
across a huge range of memory.

> And do you like to also include a fix as below, which is to remove the
> warning in vfio_device_container_unpin_pages() when npage is 0?
> 
> @ -169,7 +173,8 @@ static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
>         *page = base_page;
>         return 0;
>  err:
> -       gvt_unpin_guest_page(vgpu, gfn, npage * PAGE_SIZE);
> +       if (npage)
> +               gvt_unpin_guest_page(vgpu, gfn, npage * PAGE_SIZE);
>         return ret;
>  }

Sure.  Want to give your SoB?  I'll write a changelog.

Thanks again!
