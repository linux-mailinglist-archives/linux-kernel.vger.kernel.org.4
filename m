Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5157D6C5B91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCWAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCWAyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:54:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B44144B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:54:42 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m10-20020a17090a4d8a00b0023fa854ec76so177271pjh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679532882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXt/uuEZJiPd6iCKnzBzoxs3VQRz86+IAZiKKn1lWnc=;
        b=jCUeVx3HhY1WoJNqMWF2eL9NfPhq/5nSlf2hpdVptxkjn9Bxw24093lSJ9deBBOLGy
         hw4KqVl9ksGF08YMs2SQYWLnXihK8ODu1YKBESxbLqaOfZ7VpBYGe9Hl/IzoA7q9h2pB
         cpObCEoOlHPtF6cDoOjLS7S/jc3gpTdjUB9FdJJjoC1BC37M+lRYy5zTkfk6oAYZW7hz
         zMbGwrpnK+e7W53Lxq7kUgt8GHPi+f8Oa7dDZMRgJO8pVO+RC3JP9LCSsQAwKyhIHBKA
         Nk3ThC5tLjasask/L1rJcKSuwfhudWpek9Ty38Oz7Cgef2zN6sAWT6OO/ggujDb8GO6S
         zGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679532882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXt/uuEZJiPd6iCKnzBzoxs3VQRz86+IAZiKKn1lWnc=;
        b=doX7evGnlnxBzZfXS3S6X6cG9An1aOsNxX25YxvAA+v7WtH7AdVvsOqz05vZrXPg3q
         zRWRKf5cKAy8VxX1qn2/6SiswtYw78JqkB2+qnXPA9IXm2AWChlDKvR5/yim/VWhJvci
         kXnhwdvkjzVQZSze8bGI0c2ctD/d3kij45Tr0vFzQmOMyi2Ig+ZdGyOWhwzCKJ8xxH08
         TXlMeMFkvJx+Dn7NXc56rv5vxEkEBpEPZ3OFQZc7gU7sqdMmnf5wogDvjqIYJ+osv1Rc
         cpb56ZtmayrONWemkVjjOw7GrpH9YUPEZ5iYjYuRJ9Axq1bNuSoCdOwp7wFcCB+l5bVa
         Uq2Q==
X-Gm-Message-State: AO0yUKV4byfOo76ajaq2iSdZBIPIMxOrfhr5LE2+VGxDqbsSCiQ6pcHo
        cdq/pc3sXzbZ4MA79Myz7zEaw2V1zGU=
X-Google-Smtp-Source: AK7set/E+ZqnkdfjykckT1v1ak0rvsbe0mOtVRJntajXMcnHlawxOH1WXDm26dVTsGg2Ug5nFHES00jJQcs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6784:b0:23b:32c0:7cc8 with SMTP id
 o4-20020a17090a678400b0023b32c07cc8mr1716026pjj.7.1679532881981; Wed, 22 Mar
 2023 17:54:41 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:54:40 -0700
In-Reply-To: <20230227084016.3368-10-santosh.shukla@amd.com>
Mime-Version: 1.0
References: <20230227084016.3368-1-santosh.shukla@amd.com> <20230227084016.3368-10-santosh.shukla@amd.com>
Message-ID: <ZBujUGXG0JlOLEBh@google.com>
Subject: Re: [PATCHv4 09/11] KVM: SVM: Add VNMI bit definition
From:   Sean Christopherson <seanjc@google.com>
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, jmattson@google.com,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        mail@maciej.szmigiero.name, mlevitsk@redhat.com,
        thomas.lendacky@amd.com, vkuznets@redhat.com
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

On Mon, Feb 27, 2023, Santosh Shukla wrote:
> VNMI exposes 3 capability bits (V_NMI, V_NMI_MASK, and V_NMI_ENABLE) to
> virtualize NMI and NMI_MASK, Those capability bits are part of
> VMCB::intr_ctrl -
> V_NMI_PENDING_MASK(11) - Indicates whether a virtual NMI is pending in the
> guest.
> V_NMI_BLOCKING_MASK(12) - Indicates whether virtual NMI is masked in the
> guest.
> V_NMI_ENABLE_MASK(26) - Enables the NMI virtualization feature for the
> guest.

This is way harder to read than it needs to be.  The intent of the various rules
for line length and whatnot is to make code/changelogs easier to read.  That intent
is lost if code/changelogs are written without actually considering the rules.
In other words, don't write changeloges, comments, etc. without thinking about how
the result will look when the line length rules apply.

    Add defines for three new bits in VMVC::int_ctrl that are part of SVM's
    Virtual NMI (vNMI) support:
    
      V_NMI_PENDING_MASK(11)  - Virtual NMI is pending
      V_NMI_BLOCKING_MASK(12) - Virtual NMI is masked
      V_NMI_ENABLE_MASK(26)   - Enable NMI virtualization
    
    To "inject" an NMI, the hypervisor (KVM) sets V_NMI_PENDING.  When the
    CPU services the pending vNMI, hardware clears V_NMI_PENDING and sets
    V_NMI_BLOCKING, e.g. to indicate that the vCPU is handling an NMI.
    Hardware clears V_NMI_BLOCKING upon successful execution of IRET, or if a
    VM-Exit occurs while delivering the virtual NMI.
