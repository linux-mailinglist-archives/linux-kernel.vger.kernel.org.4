Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0AE65CB6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbjADBcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbjADBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:31:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26963117C;
        Tue,  3 Jan 2023 17:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ijnis/WI5plp38mtmuFWM0btH8pvOuArfVZ6ZZO26+Y=; b=iATV2NXx5v9rrUgFhuJlontJxk
        TDxCgt5yG3Z5kdaUMpTB0ZUdrvYp+iO3lFYGnUPMv4jMQB973CMuMjbTtxgClc4+AI+uwNHvGKnS1
        uN+whSmcWn322VWte3Is8JbIOEr9g6DKbxvGqDu5T1jHsTzu1smaRFDwuaSJbQ6KSanGKVHzya0gM
        Q2UM4KBUs1Ykvhs140BzPwpZuVJb70nsDpOZEA78EfU7ZGmZJrr1+YfE1OkzQvGCodMidrmxVnyyA
        uZXmO3Sxph7KFhGSqHcmNcO5/Pa0st1IuoKCrQzUQvLLjSG4cgR/z9TvET8Tpa/6RiEaIl78uMJPA
        pDSTyHMQ==;
Received: from 108-90-42-56.lightspeed.sntcca.sbcglobal.net ([108.90.42.56] helo=[192.168.1.80])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCsdF-00EZrR-4u; Wed, 04 Jan 2023 01:31:53 +0000
Message-ID: <53dd3a2c-3f56-dcdc-bb75-5dc5adbe30bf@infradead.org>
Date:   Tue, 3 Jan 2023 17:31:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] of: Fix handling CONFIG_CMDLINE* even without /chosen
 node
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-dt-cmdline-fix-v1-0-7038e88b18b6@kernel.org>
From:   Geoff Levand <geoff@infradead.org>
In-Reply-To: <20230103-dt-cmdline-fix-v1-0-7038e88b18b6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/3/23 10:00, Rob Herring wrote:
> 
> Let's revert the above commit and redo the missing /chosen node handling 
> within early_init_dt_scan_chosen().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Rob Herring (2):
>       Revert "of: fdt: Honor CONFIG_CMDLINE* even without /chosen node"
>       of: fdt: Honor CONFIG_CMDLINE* even without /chosen node, take 2
> 
>  drivers/of/fdt.c | 54 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)

I applied these two patches to v6.2-rc2 and tested on PS3. I used a kernel
config file that had a CONFIG_CMDLINE, and CONFIG_CMDLINE_FORCE=y set.
Everything seemed to work OK.  

Tested-by: Geoff Levand <geoff@infradead.org>

