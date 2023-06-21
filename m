Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07B8738481
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjFUNKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjFUNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:10:14 -0400
X-Greylist: delayed 449 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 06:10:10 PDT
Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D95199A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8UoH+idalnUpQmcaZ1lY5Un8Qxa8aRoGfhmVKfM+sXg=;
        t=1687353010;x=1687443010; 
        b=umMZJVMIXi6yXlr3SJK3KJHyafR71pXllhBl+wIUeR8Fay01aEsV6j4xGrF8DHceHkDeEL9osdVXHIcGF2WI2T9H8uKRjYZqPj7o3maT5ZLrX+zOeIGoPoO+xnnUzcvBcVWx+z7nK35hPAj1hwKhI5zJJGHaO3vfz7syOr8A06l8CH267BWqJW4Z2LorpKR6SmiddXfoA0ww0IfRl17V5Y1k/EubB1CrmG8cqrfZDkQUU9jaA/ifDxmUX/+J3BFgSGy05kqLbfrQJbgYrdsEKwiNSUiRd0o0oVQcP+DtvVZanAmWFik/i/6TIF4p2LJlS0Sa/6qdZOTNOyJE8W8nIg==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qBxb5-0007PP-0T; Wed, 21 Jun 2023 16:10:08 +0300
Message-ID: <0273daf8-7eeb-17bc-2246-6b29ae27a99d@inbox.ru>
Date:   Wed, 21 Jun 2023 16:10:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] net: axienet: Move reset before DMA detection
Content-Language: en-US
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230621112630.154373-1-fido_max@inbox.ru>
 <MN0PR12MB5953C2C8784514E9270787DAB75DA@MN0PR12MB5953.namprd12.prod.outlook.com>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <MN0PR12MB5953C2C8784514E9270787DAB75DA@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDCFB14F17D0E9EAA49C0FEF2B22CA0AFAD182A05F538085040B44ECD70E72B90A1C7353EAF187005552EA5ED39D79F3D75C08906BD2F7D89B7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70D278D70F8433719EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375ABF1810CDE7D0E9EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA33A0F5DF476A30A0971C869230D0F2B120879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0CB629EEF1311BF91D2E47CDBA5A96583C09775C1D3CA48CF4964A708C60C975A117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7461A70166B335A6C9FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F83C798A30B85E16BCE5475246E174218B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5C7665F0965BF676094CE825CDB77D22BEF5B8AB05602438DF87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA588CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD112376CCE7498FB9CBFCB5D401BB18F622B7175CF24EB457EF6F00A15DAB1FE0FDE042572883009C17492877F82D9B8D901DEB25329734293F040D49FDC2017464E0F6E1F48538C02C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lxRFo++Or8dyQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BA32DCDD1994A7535DD38DE2913B0E5CE98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.2023 15:23, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Maxim Kochetkov <fido_max@inbox.ru>
>> Sent: Wednesday, June 21, 2023 4:57 PM
>> To: netdev@vger.kernel.org
>> Cc: Maxim Kochetkov <fido_max@inbox.ru>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; David S. Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simek,
>> Michal <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: [PATCH 1/1] net: axienet: Move reset before DMA detection
>>
>> DMA detection will fail if axinet was started before (by boot loader, boot
>> ROM, etc). In this state axinet will not start properly.
>> So move axinet reset before DMA detection.
> 
> Please provide more detail on the failing testcase. In which scenario we are
> seeing DMA detection failure? What is error log . Is it random?
> 

XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to 
detect 64 DMA capability here. But datasheet says: When DMACR.RS is 1 
(axinet is in enabled state), CURDESC_PTR becomes Read Only (RO) and is 
used to fetch the first
descriptor. So iowrite32()/ioread32() trick to this register is failed.
