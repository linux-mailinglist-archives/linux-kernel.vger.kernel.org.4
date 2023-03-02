Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44D6A879E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCBRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:15:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882B1ACD7;
        Thu,  2 Mar 2023 09:15:01 -0800 (PST)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F3816602F05;
        Thu,  2 Mar 2023 17:15:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677777300;
        bh=MKf13LLrF97Xk6jvSCKLeu38G4LeLT4CpYwHqJ0gXCo=;
        h=From:To:Cc:Subject:Date:From;
        b=YJoW6/ka66QlJHMHOuVwNMdmHdV0K5WZ1PIh68Thkmwp4lJjFLGZxoTOMkVAN5HUO
         FHQT4sGRnUSCAageWClckm9JJTGyfyF6rnX+/8FvgzguFwZcfunZY320ze+9/7tZcC
         hT+svAdfTb7puZBUD45MtQ5nk5DLb8teexvJlCvRjDMfe/MhAHJ4JbOXuVYJxowXbw
         Z7Ix386zEhS++gH/5hDNkd6+YtMQuaWVshG39LdkCcbkhVQ6Hnn+Muc2Jo2OrGAxDD
         hvXD1WRfmpr3L8SUAqmHsPrfGvyXbMSLQHQzpl1N7nwdeyghG9QexS7Vi6cyOryXav
         9jzK0Dkl+hJag==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hnagalla@ti.com, p.zabel@pengutronix.de
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] TI K3 M4F support on AM64x and AM62x SoCs
Date:   Thu,  2 Mar 2023 17:14:47 +0000
Message-Id: <20230302171450.1598576-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series introduces K3 M4F remoteproc driver support for
AM64x and AM62x SoC families. These SoCs have a ARM Cortex M4F core in
the MCU voltage domain. For safety oriented applications, this core is
operated independently with out any IPC to other cores on the SoC.
However, for non safety applications, some customers use it as a remote
processor and so linux remote proc support is extended to the M4F core.

See AM64x Technical Reference Manual (SPRUIM2C – SEPTEMBER 2021) for
further details: https://www.ti.com/lit/pdf/SPRUIM2

This series was originally submitted by Hari in Jan 2022. Review
comments were made, however I've been unable to find any further
submissions. I have tried to contact the author and have received no
reply. As we are interested in using this functionality, we have decided
to pick this up and see if we can get it merged.


Hari Nagalla (1):
  dt-bindings: remoteproc: k3-m4f: Add bindings for K3 AM64x SoCs

Martyn Welch (2):
  remoteproc: k4: Split out functions common with M4 driver
  remoteproc: k4-m4: Add a remoteproc driver for M4F subsystem

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 158 ++++++
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   3 +-
 drivers/remoteproc/ti_k3_common.c             | 375 +++++++++++++
 drivers/remoteproc/ti_k3_common.h             | 107 ++++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 462 +---------------
 drivers/remoteproc/ti_k3_m4_remoteproc.c      | 491 ++++++++++++++++++
 7 files changed, 1174 insertions(+), 435 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_common.c
 create mode 100644 drivers/remoteproc/ti_k3_common.h
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

-- 
2.39.1

