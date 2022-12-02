Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2A6405A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiLBLSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiLBLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:18:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C225BD42
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:17:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2085B80955
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0C2C43470;
        Fri,  2 Dec 2022 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669979876;
        bh=+Z1MWlojIRA1QnTq1ioenobi9ADsvAqAO/dbKIkbqjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HubRNWXyGURblb7IaT99ORDq0RAytki48Py2iNBMKtLeEmIUw5kIR4/XIgr4IAHnb
         4T5KMpEae2eaNa7TyLUEd6Jf5aJxTwdPg3i049crdrYVGshKHGxlyW8UtpX2tYvM3N
         iUaVu3gx+8/Wg+/HfEeH6INCWGDqyTf/dl3s6olUARfaU0Octbd45SN+lSvEgHdF/x
         hSF/nIr0hi/kFUbfmn6f6jmSDB146ZbSOK6oIw0gs0G93El+mNtgNAG1RLHrs9/YE5
         +FsQzyQI9l1Tjaw810VXs/t3Dr/GHcC7x9Cew+fzI95CBaRFe+edZLpDXN6ISfoc2r
         UvUHlrSFy6Vpw==
From:   Will Deacon <will@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] KVM: arm64: FF-A proxy for pKVM
Date:   Fri,  2 Dec 2022 11:17:43 +0000
Message-Id: <166990989276.390165.11951641189203574187.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
References: <20221116170335.2341003-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 17:03:23 +0000, Quentin Perret wrote:
> pKVM's primary goal is to protect guest pages from a compromised host by
> enforcing access control restrictions using stage-2 page-tables. Sadly,
> this cannot prevent TrustZone from accessing non-secure memory, and a
> compromised host could, for example, perform a 'confused deputy' attack
> by asking TrustZone to use pages that have been donated to protected
> guests. This would effectively allow the host to have TrustZone
> exfiltrate guest secrets on its behalf, hence breaking the isolation
> that pKVM intends to provide.
> 
> [...]

Applied first two cleanups to arm64 (for-next/ffa), thanks!

[01/12] firmware: arm_ffa: Move constants to header file
        https://git.kernel.org/arm64/c/229d58e31678
[02/12] firmware: arm_ffa: Move comment before the field it is documenting
        https://git.kernel.org/arm64/c/c8e320b00a2a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
