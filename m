Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3621C5B8B16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiINOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiINOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E06DD132;
        Wed, 14 Sep 2022 07:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0990161E23;
        Wed, 14 Sep 2022 14:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACD8C433D6;
        Wed, 14 Sep 2022 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663167288;
        bh=1lMB4uwONnZkbCv2WHjxaEFCglKHhnqRUR/D9tJpSsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0L92bicqt0+JR/a7wWzgZZmCLWkHKl9+hjueYV22kS2gAiPbMsYiX2ATdshoZtPW1
         KlJ1PSkCJ/NY7SXcpYFVHDHTVDqjPSvivB4Hl2ksT2/jHIE5A9qPiU6LGEr8uCTYN+
         3rD1izJ5CbuM+GKQXUg6j+s09mfxhBcS3hwsBD0k=
Date:   Wed, 14 Sep 2022 16:55:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx
 series chip
Message-ID: <YyHrT6q9fockgPjl@kroah.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
> +/**
> + * sr1xx_dev_transceive
> + * @op_mode indicates write/read operation
> + *
> + * Write and Read logic implemented under same api with
> + * mutex lock protection so write and read synchronized
> + *
> + * During Uwb ranging sequence(read) need to block write sequence
> + * in order to avoid some race condition scenarios.
> + *
> + * Returns     : Number of bytes write/read if read is success else (-1)

I'm sure I mentioned this before, but NEVER use magic "-1" as an error
value.  Use the real in-kernel -ERROR numbers for error codes please.
This needs to be fixed in many places in this code.

thanks,

greg k-h
