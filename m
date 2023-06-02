Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED91B720741
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjFBQSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbjFBQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:18:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71741E40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:18:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9241B1063;
        Fri,  2 Jun 2023 09:12:47 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2D223F7BD;
        Fri,  2 Jun 2023 09:12:00 -0700 (PDT)
Message-ID: <50399db6-f7f0-8e9d-cc13-fe4fbc0287e1@arm.com>
Date:   Fri, 2 Jun 2023 17:11:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [RFC PATCH] coresight: etm4x: Match all ETM4 instances based on
 DEVARCH and DEVTYPE
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        james.clark@arm.com, anshuman.khandual@arm.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        frowand.list@gmail.com, linux@armlinux.org.uk
References: <20230525095807.1379811-1-suzuki.poulose@arm.com>
 <CAJ9a7Vi2qwjrL13dUC7AvYpvMwyn9w0nL=OaiDmXt3-+aiL9NA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7Vi2qwjrL13dUC7AvYpvMwyn9w0nL=OaiDmXt3-+aiL9NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 16:59, Mike Leach wrote:
> HI Suzuki,
> 
> On Thu, 25 May 2023 at 10:58, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> All,
>>
>> This is an RFC patch to allow all ETM4 instances to be detected via AMBA driver
>> without having to add the PIDs to the list. The AMBA driver already supports
>> checking the DEVTYPE and DEVARCH registers for CoreSight components. This patch
>> adds a pid,mask value that is bound to match all PIDs (with PIDR2.JEDEC field
>> mandated to be RA0).
>>
>> With this patch, we wouldn't need to add the PIDs for newer CPUs to be able to
>> use them. An entry in the device tree is all we need. The only side effect of
>> this patch is :
>>      If a DT description exists for an ETM and the CPU ETM has an erratum, the
>>      driver may still probe it and use it. But then the DT shouldn't have
>>      described it in the first place.
>>
> 
> Don't think this is an issue.
> 
> In the previous mechanism, with an ETM with an erratum - or indeed
> need of some arch specific extension as we allow now - someone would
> have added the PID - tested it, hit the erratum, and would have to
> investigate and fix according to what is required. This changes
> nothing in terms of handling errata on ETM hardware - it just removes
> the add PID step.
> 
> For new ETM that work out of the box, this saves time re-spinning the
> driver every time - which is kind of what we want from device tree!
> 
> I'd go for it.
> 
> Moreover, the same principle could be added to the CTI drivers -
> though these are generally pretty standard anyway (i.e. based on
> Coresight Soc 600/400), so may be no pressing need for this right now.
> 

Thank you Mike, I will send it as a proper patch.

Cheers
Suzuki


