Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837916A907F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCCFgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCCFgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:36:50 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB2116ADE;
        Thu,  2 Mar 2023 21:36:49 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3235aaZZ016516;
        Thu, 2 Mar 2023 23:36:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677821796;
        bh=0UuwiPbuzfGP6jLk+3jQHWnAHOr7rltx8G6UhwdqOcQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lkZa3eBiMlZ0p4Z2Ej2EXw4/Z2Ju/91MmQcceCJHIiXZMlE3TFilO1m9eb8IlY0r/
         82a96C3v42H7/eNDLNwz5m0yxUWQpQ4+p04sbq1i+Xg6dZSBR1zl+njXO8LY52t9He
         RkfsfZ0QEZ6CZUImDynzgwtumquucXBPL+hqC9u8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3235aZTt044794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Mar 2023 23:36:35 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 2
 Mar 2023 23:36:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 2 Mar 2023 23:36:35 -0600
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3235aWtl005315;
        Thu, 2 Mar 2023 23:36:33 -0600
Message-ID: <4b9fc988-5313-757a-b3bc-ec90dba4f4b2@ti.com>
Date:   Fri, 3 Mar 2023 11:06:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Content-Language: en-US
To:     Jerome Neanne <jneanne@baylibre.com>, <tony@atomide.com>,
        <lee@kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khilman@baylibre.com>, <nm@ti.com>, <afd@ti.com>,
        <msp@baylibre.com>
References: <20230203140150.13071-1-jneanne@baylibre.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230203140150.13071-1-jneanne@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/23 19:31, Jerome Neanne wrote:
> Use new API for power-off mode support:
> Link: https://lwn.net/Articles/894511/
> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
> 
> sys-off API allows support of shutdown handler and restart handler.
> 
> Shutdown was not supported before that enhancement.
> This is required for platform that are not using PSCI.
> 
> Test:
> - restart:
>   # reboot
>   Default is cold reset:
>   # cat /sys/kernel/reboot/mode
>   Switch boot mode to warm reset:
>   # echo warm > /sys/kernel/reboot/mode
> - power-off:
>   # halt
> 
> Tested on AM62-SP-SK board.
> 

There is no -SP-SK that I am aware of.. Do you mean -LP-SK?
[...]

-- 
Regards
Vignesh
