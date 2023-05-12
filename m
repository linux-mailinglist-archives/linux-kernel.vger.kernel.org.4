Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8853C70009A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjELGeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbjELGeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:34:01 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312483C1B;
        Thu, 11 May 2023 23:33:38 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 11F3C20009;
        Fri, 12 May 2023 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683873217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1dFYZRvKs4qv+uZsl9ppvEEACIWA+psNysfH673qxs=;
        b=Zdf+fefnpviYfTYSM6hSlNchA5psiLJSt3pN1J8qFDSD5pSgPcaJCR3vXhhGx7wILvKiHF
        GgyjFtafMX7T4HDX9RKIa22aZvZpdnUcGF0j/9Exbap6pe+dAn2piY7VgR+mUNs4vDfw5T
        2KC/WJjhCLzEwW7WRhbeoJ+H6HLYZSV56hmyT910UCwz+30LRFQ3D23Go6CSQ66fmnX2Q6
        G8Vo8Z4i21ELlJylwiJblQxBQjstRI5ZlK8wcWBtyLIuKWC3k4tZeQluShvUGZlPYTN+SD
        K0RjOUXUhwzQCR7GWNFW/EQAVch8gnP5rQ+z5jdLi+toYSlxpFWAi5H7UX5EiQ==
Message-ID: <7a2c205a-70dc-0d62-9e7b-cf09f7f5aac7@bootlin.com>
Date:   Fri, 12 May 2023 08:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH net v2 2/3] net: dsa: rzn1-a5psw: fix STP states handling
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        herve.codina@bootlin.com, miquel.raynal@bootlin.com,
        milan.stevanovic@se.com, jimmy.lalande@se.com,
        pascal.eberhard@se.com
References: <20230511170202.742087-1-alexis.lothore@bootlin.com>
 <20230511170202.742087-3-alexis.lothore@bootlin.com>
 <20230511213749.j2be7po5n2vgfwmu@skbuf>
Content-Language: en-US
From:   =?UTF-8?Q?Alexis_Lothor=c3=a9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20230511213749.j2be7po5n2vgfwmu@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vladimir,
thanks for the fast review !
On 5/11/23 23:37, Vladimir Oltean wrote:
> On Thu, May 11, 2023 at 07:02:01PM +0200, alexis.lothore@bootlin.com wrote:
>> From: Clément Léger <clement.leger@bootlin.com>
>>
>> stp_set_state() should actually allow receiving BPDU while in LEARNING
>> mode which is not the case. Additionally, the BLOCKEN bit does not
>> actually forbid sending forwarded frames from that port. To fix this, add
>> a5psw_port_tx_enable() function which allows to disable TX. However, while
>> its name suggest that TX is totally disabled, it is not and can still
>> allow to send BPDUs even if disabled. This can be done by using forced
>> forwarding with the switch tagging mechanism but keeping "filtering"
>> disabled (which is already the case in the rzn1-a5sw tag driver). With
>> these fixes, STP support is now functional.
>>
>> Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
>> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
>> ---
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
>> @@ -344,28 +376,35 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
>>  
>>  static void a5psw_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>>  {
>> -	u32 mask = A5PSW_INPUT_LEARN_DIS(port) | A5PSW_INPUT_LEARN_BLOCK(port);
>>  	struct a5psw *a5psw = ds->priv;
>> -	u32 reg = 0;
>> +	bool learning_enabled, rx_enabled, tx_enabled;
> 
> Absolutely minor comment: in the networking subsystem there is a coding
> style preference to order lines with variable declarations longest to
> shortest (reverse Christmas tree). Since I don't see another less
> frivolous reason to resend the patch set, I thought I'd just mention
> for next time.

ACK. Since an error has been raised by CI bot on this series, I will send a V3
and fix this ordering too.

Regards,

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

