Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366516B167C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCHX0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:26:10 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569E678C9B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:26:09 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so207349pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678317969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mO+8G7LuCN5RyG85hig1TmjVb1pwcUykz5d1VwW8+9w=;
        b=ilByeTHEISCAXEI9fgpg9hqfXJr6Qqqkt0icnJPk17X9kPVEdJbJempSLijbnW84Zh
         Vqvb49XEzTzibRJRxIaX2ZFR5oPjo/lgdxSJS2WGC8ch+7jLTyp7bA7zBTetH9/9jSL/
         wkHGLGvyfEdOzsrXgIb4ktfDetylWJguhddEEnAiQe9qkR8HRgPPRPsHN3whza9/70vk
         q3gt9qdK0yuI2ZdPqxwUs/KPst39BNCgxkcjzRCUpwlmGr3xapSoINalR2e3w9iOGUBp
         wdJWmytQQTZXhUOUv+onyXR2Se9djpjMHEeuszmk1NmseH5masnjiH509m3GlUMhpIWB
         bhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mO+8G7LuCN5RyG85hig1TmjVb1pwcUykz5d1VwW8+9w=;
        b=CssX0cw0R0Pgvi6WrvDlDKDPt4d1VjP8FXueIWUs/vJpAvjrf2CWsXiOBweivAh/tr
         5rctSaWM/aiR3TXgbbVSCchEAhDDwbD3itMbgrNa/RhzftwE0UTZrndPvKgI6/jp+b8j
         tdfzzbsJljy0A1EhRPxCVxWq9trYwrFZydkb4ahOOorPpgNo6ePAKVGPJ+hMtgoQZr5D
         Ai2sIewqphvbIDSy2BJIdN2Yh8GyINqsH47RG2A38zoNMEggC64GDQRBwdCzHU1Aqyu5
         UC55z7VCez1Rkbgo7GD2EETT98yHNpfaB5kF/h5iogK1yU0ZqeherPcheqynSEu0T+a9
         chNw==
X-Gm-Message-State: AO0yUKWEEu3uSMXQBME1dRVNL/qQYTnFW8xg224psrORTB36y96VJYWW
        L4Ta5h/lOevPpZ7iPCbvsTKlQhf9o5s=
X-Google-Smtp-Source: AK7set+v9hHmIlWQWM847YU6kzpuhNcwjjGFkMNDH9YHxm8SeskkVvbbkfGQPgt3zpPHQebh7hgmLS7Skek=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7e11:0:b0:503:913f:77b9 with SMTP id
 z17-20020a637e11000000b00503913f77b9mr6849465pgc.6.1678317968939; Wed, 08 Mar
 2023 15:26:08 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:26:07 -0800
In-Reply-To: <20230307135233.54684-1-wei.w.wang@intel.com>
Mime-Version: 1.0
References: <20230307135233.54684-1-wei.w.wang@intel.com>
Message-ID: <ZAkZjzQ8pJQXQhJR@google.com>
Subject: Re: [PATCH v2] KVM: allow KVM_BUG/KVM_BUG_ON to handle 64-bit cond
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     dmatlack@google.com, mizhang@google.com, isaku.yamahata@gmail.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023, Wei Wang wrote:
> Current KVM_BUG and KVM_BUG_ON assume that 'cond' passed from callers is
> 32-bit as it casts 'cond' to the type of int.

You're very generous, I would have led with "Fix a badly done copy+paste ..." ;-)

> Fixes: 0b8f11737cff ("KVM: Add infrastructure and macro to mark VM as bugged")
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
