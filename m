Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED662318C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiKIRcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKIRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:32:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0518B30
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:32:47 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 78so16779767pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DniZYIrdQUoi19Dm9u4aWgvIz7zq8OgKhX/hNYiha0A=;
        b=hkP9VUgPvWQqatGgQWkQhRjPcH9wd71PeA8E+GuyDXozXGtxCy7gxSpFLKhRxjAjV3
         dCFha/1YCGU7QJwdAnz3SiUrvUi5PK1Ng8SJzGj9OoPdQtovjxy2OcMBUg+eZUydmeaC
         xCG0NXjsD8zhLnZK7w3QkgK7q4vHRBta6xHaqYT69S31NLLNiTDmTpIYfvvd6IjwHjuq
         jEHCkZKUTA5le4sLLpNKn6zyHC30cKemYxtap3vnNsBrI9+f5MVP1PHLP4ZZw3gQaU0u
         et+bTmKPH+TszVA8tKuGcBUP6+s3Jp4g10tdMynZvQL0wjZqAy4URHGESNF/VVxEmGbQ
         HNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DniZYIrdQUoi19Dm9u4aWgvIz7zq8OgKhX/hNYiha0A=;
        b=6L861N7SwQ+kkqFL3ZHvINIm9IhTBOLevj9I16VyktTxSel9m5RJQXYYxsphuOpRI6
         UhPvtbCZNZCsybsG5YjYDGsuwr8inojWUsdw+7+YXs43OrP355SNwx4KFOgC1fnc9Ecl
         Wg+FNkt6Oqt3+8e9idnKnaaQ8EuuyuGSiWFLCZkAXBdIyN1MKcUHom3O5txnJL0bYuCk
         hNATdWcb4LPLeCx8urnVltbkI3TegAi6qwspLjoHxSwrk0P1Ac0FgRDncdNdUs0HhxbZ
         eRUpEoaXOCjBgf03oGjIC/AkwwftigyzV1hhIRuhRhC/Z8ZDpgvVzCWiKWNGqRil+0Gm
         UFBQ==
X-Gm-Message-State: ACrzQf0mmln9IPhDfq8Fp7A//nWqfzlCpRiIruK4Lh6o6DTDnLB/QROB
        iOwvtVpPMU6H3Wiz4H7X9uI9jg==
X-Google-Smtp-Source: AMsMyM4OiymPkjMx8j345vhKCAFlCTF6IghoE3Ywv5QJvnGEZtrg39P+M9ihrgsG/ZQX+L0MLAbsbw==
X-Received: by 2002:a05:6a00:2315:b0:56d:a084:a77d with SMTP id h21-20020a056a00231500b0056da084a77dmr49476799pfh.53.1668015167101;
        Wed, 09 Nov 2022 09:32:47 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b0017c37a5a2fdsm9240786plb.216.2022.11.09.09.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:32:46 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:32:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] KVM: svm/avic: Drop "struct kvm_x86_ops" for
 avic_hardware_setup()
Message-ID: <Y2vkOxMcMJMdbDjL@google.com>
References: <20221109115952.92816-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109115952.92816-1-likexu@tencent.com>
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

+Maxim

On Wed, Nov 09, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Even in commit 4bdec12aa8d6 ("KVM: SVM: Detect X2APIC virtualization
> (x2AVIC) support"), where avic_hardware_setup() was first introduced,
> its only pass-in parameter "struct kvm_x86_ops *ops" is not used at all.

I assume the intent was to fill the AVIC ops so that they don't need to be exposed
outside of avic.c.  I like the idea in theory, but unlike vmx_nested_ops they
wouldn't be fully contained, which IMO would make the code as a whole more difficult
to follow.

Maxim, any objection?

> Clean it up a bit to avoid compiler ranting from LLVM toolchain.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
