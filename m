Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D542773A899
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFVSux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjFVSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:50:51 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EFAA2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:50:49 -0700 (PDT)
Received: from [192.168.50.162] ([146.241.96.150])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CPOJqUQ4W7skLCPOJqI8Pq; Thu, 22 Jun 2023 20:50:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1687459848; bh=NiL5KJY63hJ4jA23FuSWyQhcwnYWpVK+f6seEcG9u6o=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=AAOPqMmunz1BKpXzVO0l7wO8cXRPc4XnCeUZqacKrZZIoRiBFLuqU5ji7G++xkuXL
         ezJQPQVZu5hi2LpJ2ZH/K+dydL8bMSD+JQQeD4fFu/LiKrUOjY+LA5iXKtGD3JMjvs
         EGCcVeXa981EtexBs8U7eHKdMJXWLAY7SewP2CA22Ttkocsd8lsFlqhGOEV3reApvC
         2GC3dbsiIX5E0g3mU0wWQT/smXyR7AsRiB/W/rTkibYjd5hpFaE9TcD+Awv5ScAnBW
         ZfCkJXLde7CDXyw30vYbV6qJh+UqQsN2IzvECIBfnrpBy+xxnxRt6Gl6axgyd/OJbW
         VaptUwg3BQAuw==
Message-ID: <ec6fbaae-323e-5986-3930-a62fa365193a@benettiengineering.com>
Date:   Thu, 22 Jun 2023 20:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] net: phy: broadcom: drop brcm_phy_setbits() and use
 phy_set_bits() instead
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622123737.8649-1-giulio.benetti@benettiengineering.com>
 <12d3d3e7-da90-cc73-57e6-1aa7859dce90@benettiengineering.com>
 <ZJRqMLepCTPqvCD9@corigine.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <ZJRqMLepCTPqvCD9@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPgOOi/LCA4VeUvKOAH9MIyz0KRj9UZKaH5rDQXASx+NILAQrSp/XoIyKQzSdzqn2+3Rfmn3+rJPP5nCDVJv5sR/ye1UVAW0WkX4OIKcBbFaLmRUV9w8
 m4z+JLokFSIvd4o9oVhp9oNdYS3bmIxdMH6nlw0DvpAInymiHku8ALzCKFsvdXKLYXDG82JTtGglwXwenaF4dXOZgWSVLyio95ddILby+xV194rTyserouU7
 P828/F0nS141CL1eCVJTI5HKYMSCr/wIQiHI/JSJg8eV7r1CIYa3Wqqys66BeQe8Zq+FRqm23v5mEMP3UnQ19eB2WLzcJwu0Ohoc772CmTjEGTUsNhXX/N38
 0fxNGPtU09RY7kU3ntgPCYfqV9Z/vt+oJHrlDma4ackjGPt54pvC6G7rfUV6v0TgNDX2Y6kge4HJydiAAgIugdqlh2CxiMnE9y7d3lEahndrJwvC2Ri7UDEQ
 YMbnMpUbYrJ1tBn/7W/AmdoChAaVN4kz53WiQP22rg2zqC2RKLNIyN+DQym23OSuWUQtutLa6bFTv9o0VwOtFBP32bIUzrRL4L+ojV1X4+rY0qBCdITrdpbB
 TLU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 22/06/23 17:35, Simon Horman wrote:
> On Thu, Jun 22, 2023 at 02:48:46PM +0200, Giulio Benetti wrote:
>> Pardon,
>>
>> On 22/06/23 14:37, Giulio Benetti wrote:
>>> Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
>>> use phy_set_bits() in its place.
>>>
>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> ---
>>>    drivers/net/phy/broadcom.c | 15 ++-------------
>>>    1 file changed, 2 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
>>> index ad71c88c87e7..d684c5be529a 100644
>>> --- a/drivers/net/phy/broadcom.c
>>> +++ b/drivers/net/phy/broadcom.c
>>> @@ -608,17 +608,6 @@ static int bcm54616s_read_status(struct phy_device *phydev)
>>>    	return err;
>>>    }
>>> -static int brcm_phy_setbits(struct phy_device *phydev, int reg, int set)
>>> -{
>>> -	int val;
>>> -
>>> -	val = phy_read(phydev, reg);
>>> -	if (val < 0)
>>> -		return val;
>>> -
>>> -	return phy_write(phydev, reg, val | set);
>>> -}
>>> -
>>>    static int brcm_fet_config_init(struct phy_device *phydev)
>>>    {
>>>    	int reg, err, err2, brcmtest;
>>> @@ -689,14 +678,14 @@ static int brcm_fet_config_init(struct phy_device *phydev)
>>>    		goto done;
>>>    	/* Enable auto MDIX */
>>> -	err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
>>> +	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
>>>    				       MII_BRCM_FET_SHDW_MC_FAME);
>>
>> I've missed to checkpatch.pl and there is a style error ^^^
>>
>>>    	if (err < 0)
>>>    		goto done;
>>>    	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
>>>    		/* Enable auto power down */
>>> -		err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
>>> +		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
>>>    					       MII_BRCM_FET_SHDW_AS2_APDE);
>>
>>                                        and here ^^^
>>
>> I wait some time for any feedback and then I send a V2.
> 
> Hi Giulio,
> 
> Please include the target tree, net-next, when you send v2:
> 
> 	Subject: [PATCH net-next v2] ...

Thank you,

I've just sent the v2 in reply to this.

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
