Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535C85E6326
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIVNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIVNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:05:46 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F448E6A3E;
        Thu, 22 Sep 2022 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663851946; x=1695387946;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=jde3lYab1cgEqi5kdLQjfYu3v4kqudgRikp9yDWVE8U=;
  b=QJhtmfftJPUIkpCaiVm1P9XylPESbOuG//+iDFUqYdIpR2ML/qD+1VjQ
   fzzsTv1zVRirj7eGePZlvdovyicLVwFuuK7OUhM7nkAMnHbuJFtrpuwSV
   p5h0X0qsp0oV9QPxzkQT1Hx2cGCh5xFMKTHKyui31hCW3at41a8oLF02Y
   M=;
X-IronPort-AV: E=Sophos;i="5.93,335,1654560000"; 
   d="scan'208";a="227801747"
Subject: Re: linux-next: Fixes tag needs some work in the hwmon-staging tree
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:05:30 +0000
Received: from EX13D43EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com (Postfix) with ESMTPS id 5E53745444;
        Thu, 22 Sep 2022 13:05:29 +0000 (UTC)
Received: from EX19D044EUA001.ant.amazon.com (10.252.50.83) by
 EX13D43EUA002.ant.amazon.com (10.43.165.108) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 22 Sep 2022 13:05:28 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D044EUA001.ant.amazon.com (10.252.50.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 22 Sep 2022 13:05:27 +0000
Received: from [10.220.236.67] (10.220.236.67) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 22 Sep 2022 13:05:25 +0000
Message-ID: <4e81be21-b027-cdaf-be69-423e32976269@amazon.com>
Date:   Thu, 22 Sep 2022 16:05:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220922202039.211372a6@canb.auug.org.au>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220922202039.211372a6@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2022 1:20 PM, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>  103974b11176 ("hwmon: (mr75203) fix undefined reference to `__divdi3'")
>
> Fixes tag
>
>  Fixes: 381a86c545f1 ("hwmon: (mr75203) modify the temperature 
> equation according to series 5 datasheet")
>
> has these problem(s):
>
>  - Target SHA1 does not exist
>
> Maybe you meant:
>
> Fixes: 94c025b6f735 ("hwmon: (mr75203) modify the temperature equation 
> according to series 5 datasheet")


Correct, it should be 94c025b6f73.

--
Regards, Eliav


