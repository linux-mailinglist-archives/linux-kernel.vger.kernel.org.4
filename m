Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485356ACFFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCFVQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCFVQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:16:29 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D97515F9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:16:26 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k17-20020a170902d59100b0019abcf45d75so6406279plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678137386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4cSjs2hF+stLMorZuJ3Q4yg6wn5aTQLGNhdQrvetiCw=;
        b=nO81Dd+ZdOpPz+rMZF+TlStTUcOdB9fYf13b12+wmj6L3uW+fQA7rdl9b7YXUwV0jX
         I13woF73Otxijbj8ERXL0Ue7ErTR+09OxofYhExYX82U38pFRLv7VwAAVLlkCf8njVEy
         Z/kRmWywNVghsM99HWEY5cKmP9X1L+vYcJn9Gu5g39MFFMOh6J/04/U2GjXKa8nzeKgt
         VXWrXIyQkhG/rNkxiRYiCvs89f/6XCE73rAe2CCcH2mdABft17Q0wfBOkrN9i7G7XGV9
         qMRC7I0Cn3xahUbo9C0V4E1U0nKdC9XcIy+nSLME4DyqC6ubKOlchC87aSk/WleNGZN1
         Vi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678137386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cSjs2hF+stLMorZuJ3Q4yg6wn5aTQLGNhdQrvetiCw=;
        b=iPHrnRj5UCyeKyDA+VadUjcDDp/WSqTW1N5lBGyS747fdDIkxin/z5UZM4+cUr9cGp
         7ebF6pIWRKaz7b4cSOgJFaeECKjU5qzb+/1l8cDeVqEs+im1o3Okms8KYNIWMAT+iWbm
         rMhG6KfOKSQO10Ma6jueNVJo1R1RNt61kt5Ot3DMKPcBTqqjZcdN5an2j3jjWZ8CDnam
         rK8xDq1oFzCB2xD8YSPkaMQx5AZmOAvOGk977dVNBWdt7BM5XC7gc39Zs6Gv6P/BRFxk
         Z/xek8w5lT5MLLDxT3JPokOe6xKKroVCGJT15CCwE0vBryKpqyOyAH0xaGE6XVTqDkuJ
         VPZA==
X-Gm-Message-State: AO0yUKWY2N7g7krAnkFwXJIA7lBmbQ5SsqRaaHP/QqAJWbCezzX/PgPJ
        aWA5WNDA9BT+M6B/+cmUWMJu7ZtQq5w=
X-Google-Smtp-Source: AK7set/FdOs8fBG1Qf4JZnE/q2KTXSkvw2Xh3WHAVa7wzG+qH5k8o2Dr60lo7nSbCYK7xaiiauyALjwZOQ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:d443:0:b0:5df:9809:6220 with SMTP id
 u3-20020a62d443000000b005df98096220mr5102359pfl.3.1678137386366; Mon, 06 Mar
 2023 13:16:26 -0800 (PST)
Date:   Mon, 6 Mar 2023 13:16:25 -0800
In-Reply-To: <Y/6FIeJ5KCOfKEPN@zn.tnic>
Mime-Version: 1.0
References: <Y/5oBKi6vjZe83ac@zn.tnic> <20230228222416.61484-1-itazur@amazon.com>
 <Y/6FIeJ5KCOfKEPN@zn.tnic>
Message-ID: <ZAZYKe4L8jhMG4An@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Propagate AMD-specific IBRS bits to guests
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Takahiro Itazuri <itazur@amazon.com>, dave.hansen@linux.intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org, zulinx86@gmail.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023, Borislav Petkov wrote:
> On Tue, Feb 28, 2023 at 10:24:16PM +0000, Takahiro Itazuri wrote:
> > I'm still a kernel newbie and I don't have a strong opinion for that.
> > I just thought it would be helpful if the KVM_GET_SUPPORTED_CPUID API
> > returns the same security information as the host, as long as it is
> > harmless.
> 
> Not harmless - cpufeatures.h should contain flags which the kernel uses
> and not *every* CPUID bit out there.

I thought that the consensus was that adding unused-by-the-kernel flags to
cpufeatures.h is ok so long as the feature is hidden from /proc/cpuinfo and the
kernel already dedicates a word to the CPUID leaf?
