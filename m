Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2267E934
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjA0PQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjA0PQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:16:27 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793040E1;
        Fri, 27 Jan 2023 07:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1674832586; x=1706368586;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=J85XzxxjAKCt6wUsJoyOWvpKjjyw1igxFqPQ00CyA24=;
  b=o8NVY8FAE8oBz4G/C/L6u5uBpBoY+E1cfyYD5xtHEJhnW6+qUT/Lt5c3
   HVmrwlZ83YWqlq54L9H1fLvDy/ol4ZnICLpPgvaA3T5jKt2Qvv9FNgOgv
   Ezic3X47Ufn7mtlZAvUORCnfQl3WX3gnI4mP3k0nRBMy4ZBKP5Q+09euG
   M=;
X-IronPort-AV: E=Sophos;i="5.97,251,1669075200"; 
   d="scan'208";a="292851507"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 15:16:23 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id A7AA943230;
        Fri, 27 Jan 2023 15:16:21 +0000 (UTC)
Received: from EX19D009UWB003.ant.amazon.com (10.13.138.95) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Fri, 27 Jan 2023 15:16:21 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D009UWB003.ant.amazon.com (10.13.138.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Fri, 27 Jan 2023 15:16:21 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.45 via Frontend Transport; Fri, 27 Jan 2023 15:16:20 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 6FD3220D34; Fri, 27 Jan 2023 16:16:19 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 1/4] spi: cadence-quadspi: Reset CMD_CTRL Reg on cmd
 r/w completion
References: <20230125081023.1573712-1-d-gole@ti.com>
        <20230125081023.1573712-2-d-gole@ti.com>
Date:   Fri, 27 Jan 2023 16:16:19 +0100
In-Reply-To: <20230125081023.1573712-2-d-gole@ti.com> (Dhruva Gole's message
        of "Wed, 25 Jan 2023 13:40:20 +0530")
Message-ID: <mafs07cx8f1oc.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wed, Jan 25 2023, Dhruva Gole wrote:

> If one leaves the CQSPI_REG_CMDCTRL in an unclean state this may cause
> issues in future command reads. This issue came to light when some flash
> reads in STIG mode were coming back dirty.

Can you explain in more detail what you mean by "reads coming back
dirty"? Because I don't see any clear reason why not resetting the
register would break anything. We re-create the register value from the
scratch on the next read anyway, and as soon as you writel() that, the
old fields get thrown away anyway.

>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 676313e1bdad..6030da942c6e 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -549,6 +549,9 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
>                 memcpy(rxbuf, &reg, read_len);
>         }
>
> +       /* Reset CMD_CTRL Reg once command read completes */
> +       writel(0, reg_base + CQSPI_REG_CMDCTRL);
> +
>         return 0;
>  }
>
> @@ -613,7 +616,12 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
>                 }
>         }
>
> -       return cqspi_exec_flash_cmd(cqspi, reg);
> +       ret = cqspi_exec_flash_cmd(cqspi, reg);
> +
> +       /* Reset CMD_CTRL Reg once command write completes */
> +       writel(0, reg_base + CQSPI_REG_CMDCTRL);
> +
> +       return ret;
>  }
>
>  static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
> --
> 2.25.1
>

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



