Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBE5F9777
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiJJEoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiJJEoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6491A38B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96A4260CA0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF340C433D6;
        Mon, 10 Oct 2022 04:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665377049;
        bh=g1VytrLgNEwd+q2EYnSIYCJSJm640mEYTeQxP15c3uU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eSKo/VISFLTunBUsMi9uRrKnwbKjyhqVcfChRdXwGpa5aljiLUsgJIQ4Sk/i9JBQk
         4sUTuTLyhoRFjJVq0QsEIYwq8W35ByJRfAi9chdvypVgcB0rwrS64Jumat06X8XMQ+
         A3aAxL1cvVVfFVmxe1GThvBbpbCU9xlHBVaii62chQh7iQH6RMFI9oXseNQMNRf0Ng
         k+2BYfXs/hy1dOKLJos6iRS6VWzDmPWw+Hqo1GyFTNXrZ4+ud6omyobmSOtKSzCodM
         wx3qntulLhz04cklCb1HyLiLx9O+/5J5L6cYy+yfQqKdaOADlJEY0WL1fGMeIZdx2n
         V88wjXKUfR30w==
Message-ID: <593925a6-66d3-42bf-19d3-2f54917892ce@kernel.org>
Date:   Sun, 9 Oct 2022 21:44:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] arc: iounmap() arg is volatile
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
References: <20221010022846.20101-1-rdunlap@infradead.org>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20221010022846.20101-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/22 19:28, Randy Dunlap wrote:
> Add 'volatile' to iounmap()'s argument to prevent build warnings.
> This make it the same as other major architectures.
>
> Placates these warnings: (12 such warnings)
>
> ../drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
> ../drivers/video/fbdev/riva/fbdev.c:2067:42: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
>   2067 |                 iounmap(default_par->riva.PRAMIN);
>
> Fixes: 1162b0701b14b ("ARC: I/O and DMA Mappings")
> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
> Cc: Vineet Gupta<vgupta@kernel.org>
> Cc:linux-snps-arc@lists.infradead.org
> Cc: Arnd Bergmann<arnd@arndb.de>

Thx for the fix. On for-curr.

-Vineet
