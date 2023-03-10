Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C76B39F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCJJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCJJO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:14:28 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372E15150;
        Fri, 10 Mar 2023 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678439400; x=1709975400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HRadc1zXN2PqdKrwhkkjyFW8VZrHqm0P8DnEtzPMe9M=;
  b=k/NOxI5nwBja1wKCCYtHteMQiBkdVys1CxlfI2k/6PvA87XcYm0ieoZK
   LjNtl2Qd3UGbZcGUX89T2D6yvSEt5zQLQh9jQpr5EWuyxEGrOXVv6vyYI
   AiawMkwLtJis9qnFIgG8DZvl9eQ/BbBOKm7c8+Thlmy/zBasYyK/hub/0
   eISoUmF10Ae1T2tqwKlZHBQLE9ba1Tv4KfscBd3sPmuqHh4R7q9d2NNO1
   2cT13mfy1qj1EMcXRn87Q5p2s6dX5IR8etrTRJSDUbMVNOX8V/AytDlHw
   Wd3OmYM05NPZ+94fXUfXIPTrVoYX1UzprYHsu7v6iFdEgDqzqaaRudJwS
   A==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29600347"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Mar 2023 10:09:57 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 10 Mar 2023 10:09:57 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 10 Mar 2023 10:09:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678439397; x=1709975397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HRadc1zXN2PqdKrwhkkjyFW8VZrHqm0P8DnEtzPMe9M=;
  b=byHHmwkbMM1ggXeVCc64h7izuu1M0W99MBykH8R+n7nXGjO/NF6NRF/R
   h2Szf0n+OW3ewj/QHIJnR58DJUAzpw93l1ZNomqzEo+tMCnDVIEZ103+W
   mV6LiEi12RwPZxj7RxXC1J/fMPxgBvmozXq7NxHdt0Q+HkkLuQwA4GOkr
   Kbw1q9bopuVl8k4qFTJvuUG2tY4CaBmIP+e75fgSAZY/b6ZO7L11M2VjR
   XlCqvVay9HrIv5HbL+dnEz7AqLPgIbZmXLljMlPvmlREoYVubvYQHahdK
   NYyV7io9alp/bgdIKOyw5aYUZKK2HZFKdGcs91OprQaca/X2Ar5TxgP94
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29600346"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Mar 2023 10:09:57 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 478AF280056;
        Fri, 10 Mar 2023 10:09:57 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: Re: [PATCH v1 0/4] add i.MX93 TMU support
Date:   Fri, 10 Mar 2023 10:09:53 +0100
Message-ID: <2570782.NG923GbCHz@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230105101748.6714-1-alice.guo@oss.nxp.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Januar 2023, 11:17:44 CET schrieb Alice Guo (OSS):
> From: Alice Guo <alice.guo@nxp.com>
>=20
> Alice Guo (3):
>   dt-bindings: thermal: qoriq-thermal: Add compatible for i.MX93
>   thermal: qoriq: add i.MX93 TMU support
>   arm64: dts: imx93: Add CPU thermal zone
>=20
> Pankit Garg (1):
>   qoriq_thermal: No need to program site adjustment register
>=20
>  .../bindings/thermal/qoriq-thermal.yaml       |  1 +
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 48 +++++++++++++++
>  drivers/thermal/qoriq_thermal.c               | 59 ++++++++++++++++---
>  3 files changed, 100 insertions(+), 8 deletions(-)

Additional to the small review points:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
on TQMa93xxLA+MBa93xxCA.

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


