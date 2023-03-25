Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177F6C896B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjCXXkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCXXkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:40:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92762113CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:40:19 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bk5so2443521oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679701219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHpidQtSUhq3zpSTOAjO5JszMuIBlCwSY/IIVCS13Og=;
        b=OAMSGtUvcgKwUCSlAKFsRCZIQZO/KMvaklqg44VZjnuRh+tIRYjgzQGOEAW2IigUv3
         lDxzy8GKkQ/C80ZAgD+Nh4W6lWwi/DSPoD6mE9ylrrybRA8nODH6anAXXCzwOhUehhW7
         Q3j4s7HGCB3ETtSVwEAUoQt/rFECW8YR8jVibgjmB6CMuou0GnE21WDrABxSz7Z+nU40
         Lct9J/ShRIsvbRxteaypiQUSXkJg2HNx5f3k8RQlUkI4eaBkzFadRlsH0LpCI72l2LE5
         Utnw/kYBhuNamQ9r4ZmEsEYgxZ6a7GW3piX8R4yy/ANoCgH0CjHUHsFWj88gwQwN8b00
         C1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHpidQtSUhq3zpSTOAjO5JszMuIBlCwSY/IIVCS13Og=;
        b=7W1I7h/S3oFzv3sp1fANkDxRLhE7dOia9XZ7OL9OS1eXgVYPzAUqIWOCQRUbn7ZkqZ
         H7EFsZcHkZgN//lZi5r1b3bzV2awZiQ6HNimL7/KT3cXkHJEBUeFgP3RlRsnHMYYGmsL
         2IEjy1LiZKBFPO6f0BWiI66cMtGDYIyfiduvgzHTM7X1vY0hwV41jKP6VrT4qJCdBJep
         QfIpqxAVeL5PE7FJZ8KNYWgO4d3P2Sa421w7fuFmI8ZCxlGPHOVuwTW3APO59l61cGJj
         4D7E34QAWXlju3zNXRnVfZeGJSQqvRth+hfWYoAB4PQiHDIj0ksPJO1V+ya9/H+Gfn/v
         wcEA==
X-Gm-Message-State: AO0yUKVNTgS84JpJawE07ASgVV+Xtm1JvfRrXBHrhxpyckuNhfF1F3Zq
        creF2e04Or2ScNL2PPKx3Raki0MqMYGiivOv6VSOfg==
X-Google-Smtp-Source: AK7set8kWpGKbko4C/hT8r6bhx97Jjx5Kdn8h6twZJE7ICY0Ywo/Xw0NrC7eBrFNsJ2lFfldWAtWm8UcA02q1zrh8Os=
X-Received: by 2002:a54:4710:0:b0:384:4e2d:81ea with SMTP id
 k16-20020a544710000000b003844e2d81eamr1128565oik.9.1679701218769; Fri, 24 Mar
 2023 16:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230301185838.21659-1-itazur@amazon.com> <20230301185838.21659-2-itazur@amazon.com>
 <ZB4S9eP0tGbGUTSC@google.com>
In-Reply-To: <ZB4S9eP0tGbGUTSC@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 24 Mar 2023 16:40:06 -0700
Message-ID: <CALMp9eR766pb0664V3GHsq84qCCATRwUxPLrmeRUMv-6EYcs1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] KVM: x86: Propagate AMD-specific IBRS bits to guests
To:     Sean Christopherson <seanjc@google.com>
Cc:     Takahiro Itazuri <itazur@amazon.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 24, 2023 at 2:16=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Mar 01, 2023, Takahiro Itazuri wrote:
> > VMMs retrieve supported CPUID features via KVM_GET_SUPPORTED_CPUID to
> > construct CPUID information to be passed to KVM_SET_CPUID2. Most CPUID
> > feature bits related to speculative attacks are propagated from host
> > CPUID. AMD processors have AMD-specific IBRS related bits in CPUID
> > Fn8000_0008_EBX (ref: AMD64 Architecture Programmer's Manual Volume 3:
> > General-Purpose and System Instructions) and some bits are not
> > propagated to guests.
> >
> > Enable propagation of these bits to guests, so that guests can see the
> > same security information as the host without VMM action.
Usually, I can count on Sean for the semantic nitpick:

This propagates bits only to the userspace VMM. They may make it to
the guest. They may not.
