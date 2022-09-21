Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B85BFDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiIUMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIUMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:19:45 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8478D111E;
        Wed, 21 Sep 2022 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663762785; x=1695298785;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=SXknPu8p6P5GCLG1lEIpEVchBPddZY3bhhgvk01JZqw=;
  b=r1ZR6Mf8bM16yiGwJiQxa/xL0W8TPGxrYWhNo58SVu884g76mWSwplvC
   L4GXOPG2Fy4qlPFzvT9mP/woWKA6k63JLBlzRJg55p12/FB61O6nn3HxB
   pkxwQhmmnOoJ6xHgOJzT5cXmJT8NuymBY7eGgsmdfpL5hyutulk60Gnzs
   k=;
X-IronPort-AV: E=Sophos;i="5.93,333,1654560000"; 
   d="scan'208";a="261732813"
Subject: Re: build failure of next-20220921 due to 94c025b6f735 ("hwmon: (mr75203)
 modify the temperature equation according to series 5 datasheet")
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 12:19:45 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com (Postfix) with ESMTPS id BA32D4546C;
        Wed, 21 Sep 2022 12:19:43 +0000 (UTC)
Received: from EX19D014UEC002.ant.amazon.com (10.252.135.185) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 21 Sep 2022 12:19:43 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D014UEC002.ant.amazon.com (10.252.135.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 21 Sep 2022 12:19:43 +0000
Received: from [192.168.151.220] (10.85.143.178) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 21 Sep 2022 12:19:41 +0000
Message-ID: <04cb2084-7023-2a0b-ef31-ce25a54132cf@amazon.com>
Date:   Wed, 21 Sep 2022 15:19:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>
References: <Yyr7c4IjjcnWZ3mr@debian>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yyr7c4IjjcnWZ3mr@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2022 2:54 PM, Sudip Mukherjee (Codethink) wrote:
> Hi All,
>
> The builds of arm, mips and xtensa allmodconfig have failed to build
> next-20220921.
>
> Error from xtensa and mips build:
> ERROR: modpost: "__udivdi3" [drivers/hwmon/mr75203.ko] undefined!
> ERROR: modpost: "__divdi3" [drivers/hwmon/mr75203.ko] undefined!
>
> Error from arm build:
> ERROR: modpost: "__aeabi_uldivmod" [drivers/hwmon/mr75203.ko] undefined!
> ERROR: modpost: "__aeabi_ldivmod" [drivers/hwmon/mr75203.ko] undefined!
>
> git bisect pointed to 94c025b6f735 ("hwmon: (mr75203) modify the 
> temperature equation according to series 5 datasheet")
>
> I will be happy to test any patch or provide any extra log if needed. 

I just provided two potential fixes.
One is an incremental patch on top of the previous series of patches.
Second, I reworked it into the original series and modified two of the
patches.
You are recipient to both.

--
Regards, Eliav
