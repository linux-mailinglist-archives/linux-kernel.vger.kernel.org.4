Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8A73A890
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjFVSs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVSsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:48:24 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348979B;
        Thu, 22 Jun 2023 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tspVlKiufErAuZI5tAA+g+cp7j3kNkooAReOKETi6MU=;
        t=1687459703;x=1687549703; 
        b=uJd3me7L4v+AzqbaYkR2nMFRsLmLqDJWI7XKS1GIunNUpONHW54nFj8kSpdRPxTckSQXqjKUVWItD1i3MBAjvUfL9nN1NMPpKWNzGAnRN0SkCDWnUs7C3Fm6MlUzRLpdZHgmlmUpma1OD0JPC0kAA0FuPNmq7to1Ig1EzttBKFsq/cHgBkkXSWL9uPgzG+22Sg2/hw00fXfHOjRFG6ffDeU++dLXZmI3xkInlb6WDeN7Z8gTjqx74a/cd3Sz18hyqkrX0HLbKfEAJQf7HFZHZb746e8Jajau8SCOIftNBifHveYND9hoHTvf86nBEiLsAy4toLn18zjiMM72BrCpWA==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qCPLw-0000fO-DS; Thu, 22 Jun 2023 21:48:21 +0300
Message-ID: <054c180f-9fab-c849-0971-1b8b9a89fb9b@inbox.ru>
Date:   Thu, 22 Jun 2023 21:48:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Content-Language: en-US
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Hancock <robert.hancock@calian.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230622175200.74033-1-fido_max@inbox.ru>
 <MN0PR12MB59539C6540FA6B673A1A7FF8B722A@MN0PR12MB5953.namprd12.prod.outlook.com>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <MN0PR12MB59539C6540FA6B673A1A7FF8B722A@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC4BAA77128DB4F5EE54F063C3FC487264182A05F538085040BB9AF963AB5826EAD8188C53122D70189A04EE8BA4A6E59B59063A2A363346FA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D77100FFB2844417EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063750965CC5CDB672DE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89CEC63685002E57A8AA15541D1F7D18E6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE73AFA331E307B52169FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BCF01C05423B8DB1BA471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C468D16C903838CAB43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A57C8A090D94BBFB9D1B629E33631D82B04C94E5F37702D570F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B35CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2FDC0E0109DA09B129727C36B62EE47C0B555BC7EAAC10B732570450FEC1CD0DE5D0AE1B90484215B05B57073EAFDF979A740917082118EF665E68E0CAD544E0A866A4CE178307D84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB41c+mu8Ac+ygcXZAujKzA==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BE4706A62D392446E65809945BE328CEB98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2023 21:43, Pandey, Radhey Shyam wrote:

>> DMA detection will fail if axinet was started before (by boot loader,
> 
> :%s/axinet/axienet/g
Sorry about that. I will fix it in v3.

> 
>> boot ROM, etc). In this state axinet will not start properly.
>> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to
>> detect
>> 64 DMA capability here. But datasheet says: When DMACR.RS is 1
>> (axinet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
>> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
>> to this register to detect DMA will not work.
>> So move axinet reset before DMA detection.
>>
>> Fixes: 04cc2da39698 ("net: axienet: reset core on initialization prior to MDIO
> 
> Is this fixes tag correct ? I think the failure is introduced after
> f735c40ed93c net: axienet: Autodetect 64-bit DMA capability?

Yes of course. I will fix it in v3.

