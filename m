Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97C741DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF2CAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjF2CAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:00:02 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 63D9A2961;
        Wed, 28 Jun 2023 19:00:00 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 92556604A13F4;
        Thu, 29 Jun 2023 09:59:57 +0800 (CST)
Message-ID: <325f00e3-1dfd-f77b-9795-6f89e44c0417@nfschina.com>
Date:   Thu, 29 Jun 2023 09:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 08/10] net: mdio: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <ZJwCcWgi0d6kEepI@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 17:50, Russell King (Oracle) wrote:
> Hi,
>
> I think you missed one case:
>
>          if (mdio_id == XGENE_MDIO_RGMII) {
>                  mdio_bus->read = xgene_mdio_rgmii_read;
>                  mdio_bus->write = xgene_mdio_rgmii_write;
>                  mdio_bus->priv = (void __force *)pdata;
>
> This cast using __force is also not required.
>
> On Wed, Jun 28, 2023 at 10:45:17AM +0800, wuych wrote:
>> @@ -211,7 +211,7 @@ static void xgene_enet_wr_mdio_csr(void __iomem *base_addr,
>>   static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
>>   				int reg, u16 data)
>>   {
>> -	void __iomem *addr = (void __iomem *)bus->priv;
>> +	void __iomem *addr = bus->priv;
>>   	int timeout = 100;
>>   	u32 status, val;
>>   
>> @@ -234,7 +234,7 @@ static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
>>   
>>   static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
>>   {
>> -	void __iomem *addr = (void __iomem *)bus->priv;
>> +	void __iomem *addr = bus->priv;
>>   	u32 data, status, val;
>>   	int timeout = 100;
> These probably cause Sparse to warn whether or not the cast is there.

Hi, Russell King,

I didn't notice this Sparse warning.
Should I remove this cast although it cause Sparse warning?
>
> Given that in this case, bus->priv is initialised via:
>
>                  mdio_bus->priv = (void __force *)pdata->mdio_csr_addr;
>
> I think the simple thing is to _always_ initialise mdio_bus->priv
> to point at pdata, and have xgene_xfi_mdio_*() always do:
>
> 	struct xgene_mdio_pdata *pdata = bus->priv;
> 	void __iomem *addr = pdata->mdio_csr_addr;
>
> The extra access will be dwarfed by the time taken to perform the
> access.
>
> This change should be made with a separate patch and not combined with
> the patch removing the casts in xgene_mdio_rgmii_*().
yeah, this change is great.
I will send a separate patch as your suggestion If we can ignore Sparse 
warning.
Thanks for your suggestion!

wuych

>
> Thanks.
>
