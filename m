Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF86FC2A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjEIJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjEIJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:21:06 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F3106CE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:20:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E049B8477D;
        Tue,  9 May 2023 11:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683624044;
        bh=V6XmCUytsEBLvY/oVR73wPgI8LYLb7mCtHISXwkQgNo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D7TGIdrgyfk+zZ6mJmGlLvsie7r6xveNUqC64XL3MhlztbJssGXh/R2UAof5PodI5
         +vw1xvPDcJIfM0B1hCfVSQy1UmkLrYDhcKZ97ujTHZYl6VRl9fxIWNvuxDVc//CqXg
         jYBtSUpWK9qMGT6/R2IbTlZ+safElOhL2RosSfVhf8ks4YkOUnI7S0L3v3J07siwkx
         B4wq0D63e9xFf4UGINixaFil640kT/62I1+UwF47Y/OO8CcoGiJYCSq8A2c6+n1zy/
         sdrgV3CL4DkkvXL4R7S5hSDOBrTZ/DPeYj3/Hza3Rhgg7JCu772x1dlIk3y1OHx2hb
         q0TimkbjElkMA==
Message-ID: <e7e4f933-5098-5fea-7a1d-254609c93cbd@denx.de>
Date:   Tue, 9 May 2023 11:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
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
 <02349503-4542-cbfd-2a2f-379fe8284cca@denx.de>
 <OS3PR01MB8460C4A6047EE4590D4F791FC2769@OS3PR01MB8460.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <OS3PR01MB8460C4A6047EE4590D4F791FC2769@OS3PR01MB8460.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 10:59, DLG Adam Ward wrote:
> On 08 May 2023 00:41, Marek Vasut wrote:
> 
>>> It looks fine now; sorry I didn't notice before.
>>
>> I think a formal Reviewed-by / Acked-by would be nice.
> 
> It's already there in the patch - obliquely referred to by "before", the apology because I'd missed that which the robot picked up on after I'd looked at it.

Ahh, in that case, sorry for the noise and thanks for the RB .

And for all its worth, patch is also:

Reviewed-by: Marek Vasut <marex@denx.de>
