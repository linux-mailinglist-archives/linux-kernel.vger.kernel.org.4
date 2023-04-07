Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404DC6DB00F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjDGQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbjDGQBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:01:45 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81FBBB92
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:01:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l1-20020a170903244100b001a0468b4afcso24488403pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680883291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArkFzgGmWr5GIWIb5S26dnAG6/MRvelBkLMc+Gk1DCI=;
        b=b1x6wuN8SB2jxdh5jqkPjFSPwNKAuuWDG6iq4r0w3QQ/c5uBQxAUffbz7fBkpbziRs
         lMJRpn1M2y6+OlEjiNm3RbYpHz87fmdsm1jcQrsUaK7jsdHCMBrQjEVfhZbS2K8FL1xC
         BjOOsJBZ/EzEfpR405ay040NT0E7n++jFFtxki7qpx43vYV/QX7b+IUkqPqVe7tcsl+y
         celfLgTwE59cPCrG6hNTC32U/dCV/eE9guxjTQaSprpdU+4l2Qni1vJVQi9P8OgA5p5x
         zskClbiyAR4JdPnZE4oZ6VhsZg2eDSH7aRqCaxCbL86DuP6LI+TvES+S+ZRH9wBMef7s
         QYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArkFzgGmWr5GIWIb5S26dnAG6/MRvelBkLMc+Gk1DCI=;
        b=hhCmgYdvQpurXgXQWuClqHuR/P3LRoXKpjIkO5MmqhjV4Lq5MS0JK/yhtiHINc+pWV
         4EqsTuQYuApKXMVbjy8WNvmjHKAPi2R5naUslMSR/unPbfqVXq6TopX9W8ySt2DwKE6D
         fOsbtXSYAUjF+OLzt9p4P/XKARp2YxntsbZEbxrYrXUHQCankNkbAGCLl2trcAeuAdA9
         7ciPR2cJO4YW1eA1F6dn1xVBGN7g+IbnxIBtlzTcOHfipYcbJmt+0ttxrUSRFISXZ6Ny
         /w3t/+tTuGBSkezRUEEZATovevNOrlAEfNINUO9xf5Pz0cNPihTQ/nsLcs0XqF25m/ZT
         ofVg==
X-Gm-Message-State: AAQBX9cUF1PU0bPIoVamjkAb6ExSkAtsVgX1jpDTU0RnpZAe522Hy4/Y
        k3FIERq+hmEOAumSH7CKGk2sESsBzDE=
X-Google-Smtp-Source: AKy350a1DofUs4VOJFEpf/Bjl29q9TIoQByxl0Ghis+7csRXJ+eNPnFAcI7+ZZ3vVziDU2S9rTWGWVfcWWc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:cf90:b0:244:a6e7:bb6c with SMTP id
 i16-20020a17090acf9000b00244a6e7bb6cmr760824pju.8.1680883291507; Fri, 07 Apr
 2023 09:01:31 -0700 (PDT)
Date:   Fri, 7 Apr 2023 09:01:29 -0700
In-Reply-To: <ZDAeuL2fz1aEW6rz@debian.me>
Mime-Version: 1.0
References: <20230407093147.3646597-1-kconsul@linux.vnet.ibm.com> <ZDAeuL2fz1aEW6rz@debian.me>
Message-ID: <ZDA+WdiqB2931xHB@google.com>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: book3s_hv_nested.c: improve branch
 prediction for k.alloc
From:   Sean Christopherson <seanjc@google.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Kautuk Consul <kconsul@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 07, 2023, Bagas Sanjaya wrote:
> On Fri, Apr 07, 2023 at 05:31:47AM -0400, Kautuk Consul wrote:
> > I used the unlikely() macro on the return values of the k.alloc
> > calls and found that it changes the code generation a bit.
> > Optimize all return paths of k.alloc calls by improving
> > branch prediction on return value of k.alloc.

Nit, this is improving code generation, not branch prediction.

> What about below?
> 
> "Improve branch prediction on kmalloc() and kzalloc() call by using
> unlikely() macro to optimize their return paths."

Another nit, using unlikely() doesn't necessarily provide a measurable optimization.
As above, it does often improve code generation for the happy path, but that doesn't
always equate to improved performance, e.g. if the CPU can easily predict the branch
and/or there is no impact on the cache footprint.
