Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B16C8777
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjCXV1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjCXV1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:27:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F3199DC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:27:17 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l14-20020a170902f68e00b001a1a9a1d326so1836466plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679693237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zePKddV/iwqym9bgYlEazTH1FsVa1YzF3bKPGXvyUE=;
        b=TPLvUusFr04aY1T8sG+B11UMeVGSvt3rYDLfC+ZDclob/dEbEDc+HS2AMxlgy8GJ6c
         yF9p4G8EY3b9xXqA0mjA6XXvfzwxsYOsZw4QCZBQ1X/FKmrGmKg6i39HGfImcXuJJoTy
         EdPIGSymDbNdzX1EA0vaAZm4KiQZbUZgaoOTMFRMBPmfzbSHimw4Fhg76gxYdRLg+o5y
         0WHD5fLeSOQ41C41WYtOoow8OZioEc/lbQGhWf+hXCZOjxn8CA8k/0JBLVpyz7sCHsYK
         HDY7xVfSswAjRVXv4O3AhGyB6LcCDgyDikHDD6AJRCrxMB53rBbzFR+cFmgLuPPCvzkP
         qjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zePKddV/iwqym9bgYlEazTH1FsVa1YzF3bKPGXvyUE=;
        b=Pqc67fl62NPvJJYkXzvdOdW7J+Zi1UHop6SPsySSCilc3g0DbqhsFBqS7CGLhxwNS6
         YtTY+lREZhUnNOKnhB4SFcjBXm6keE8hBtl6sLupx2TvOSrUROlRbY+Rl/094EZ5mGZs
         f1ef8yoYuBihf++Ht1aN7V+z2X3fSPDw+B/16YVAjDX1B4AVu7Dz5bBTgfO07K8300qk
         C41E808xdsJnmjsL3SJTsH0WAxZOwDmLHizxxUZ9oPaLOEgtm0FHoJJbSj4UR2r+cTS4
         J0FxYD5Te60CZEXKSN7MGMws+PfHNQkIQGhBhOqIAKCJpsD7cTD1s6f74x1m0Mz11bHo
         NGyg==
X-Gm-Message-State: AAQBX9c1BwOWr96drK9lnS+LTMw8S5sHwQWR7q/0HQSB5E/QESyUF4gG
        I0wuVgjIAFt1KblFw/0lgUH8CH1ehdE=
X-Google-Smtp-Source: AKy350aqGWsdWjWwegqoLWfvcdbn6k4rDZFiOq/lDmEEoy5VQtVIcuZTzkPUDGTRpSoVgjf+URb5P6CmVQ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fa12:b0:23b:3426:bc5e with SMTP id
 cm18-20020a17090afa1200b0023b3426bc5emr1279659pjb.4.1679693237539; Fri, 24
 Mar 2023 14:27:17 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:27:16 -0700
In-Reply-To: <167969137156.2756401.15618241992481271147.b4-ty@google.com>
Mime-Version: 1.0
References: <20230227180601.104318-1-ackerleytng@google.com> <167969137156.2756401.15618241992481271147.b4-ty@google.com>
Message-ID: <ZB4VtIPZjDGwuPOc@google.com>
Subject: Re: [PATCH v2 1/1] KVM: selftests: Adjust VM's initial stack address
 to align with SysV ABI spec
From:   Sean Christopherson <seanjc@google.com>
To:     pbonzini@redhat.com, shuah@kernel.org, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Cc:     erdemaktas@google.com, vannapurve@google.com, sagis@google.com,
        mail@maciej.szmigiero.name
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

On Fri, Mar 24, 2023, Sean Christopherson wrote:
> On Mon, 27 Feb 2023 18:06:01 +0000, Ackerley Tng wrote:
> > Align the guest stack to match calling sequence requirements in
> > section "The Stack Frame" of the System V ABI AMD64 Architecture
> > Processor Supplement, which requires the value (%rsp + 8), NOT %rsp,
> > to be a multiple of 16 when control is transferred to the function
> > entry point. I.e. in a normal function call, %rsp needs to be 16-byte
> > aligned _before_ CALL, not after.
> > 
> > [...]
> 
> Applied to kvm-x86 selftests, thanks!
> 
> [1/1] KVM: selftests: Adjust VM's initial stack address to align with SysV ABI spec
>       https://github.com/kvm-x86/linux/commit/1982754bd2a7

Force pushed to selftests 'cause I had a goof, this now:

        KVM: selftests: Adjust VM's initial stack address to align with SysV ABI spec
        https://github.com/kvm-x86/linux/commit/8264e85560e5
