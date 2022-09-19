Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28EB5BD48A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiISSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiISSJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:09:29 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A1F476C6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:08:40 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12b542cb1d3so498396fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TJiXMkCUTojlXKbQiyFacYe67YzyD0jjA+qabTsDbHM=;
        b=ju2bOaIH0x2rfWBR2EkNKXtD+zFlJlrmslGAw5GPkTydyo40nU2mIIXyv2TelU5tHO
         XqrygKYF6N7ls5CstZqbkxAOXW7kG8TPicncmVypRq0wuO5k4e/KQxMyaLj94h/heLnA
         3YqZUWkGMtKcZBkuNQZZt0/JtAaUyY32r+kErbm8hAv6ZAzapfJeonMQ+Ld+gt0hoHSC
         YriET+StwTfUXoXl/oTAlgLYp2Dncrqm1FhtXPMPPSRVSsen4yUPFaR0F9F2xUnMD0IR
         Sv9+pHEbDmVPfSX0JGHO+IRu0eHP86NFLmrK6CycdkinEcxd9nuqVsEwxUEXfP7uPxlp
         SNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TJiXMkCUTojlXKbQiyFacYe67YzyD0jjA+qabTsDbHM=;
        b=4etEvprjtkSdysHoHX2afrAyhluZBjBqULy97Egvq47FQMh9pvgSsmXeNDi/t/RBPa
         4rvgkhPuAHLs1q52aOLnB3p/Yvh8OCxA22Cisv18qgNhxx068ng3RQlWKyINojIvfF9n
         40pcz7xgi2eoP6XvhiVgfPwgDK5ZRp3MY6//cSQ0m/psjjKSNwpa6TMUAW3DXlWgLfic
         MVZ/PhMGXmPzgLX5Tnr88l66sonGAUt2xebXRb2CrtlLwJ+qeK+cGI/oEBcHmxZ2qFPZ
         clvoaBC6YlCaKvFgXDZxB7dKPtT1VKMZTqWQF25s+VvYCyrv9sw5fmUHeTky0luKphaO
         t2CA==
X-Gm-Message-State: ACgBeo0zREow17V22pVsdWsuJglfbeEBrWMi3B8FofLXV4VJ4hDso868
        ZvpJo+OVooheYiIWVxZWlj1Nci0+tcuc9FHK5D28gA==
X-Google-Smtp-Source: AA6agR5v80bCpuIGZxW8+dnb0Fm/3JglgbXD42nIcGRa2wRJbTpJtPkJJrNswQZmAUSCoovE0ee1n9GMUxUu1co/F/w=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr15701327oap.269.1663610919985; Mon, 19
 Sep 2022 11:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210201051039.255478-1-like.xu@linux.intel.com>
 <CALMp9eRC2APJgB3Y7S4MWsTs9wom3iQycd60kM2eJg39N_L4Ag@mail.gmail.com> <ec0f97e9-33b7-61d8-25b8-50175544dbdd@gmail.com>
In-Reply-To: <ec0f97e9-33b7-61d8-25b8-50175544dbdd@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 19 Sep 2022 11:08:28 -0700
Message-ID: <CALMp9eRAv_7UOL8K+15_UsV9ML5M3rnh-Rz2C1GtTkZCHt4Yjg@mail.gmail.com>
Subject: Re: [PATCH v14 00/11] KVM: x86/pmu: Guest Last Branch Recording Enabling
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, ak@linux.intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com,
        alex.shi@linux.alibaba.com, kvm@vger.kernel.org, x86@kernel.org,
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

On Mon, Sep 19, 2022 at 12:26 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 14/9/2022 7:42 am, Jim Mattson wrote:
> > How does live migration work? I don't see any mechanism for recording
> > the current LBR MSRs on suspend or restoring them on resume.
>
> Considering that LBR is still a model specific feature, migration is less
> valuable unless
> both LBR_FMT values of the migration side are the same, the compatibility check
> (based on cpu models) is required (gathering dust in my to-do list);

This seems like a problem best solved in the control plane.

> and there is another dusty missing piece is how to ensure that vcpu can get LBR
> hardware in
> vmx transition when KVM lbr event fails in host lbr event competition, the
> complexity here is
> that the host and guest may have different LBR filtering options.

In case of a conflict, who currently wins? The host or the guest? I'd
like the guest to win, but others may feel differently. Maybe we need
a configuration knob?

> The good news is the Architecture LBR will add save/restore support since Paolo
> is not averse to
> putting more msr's into msrs_to_save_all[], perhaps a dynamic addition mechanism
> is a prerequisite.
>
> Please let me know what your priority preferences are for these tasks above.
