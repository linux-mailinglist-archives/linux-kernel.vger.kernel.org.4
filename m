Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8D5FEE13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJNMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJNMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:42:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE354E09AA;
        Fri, 14 Oct 2022 05:42:26 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpmGj1Zj9z6HJRq;
        Fri, 14 Oct 2022 20:41:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 14:42:23 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 13:42:22 +0100
Date:   Fri, 14 Oct 2022 13:42:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/5] regulator: Add devm helpers for get and
 enable
Message-ID: <20221014134221.000055de@huawei.com>
In-Reply-To: <fc3c70d7-1787-5f7c-7394-2f93b42d56b0@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
        <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
        <20221009132421.6e472385@jic23-huawei>
        <fc3c70d7-1787-5f7c-7394-2f93b42d56b0@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 12:24:51 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan,
> 
> On 10/9/22 15:24, Jonathan Cameron wrote:
> > On Thu, 6 Oct 2022 19:17:39 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> On Thu, Oct 06, 2022 at 05:36:52PM +0300, Matti Vaittinen wrote:  
> >>> A few regulator consumer drivers seem to be just getting a regulator,
> >>> enabling it and registering a devm-action to disable the regulator at
> >>> the driver detach and then forget about it.
> >>>
> >>> We can simplify this a bit by adding a devm-helper for this pattern.
> >>> Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()  
> >>
> >> ...
> >>  
> >>> (cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)  
> >>
> >> Not sure:
> >>   - why this is in the commit message
> >>   - what it points to, since
> >> $ git show b6058e052b842a19c8bb639798d8692cd0e7589f
> >>   fatal: bad object b6058e052b842a19c8bb639798d8692cd0e7589f  
> > 
> > These are now upstream in Linus' tree and in my testing branch.
> > I'd not normally advocate working on top of that (because I rebase it), but
> > if it is useful for this series go ahead.  
> 
> Thanks for the explanation :)
> 
> This series will conflict with my fixup series for triggered-buffer 
> attributes. Hence I though I might combine these two series into one if 
> I need to respin the fixup series. I thought of using the v6.1-rc1 when 
> it is out. (I think the 6.1-rc1 should not be that far away)
> 
> OTOH, I just read your another mail which told that there will be one 
> more driver which will conflict with the fixup coming in during this 
> cycle. If that driver lands in your tree before the fix - then I guess I 
> need to rebase the fixup series (and maybe this too) on top of your tree 
> + add conversion of this new driver. I don't think that would be the 
> testing branch though(?)
I'll be messy, but the majority of that fix series will need to go
in during rcX..

The last patch (refactoring one) will need to wait until those are
upstream and have worked there way around to be in my togreg branch
(I usually rebase that tree only after pull requests, but given this
 is going on I may do an earlier pull request than normal.)

That refactoring patch will probably need to cover the new driver.
I can do that as a fixup whilst applying it though once we get that far.

Jonathan

> 
> Yours
> 	-- Matti	
> 

