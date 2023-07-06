Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC674A7B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjGFX3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGFX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:29:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5FAB9;
        Thu,  6 Jul 2023 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f9sZIfUgYTr1DblItYc9uUM3d2fixVGsi3Vy+MfgJ/g=; b=hufHYw9k12YtMfcjZHguIfXDWh
        D9cWiHR5YXNFBYQ2P+Brw1tgKlwxfeErZiV+r59wykNfxUue0MEw8C7rKaFZn378Cqwkmz1uyYBgr
        SvkkgKRJs0mBzLOo85lH+V8+FKkokYxxOLZEiR2B9LTZ2o3U+qtQ9eXY4/xbRZsMP2LbBKgPR0skL
        rARH3/LCpYXU1GEcr8SiAZYAyJVwFxRzKAQDq6MHNxKBSllYdaxduBFROGQh8J6LbESLRi4ybBw92
        HFJ9qAixDodzOITTIkUUld9ppsd/fD8Mbp9ZH/ObjlJlMzb85eBCWr6ItFyO1ssvT+erC9vg9reZZ
        QMvn9qDw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHYPf-002xpz-1q;
        Thu, 06 Jul 2023 23:29:27 +0000
Message-ID: <e2be9c20-4e0c-7880-ba0d-11b8f2c5404c@infradead.org>
Date:   Thu, 6 Jul 2023 16:29:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: Tree for Jul 4
 (drivers/net/ethernet/microchip/lan743x_main.c)
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Network Development <netdev@vger.kernel.org>,
        UNGLinuxDriver@microchip.com,
        Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>
References: <20230704134336.4c5d1772@canb.auug.org.au>
 <725bf1c5-b252-7d19-7582-a6809716c7d6@infradead.org>
 <ZKc2DLIroSNi4tgs@corigine.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZKc2DLIroSNi4tgs@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 7/6/23 14:45, Simon Horman wrote:
> + Pavithra Sathyanarayanan
> 
> On Tue, Jul 04, 2023 at 03:25:31AM -0700, Randy Dunlap wrote:
>>
>>
>> On 7/3/23 20:43, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do *not* add any v6.6 related stuff to your linux-next included
>>> branches until after v6.5-rc1 has been released.
>>>
>>> Changes since 20230703:
>>>
>>
>> on s390:
>>
>> s390-linux-ld: drivers/net/ethernet/microchip/lan743x_main.o: in function `lan743x_phy_open':
>> drivers/net/ethernet/microchip/lan743x_main.c:1514: undefined reference to `fixed_phy_register'
>>
>>
>> Full randconfig file is attached.
> 
> Thanks for the config.
> 
> I bisected this problem and it appears to be introduced by:
> 
> 624864fbff92 ("net: lan743x: add fixed phy support for LAN7431 device")
> 
> I wonder if the following change in dependencies is an appropriate fix for
> this problem.

Yes, that change fixes the build error. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> 
> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> index 24c994baad13..329e374b9539 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -46,7 +46,7 @@ config LAN743X
>         tristate "LAN743x support"
>         depends on PCI
>         depends on PTP_1588_CLOCK_OPTIONAL
> -       select PHYLIB
> +       select FIXED_PHY
>         select CRC16
>         select CRC32
>         help
> 

-- 
~Randy
