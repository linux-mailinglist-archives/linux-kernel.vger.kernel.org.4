Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6716572F40B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbjFNFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbjFNFOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:14:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F91A3;
        Tue, 13 Jun 2023 22:14:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35E5ERGE019010;
        Wed, 14 Jun 2023 00:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686719667;
        bh=f9NMbjlYWWumPMMGPp1UTUYH/PBscYjmbqd1a/TRdfg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=U3LRbxtzXevFMfcfubOczIyWhhohFuuXhUA8vVAQ6YYI1+tPiLRfa0oAwUp3EjcUN
         oDwQ32qIrcQqOMb6bCAVmoK3KfhrX2aN0qDj/nf8Jj5pPfK0EPUGTAoe/DKSkOzGll
         d6DcPKJyon0vg3bD+JKgtWwsbUKck/jF3ZXCz/u4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35E5ERnx022020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 00:14:27 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Jun 2023 00:14:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Jun 2023 00:14:26 -0500
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35E5EMEB097229;
        Wed, 14 Jun 2023 00:14:23 -0500
Message-ID: <13562904-2f92-8a2f-0dcc-71fc0687d7da@ti.com>
Date:   Wed, 14 Jun 2023 10:44:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] serial: 8250_omap: Use force_suspend and resume for
 system suspend
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Vignesh R <vigneshr@ti.com>
CC:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-omap@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230614045922.4798-1-tony@atomide.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230614045922.4798-1-tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Thanks for the fix!

On 14/06/23 10:29, Tony Lindgren wrote:
> We should not rely on autosuspend timeout for system suspend. Instead,
> let's use force_suspend and force_resume functions. Otherwise the serial
> port controller device may not be idled on suspend.
> 
> As we are doing a register write on suspend to configure the serial port,
> we still need to runtime PM resume the port on suspend.
> 
> While at it, let's switch to pm_runtime_resume_and_get() and check for
> errors returned. And let's add the missing line break before return to the
> suspend function while at it.
> 
> Fixes: 09d8b2bdbc5c ("serial: 8250: omap: Provide ability to enable/disable UART as wakeup source")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Tested-by: Dhruva Gole <d-gole@ti.com>

>   drivers/tty/serial/8250/8250_omap.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> [...]


-- 
Thanks and Regards,
Dhruva Gole
