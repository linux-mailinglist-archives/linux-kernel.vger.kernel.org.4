Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13CB71860E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjEaPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjEaPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:21:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44C9510E;
        Wed, 31 May 2023 08:21:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52CF91042;
        Wed, 31 May 2023 08:21:55 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CCA63F663;
        Wed, 31 May 2023 08:21:08 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, tarek.el-sherbiny@arm.com,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 0/3] Add SCMI v3.2 Powercap disable support
Date:   Wed, 31 May 2023 16:20:36 +0100
Message-Id: <20230531152039.2363181-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Upcoming SCMI v3.2 specification (publicly available as BETA at [1])
introduces support to disable powercapping as a whole on the desired
zones.

This small series at first add the needed support to the core SCMI Powercap
protocol, exposing a couple more enable/disable protocol operations, and
then wires such new ops in the related Powercap framework helpers.

Based on v6.4-rc4.

Thanks,
Cristian

[1]: https://developer.arm.com/documentation/den0056/e 

---

v2 --> v3
- rebased on v6.4-rc4
- added tags

v1 -> v2
- rebased on v6.3-rc1
- simplified enable status check logic

Cristian Marussi (3):
  firmware: arm_scmi: Refactor powercap get/set helpers
  firmware: arm_scmi: Add Powercap protocol enable support
  powercap: arm_scmi: Add support for disabling powercaps on a zone

 drivers/firmware/arm_scmi/powercap.c | 173 +++++++++++++++++++++++----
 drivers/powercap/arm_scmi_powercap.c |  16 +++
 include/linux/scmi_protocol.h        |  18 +++
 3 files changed, 182 insertions(+), 25 deletions(-)

-- 
2.34.1

