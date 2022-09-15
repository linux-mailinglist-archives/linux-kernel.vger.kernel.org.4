Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9985B974C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIOJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIOJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:17:57 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829060C2;
        Thu, 15 Sep 2022 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663233476; x=1694769476;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=COIrX3KPTvWnUKYe5h2JMwqR3QiO2e7tgieg9Gealwg=;
  b=R7veDclHTmzOdq+h15P8Jlow1E2jlO0c8GRlTusmQ7wSVNFyVt/2R+67
   QTv9Yjg2HDvKkNEw+Li2vj3kkYhmD3e2YYUNLhVo1EXnvXDPJOgyostXV
   6NRGZL0vZpuoQA70eBisaGEBPibvJyFsXqxWJfIS8zPS6UJISHspqs64D
   w=;
X-IronPort-AV: E=Sophos;i="5.93,317,1654560000"; 
   d="scan'208";a="259711586"
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 09:17:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com (Postfix) with ESMTPS id 534FEC0A5C;
        Thu, 15 Sep 2022 09:17:34 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 15 Sep 2022 09:17:32 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 15 Sep 2022 09:17:32 +0000
Received: from [192.168.161.125] (10.85.143.179) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 15 Sep 2022 09:17:29 +0000
Message-ID: <fa5e1e3b-b040-c7d7-a93f-700552c7b252@amazon.com>
Date:   Thu, 15 Sep 2022 12:17:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
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
 <bdb73546-f309-60dd-3c40-d749654228fe@amazon.com>
 <YyGfvzlCu9qgtgA0@smile.fi.intel.com> <YyHfHSIz9F+1SGnX@smile.fi.intel.com>
 <YyHgce96oZYJsHZn@smile.fi.intel.com>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <YyHgce96oZYJsHZn@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2022 5:08 PM, Andy Shevchenko wrote:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you can confirm the sender 
> and know the content is safe.
>
>
>
> On Wed, Sep 14, 2022 at 05:03:09PM +0300, Andy Shevchenko wrote:
>> On Wed, Sep 14, 2022 at 12:32:47PM +0300, Andy Shevchenko wrote:
>> > On Wed, Sep 14, 2022 at 07:26:36AM +0300, Farber, Eliav wrote:
>> > > On 9/13/2022 8:01 PM, Andy Shevchenko wrote:
>> > > > On Tue, Sep 13, 2022 at 05:40:16PM +0300, Farber, Eliav wrote:
>> > > > > On 9/13/2022 4:06 PM, Farber, Eliav wrote:
>
> ...
>
>> > > > > It seems like debugfs_attr_write() calls simple_attr_write() 
>> and it uses
>> > > > > kstrtoull(), which is why it fails when setting a negative 
>> value.
>> > > > > This is the same also in v6.0-rc5.
>> > > > >
>> > > > > debugfs_attr_read() on the other hand does show the correct 
>> value also
>> > > > > when j is negative.
>> > > >
>> > > > Which puzzles me since there is a few drivers that use %lld.
>> > > > Yeah, changing it to
>> > > >
>> > > >        ret = sscanf(attr->set_buf, attr->fmt, &val);
>> > > >        if (ret != 1)
>> > > >                ret = -EINVAL;
>> > > >
>> > > > probably can fix that. Dunno if debugfs maintainer is okay with 
>> this.
>> > > >
>> > > > P.S. This needs revisiting all format strings to see if there 
>> are no
>> > > > additional
>> > > > characters, otherwise that needs to be addressed first, if 
>> feasible.
>> > >
>> > > I was thinking of making such a correction:
>> > >
>> > > -       ret = kstrtoull(attr->set_buf, 0, &val);
>> > > +       if (attr->set_buf[0] == '-')
>> > > +               ret = kstrtoll(attr->set_buf, 0, &val);
>> > > +       else
>> > > +               ret = kstrtoull(attr->set_buf, 0, &val);
>> > >
>> > > and when I tested the change it worked, but then I noticed this 
>> commit:
>> > >
>> > > 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/libfs.c?h=v6.0-rc5&id=488dac0c9237647e9b8f788b6a342595bfa40bda
>> > >
>> > > According to this, it previously used simple_strtoll() which 
>> supports
>> > > negative values, but was changed to use kstrtoull() to deliberately
>> > > return '-EINVAL' if it gets a negative value.
>> > >
>> > > So I’m not sure debugfs maintainers will be okay with a fix that
>> > > basically reverts the commit I mentioned.
>> > > Hence, what do you suggest to do with my commit?
>> > > Is it ok to leave it as it is today?
>> >
>> > Meanwhile asking is not a problem, at least we will know for sure.
>> > And yes, leave it as is, but point to the thread where you asking
>> > the clarification.
>>
>> For the record:
>>
>> $ git grep -n -A1 -w DEFINE_DEBUGFS_ATTRIBUTE | grep ');' | sed 
>> 's,.*\(".*%.*"\).*,\1,' | sort | uniq -c
>>   1 "%08llx\n"
>>   5 "0x%016llx\n"
>>   5 "0x%02llx\n"
>>   5 "0x%04llx\n"
>>  13 "0x%08llx\n"
>>   1 "0x%4.4llx\n"
>>   3 "0x%.4llx\n"
>>   4 "0x%llx\n"
>>   1 "%1lld\n"
>>  40 "%lld\n"
>>   2 "%lli\n"
>> 129 "%llu\n"
>>   1 "%#llx\n"
>>   2 "%llx\n"
>>
>> means that sscanf() should work and fix the issue. You may even 
>> propose a patch
>> as a starter for a discussion.


I proposed a patch with the fix you suggested.

--
Thanks, Eliav

