Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7F742794
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjF2Nkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjF2NkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:40:23 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ACE35AA;
        Thu, 29 Jun 2023 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=M3OpBfdI1HQqAXGgDJu5F2fM4UCfWxFlAYDKoVm+Fl4=; b=Wnpn6sLkbY6VdfDukd8MvApRbV
        zYEGeeioKp8QrP9ZJVE8r19/IaStRAdagVHdsYNmiCm4+mwdiZTe2iUA3Oy2tOfC5ne5R2EzNZNO4
        MnOkED6r1DQuFOY4wCQeh3of63qi7ZhqlI9qCKclVBDkN0LfNmq8gNctcE3AvinuxG2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qErsX-000EI5-1E; Thu, 29 Jun 2023 15:40:09 +0200
Date:   Thu, 29 Jun 2023 15:40:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sathesh Edara <sedara@marvell.com>
Cc:     linux-kernel@vger.kernel.org, sburla@marvell.com,
        vburru@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        hgani@marvell.com
Subject: Re: [net-next PATCH] octeon_ep: Add control plane host and firmware
 versions.
Message-ID: <9c470add-1a35-4f09-bba6-12b99f890a82@lunn.ch>
References: <20230629084227.98848-1-sedara@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629084227.98848-1-sedara@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  int octep_ctrl_net_init(struct octep_device *oct)
>  {
>  	struct octep_ctrl_mbox *ctrl_mbox;
> @@ -84,12 +101,22 @@ int octep_ctrl_net_init(struct octep_device *oct)
>  
>  	/* Initialize control mbox */
>  	ctrl_mbox = &oct->ctrl_mbox;
> +	ctrl_mbox->version = OCTEP_CP_VERSION_CURRENT;
>  	ctrl_mbox->barmem = CFG_GET_CTRL_MBOX_MEM_ADDR(oct->conf);
>  	ret = octep_ctrl_mbox_init(ctrl_mbox);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize control mbox\n");
>  		return ret;
>  	}
> +	dev_info(&pdev->dev, "Control plane versions host: %llx, firmware: %x:%x\n",
> +		 ctrl_mbox->version, ctrl_mbox->min_fw_version,
> +		 ctrl_mbox->max_fw_version);

Please consider exporting this information via devlink.

> +	ret = validate_fw_version(ctrl_mbox);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Control plane version mismatch\n");
> +		octep_ctrl_mbox_uninit(ctrl_mbox);
> +		return -EINVAL;
> +	}

If i'm reading this correct, a mismatch is fatal, the driver probe
will error out. That sort of thing is generally not liked. The driver
worked so far with mismatched firmware. It should keep working, but
not offer the features which require matching firmware.

    Andrew
