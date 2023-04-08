Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49B46DB8AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 05:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDHD7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 23:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDHD66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 23:58:58 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01FDD330
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 20:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equiv.tech;
        h=from:subject:references:mime-version:content-type:in-reply-to:to:cc:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=org; bh=9fXf41jSfeH8npS2SnXtOfP5uik6JpmwKRQ6ipNjZhg=;
        b=mMH1/aZlfkigrD7oqZwotDQVo/b4Gps6GU01Cot3KtnizHwlc1YMxH8vHOuUfqdnuCGC
        SGn+ixiHfYx6Bu2utFfKxDrVH2vcBFJQhabWRRsDqH0GXi020AkfwMnGjmS+a/ErGhtW1Y
        4uBWi3DmmdxfeSR2TygKP3Kzcy8nlBWo4=
Received: by filterdrecv-7457b4c9b5-zkl2v with SMTP id filterdrecv-7457b4c9b5-zkl2v-1-6430E67E-6
        2023-04-08 03:58:54.271893053 +0000 UTC m=+3903964.849135075
Received: from localhost (unknown)
        by geopod-ismtpd-6 (SG) with ESMTP
        id XJJ8jxPtQIa9xN2G75nh4A
        Sat, 08 Apr 2023 03:58:53.421 +0000 (UTC)
Date:   Sat, 08 Apr 2023 03:58:54 +0000 (UTC)
From:   James Seo <james@equiv.tech>
Subject: Re: [PATCH v2] hwmon: add HP WMI Sensors driver
Message-ID: <ZDDmewAgPi/4jpcX@equiv.tech>
References: <20230406152321.42010-1-james@equiv.tech>
 <2257deba-187b-82d2-181c-f1fed08a2ff7@gmx.de>
 <ZC+sgnuy5bssD1DN@vb-22lts>
 <e256d281-49a5-2d9a-7def-fd68e177e926@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e256d281-49a5-2d9a-7def-fd68e177e926@roeck-us.net>
X-SG-EID: =?us-ascii?Q?1X41iaRO4wVP+tFXGLuxpQ0yxxMDhGIesR5UcsYKVengQKgidLJSXwOMZlPQwP?=
 =?us-ascii?Q?WsEyzZr62PnJ8E17NJhhMO0lG3ycUBe69Gwm5XP?=
 =?us-ascii?Q?UVOGIf7x=2FfnTSULP9ZVcTc=2FVMlX41+BWNk1aAfb?=
 =?us-ascii?Q?WMk78u45ClkgQzWopc48ZH4Rs=2F0BNxmbi4xb48H?=
 =?us-ascii?Q?kKMGsqU1rOoQAuH3VBeCplEmsM7UjOQdMUeGpbv?=
 =?us-ascii?Q?LQyLTJ9ltU0BCbICnMdVUatvXGu3HcSvvCD+OT?=
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
X-Entity-ID: Y+qgTyM7KJvXcwsg19bS4g==
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On Fri, Apr 07, 2023 at 05:54:48AM -0700, Guenter Roeck wrote:
> On 4/6/23 22:39, James Seo wrote:
>> Hi,
>> 
>>> is it guaranteed that faulty sensors wont become operational later?
>>> Also filtering out such sensors would make the support for the hwmon_temp_fault and
>>> hwmon_fan_fault attributes meaningless.
>> 
>> Good point. I can't be certain, but the MOF does seem to imply that
>> sensors can indeed be faulty on just a temporary basis.
>> 
> 
> Your current code would explicitly exclude faulty fans from being listed,
> which does not exactly sound like a good idea.

True enough. I recall my reasoning being that faulty sensors would
still be visible in debugfs. I should have seen the problem then.

>> I'll filter out only the sensors that are "Not Connected" at probe
>> time. My thinking is, even if these might turn into connected sensors
>> later, that would mean the user is e.g. hot-plugging a fan (!), and
>> keeping them could result in a large number (~10 on my Z420) of
>> pointless extra channels. And this would also match the behavior of
>> HP's official utility.
>> 
> Ultimately that is an implementation decision. Are the sensors hot-pluggable ?

HP's WMI object specification allows sensors to be hot-pluggable in
principle. I can't definitively say more than that due to a lack of
test hardware (that whitepaper I referenced is from 2005, after all).

So I think the answer is that it depends on the board and the WMI
implementation. That's also what I meant in my reply to Armin when I
said that I couldn't be certain whether faulty sensors can recover.

But I take your point that the driver should be able to handle it if
the board can.

> If so, how does HP's utility handle the insertion or removal of a sensor (fan) ?

HP's utility just pretty-prints a snapshot of what is in WMI at the
moment when the user clicks a button, and then only for the sensors
that were connected when the utility was first started. It doesn't do
anything special to handle insertion or removal beyond that.

> Either case, it is ok with me if disconnected sensors are not listed.
> Not listing faulty sensors seems like a bad idea, though.
> 
> Guenter

Acknowledged. Faulty sensors will be listed in the next version.

Thanks for reviewing. Further suggestions or concerns from you or
anyone else reading this are both welcome and appreciated.

James
