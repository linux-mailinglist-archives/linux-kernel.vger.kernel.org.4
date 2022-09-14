Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295625B804D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiINE1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiINE1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:27:05 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6748E99;
        Tue, 13 Sep 2022 21:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663129624; x=1694665624;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=R2PH0fTVkuZ36bSfVulz65uK785hLVcgLYUgevvR8/g=;
  b=jVXGsKdTeaKQ+yzTL4XKqCT3YIyFSksmTGjmJ+Gc6bnsdAmHUoK9J069
   38pANd1mIf3prYZ1dwwUMLzAZrrtt+wOg0z1/cYFnZpRu2OM9wdsGEFUt
   QiWDPDqTX2y2qtFj3L8G5opmH9qdoRaYwn8HtB78KBEba3SWWGZEqAfJO
   k=;
X-IronPort-AV: E=Sophos;i="5.93,313,1654560000"; 
   d="scan'208";a="259225995"
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 04:26:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id 11E6C2015D4;
        Wed, 14 Sep 2022 04:26:44 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 14 Sep 2022 04:26:40 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 14 Sep 2022 04:26:40 +0000
Received: from [192.168.159.232] (10.85.143.178) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 14 Sep 2022 04:26:37 +0000
Message-ID: <bdb73546-f309-60dd-3c40-d749654228fe@amazon.com>
Date:   Wed, 14 Sep 2022 07:26:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-21-farbere@amazon.com>
 <YxowTBIODMLjf1Ek@smile.fi.intel.com>
 <581a4a0b-8e0e-b7a2-f873-77ed74b54e96@amazon.com>
 <3b121ab4-dd64-68b3-ee89-8571b5d3651e@amazon.com>
 <YyC3hsNhbQGIlReU@smile.fi.intel.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <YyC3hsNhbQGIlReU@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2022 8:01 PM, Andy Shevchenko wrote:
> On Tue, Sep 13, 2022 at 05:40:16PM +0300, Farber, Eliav wrote:
>> On 9/13/2022 4:06 PM, Farber, Eliav wrote:
>
> ...
>
>> It seems like debugfs_attr_write() calls simple_attr_write() and it uses
>> kstrtoull(), which is why it fails when setting a negative value.
>> This is the same also in v6.0-rc5.
>>
>> debugfs_attr_read() on the other hand does show the correct value also
>> when j is negative.
>
> Which puzzles me since there is a few drivers that use %lld.
> Yeah, changing it to
>
>        ret = sscanf(attr->set_buf, attr->fmt, &val);
>        if (ret != 1)
>                ret = -EINVAL;
>
> probably can fix that. Dunno if debugfs maintainer is okay with this.
>
> P.S. This needs revisiting all format strings to see if there are no 
> additional
> characters, otherwise that needs to be addressed first, if feasible.

I was thinking of making such a correction:

-       ret = kstrtoull(attr->set_buf, 0, &val);
+       if (attr->set_buf[0] == '-')
+               ret = kstrtoll(attr->set_buf, 0, &val);
+       else
+               ret = kstrtoull(attr->set_buf, 0, &val);

and when I tested the change it worked, but then I noticed this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/libfs.c?h=v6.0-rc5&id=488dac0c9237647e9b8f788b6a342595bfa40bda

According to this, it previously used simple_strtoll() which supports
negative values, but was changed to use kstrtoull() to deliberately
return '-EINVAL' if it gets a negative value.

So I’m not sure debugfs maintainers will be okay with a fix that
basically reverts the commit I mentioned.
Hence, what do you suggest to do with my commit?
Is it ok to leave it as it is today?

--
Thanks, Eliav
