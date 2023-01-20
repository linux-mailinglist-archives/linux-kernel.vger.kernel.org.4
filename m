Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3756759A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjATQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:15:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD714CFD26
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:15:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF68261FEE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF27C433EF;
        Fri, 20 Jan 2023 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674231332;
        bh=xXhXTMxKo1OimWhu5kAmuS7msRdZk/rgYF7+cW7gPUo=;
        h=Date:From:To:Cc:Subject:From;
        b=PyNdK4+sMXqBpM+1o3ehi3YOjmG+iE6TzHr9++A47JmF7uCy6h6CeC3i8EMb9a8bM
         aTrwxgvx+5Ilz7h+x+K9TcfZ9VPOOL7AN+weUn/rv/N8igGfP2JcmajFeyy4rNCbxe
         h/hdBlYPi6cXKrZD2qwYuEP+VcdLZ6HMFb8jERwGLi8ndxWnVicz7lEWszOXgDZWE2
         N3rJin88Ic6noDJuF39OMct0JpQxBdrb5/+cj97DlrH3ZY/WN2zLVC8I2ffcLmkpze
         jtys26uLJfLaLi5ASygftfDE7IKTsqZQkjN+f64tIyQ0xKvIDOOGCjjBycxviI41lD
         cs4bOj5/eBE/A==
Date:   Fri, 20 Jan 2023 16:15:27 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.3
Message-ID: <20230120161527.GA22266@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these arm-smmu updates for 6.3. The only changes relate to
device-tree bindings and their use within the driver -- summary in the
tag.

!! NOTE !!
To avoid conflicts with the fixes I sent previously [1], I based this
branch on top of the fixes tag. However, when I did a test pull I
noticed that you seem to have cherry-picked the changes from my earlier
fixes tag rather than pulling them in directly, so if you pull this one
as-is then we'll get duplicate commits in the tree. How would you like
to resolve this?

If you decide to go ahead and cherry-pick things again, then a linearised
history (since I've got a merge) is:

1d6316e50572 iommu/arm-smmu-qcom: Select identity domain for sc8280xp MDSS
4fef70ad65f6 iommu/arm-smmu-qcom: Add SM8150 DPU compatible
c940c8787929 dt-bindings: arm-smmu: Document smmu-500 binding for SM6125
7caf324fac0b dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
3a3f20bae0ce dt-bindings: arm-smmu: disallow clocks when not used
e3fed6861d86 dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible
58499c0fd22c dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
5cc1842372bf dt-bindings: arm-smmu: Allow 3 power domains on SM6375 MMU500

Please let me know if you need a hand with any of this.

Cheers,

Will

[1] https://lore.kernel.org/linux-iommu/20230113110318.GA12771@willie-the-truck/

--->8

The following changes since commit f1ba05a70f7df4e2e4d2d7fed2d4e63a1e700660:

  iommu/arm-smmu-v3: Don't unregister on shutdown (2023-01-11 12:20:00 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to c9911d6c9bd03655e6c100d7465546d89799e960:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-01-20 15:14:36 +0000)

----------------------------------------------------------------
Arm SMMU updates for 6.3

- Device-tree binding updates:
  * Cater for three power domains on SM6375
  * Document existing compatible strings for Qualcomm SoCs
  * Tighten up clocks description for platform-specific compatible strings

- Enable Qualcomm workarounds for some additional platforms that need them

----------------------------------------------------------------
Bartosz Golaszewski (1):
      dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P

Bjorn Andersson (1):
      iommu/arm-smmu-qcom: Select identity domain for sc8280xp MDSS

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Allow 3 power domains on SM6375 MMU500

Krzysztof Kozlowski (1):
      dt-bindings: arm-smmu: disallow clocks when not used

Luca Weiss (1):
      dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible

Marijn Suijten (2):
      dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
      iommu/arm-smmu-qcom: Add SM8150 DPU compatible

Martin Botka (1):
      dt-bindings: arm-smmu: Document smmu-500 binding for SM6125

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 56 +++++++++++++++++++++-
 .../devicetree/bindings/iommu/qcom,iommu.txt       |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  2 +
 3 files changed, 58 insertions(+), 1 deletion(-)
