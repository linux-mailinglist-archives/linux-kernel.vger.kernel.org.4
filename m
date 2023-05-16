Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED47052E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjEPPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjEPPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:55:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A57DBB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:54:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643fdc3e994so11911636b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684252478; x=1686844478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vuvfF0mbmPVlAJV/IyiTE8KBjpX8EqXFXoocKzSOeCE=;
        b=4jbQy6plX2lrkT/CFX+Cpnj+y3894hYSyxz8xIqHyBpW/z0cbpNkv454t/4RvQazmk
         KgY8LvK71QLdsJCPUKE7j+UC29pMRQ1vQ1ziv9dMTVSOo53YxdXNdDiDPLRrUIxSZpMg
         gXiu+ZP/i1UzrXGn5v03XfEnnEoQiVb9Sitsw1Gjs9FgOnOr0fM1CT2/XKoXJkKL+JF3
         dJ5BHQ1jlKtOGR/QPiAEn29qdZWIUlRiYOtYSz9Pi5e32CqaoZCwN8ps+eluFs2uUnJb
         rUVz/3//yZO4SC/Svtgh4IM2gnGLO5+phPQEew1TZIPb134WIiaHFLZtMPo7l5w3RHOx
         Y7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684252478; x=1686844478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuvfF0mbmPVlAJV/IyiTE8KBjpX8EqXFXoocKzSOeCE=;
        b=OLyrZG2N5BpAaKSbmUoXq3f2zaOS/ZwwFTa+XECXvg5qFEpXVNyMHT2bzlh5K2b/2S
         zIPuHDgD/96ad0SVYEz+vZd1DkpjH2FYdi7HxGTxLFbv7cHgJTdSknsgVtBz7mCUfVMw
         LAc6znNbukGwHCEextxH4h6CIU2cLPuR7giD2ubhxEttMihhMSlxkz8lquum+ggoPuzv
         hOXpLTCGc+xTUGlopfnrBqLhoLCdYjxZO2kHbrZXOaG4GvNtqo0y8DRyqPJA/HR6V7lF
         jdT/I2VfrmWrEgC8cWN0ndhAGwXOxuLy7xhq9rXXnPm4/0vBPglB0tV2NfXz4X4N0hRq
         H8uw==
X-Gm-Message-State: AC+VfDzsjhQ2U3cleheZuSqioZWCMDsHdG+etALCXXUFFBW/5J7JF8K8
        dlAf7UemSQS/SfRWtDai094mr4rPBHQ=
X-Google-Smtp-Source: ACHHUZ5eDqFHhP00qJpB5efU8Z8+xLn+sgiI3C5FYM7RixATG9CvKtOxlEBBv07UOEqzZrDzfmgiwa4HKdU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:80df:b0:646:6baf:48d7 with SMTP id
 ei31-20020a056a0080df00b006466baf48d7mr7162453pfb.1.1684252478431; Tue, 16
 May 2023 08:54:38 -0700 (PDT)
Date:   Tue, 16 May 2023 08:54:36 -0700
In-Reply-To: <20230516122159.3834044-1-dengqiao.joey@bytedance.com>
Mime-Version: 1.0
References: <20230516122159.3834044-1-dengqiao.joey@bytedance.com>
Message-ID: <ZGOnPMTEKqRq89jt@google.com>
Subject: Re: [PATCH] KVM: SVM: Update destination when updating pi irte
From:   Sean Christopherson <seanjc@google.com>
To:     "dengqiao.joey" <dengqiao.joey@bytedance.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023, dengqiao.joey wrote:
> Destination of irte will be cleard by IOMMU driver when updating irte.
> It will only be set correctly in vcpu_load. IOMMU will deliver the
> doorbell message to the wrong physical cpu before vcpu_load is executed.
> That means vcpu can not recognize interrupt delivery during the time of
> non-root mode.

I suspect this is actually a bug in amd_iommu_activate_guest_mode().  Does the
below fix the issue?  If so, can you give a Tested-by and/or Reviewed-by on the
posted patch[*]?

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..fbe77ee2d26c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3484,8 +3484,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 	u64 valid;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || entry->lo.fields_vapic.guest_mode)
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) || !entry)
 		return 0;
 
 	valid = entry->lo.fields_vapic.valid;

[*] https://lore.kernel.org/all/20230419201154.83880-2-joao.m.martins@oracle.com
