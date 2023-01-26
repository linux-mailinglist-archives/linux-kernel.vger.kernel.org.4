Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE667D0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjAZQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjAZQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:10:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E067215561;
        Thu, 26 Jan 2023 08:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B6C8618C4;
        Thu, 26 Jan 2023 16:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591BDC433EF;
        Thu, 26 Jan 2023 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674749404;
        bh=nyZvVT0ixGZyn27JMAEZpO/d+K/tU5a0uU7uxI7J0WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTrKRF2Dr+YQ4w7Ruyxvy4l4J9hS3+JEsT3KdUzIiz7DrUG4SCjYKAb+PkEl/bz8T
         0vrAemuTxPFRrbn1HiQ7QsZyM2k0XsQXwSBz2Z9aqPIB6l6HBhewayHZdYzE3v0pCS
         KhT8W4t77pjWL7GgrTtiV0Pyg7Xw1F+2DzRYrnczfznf1Poy+3U++tK+BgMibv+rvt
         TUMlsYJqArF+q+uiBuKtsHp6yTC4Cd87zjJ8UCJg6hFDa62taEhhKQ7rO8cxYERQjY
         Av6MVlN/A/zH9yLnfN2UfN2IJyekQbpL5CYKFHQ6fyYWgzN0eZ+SPlTdq9Pmk/NA+c
         44IbH/8AVng4A==
Date:   Thu, 26 Jan 2023 10:10:02 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvmem: qcom-spmi-sdam: fix module autoloading
Message-ID: <20230126161002.74wbgoo7ytx4cyoi@builder.lan>
References: <20230126133034.27491-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126133034.27491-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:30:32PM +0100, Johan Hovold wrote:
> The Qualcomm SDAM nvme driver did not have a module device table, which
> prevents userspace from autoloading the driver when built as a module.
> 
> The driver was also being registered at subsys init time when built in
> despite the fact that it can also be built as a module, which makes
> little sense. There are currently no in-tree users of this driver and
> there's no reason why we can't just let driver core sort out the probe
> order.
> 
> Note that this driver will be used to implement support for the PMIC RTC
> on Qualcomm platforms where the time registers are read-only (sic).
> 
> Johan
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> 
> Johan Hovold (2):
>   nvmem: qcom-spmi-sdam: fix module autoloading
>   nvmem: qcom-spmi-sdam: register at device init time
> 
>  drivers/nvmem/qcom-spmi-sdam.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> -- 
> 2.39.1
> 
