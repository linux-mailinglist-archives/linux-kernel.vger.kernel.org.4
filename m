Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A2732094
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFOUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFOUFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EE295D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C846561BDF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8D5C433C8;
        Thu, 15 Jun 2023 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686859507;
        bh=CZRKMMFyvWLL7Fxx/I7YyvYMRKdHPJbcAAkIvVyEre0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DvetiO+ccq8E8j7W77N+P4EFu/yQ9EjvGSV7yR2aO2aVRgfgfK6W/jqszhwQzqC+E
         Hy0TjSSV6yVbsZrKEyOCSO/lUgIXhomOa28NyMgNlLdERlr3tlIVvsDwgDMLRrevc9
         QUyCjbkC5qPSzPD0sxhChiKMvV5Xy9sCy+49/YRRpu1Mtm/KKhPc0MsuuqaFeUSTNn
         si0v5wROeDiIpCJKCxBw1xVa538lf5INBqNiSD+i4k1g/b7sft8yCA4g9WK9Bz+zrH
         V/hzHjNCdRZ8HO91lpjsnaHbNhvy2jllGCV/HssiNI21iJLjEY8QwggElJGGXo2zJy
         uhqyToDBuJdpg==
Date:   Thu, 15 Jun 2023 13:05:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        <simon.horman@corigine.com>, <andrew@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <vincent.cheng.xh@renesas.com>,
        <harini.katakam@amd.com>, <git@amd.com>
Subject: Re: [PATCH V2] ptp: clockmatrix: Add Defer probe if firmware load
 fails
Message-ID: <20230615130506.3efb333c@kernel.org>
In-Reply-To: <20230614051204.1614722-1-sarath.babu.naidu.gaddam@amd.com>
References: <20230614051204.1614722-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 10:42:04 +0530 Sarath Babu Naidu Gaddam wrote:
> Clock matrix driver can be probed before the rootfs containing
> firmware/initialization .bin is available. The current driver
> throws a warning and proceeds to execute probe even when firmware
> is not ready. Instead, defer probe and wait for the .bin file to
> be available.

The first-step fix should be to try to get the FW into initramfs.
For that driver should specify MODULE_FIRMWARE(), which I don't see
here.
-- 
pw-bot: cr
