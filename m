Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0966C6CED25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjC2PkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjC2Pjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:39:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 242434C3E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:39:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C797E1FB;
        Wed, 29 Mar 2023 08:40:34 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0793F663;
        Wed, 29 Mar 2023 08:39:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com, Tushar.Khandelwal@arm.com,
        viresh.kumar@linaro.org, jassisinghbrar@gmail.com
Subject: [PATCH 0/2] Add MHUv2 support for multiple rx interrupt
Date:   Wed, 29 Mar 2023 16:39:34 +0100
Message-Id: <20230329153936.394911-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was experimenting with a TotalCompute2022 (TC2) [1] reference design
sporting MHUv2 (v2.x) mailboxes and running on top of it an SCMI stack
configured platform-side to use multiple per-protocol channels with
multiple rx interrupts but NOT using a combined interrupt.
(it is not even wired at the hw-level on this platform anyway...)

This configuration seemed not supported by the current driver which
assumes that you have only one rx interrupt, possibly a combined one.

Looking at the MHUv2 spec ([2]/[3] "Channels") seems indeed that
per-channel rx-interrupts are indeed a possibility, beside the combined
one.

This small seriers aims to add such support by simply allowing to
specify multiple rx interrupts in the DT node and taking care to
register the same orginal ISR for all.

On the tx path, instead, I left things unchanged and stuck with the
current approach that just uses one single combined interrupt for the
clear channel interrupt. (if supported at all)

I tested on a TC2 model configured alternatively with MHU v2.1 and v2.0.

Series based on v6.3-rc4.

Any feedback welcome.

Thanks,
Cristian

----
[1]: https://gitlab.arm.com/arm-reference-solutions/arm-reference-solutions-docs/-/blob/master/docs/totalcompute/tc2/tc2_sw_stack.rst
[2]: https://developer.arm.com/documentation/102342/0000/Message-Handling-Unit/About-the-Message-Handling-Unit/Channels?lang=en
[3]: https://developer.arm.com/documentation/101418/0100/Message-Handling-Unit/Message-Handling-Unit-v2/Channel?lang=en


Cristian Marussi (2):
  dt-bindings: mailbox : arm,mhuv2: Allow for more RX interrupts
  mailbox: arm_mhuv2: Add support for multiple rx interrupt

 .../bindings/mailbox/arm,mhuv2.yaml           | 13 +++++---
 drivers/mailbox/arm_mhuv2.c                   | 30 ++++++++++---------
 2 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.34.1

