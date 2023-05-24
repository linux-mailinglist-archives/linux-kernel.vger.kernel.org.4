Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80A070F909
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjEXOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjEXOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:46:25 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35171A8;
        Wed, 24 May 2023 07:46:19 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EA4F6240002;
        Wed, 24 May 2023 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684939578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+cltjGsXRVc+jhfOK5S2Eb6eEokNQM2bb/7nSwdxM4=;
        b=SLw6v2MtUbswIO8dRbsUdbYhRWpzDdEYGKlGCv8NQUCS/GQLNl7w/TSyP6DHsqjx9ZBTUp
        MNgdeqZER1Y+hHLIgaGNcObXk6lZ48r2BHhdm20ObGuTXaW3aLO1+vqgLutuVg88r0Zvp5
        976eS1oYFjxRpbGQ7eTJ6rO14rKY4XonQ7tMaZi7DxFGTXoRyHGtZfETUF25WNItZzsOsk
        Wm7MvptIYvVKDIAlnIL2IJYW+oMGpkm7qqQx7973XsZEQ3nBCY/WI+maISdkNBiknaj7sS
        pDjwSu6OF1AYLGhyysFpTqs9GsiGUhRqBUQlIKql5DTjmUrQorL/4zycmznTaA==
Message-ID: <9a7fac7b-e04b-27e2-8679-ffbbb23c248e@bootlin.com>
Date:   Wed, 24 May 2023 16:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH net-next v3 2/7] net: dsa: mv88e6xxx: pass directly chip
 structure to mv88e6xxx_phy_is_internal
Content-Language: en-US
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
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <20230524130127.268201-1-alexis.lothore@bootlin.com>
 <20230524130127.268201-3-alexis.lothore@bootlin.com>
 <ZG4OuWllZp3MZxO8@shell.armlinux.org.uk>
From:   =?UTF-8?Q?Alexis_Lothor=c3=a9?= <alexis.lothore@bootlin.com>
In-Reply-To: <ZG4OuWllZp3MZxO8@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On 5/24/23 15:18, Russell King (Oracle) wrote:
> On Wed, May 24, 2023 at 03:01:22PM +0200, Alexis Lothoré wrote:
>> Since this function is a simple helper, we do not need to pass a full
>> dsa_switch structure, we can directly pass the mv88e6xxx_chip structure.
>> Doing so will allow to share this function with any other function
>> not manipulating dsa_switch structure but needing info about number of
>> internal phys
>>
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> ---
>> Changes since v2:
>> - add reviewed-by tags
>>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
>> ---
> 
> It never ceases to amaze me the way human beings can find creative ways
> to mess things up, no matter how well things are documented. The above
> commit message (and the others that I've looked at) are all broken
> because of this creativity.
> 
> In effect, because of the really weird format you've come up with here,
> your patches are in effect *not* signed off by you.

Sorry for that. This was an attempt to provide relevant changelog for each
patch, but obviously the way I stored those changelogs was wrong, and I did not
catch the consequent broken Signed-off-by lines after re-generating the series.
I'll do as suggested and hold off a bit before fixing/re-sending.

Kind regards,
> 
> The patch format is in Documentation/process/submitting-patches.rst
> under the section marked "The canonical patch format". Please review.
> 
> Please wait a while (a few days) to see if anyone responds to _this_
> posting with any other comments. Thanks.
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

