Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BD635A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiKWKsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbiKWKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:47:44 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B615AA84;
        Wed, 23 Nov 2022 02:34:48 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 0DEA21D40;
        Wed, 23 Nov 2022 11:34:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669199661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugMG0Tcnl7CDfJOrBRttmEp/8J+TkQScVAZ9tYvp7jA=;
        b=ZTslL8+2vDBksTnAyBBuYZKCAPFi1g5JWnotNu0agoVSmye30ARW+yyX6bhCtkK2C08B4E
        a8+kbVsGPOCdwCxjk0KpDWkNKxQuWSrmWeZ6EsV0oreIlRnpQfiPtDBykinmdLaTK95/OH
        hvgAHpv2l/xNav0loSDWJ8hJu0pXy8WeVmvBM2fmCV10b+6OjeaQ1CcYNipAjsdbOhB1G8
        XiSlFeTp8BO+qVR5zKrxdNQSa3AYvh9L//iY+fuGel3jGPwdQOkTtsA3cR9RFEzrkECiUQ
        /mfnihVKPwD312PpcFmrDVybR9MRwqDm5qFIgcR+GS1LI1vcobWCyaxEMMOljA==
MIME-Version: 1.0
Date:   Wed, 23 Nov 2022 11:34:20 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jingchang.lu@freescale.com, tomonori.sakita@sord.co.jp,
        atsushi.nemoto@sord.co.jp, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
In-Reply-To: <20221110081728.10172-3-sherry.sun@nxp.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-3-sherry.sun@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1a7c9345e3c8b97adfbadffda7340871@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-10 09:17, schrieb Sherry Sun:
> UARTCTRL_LOOPS bit is set in lpuart32_set_mctrl() for loopback mode, 
> but
> nowhere clear this bit, it should be cleared when closing the uart port
> to avoid the loopback mode been enabled by default when reopening the
> uart.

It's cleared in set_mctrl(). What is the expectation from the serial
core here?

-michael
