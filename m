Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6943B6BD064
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCPNEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCPNEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:04:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1510B1EDB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACF70B82147
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219B2C433D2;
        Thu, 16 Mar 2023 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678971877;
        bh=6SKDCIH8F2y9+9R8yw+MQjW9o6dNgojeQwy94ObmQjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7Gm3ADSOJDnBTskBTaVy90s2Bz43LFoXIOYdkrEcqL5D97+Is9QRwK0+qgHeR4ni
         HEhX9Hp3sRMgq6IciiQsr/08W+WWKUqbYHZNTfOI9kBG5jKBpVw229N0d+lCbjQsZg
         5qliHEFuOZGZZp8PpNOItSKQ8G2wp+puOggTTMk0=
Date:   Thu, 16 Mar 2023 14:04:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBMT41g8kYQPCw+d@kroah.com>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:56:02PM +0500, Khadija Kamran wrote:
> @@ -815,6 +811,16 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	char *device_name;
>  	int rc = 0; /* error return value */
> 
> +	if (read_timeout >= 0)
> +		read_timeout = msecs_to_jiffies(read_timeout);
> +	else
> +		read_timeout = MAX_SCHEDULE_TIMEOUT;
> +
> +	if (write_timeout >= 0)
> +		write_timeout = msecs_to_jiffies(write_timeout);
> +	else
> +		write_timeout = MAX_SCHEDULE_TIMEOUT;

Also, this change needs to go into the axis_fifo_init() function, not
the driver probe as now the print message in there is not correct.

thanks,

greg k-h
