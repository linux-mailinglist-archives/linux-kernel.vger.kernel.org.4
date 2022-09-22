Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7FD5E6934
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiIVRJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiIVRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:09:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DF1FFA4E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:09:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n83so13145773oif.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SCH41PZHoDU628bdtYlErvnzmog8gkI9vkvu5Tjn52s=;
        b=ncNtd1PSg4kUznwkkXE+qWSY1m9YVzp63INmh6bBgJQkic26IxE037zM8bQxTL6I8X
         kD0ghv6o0UOt/bxoN+DaenaNoPAesHvwIyP3y2fPJ1tH1YX6fRYOc4THXcEfNMOlq7Kf
         1VvyaXorhfKSTaPyaJMbv73J3ZFDOxyCszTGD/MqxdsaPajpAa1GXKgoEAsIelQPj6t4
         xXWX4IlAXDOKOP37HtEZrOIwxzLmEwCzM5CUBjTidSUA1pBETqXur7wIKvFD+2wUYwUS
         CcN/64DD8idi/BHFdC2czjdp5Q2Sr0HwkMIZn+XLyiNAEwjTAQS7Ij3pQrgRy2gokILg
         nNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SCH41PZHoDU628bdtYlErvnzmog8gkI9vkvu5Tjn52s=;
        b=emY2CaGY3BCTLO/C//kZwHQG01PtsOxvjmT6YeRXKZUb6jP1/9hCmO2Tv5eufyG5Dj
         0vNnjUYXllrCfZgG07MTIJSQ8c4/OiXUILd+hiOjewD+neNfC7RNMD7I2uEbYL49eUeF
         C8YfRXJvizgSXb74L/u1wf93fTm44UEchM4b2D1634IMKIdYvnaGt6X8m+yTpO4/8LS+
         Pco704Q6WYQyJ7Z4rY7pnUyIEsre9qLfYfMfTExdY+uieK+V4PaGfHdNNhpP+qOimAEl
         p7YKVclOBfUMdyLH31LXlOsHSU9hR9wonxLMkXqcl/kBgK5VffPv6Z4oOPs5KZco9XnK
         OP/g==
X-Gm-Message-State: ACrzQf3k7VUCOHE/h6dm7kJpFWTLfMNYR/a+nGQcfF1Eh+V505hH9P1T
        +pc0Cwefsx94Jtt7Tv3O9VAaRTJuZVdhMzji1CA/PA==
X-Google-Smtp-Source: AMsMyM4cudPwjpo5sIQdFq8qIK/InHXSVSkRir2eTxuIg3sDXCu48Ri/NTXF5br4Ip4LRDZM71GXejwYXBh+g+ZSfQk=
X-Received: by 2002:a05:6808:f8e:b0:351:a39:e7ca with SMTP id
 o14-20020a0568080f8e00b003510a39e7camr698564oiw.269.1663866559313; Thu, 22
 Sep 2022 10:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922143655.3721218-1-vkuznets@redhat.com> <20220922143655.3721218-3-vkuznets@redhat.com>
In-Reply-To: <20220922143655.3721218-3-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 22 Sep 2022 10:09:08 -0700
Message-ID: <CALMp9eSVQSMKbYKr0n-t3JP58hLGA8ZHJZAX34-E4YWUa+VYHA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] KVM: x86: Introduce CPUID_8000_0007_EDX
 'scattered' leaf
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Why do we need a new 'scattered' leaf? We are only using two bits in
the first one, right? And now we're only going to use one bit in the
second one?

I thought the point of the 'scattered' leaves was to collect a bunch
of feature bits from different CPUID leaves in a single feature word.

Allocating a new feature word for one or two bits seems extravagant.
