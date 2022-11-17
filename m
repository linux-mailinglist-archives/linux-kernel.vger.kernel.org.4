Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D862CF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiKQAYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKQAX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:23:58 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4744161BBB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:23:57 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f189-20020a6238c6000000b0056e3400fdc0so126220pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpmvhPUsFZSSLhAYtyq+lnahyrVFyMY6HS7SD72pXuo=;
        b=gNlC3pG6woPDN/PLsQTy7kCfejxGoDjjgCDqeYlESkUwnl4hdFlijtgdjR92RU+gDu
         Zvo8aD6WPhj34C6XqgL8Sskbz28auhO8ceP0/v4Qh6yw/gYonpMDGFF2irfWRDwSHyCJ
         R/ICN9FQuNt2xrG9CFVwkPxtgwMvdbVsMB65kgtt35DNEtXRdtqpCU2V13yuti5yTYL8
         Z3VSSx1ug+op/sspO4IX8cxnJtAIuY89m6RhH/CqaIrxUOGiouWM3QjjyQlbL0bHBQMD
         1YLN18yT9tPwAwJv3JeHZvjHNPbabEUNFw65JWje87zDEuyCoJDSomUUafz3p9TOXCCL
         zUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpmvhPUsFZSSLhAYtyq+lnahyrVFyMY6HS7SD72pXuo=;
        b=xho8CIyoDihp8QqJczouRcMophvGj1m+yOJNFt6R6kAolRjXhb5rGtRWhMcLb7Hqnu
         iSFwQKBC7Rph9x3FQW4qgc9bKJ3hPSIEagrS2A9wqtLnWj7E80i5yfYcqdqMGmVf7FdW
         srNmfcEDsuQxkJd21gQkW9ov6lvBQrpr4DqFkPtj5n7QE+4t3MWNyoJawynNC5FZpnGu
         Hz350VVKdRmIkpDws2M3QZQG56QmFKriU7bWF0u33N0w4ZbxT1UGKbjSYy4o6ZKZZj5n
         +tmeFR5UmeNH+FJFg0FcmV+aLxUW2wljTs/uQu1LE9X+Tk43oUjCYmNRGe11A0ir66FQ
         vTgg==
X-Gm-Message-State: ANoB5pkdjIj0MMWVIIl+cX/DB+Arj+RD14dI+dRrlbQs+GaYB0oLgjiI
        Ofypo3KT0AUk5lO/EBtVIRSWhmy6vgE=
X-Google-Smtp-Source: AA0mqf48bzKDE2Lb8bz6HjmAijvXpLnfL7EKx0nmUTvxI/NOxkKZ8jGDDtXitJI0o6StktvINPXJ6rgmuPU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7609:b0:187:3c62:5837 with SMTP id
 k9-20020a170902760900b001873c625837mr223332pll.123.1668644636835; Wed, 16 Nov
 2022 16:23:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 17 Nov 2022 00:23:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221117002350.2178351-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: arm64: selftests: Fixes for single-step test
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

I would like to route this through Paolo's tree/queue for 6.2 along with
a big pile of other selftests updates.  I am hoping to get the selftests
pile queued sooner than later as there is a lot of active development in
that area, and don't want to have the selftests be in a broken state.
I'm going to send Paolo a pull request shortly, I'll Cc you (and others)
to keep everyone in the loop and give a chance for objections.



Fix a typo and an imminenent not-technically-a-bug bug in the single-step
test where executing an atomic sequence in the guest with single-step
enable will hang the guest due to eret clearing the local exclusive
monitor.


Sean Christopherson (2):
  KVM: arm64: selftests: Disable single-step with correct KVM define
  KVM: arm64: selftests: Disable single-step without relying on ucall()

 .../selftests/kvm/aarch64/debug-exceptions.c  | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)


base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.431.g37b22c650d-goog

