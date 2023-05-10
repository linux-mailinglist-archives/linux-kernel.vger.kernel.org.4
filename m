Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBB6FE32E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjEJRXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:23:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE43525A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:23:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6434e263962so5664355b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683739388; x=1686331388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hAaVCKo1eByEZXhLUJu/Zdb96FUwCt8+VS8aKYztbs=;
        b=ztGvKBH/eztgMhM0RLd+O7UK4hn2rF/L45uOk92SBGXnpAEcUwIqLhIefWwCVWwTwc
         8pW52i1CXmr3euS5PHkF6V6Fk2FaDymVz7BYQpPJa5mvcP0XIstkwie36AqrzBuK1WlO
         /dt78RDyEBNDjju75aCH/51uHKGBYJ0pUzXuv909SrJLb+vr9ZxQkS+h4ktGx/ZtwqAg
         wzYxMPDIK1cN+0M5kGTzbFwwYezhQNW+oNnikz5aX229mT8/VjXaKVbojnwBRtsLqDtv
         O9f1whvhgGZNbQkKDZKgIaMmEFFM7jSrYQFuvyhQP2suqDcEdahUe5XEs5ecyubs3oOw
         8MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683739388; x=1686331388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hAaVCKo1eByEZXhLUJu/Zdb96FUwCt8+VS8aKYztbs=;
        b=MzHResAs/k9p2Du6KXtmnk78oe8gyDnpQDh7xucWFB88W6SNGY9UIdNjBQl396UP0N
         9xcyeoB/Hz7R+t9gvquwGtBIkYktBwoXRtGED+BL23/ssD9G9ckOZh39lzQK1+b5QMoU
         Bla5kU7DRLonkcPjhRlHeNXRg9T1xx29xxMCf05QdONkKjRoz+4MXffAArTmRhPLZL3q
         1TkgXZLCIlksR/EceN+BH3auOjlsVzKTYpmwQ+TGU3FKpE7MdVMDE0Kumny9Ag5uLm/P
         bYa5e0fySMAGsNUfHkOWSN8c2HtpkPvfjw0JvvyFzsAi/85K9uN8qoaoNt7c4ynt06d3
         P9kQ==
X-Gm-Message-State: AC+VfDwx3WiOGMruwigx2GZ4ls0+qb9z/rqG8sBouvmjU5ce+Fmr/oli
        0vzUx5CtnwRsyRV2aDuU/YtYNw==
X-Google-Smtp-Source: ACHHUZ5su4KURLaEkl/4yAdIgxwtjNl8aZ5TnfoE4jORvAYbsDhMn3lXw++ZvCljQBDkDUBhrusuFQ==
X-Received: by 2002:a05:6a21:168f:b0:ef:7d7b:433a with SMTP id np15-20020a056a21168f00b000ef7d7b433amr19655518pzb.47.1683739388289;
        Wed, 10 May 2023 10:23:08 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id s145-20020a632c97000000b0050bc4ca9024sm3429417pgs.65.2023.05.10.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 10:23:07 -0700 (PDT)
Date:   Wed, 10 May 2023 10:23:04 -0700
From:   David Matlack <dmatlack@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v2 5/6] KVM: x86: Keep a per-VM MTRR state
Message-ID: <ZFvS+AXATLVfB5vQ@google.com>
References: <20230509134825.1523-1-yan.y.zhao@intel.com>
 <20230509135300.1855-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509135300.1855-1-yan.y.zhao@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 09:53:00PM +0800, Yan Zhao wrote:
> +void kvm_mtrr_init(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +
> +	if (vcpu->vcpu_id)
> +		return;

vcpu_id is provided by userspace so I don't think there's any guarantee
that a vCPU with vcpu_id == 0 exists.
