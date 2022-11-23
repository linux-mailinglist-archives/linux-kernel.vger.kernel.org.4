Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D145C635B56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiKWLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiKWLLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:11:16 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC5B9A5FD;
        Wed, 23 Nov 2022 03:09:23 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CC8EB25E7;
        Wed, 23 Nov 2022 12:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669201760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2uICglmOipyNQWSDxRY69K7C8c5I2T+tdKX90LjQzQ=;
        b=Jj5rBHsESwngdrIVZX4OGjDbSVg3tteZ1kwDcdPIQvBt+7fd7H9Q4O+8bFDUsCVvzBzbYC
        xEVxiGcG1ujQlMo4u7y6bCoHjCSif84V6M28rYSuNM8B46y/1JOhE+EJd3+GEs2xyIe6B4
        Ru6Xjg0iJujmBWzVKgUFEqGI3PVKWamkfI5Pr+wlxcP20Gn+/9rnxli8nz2Fjw+vobp2wx
        2XbUJLr7wEm9EEHZ2lvdk4/aWz7qfRrDoagjY8c03IR3gwHfFRyxxzcS5YoYihmUM5Clgr
        vsz4KnDL3mBsPsVCsYZirbzsBzV4ZJ0q2yvePIJOzb/HDMG5O2Q9egNiji3yOw==
MIME-Version: 1.0
Date:   Wed, 23 Nov 2022 12:09:20 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jingchang.lu@freescale.com, tomonori.sakita@sord.co.jp,
        atsushi.nemoto@sord.co.jp, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
In-Reply-To: <AS8PR04MB8404EBF13DF7A051650EE76C920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-3-sherry.sun@nxp.com>
 <1a7c9345e3c8b97adfbadffda7340871@walle.cc>
 <AS8PR04MB8404EBF13DF7A051650EE76C920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7724b39dabc60f872e20ffb5ed21d1d6@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-23 11:58, schrieb Sherry Sun:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: 2022年11月23日 18:34
>> To: Sherry Sun <sherry.sun@nxp.com>
>> Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org;
>> jingchang.lu@freescale.com; tomonori.sakita@sord.co.jp;
>> atsushi.nemoto@sord.co.jp; linux-serial@vger.kernel.org; linux-
>> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear 
>> UARTCTRL_LOOPS in
>> lpuart32_shutdown()
>> 
>> Am 2022-11-10 09:17, schrieb Sherry Sun:
>> > UARTCTRL_LOOPS bit is set in lpuart32_set_mctrl() for loopback mode,
>> > but nowhere clear this bit, it should be cleared when closing the uart
>> > port to avoid the loopback mode been enabled by default when reopening
>> > the uart.
>> 
>> It's cleared in set_mctrl(). What is the expectation from the serial 
>> core here?
>> 
> 
> Hi Michael,
> 
> If we call .set_mctrl(TIOCM_LOOP), the UARTCTRL_LOOPS will be set.
> Then when we call .shutdown(), serial core won't call .set_mctrl() to
> clear it, so the UARTCTRL_LOOPS need to be cleared here.
> Per my understanding, .shutdown() should clean up all the uart flags,
> as the transmitter and receiver will been disabled, we will
> re-configure all the settings needed when re-open the port.

Two things,
(1) should the loopback be cleared on a newly opened serial device?
(2) as mentioned in my other reply, this can also be handled in
     the startup. Eg. the startup can clear the loopback flag.
     (together with possible hardware events).

I'm not that deep into the serial core, thus my question about
the expectations from the serial core. I guess the answer to
(1) is yes, but better to ask.

-michael
