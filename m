Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7D74BD82
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGHMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 08:53:06 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C41737;
        Sat,  8 Jul 2023 05:53:04 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CB1F0861A1;
        Sat,  8 Jul 2023 14:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1688820782;
        bh=IvddLfxwhrH7kTVtfgBFgKokYGybU9LtMq+/etkdvbI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NHqRydq/3DWpKNfzIpfw3UKozdmCaMiozNFilkMiJMlziIeTSdMqOTMJ2cQw14JKI
         ruGev34X1eYWi8FvOyvKSOPUidKLzZL63NBpXZ8YMMRoD/bG12sF7vF2+PeFszVewa
         WIAsD7sgfn/VbOL4miCL8falHNw9TI+1Z5BBy2tW/oIzOOTOzpe9OrkyiNuV9rqmm0
         6ORny8Uo/MywvdnVktK+h6squ6maxI4NBwr+B4HWjQNhilCSlTngNB/8ir03B90ami
         PjWd/c53V7RmBPTSCi5WJGnu7QPEVyB+6oJcmTMDOvnk+2yc21FQwAYYoWGczGNQCl
         xF0GxvbOw2lMw==
Message-ID: <db4304f6-0d8b-5eef-38d9-f3965cdc3cba@denx.de>
Date:   Sat, 8 Jul 2023 14:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] thermal: imx8mm: suppress log message on probe deferral
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230708112647.2897294-1-a.fatoum@pengutronix.de>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230708112647.2897294-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/23 13:26, Ahmad Fatoum wrote:
> nvmem_cell_read_u32() may return -EPROBE_DEFER if NVMEM supplier has not
> yet been probed. Future reprobe may succeed, so printing:
> 
>    i.mx8mm_thermal 30260000.tmu: Failed to read OCOTP nvmem cell (-517).
> 
> to the log is confusing. Fix this by using dev_err_probe. This also
> elevates the message from warning to error, which is more correct: The
> log message is only ever printed in probe error path and probe aborts
> afterwards, so it really warrants an error-level message.
> 
> Fixes: 403291648823 ("thermal/drivers/imx: Add support for loading calibration data from OCOTP")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
