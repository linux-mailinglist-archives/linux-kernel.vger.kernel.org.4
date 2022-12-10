Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E545648FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 17:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLJQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 11:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLJQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:57:59 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603396589
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 08:57:57 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3f15a6f72d0so91542517b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u0nAkLHKV0vpo/DjFQeWuCjnIFWvWxAPsVOMOIFtGSk=;
        b=N/YuNhCKlrbachtomiLXy24YBN/H6neRhw4cwQXT8dL0WgGlwB3i8pc64bRVB0Pn3N
         wQxW3Bc72d4+iszA8RReFGm+MiB5hdjdoIqJs9bE7h4aS39s/cc7IwHklW6sQSFRZh0r
         Kpuxhyz8zPCAkFtPQjQrFhaHWTKMiA3jPKci0IN973Z9Wh5NIaDcCelz8vzp6v2z3VfG
         lxe/qEWaM473REetwgWR7bGCFDtNfB/MIS9fe6ACb1Z5C8dd8VlWe88sxMBbTLYtxXkH
         zHJX9Zt8tF53XSx2IeHf0uzXh1IAMV6+1J8uIW3XCHG0Ux1Us+mVUKiTMpVrG56ftrqG
         AN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0nAkLHKV0vpo/DjFQeWuCjnIFWvWxAPsVOMOIFtGSk=;
        b=lHFkqnfexJWgl8ldW2YRDUcwme+aZs/gnW1hzZuT6QNIuYbfmPWqDfEnYLTMN/ke3k
         wa8ZrvhJ18Kx0ThDLcdEzr0CJwxcavwr+49HxW8xTYGFPXoXSbz6+1RbossTkiNC5c2m
         aRmsUgPDoahhINV0osGpg01DZr+r3KhlbW8Wiy+ANYSksXRPYTRUmEsd62VLgMkzMn61
         3epU6s27xdPIY9gRxruDmH2Hhv5Y3bHSvInOJQpTMUWBk0d2elsUA6ruW8A7ZqrQQJGA
         5msA7KFPO9lOheehR08/kB4CKDsWFCwjixjAyMDwIAkrdS/oIW81ULqqUTYN4OOJY51m
         gbdg==
X-Gm-Message-State: ANoB5plL3gLrIS017XxUZ5NH9WNBAtrxYp5XDNUqZEb+hEoeTg61VNaL
        wLj+82F52WNX3P6RJ/p8U2SVvNTwsAfaTRESC/ukDtDNPN4Vcoia
X-Google-Smtp-Source: AA0mqf4tOd40aLLxRbmUXdMSoQbY/EaeotDpeaV8ESmuINdzRMBUeoJFodD0+L2vQuaHQGEsLB1BUNoHV92FUt3m6rQ=
X-Received: by 2002:a0d:f101:0:b0:3ef:23fb:124b with SMTP id
 a1-20020a0df101000000b003ef23fb124bmr16630287ywf.111.1670691476514; Sat, 10
 Dec 2022 08:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20221205191430.2455108-1-vipinsh@google.com> <20221205191430.2455108-14-vipinsh@google.com>
 <Y5OxMBSlzjv3w9YW@google.com> <Y5PjUwTU2KGo5xq3@google.com>
In-Reply-To: <Y5PjUwTU2KGo5xq3@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Sat, 10 Dec 2022 08:57:30 -0800
Message-ID: <CALzav=f0+Tc3=adUm5vwyw8g3872vDW28x7+c53aeu4c0-JCyg@mail.gmail.com>
Subject: Re: [Patch v3 13/13] KVM: selftests: Test Hyper-V extended hypercall
 exit to userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vipin Sharma <vipinsh@google.com>, pbonzini@redhat.com,
        vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Dec 9, 2022 at 5:39 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Dec 09, 2022, David Matlack wrote:
> > On Mon, Dec 05, 2022 at 11:14:30AM -0800, Vipin Sharma wrote:
> > > Hyper-V extended hypercalls by default exit to userspace. Verify
> > > userspace gets the call, update the result and then verify in guest
> > > correct result is received.
> > >
> > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
>
> Reviewed-by: perhaps?

Oops, yes.

Reviewed-by: David Matlack <dmatlack@google.com>
