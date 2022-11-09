Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B4622F03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiKIP0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiKIP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:26:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2608012A80
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:26:03 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y13so16996034pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dELGs8lFRhRaHJurL/yZVZlax0Y+v7s3J7dg0eRKV4k=;
        b=Y+Ifwx/7OLxCXv53GjMR+eJdVbpvTnf9UsjASEoSsT0akKjYfiXkbswrLQ6UAsiDgB
         2NLZDl2L7HSraQtsuYKMmtSsPyNPyoRNIYDrxdoQ7huuT7rzB34LSmve3zFYq3yK5KeX
         3ALWfSFR+9Z3RRAu/6tw0WzQutMKVUIET91Ehfe+W8m8aCWh2qVWE0hDGbkuDWbsqdnB
         7hMgHtyhZAuqalkS+4YMIdSyuqnxXB5OH4key1xIjtVlU/PqpaT4qqqXfFg6t7Lr0IJQ
         eLaYIP9DfQTM75TtDPldfxyEeQRpWIaaMuZdgeTTkRLReGtfZE3Eez2MVHTpHYqxdSDG
         9A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dELGs8lFRhRaHJurL/yZVZlax0Y+v7s3J7dg0eRKV4k=;
        b=izb+8ezjHF6DJZZsCnZkWexF/HHLodeUfv4KTWjATNCk/WDai2Moj5Eg3IfB712gov
         KFLttMZ/g7JmPJaDzM1lHRYLO5H7652oNk53GfIsjj1jigOZvgfSYr18i9rLCQ8/SJa+
         ZwEy6/haurQWv3i9PmdvKR5JkFMazAj671e0g+FkdevsT+llfCXjRMUKoz6Szw3mfKpw
         wzlSlusNf9NZXldvx60cnVmB4LqsNhLezizUnio8fjzZ5VugTLST56w+/bXNsoSw76Lh
         TNwiyBk2ElnKg6qMeZhY2SWGsgvf0rT2JlHj3DWX50YQBYGhVH51lPvHis2Er8lTwHau
         SNWA==
X-Gm-Message-State: ACrzQf1Z9j8DwsXPwb4yuel7A78vfKpIiz20OLTEFhUCjEJ22dXoO5R6
        SeOFD60sLfmDC0MhE86AtHPqdFbMrRPrDg==
X-Google-Smtp-Source: AMsMyM5FcbuWJITIeMGOy3l2z/mJAO/r8SFo2iBbogk+aLSKJ6ApQB+AxMMIc02/tES7dbhmwmQmUw==
X-Received: by 2002:a05:6a00:27a0:b0:56e:8a72:3726 with SMTP id bd32-20020a056a0027a000b0056e8a723726mr28874267pfb.46.1668007562517;
        Wed, 09 Nov 2022 07:26:02 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b00181f8523f60sm9194581plk.225.2022.11.09.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:26:02 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:25:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, jmattson@google.com
Subject: Re: [PATCH 05/11] KVM: SVM: remove unused field from struct vcpu_svm
Message-ID: <Y2vGhtLAyr80QLcR@google.com>
References: <20221109145156.84714-1-pbonzini@redhat.com>
 <20221109145156.84714-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109145156.84714-6-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022, Paolo Bonzini wrote:
> The pointer to svm_cpu_data in struct vcpu_svm looks interesting from
> the point of view of accessing it after vmexit, when the GSBASE is still
> containing the guest value.  However, despite existing since the very
> first commit of drivers/kvm/svm.c (commit 6aa8b732ca01, "[PATCH] kvm:
> userspace interface", 2006-12-10), it was never set to anything.
> 
> Ignore the opportunity to fix a 16 year old "bug" and delete it; doing
> things the "harder" way makes it possible to remove more old cruft.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
