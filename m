Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167C971176C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjEYTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjEYTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:32:51 -0400
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F365F10C8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:32:16 -0700 (PDT)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5653213f5c0so1501997b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685042762; x=1687634762;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Gt90zOwJ9mi5eHlnv2jnI0ySmjYJ4m1WS/nV2KiYm0=;
        b=xckIqZevWkLNFYjYVIxqvOArlpXTXa4Rn+4hryPquh3h+fqnBRh11PbOzFWkQqTVxr
         YKTrsk4LdsZOQNB5161ZN7r+8G26/0am4FNkfUNnHLj4I82tsM0bIQW7BqK17N4lpP1A
         juINJUIkMnkyF11/akp0KAQz+FOQVu+tdKvmOs48FBPnthJUyG27gjE3N08KUAvZddh6
         U6Ud/NZnyBNJmr5szv7MgCwisGD/M2xNvVOrFmVNa7fELo+a7rOq2FY1nx6VmdO98r14
         Kd0l5DSs9cvvb6kM73b1KVDcwCfry5cytfwHsLat+ISriw2LmWumooGaDBKsNcB+EvRR
         BFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685042762; x=1687634762;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gt90zOwJ9mi5eHlnv2jnI0ySmjYJ4m1WS/nV2KiYm0=;
        b=Wfv16kGxGgR0HGmS3mAtyNpsXy0EMYnQyczkv673krPWWLXjTuRdrRMba8DY9xBVyi
         A1MjFJGjBSRFXwEXurAgMV/QZFjGAASoYewJ4m8yrMwLnj+WHQogE00P0j+kCLdTpXWQ
         q5wD7hRZHlYK2KvaJPYMNgtYwJxZjR4zTnsawZfB9/e+aRaS5URa4RtdCD2VinH93k5M
         g2susrzQEbUMNNhvc5yq1XjqUPOCXzYoeaTa97VMTHPCp318+Z020odZusmDd1A0WDQi
         dg1oySgxxbnbc/84koydQamaEID5oJK0G8VHUqCffGDrhsYCBhJQ98uc5M6wIjGjd9Nu
         vv3Q==
X-Gm-Message-State: AC+VfDyMeHrJ4B3+DfyqygtrvT7TSGhnEMvz0sfv/iX4Yqnvg8njYObo
        azt6C+FeiRqNTngT0JF5yIWUwsyI4gMKkEer/Q==
X-Google-Smtp-Source: ACHHUZ4uH5AqfAW158utnpLgI3U+J0T8My2BfvrDS2VXq1pyjhZTgWuSJAqcH/fLYDWyCXakupT40XwCiknFplrL1w==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a81:b1c6:0:b0:559:e97a:cb21 with SMTP
 id p189-20020a81b1c6000000b00559e97acb21mr346190ywh.9.1685042762258; Thu, 25
 May 2023 12:26:02 -0700 (PDT)
Date:   Thu, 25 May 2023 19:26:01 +0000
In-Reply-To: <20230509142235.3284028-7-kristina.martsenko@arm.com>
Mime-Version: 1.0
Message-ID: <gsntcz2ob4c6.fsf@coltonlewis-kvm.c.googlers.com>
Subject: RE: [PATCH v2 06/11] KVM: arm64: hide MOPS from guests
From:   Colton Lewis <coltonlewis@google.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As FEAT_MOPS is not supported in guests yet, hide it from the ID
> registers for guests.

> The MOPS instructions are UNDEFINED in guests as HCRX_EL2.MSCEn is not
> set in HCRX_GUEST_FLAGS, and will take an exception to EL1 if executed.

For my benefit, could you please explain why no support for guests yet?
Why not set HCRX_EL2.MSCEn in this series?
