Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CBC63E3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK3W4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiK3W4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:56:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD192089
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:56:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c15so155363pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPYmy5zhAGqq2nGzX5m2iL8cfIBwPQzj7RKxKIpRxts=;
        b=gngr2dsQxUoxgrfjcMrO2lRS8QgSBYcCmjqKUkHXa2pIJE1qDDFWX03B3gDNOINmp7
         zeA4aD6INEmF0IE2AVLZcGQxNMVs2pqldh0PgnPCWZJyO52Raxp6OgRUtxD6kWBeIBtz
         81E3rQ8By9mHV/6uN5+nf6TCeR2trqFx2YHCzCCN5sIT6hoIoAHdoCoLg9sXNKk9Fx+E
         i8jpY/jt7DuMj0zgtJGT6HMYPdnFr0CqBXHrm7lY4O+qqBmC7SlpGqpsuT4cy0ea787I
         FuVma0jRK/vmYKViIWuztHsYFqP7xtn5820EvNsJgZudJYDXDk69INUW0wyIDvAt+J01
         NhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPYmy5zhAGqq2nGzX5m2iL8cfIBwPQzj7RKxKIpRxts=;
        b=srlLkopaC3kgu0UP2VgWmMRPUEn7GSgixh3FE855mRvky+rdBvg7QilgcIVx5O2lgy
         O4pR+3NleAhzoGpfL17Vf8etWc0PGcqce7+nxrRY8rPxxGnoXaFkUqV29ur6/SOC2lKb
         OjWVEcSGdodQUJOUdqfTvIyDYWspeJ26urdb5IfHB8F7nZX1mkGdimFLD21+7SYgm52f
         6BwXriAQQBOcsxNSQ6Oy8tdsFltpTPwZ0q6GyEluBZs6sBkiy/desrWBoXeKTVcU/uyx
         YS15dmHxvuiT0+3De//RGSkrzEp9y/dHnchu1kczb64KhOornrgCfn6e3Z2a6sLr6wfH
         UkNA==
X-Gm-Message-State: ANoB5pmC7Yw0Fe2HBg/MDILPHlDFHHr1QDZKzUsv35BCgIBpPwA+V4+Q
        7Iz03Z+sLpzpArLkUmjD+5hQlw==
X-Google-Smtp-Source: AA0mqf4zbMKUGhqOrmt+FcSgRVmsRyWYxSQG/grvBn6WVLMMMxoaPP1N132gmW2vWAldO9VuQS7U3g==
X-Received: by 2002:a05:6a00:98e:b0:574:6929:e50e with SMTP id u14-20020a056a00098e00b005746929e50emr36690700pfg.67.1669848965552;
        Wed, 30 Nov 2022 14:56:05 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b0017da2798025sm1967465plb.295.2022.11.30.14.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 14:56:04 -0800 (PST)
Date:   Wed, 30 Nov 2022 22:56:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] KVM: selftests: restore special vmmcall code layout
 needed by the harness
Message-ID: <Y4ffgC+HbftkPbaW@google.com>
References: <20221130181147.9911-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130181147.9911-1-pbonzini@redhat.com>
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

On Wed, Nov 30, 2022, Paolo Bonzini wrote:
> Commit 8fda37cf3d41 ("KVM: selftests: Stuff RAX/RCX with 'safe' values
> in vmmcall()/vmcall()", 2022-11-21) broke the svm_nested_soft_inject_test
> because it placed a "pop rbp" instruction after vmmcall.  While this is
> correct and mimics what is done in the VMX case, this particular test
> expects a ud2 instruction right after the vmmcall, so that it can skip
> over it in the L1 part of the test.
> 
> Inline a suitably-modified version of vmmcall() to restore the
> functionality of the test.
>
> Fixes: 8fda37cf3d41 ("KVM: selftests: Stuff RAX/RCX with 'safe' values in vmmcall()/vmcall()"
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

We really, really need to save/restore guest GPRs in L1 when handling exits from L2.

For now,

Reviewed-by: Sean Christopherson <seanjc@google.com>
