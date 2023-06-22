Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3174073A8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjFVTXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFVTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:23:29 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AAD1BC;
        Thu, 22 Jun 2023 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Om+Xr8yRexJCLHu1hxd99Ji7xno9XNQw6owZX28mhnM=;
        t=1687461808;x=1687551808; 
        b=cEIgy51Eprtm4X4VZdpBDaxWXJ4+5jHmMl3E8WUs+BPmCg3Dan9ejkApYVbPSqs2VRlBuq6FQRCuEZDQMLri04DgQ7MgY8uJzx1ujo8H72xSB9b0v3HmKwi5QqaiZW1x+lfBCaF41D4EsaSKo0Q+gs1FUdODoFD2uxZIm+l81lqfte0mlNjxCRgLLIC2iC+SfFNDM80dOfglOZbTBwRWRWs+2omAr2EpBRApvPKAql5vSNePfEo+r1VZdW91Suf27073azBK4YBLOvVmkMARw/nTkVgHFXszmka9I9CHmW6a4TtakmP6CdpR/XRSh01wc0O8niUG2UXnHJ3gkwe/Xw==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qCPtt-0003TJ-Kt; Thu, 22 Jun 2023 22:23:26 +0300
Message-ID: <a2cd7370-6c42-724d-fe03-49debc566346@inbox.ru>
Date:   Thu, 22 Jun 2023 22:23:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        Robert Hancock <robert.hancock@calian.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230622175200.74033-1-fido_max@inbox.ru>
 <5e8b2552-0dcb-4683-ad52-57a239517d2d@lunn.ch>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <5e8b2552-0dcb-4683-ad52-57a239517d2d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC1DBB6C3EBD37189F9BC62CEBB67BAF8A182A05F5380850403258C9FA208D724610142D0DB1B5D7F0575FFE594294C4AC19D91D11F48CD097
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75644E22E05AA81AEB287FD4696A6DC2FA8DF7F3B2552694A4E2F5AFA99E116B42401471946AA11AF176DF2183F8FC7C096563325B6E011C88F08D7030A58E5AD1A62830130A00468AEEEE3FBA3A834EE7353EFBB55337566A9936E6FE0861A5F1616DD0D70475E44C52B2C90215B27BF1DF9E95F17B0083B26EA987F6312C9EC1E561CDFBCA1751FE5D25F19253116ADD2E47CDBA5A96583C09775C1D3CA48CFA367EA73E0D98AAD117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7E5BB3157BB985B7D9FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F83C798A30B85E16BC6EABA9B74D0DA47B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5A4F497FE6661844862276DA408752E30C26229E55F4A188EF87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B35CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D349BD6FB698A487E7E094AFA276AF82413CCD828C32CDAD344AFB53921F1BF8D83B183A3BB7B8F993B1D7E09C32AA3244CF80DBFE6BE5E6B522FED0485023C89EFBBA718C7E6A9E042DEC19D624CAB3C42B6C6411D86935C892AB2189BCAD71E73D640157F23F2FFE137E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB41c+mu8Ac9TXCqZz+JycA==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B7EDD820EFB4FC1A754E68F56748F2DAA98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
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



On 22.06.2023 22:18, Andrew Lunn wrote:
>> +	/* Reset core now that clocks are enabled, prior to accessing MDIO */
>> +	ret = __axienet_device_reset(lp);
>> +	if (ret)
>> +		goto cleanup_clk;
>> +
>>   	/* Autodetect the need for 64-bit DMA pointers.
> 
> I would say the comment is now not fully correct. It probably should
> be extended to include 64 bit DMA.

Fixed in v4
