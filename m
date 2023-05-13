Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5043870162D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjEMKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjEMKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267A42D48;
        Sat, 13 May 2023 03:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A094860DC6;
        Sat, 13 May 2023 10:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4203C433EF;
        Sat, 13 May 2023 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683973913;
        bh=u50lLtvY55sXJ6aAw7TPVTe3dvV4Gb02rVRmx7/nGog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlBmZ/ZH3vTLqfj7Br+NXVtQxakLYeVMCWh29YPYaO93jKy4gMCMyFNpqZrr4xZpb
         uy4Rq+YDJbcF89Tb2VDO/MLxSJ+YQVh5rUN5RbewmNQEA3q+WdTjS87aG0Fq1ChrmV
         GR6AxXOep1JzNCmUPjb9PvVcWmDktQFbDBy4r0hU=
Date:   Sat, 13 May 2023 19:25:03 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     XuDong Liu <m202071377@hust.edu.cn>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
Message-ID: <2023051354-tubeless-footprint-973c@gregkh>
References: <20230424125100.4783-1-m202071377@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424125100.4783-1-m202071377@hust.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:51:00PM +0800, XuDong Liu wrote:
> Smatch reports:
> drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn: 
> 'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.
> 
> In the function brcmuart_probe(), baud_mux_clk was not correctly released
> in subsequent error handling, which may cause memory leaks.
> 
> To fix this issue, an error handling branch, err_clk_put, is added to
> release the variable using clk_put(), and an err_disable branch is added
> to meet the requirement of balancing clk_disable and clk_enable calls.
> 
> Fixes: 15ac1122fd6d ("serial: 8250_bcm7271: Fix arbitration handling")
> Signed-off-by: XuDong Liu <m202071377@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> The issue is discovered by static analysis, and the patch is not tested
> yet.

Please test it.

thanks,

greg k-h
