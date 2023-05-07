Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06D36F9CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjEGXkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGXkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:40:40 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222E1BD8
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 16:40:39 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7A6D684698;
        Mon,  8 May 2023 01:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683502837;
        bh=V2j1mqxhsFE0MNfvXOxfbRhdErYoMOVzUrNHlj9GSGY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tKQeIs2xifkoi4rflT9AePNxN/oHomRv/f58GgKrcNNKj+lPaWDTzWAi00fhhcO3g
         wRLJmcGYUBaVYqllV36BG+yvqGTBH9ZxndnGFxvVajQzqE4S1Gkl1YRerS/bL+zjAK
         ox/yOCRS9meOtjkzuJhKjTHd6lkLolqNsyeQi3gxmJoPIS2XJn09cO9jB5QOq1U11t
         p3Mkxd/zVqMIvQvKhBxerQ1OGJprumnl40bHYiqbhm76sdWG7Gphf0mgJ7Gh9wlW3N
         yr4tS0wwugHGguunoZC8BJ2tDFDMHQ3niYmzI3EKTTRWxi0Rtnp3IXnkBaqGF36LZr
         T7ErV0h6sDViA==
Message-ID: <02349503-4542-cbfd-2a2f-379fe8284cca@denx.de>
Date:   Mon, 8 May 2023 01:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Content-Language: en-US
To:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
 <20230309092254.56279-3-cniedermaier@dh-electronics.com>
 <bb6f5cf8afd54836959ebfb0455b81dc@dh-electronics.com>
 <TYCPR01MB847111D756F520761D720716C26A9@TYCPR01MB8471.jpnprd01.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <TYCPR01MB847111D756F520761D720716C26A9@TYCPR01MB8471.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 12:50, DLG Adam Ward wrote:
> On 18 April 2023 21:00, Christoph Niedermaier wrote:
>> In V3 of this patch the kernel test robot found an issue. A fix is important, because otherwise the normal path with IRQ could have problems. So I fixed it in V4. Any comments or is it OK how I fixed it?
> 
> Hi Christoph,
> 
> It looks fine now; sorry I didn't notice before.

I think a formal Reviewed-by / Acked-by would be nice.

But maybe Mark can pick this 3/3 patch now either way ?
