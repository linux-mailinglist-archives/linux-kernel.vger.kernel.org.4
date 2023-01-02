Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF665B1E8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjABMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjABMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:20:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB3E12
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69A0A60F1A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF496C433D2;
        Mon,  2 Jan 2023 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672662004;
        bh=btaLwKP77c2vrIksrhaCf6AXfnXi0R3vpTgMQOQzZFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GicCVPuqMgPSRD1ofaxjiJn9wZAHZBWUGkzf5udCKW5TIAvdqkWGu8ivkGInDp+R5
         ZYorXQFVQfDFN99L1HE82ANNeUSV5uDTDMUmgXvjqFBrVYhdy7umuX2oGj5ECAX+Ck
         Vqu+sf8I6xSs4Xqb9vRbM4S7epG4L3RZOmo+0vnxTNFNkOhiu/E9pj2slZxdqZUvgS
         NGD47oWTsBb5FPK+D8NaMSos0f5qsCXiwxDUcfHjoYjGiIW02OAF4iEjarlnVjC2qW
         L+mBVKniF94IZeeW0qTYU7o2H1Vk6zzkTDuIlsjnnmh4AXUs3nKXnJgbA1mtRo4y4s
         s5H3mLCXpwIdA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pCJnO-00GJnn-L4;
        Mon, 02 Jan 2023 12:20:02 +0000
MIME-Version: 1.0
Date:   Mon, 02 Jan 2023 12:20:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: Fix refcount leak in platform_irqchip_probe
In-Reply-To: <20230102121318.3990586-1-linmq006@gmail.com>
References: <20230102121318.3990586-1-linmq006@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6fa4699cc0b1b17943d4c67e53c432a4@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linmq006@gmail.com, tglx@linutronix.de, saravanak@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-02 12:13, Miaoqian Lin wrote:
> of_irq_find_parent() returns a node pointer with refcount incremented,
> We should use of_node_put() on it when not needed anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END
> and IRQCHIP_MATCH helper macros")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Please stop sending these patches one by one.

Send a series covering the whole of the irqchip subsystem, once
you have looked at all the drivers.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
