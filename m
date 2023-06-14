Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8D7303EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbjFNPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243752AbjFNPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:31:48 -0400
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549FB6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:31:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686756704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYKbp9Q0BeM52+XXi3aMvjzJfNpfbqXByiTdIuieW4g=;
        b=ejyEaxmgzfyiMYJ2Vleh7ornI7PLLaFCXL0QtoGCEzSqXZeE+aeSAHa9bGs8qcEfvN+GdI
        6QBiDAhRREsBGwDEHb0do6SgyuATtK5gKrAL0AETuPTeqL2mRZM939ezA8/a7/MJ6DBnmu
        hE3lVIU9tPflVcLqFu/8HdfnZ2QR9og=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     kvmarm@lists.linux.dev, Mostafa Saleh <smostafa@google.com>,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Oliver Upton <oliver.upton@linux.dev>, catalin.marinas@arm.com,
        yuzenghui@huawei.com, tabba@google.com, kaleshsingh@google.com,
        suzuki.poulose@arm.com, will@kernel.org, james.morse@arm.com
Subject: Re: [PATCH v2] KVM: arm64: Use different pointer authentication keys for pKVM
Date:   Wed, 14 Jun 2023 15:31:28 +0000
Message-ID: <168675651878.3255755.17510485264525909343.b4-ty@linux.dev>
In-Reply-To: <20230614122600.2098901-1-smostafa@google.com>
References: <20230614122600.2098901-1-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 12:25:59 +0000, Mostafa Saleh wrote:
> When the use of pointer authentication is enabled in the kernel it
> applies to both the kernel itself as well as KVM's nVHE hypervisor. The
> same keys are used for both the kernel and the nVHE hypervisor, which is
> less than desirable for pKVM as the host is not trusted at runtime.
> 
> Naturally, the fix is to use a different set of keys for the hypervisor
> when running in protected mode. Have the host generate a new set of keys
> for the hypervisor before deprivileging the kernel. While there might be
> other sources of random directly available at EL2, this keeps the
> implementation simple, and the host is trusted anyways until it is
> deprivileged.
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] KVM: arm64: Use different pointer authentication keys for pKVM
      https://git.kernel.org/kvmarm/kvmarm/c/8c15c2a02810

--
Best,
Oliver
