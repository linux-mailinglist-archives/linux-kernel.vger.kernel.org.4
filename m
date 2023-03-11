Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B186B6020
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCKTSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCKTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:18:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B5E392;
        Sat, 11 Mar 2023 11:17:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADB360DE3;
        Sat, 11 Mar 2023 19:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4395C4339B;
        Sat, 11 Mar 2023 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678562277;
        bh=O7mOjm53l6IyjLyVpYPf+gqdpzVKUjs+J3yfYurbqOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hPyqMTdWr8NUbpA/5AWQp9Ohif6D8ZhxQtfopKr8OilDh3hgkLt08mtzocCCtSSPe
         Ljh0RFNxKOIWwdfu6nAwE35zDiJydv+snQR9sHXKB1Z3c7+1tjcAlyZQnEo/pBqZ6i
         tHy16izCAj7CP35rWCV2d93kbTof3P1UOgRSsKG+1ZBF1MeTwcTrKRQpG1KI5naqBL
         p8Fr1EBFgh3tt1raEsC1hXPlVXLw2XVqpiCwOImcdwaeKMClU19Bg+0OVkMljeGuZj
         5UIg4xzHun8jAc3NxvK9zVcz00laGF4Swq1f/NWf3HJuH8KFJ365QHypPa5QAIMwCa
         t8bnm4D7bRdQA==
Date:   Sat, 11 Mar 2023 19:18:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: qcom_geni: Use devm_krealloc_array
Message-ID: <20230311191800.74ec2b84@jic23-huawei>
In-Reply-To: <20230309150334.216760-5-james.clark@arm.com>
References: <20230309150334.216760-1-james.clark@arm.com>
        <20230309150334.216760-5-james.clark@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Mar 2023 15:03:33 +0000
James Clark <james.clark@arm.com> wrote:

> Now that it exists, use it instead of doing the multiplication manually.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Hmm. I've stared at the users of this for a bit, and it's not actually obvious
that it's being used as an array of u32.  The only typed user of this is as
the 2nd parameter of  
tty_insert_flip_string() which is an unsigned char *

I wonder if that sizeof(u32) isn't a 'correct' description of where the 4 is coming
from even if it has the right value?  Perhaps the fifo depth is just a multiple of 4?

Jonathan



> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index d69592e5e2ec..23fc33d182ac 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1056,9 +1056,9 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
>  		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
>  
>  	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> -		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
> -					     port->rx_fifo_depth * sizeof(u32),
> -					     GFP_KERNEL);
> +		port->rx_buf = devm_krealloc_array(uport->dev, port->rx_buf,
> +						   port->rx_fifo_depth, sizeof(u32),
> +						   GFP_KERNEL);
>  		if (!port->rx_buf)
>  			return -ENOMEM;
>  	}

