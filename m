Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DE6219D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiKHQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiKHQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:51:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C957B50;
        Tue,  8 Nov 2022 08:51:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 270941F45B;
        Tue,  8 Nov 2022 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667926312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9ykV8hJMFJwXk6aawtYnz0dSwskJrdet1sqEDHolqg=;
        b=e1csi0ceHDVT6ElHtaOfK5rcrmyejxystY4Zd1EfxzaJZ5fyVJsfDgMBorKaWv2tgUhZrw
        dxw1Y2uzDWI9Nl7B2NzxEl3m9HgUJ/UXAAmyXQxMKU9ch8Yx6tXQVkFR8NFDnBp6hSWxFY
        7zY0IezPMK6ZLREC9aihgc6crAPQ1B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667926312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9ykV8hJMFJwXk6aawtYnz0dSwskJrdet1sqEDHolqg=;
        b=IlZl2bUZaFenbZ/5W1K2+rt4+HEn1a78KNKjF498QyEM9z+N8Jc/UKOEvLfLhZjWiyVjph
        O2ztMiVE3fEE6LAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E27AF13398;
        Tue,  8 Nov 2022 16:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jovyNieJamMLCQAAMHmgww
        (envelope-from <afaerber@suse.de>); Tue, 08 Nov 2022 16:51:51 +0000
Message-ID: <d3905a85-4746-09e8-ecf9-b39757bf6d85@suse.de>
Date:   Tue, 8 Nov 2022 17:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] pinctrl: add NXP S32 SoC family support
To:     Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Chester Lin <clin@suse.com>
Cc:     dl-S32 <S32@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-3-clin@suse.com>
 <AM9PR04MB8487C664E75EBA4D3678DD03E33F9@AM9PR04MB8487.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
In-Reply-To: <AM9PR04MB8487C664E75EBA4D3678DD03E33F9@AM9PR04MB8487.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester and Andrei,

Am 08.11.22 um 15:54 schrieb Andrei Stefanescu:
>> diff --git a/drivers/pinctrl/freescale/pinctrl-s32.h b/drivers/pinctrl/freescale/pinctrl-s32.h
>> new file mode 100644
>> index 000000000000..7b48fe3d73c9
>> --- /dev/null
>> +++ b/drivers/pinctrl/freescale/pinctrl-s32.h
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * S32 pinmux core definitions
>> + *
>> + * Copyright (C) 2016-2020,2022 NXP
> 
> Could we also add: " * Copyright 2015-2016 Freescale Semiconductor, Inc."?

... and insert a space before 2022, while at it.

@Andrei: Intentionally no (C) or (c) for Freescale? (column alignment)

Cheers,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Frankenstraße 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nürnberg)
