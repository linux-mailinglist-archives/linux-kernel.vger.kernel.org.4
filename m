Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC166D5F67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjDDLqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjDDLqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB519A4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 446B960B8B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD2BC433EF;
        Tue,  4 Apr 2023 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680608775;
        bh=Bmx5sWZYWn9mDaaceeFQaRkfTZSSwMr0volPaPsmVPE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JTKl6eWVuRI/sxuD+oMgd3NswMX2ev/vilHfLcrJYT2Ggz2JnKn5iFFDHQCOoA9c1
         vNsKfAddGnVCHusf58JdLZWEGG+6n7JA78mTQE/aolADlKm3lRTbktO/UvGYYjOvwg
         SOHrO/oQvfPe4Myp68NewTFC8JqQ2Q8XQ2jaiBnTCLYnOhGTrTs6Djmqkqt/M138Kx
         vAIbF4C3t6SyO1a8GhCQ6ykaN41xO4KEqlwV6L2d1cXAeBSCwsrdi+5Htzq3Jhg6B5
         MERVmNbl0XlU0N84FjnwNWrtHik8FwIqxMIZkO0sNz5NJKX/P00Y4wK06BVUpLfoEI
         O2Vqfu1jH/lbw==
Message-ID: <076b5775-18eb-05b3-b803-c54420b3e5fe@kernel.org>
Date:   Tue, 4 Apr 2023 14:46:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module
 instead of built-in
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230404084259.13752-1-rogerq@kernel.org>
 <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
 <0ffa9690-9709-669c-b44d-dbb93446ec95@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0ffa9690-9709-669c-b44d-dbb93446ec95@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2023 13:01, Krzysztof Kozlowski wrote:
> On 04/04/2023 10:51, Arnd Bergmann wrote:
>> On Tue, Apr 4, 2023, at 10:42, Roger Quadros wrote:
>>> USB_DWC3 is not required for boot on most platforms make it
>>> as a module instead of built-in.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>
>> Does this save a significant amount of vmlinux size? Since this

vmlinux size reduces by ~529KB

>> is a fairly common USB driver, I think it does help to have it
>> built-in for users booting from USB_STORAGE or nfsroot over
>> USB_USBNET, which are both built-in and not uncommon.

OK.

> 
> Especially that sometimes, at least for arm64 defconfig, we added as
> built-in less critical pieces (RENESAS_ETHER_SWITCH, MARVELL_10G_PHY,
> HTE_TEGRA194, SM_VIDEOCC_8250 and other non-core clock controllers).
> This change will require several systems to update their initrd to
> include USB.

OK. Please ignore this patch and the arm64 defconfig one as well. ;)

cheers,
-roger
