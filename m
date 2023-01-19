Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A46740A2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjASSNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:13:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CCE8CE43
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674151939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdrDTN701XEr5+CWMY6m6v20b2OvSDiU2dbFC+yj4Dk=;
        b=ZMBnuSXvx1eaEbcff1+HP5rI5WWiGLYKsV904AU2do5jVwfaw3kMgAI/mNL8bqa6EhzJ3h
        /HzaFrr9vOMiG2OrMVb+Uug2f1XxetZX2XFdV6YTbYunHTNoNF9qO2IEHRoVSmFWkdzNMC
        ajeEz6Whb2vKoB+0+s+64YWE28Vl1Wo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-rGMf-WClO3am1PfgVgrerQ-1; Thu, 19 Jan 2023 13:12:17 -0500
X-MC-Unique: rGMf-WClO3am1PfgVgrerQ-1
Received: by mail-ua1-f70.google.com with SMTP id g4-20020ab01304000000b0060d5bfd73b5so778156uae.16
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdrDTN701XEr5+CWMY6m6v20b2OvSDiU2dbFC+yj4Dk=;
        b=pRYte/21Ezf+oEviuawxQrskK/4EszPyyMpCQBq4WgJjZAPcy+AYBPIG6B5my/CfYw
         gUqYPQUrzi6URUHkCW2rq4VK+osSxVicx675qi4QW5NJr8OkpgGF6K99CBmSR6Z539Xo
         rqwOKlc30t6eXkyUOzaqMdYVrtp7NvtE+FQghyEKg7nys145Cbsise9Hnj3mdr9Zlhjf
         si5j+yC69Okxbny0xn+YmovKDcDp56n9QqGcmZhmZZAMR29SR5sANXLqfKVfDX3lmBmO
         k3W9v86AR96DNjqJF8SYjRZGXgfYUy1fIF99caQRJcgryZX5vygx8J+ygvi9Nn3B/+ln
         yGWg==
X-Gm-Message-State: AFqh2koyAoxr5fwoRCfC8wRGg6OFgfggB/FcSNJ9cee1wpuDd9aXF/nn
        jjWk87VbFQ/YK7/QAryjGDrWjTNv6FWLlsL9MmrRFB0lBFfBm3+M101ufN8rTKiyTAEh5QSIwpK
        L7M6hy/zeLgOAGANQ/4SqUrqWhPoU8yoebnmQV9Ka
X-Received: by 2002:a1f:e701:0:b0:3dd:f5ea:63a2 with SMTP id e1-20020a1fe701000000b003ddf5ea63a2mr1626162vkh.10.1674151937441;
        Thu, 19 Jan 2023 10:12:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsY5p+k0R0sGPWSdQFYydcLWgiPLWtRkKOKc1nkSGhtM7pkgJykCPn8YcbFoLMnuG/wlE/Bp0MebqiMNtWQH3o=
X-Received: by 2002:a1f:e701:0:b0:3dd:f5ea:63a2 with SMTP id
 e1-20020a1fe701000000b003ddf5ea63a2mr1626156vkh.10.1674151937159; Thu, 19 Jan
 2023 10:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20221228110410.1682852-1-pbonzini@redhat.com> <20230119155800.fiypvvzoalnfavse@linux.intel.com>
 <Y8mEmSESlcdgtVg4@google.com> <CABgObfb6Z2MkG8yYtbObK4bhAD_1s8Q_M=PnP5pF-sk3=w8XDg@mail.gmail.com>
 <Y8mGHyg6DjkSyN5A@google.com>
In-Reply-To: <Y8mGHyg6DjkSyN5A@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 19 Jan 2023 19:12:05 +0100
Message-ID: <CABgObfZZ3TLvW=Qqph16T0759nWy0PL_C3w3g=PACj9cpupBQA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: fix deadlock for KVM_XEN_EVTCHN_RESET
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 7:04 PM Sean Christopherson <seanjc@google.com> wrote:
> > It's clang only; GCC only warns with -Wpedantic. Plus, bots probably
> > don't compile tools/ that much.
>
> /wave
>
> Want to queue Yu's fix directly Paolo?  I was assuming you'd be offline until
> sometime tomorrow.

Yes, I can, but what other patches were you meaning to send?

Paolo

