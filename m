Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B486046B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiJSNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiJSNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:17:41 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3EFFFB0;
        Wed, 19 Oct 2022 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666184603; x=1697720603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OpHeyrfs5g5Rgp1Z7VMRy13RBDkqqg8QwJgqAbh3w0E=;
  b=NjOTsM/5IP1DgSK7sxkeLYiDNN9jEAxbJAbcjBAmcZ9Kb06pRjEpnwOP
   48nrauicTeY6fd3U8Ax2aDTvU8I3m/jNySnDU9dyTKG248uWU+7Eq/QsX
   YM/Qtu12fC3Gqf8YXaIkjXGEC8dHHvHxEo1duCPy11sP8aplhLE7DEdra
   wjuzULClSkLHXmEFMJfX3Ip2SbDKIB2umhIk4+MwCIaCsOBL3MANfH+ip
   JEGtb4FD+fFv81CcNaSg2PNKn+wWbv4zagLM0P945o4uVKj4IK46sbA6V
   qDKTFSAuklMeXvYpPtx7lgsek8g6L4eINN08ahLSZOentHnfwO5cGmUew
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="26846560"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Oct 2022 15:00:42 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 19 Oct 2022 15:00:42 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 19 Oct 2022 15:00:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666184442; x=1697720442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OpHeyrfs5g5Rgp1Z7VMRy13RBDkqqg8QwJgqAbh3w0E=;
  b=VwgAES2gYLWF6vpZ+a6pbo7fM/qmhoQ9cdUxEw0Ia0ZphGOmko/jSADj
   FO1U3JgYNy3g6Iw6J1vfH/Aq6AvYzAqo7EM0ye+qqJTdh4j5UIrj1YSnV
   K9MABzo7UH89+Lp4rLxToKvjifabR2wAmBhiSBTKO3XyDeIJDSu7FRM6f
   zDe6dpH7IPIzN0/roIKybmn1Vb04UIi0g3i/eP4qGuRODhNYe4XMwMcAI
   F+t835MZaez8GhjyAYRPsqKf2JxlGtzCXyn/2bJrEZc4V+dOMrjTSbpk/
   h0gYiyUSNygjubKEm7PWICNdF9yh0n4aJtv+d7HxbGuNOuXzcAjUOBtO6
   A==;
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="26846559"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Oct 2022 15:00:42 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D5F49280056;
        Wed, 19 Oct 2022 15:00:41 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        s.hauer@pengutronix.de, wim@linux-watchdog.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: fsl-imx: document suspend in wait mode
Date:   Wed, 19 Oct 2022 15:00:39 +0200
Message-ID: <7508670.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221019111714.1953262-3-andrej.picej@norik.com>
References: <20221019111714.1953262-1-andrej.picej@norik.com> <20221019111714.1953262-3-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrej,

Am Mittwoch, 19. Oktober 2022, 13:17:13 CEST schrieb Andrej Picej:
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml index
> fb7695515be1..01b3e04e7e65 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> @@ -55,6 +55,11 @@ properties:
>        If present, the watchdog device is configured to assert its
>        external reset (WDOG_B) instead of issuing a software reset.
> 
> +  fsl,suspend-in-wait:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If present, the watchdog device is suspended in WAIT mode.
> +
>  required:
>    - compatible
>    - interrupts

What is the condition the watchdog is suspended in WAIT mode? Is this specific 
to SoC or platform or something else?

Best regards,
Alexander



