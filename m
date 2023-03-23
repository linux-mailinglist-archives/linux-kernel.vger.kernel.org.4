Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82CB6C6C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjCWPno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjCWPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:43:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7892E83C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:43:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d7-20020a25adc7000000b00953ffdfbe1aso23260987ybe.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679586216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tc2iPBU2KSJFkzxb2sQbDiu+LwsDFdSxiGWatUbS05w=;
        b=CEKjaXe5dn+F4SbhnSOGLc8mTN3sBWz87pIPOiCQKgScvO9lKaDeaqaOYkHLG8NI1q
         n/bPh8nRog+5af7eSNzZDjMdiL7ckixtoZ8MYe6zZaFX7c2TWoUx6yrFFzMiWpVksAAx
         zyRJqojv0RPAL4HtOgUtq8K79dX029ODJ9RhOErESRTnXqObi/JSaLTkvkHNZyxNIiSr
         MSAKHrbEmCkgZe/Ob0uvLIlEim9HuPxc5hELWVhIZjHK+plWNjCgfH7WIIRsCAHf4NRA
         eSWz36yJXeq6UlJSJ6maDiXI+aORwaweljkrdAWkrNc4uHlqpX8slWPPZWK3/ETKDDLu
         Lnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tc2iPBU2KSJFkzxb2sQbDiu+LwsDFdSxiGWatUbS05w=;
        b=Pt+bkQ0rXMctIwTkKljSKaowe8E1QyQI4uY9cvG498jJ2n084EIYnKgT9U5DyQtCSu
         9gcV3pVcldku8PaPYzWBx5luXvJnZrRNo+Q05UNNgXCT0H7JSoTGWcVMSAjiPOgy3Ivy
         hh1oDNkuhalGg02Fo/VLNbaOjR4kd7R/gcFwzEU451bUGtMpuw0WTSs3AUBBDfru14G7
         vJavfoC3TQfscQ0up+pDe8H/3f/aPa1RYzguKRgbver70U8ogf1zyrVQagfLPCFmIr0q
         D7mpzJQoU9XT4VGJ8SdGGnXMbHUThPptcJW8MfbXGM6T/gWYmVjqK3enBWcbM8CP0yXA
         PoaQ==
X-Gm-Message-State: AAQBX9dY4uR7Xbgl6vIAIrSK26JgiNqcvYRGtnkfVHD9txmunGzQgoSV
        tL4hCKGC2eFopbIk7LtAoRLtQwcOMm4=
X-Google-Smtp-Source: AKy350YGOGNLURvgby8o5NPWBgXIsl6iMozZdSCFZUWI+zn/AIumyHyXxX96aYe6Bq6Glb/5Vwo0D/t/w3U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1106:b0:b76:ae61:b68b with SMTP id
 o6-20020a056902110600b00b76ae61b68bmr489889ybu.5.1679586216308; Thu, 23 Mar
 2023 08:43:36 -0700 (PDT)
Date:   Thu, 23 Mar 2023 08:43:34 -0700
In-Reply-To: <20230207123713.3905-2-wei.w.wang@intel.com>
Mime-Version: 1.0
References: <20230207123713.3905-1-wei.w.wang@intel.com> <20230207123713.3905-2-wei.w.wang@intel.com>
Message-ID: <ZBxzphnyLPwBimKL@google.com>
Subject: Re: [PATCH v2 1/2] KVM: destruct kvm_io_device while unregistering it
 from kvm_io_bus
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, mhal@rbox.co, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023, Wei Wang wrote:
> Current usage of kvm_io_device requires users to destruct it with an extra
> call of kvm_iodevice_destructor after the device gets unregistered from
> kvm_io_bus. This is not necessary and can cause errors if a user forgot
> to make the extra call.
> 
> Simplify the usage by combining kvm_iodevice_destructor into
> kvm_io_bus_unregister_dev. This reduces LOCs a bit for users and can
> avoid the leakage of destructing the device explicitly.

The changelog should really call out that coalesced_mmio_ops and ioeventfd_ops
are the only kvm_io_device_ops instances that implement ->destructor.  Without
that info, this change looks super dangerous as it's not obvious other paths won't
end up with a use-after-free.

Paolo, if/when you take this, can you tack on something like:

Note, coalesced_mmio_ops and ioeventfd_ops are the only instances of
kvm_io_device_ops that implement a destructor, all other callers of
kvm_io_bus_unregister_dev() are unaffected by this change.

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
