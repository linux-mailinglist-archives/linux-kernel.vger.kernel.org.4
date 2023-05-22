Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE270B75F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjEVIO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjEVIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:14:56 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C08AB;
        Mon, 22 May 2023 01:14:53 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DCD3C1C0005;
        Mon, 22 May 2023 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684743292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWwbyb5Mxk6cx2PzwjH7Aj8olHq6kSORyWUZJykL/eI=;
        b=b9bRB2K6BiXKlseyVVmXLEsjuoXv8WLHYJJKi7Ynvulp7/OkWnioSeBovJ854/vxUoo1vz
        Bl2933HsDkQ7uQ418f1NQgBQexM1GqO/qK6l5bKLlSL0Lr+a+WGkAGdeeFFiyNct80MJ8R
        4scTcsDTdgdsCRYmt2DK+ZF7xc4om50E2fsQzlVzFfpOkAOhzS/+/uNr1ndyIB2nnfmbnw
        v+14v9JRbCYD4b8pF7hrUtUJrXnHv8xP0eLouAMi1k7F1YEC4eUS/I0JGWFI1UgmX7vgK1
        p9VQBlJFjRUEpUrWzyt+UuCTC58nrG7Wg1NqTMAyCcQx9R+4MddS47GzJ/AVfA==
Message-ID: <1c104034-b61f-5242-40fa-339de59ac9c9@bootlin.com>
Date:   Mon, 22 May 2023 10:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   =?UTF-8?Q?Alexis_Lothor=c3=a9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net-next v2 7/7] net: dsa: mv88e6xxx: enable support for
 88E6361 switch
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, paul.arola@telus.com,
        scott.roberts@telus.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <20230519141303.245235-1-alexis.lothore@bootlin.com>
 <20230519141303.245235-8-alexis.lothore@bootlin.com>
 <ZGeLEbcCHzOASasC@shell.armlinux.org.uk>
Content-Language: en-US
In-Reply-To: <ZGeLEbcCHzOASasC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, thanks for review

On 5/19/23 16:43, Russell King (Oracle) wrote:
> On Fri, May 19, 2023 at 04:13:03PM +0200, alexis.lothore@bootlin.com wrote:
>> From: Alexis Lothoré <alexis.lothore@bootlin.com>
>>
>> Marvell 88E6361 is an 8-port switch derived from the
>> 88E6393X/88E9193X/88E6191X switches family. It can benefit from the
>> existing mv88e6xxx driver by simply adding the proper switch description in
>> the driver. Main differences with other switches from this
>> family are:
>> - 8 ports exposed (instead of 11): ports 1, 2 and 8 not available
>> - No 5GBase-x nor SFI/USXGMII support
>>
>> ---
>> Changes since v1:
>> - define internal phys offset
>> - enforce 88e6361 features in mv88e6393x_phylink_get_caps
>> - enforce 88e6361 features in mv88e6393x_port_set_speed_duplex
>> - enforce 88e6361 features in mv88e6393x_port_max_speed_mode
> 
> Not exactly related to this patch, but please do not rely on this "max
> speed mode" - please always ensure that you specify the phy-mode and
> fixed-link settings for CPU and DSA ports in firmware. Thanks.

I would like to make sure to fully understand your point:
- when telling so specify phy-mode and fixed-link in firmware, you mean
device-tree, right ?
- when checking for code and execution flow, I observe that port_max_speed is
always called and its output is always used to configure shared ports mode in
mv88e6xxx driver. Are you telling that eventually, the whole mv88e6xxx driver
should stop relying on port_max_speed_mode for shared ports ?

Kind regards,


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

