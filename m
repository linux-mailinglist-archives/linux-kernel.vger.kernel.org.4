Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71106EA8AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjDUKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDUKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:55:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E9259016;
        Fri, 21 Apr 2023 03:55:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 026D11480;
        Fri, 21 Apr 2023 03:55:59 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BA0C3F587;
        Fri, 21 Apr 2023 03:55:13 -0700 (PDT)
Date:   Fri, 21 Apr 2023 11:55:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     Robbie King <robbiek@xsightlabs.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>
Subject: Re: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Message-ID: <20230421105510.hjmyt4l3rpx36mhl@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230314111135.16520-1-lihuisong@huawei.com>
 <20230327113326.dgrb5ainl6mv7wr5@bogus>
 <570a6f6d-87cb-48ca-3bbc-cd1221bfa88c@huawei.com>
 <7ef4eec4-2cfb-6f66-a9b9-9c130a1b71d8@huawei.com>
 <AS8P193MB2335FA58943B305F97D2BACCCA9A9@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
 <57c537d8-6728-2ffc-3421-accd79c1eddf@huawei.com>
 <AS8P193MB2335F1954BC345575A2C8829CA999@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
 <3d8e8817-12b9-62bc-4c04-34d8822d366f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d8e8817-12b9-62bc-4c04-34d8822d366f@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:21:54AM +0800, lihuisong (C) wrote:
> 
> 在 2023/4/14 21:48, Robbie King 写道:
> > Sorry for the delay.  I ran my simple stress test against the patch set and
> > saw no issues.  For the record it is by no means a thorough regression, but it
> > has illuminated issues in the past.
> Thanks for your testing.
> > 
> > The test itself uses a "heartbeat" module in the SCP firmware that generates
> > notifications at a programmable interval.  The stress test is simply generating
> > these heartbeats (SCP to AP notifications) while also generating protocol version
> > queries (AP to SCP).  The notifications are sequence numbered to verify none are
> > lost, however SCP to AP notification support does not support SCP generating
> > notifications faster than the AP can process them, so the heartbeat rate must be
> > reasonably slow (on the order of 10s of millliseconds).
> I understand your concern. I think this doesn't get int the way of what we
> are doing.
> 
> My stress tests were also run in type3 and type4 concurrent scenarios.
> There were two drivers using type3 to send command looply on platform.
> In the firmware terminal window,
> there were two channels for type4 to generate notifications from platform at
> the 1ms(even shorter) interval.
> I didn't find anything issues in this stress after running a couple of
> hours.
> 
> @Robbie King and @Sudeep, what do you think of my test?
>

IMO if there is a need to have this driver changes upstream, then it is good
enough test as it is the best that can be done at this time. We can always fix
the bugs or extend to new use-cases in the future.

Since it is merge window next week, it is quite late now. But sometimes
Rafael picks up additional patches late. So please post v3 even if there
are no changes with my reviewed-by and Robbie's tested-by so that I can ask
Rafael to pick it up.

-- 
Regards,
Sudeep
