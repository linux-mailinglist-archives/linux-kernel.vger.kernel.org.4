Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A4725CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjFGLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjFGLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:10:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E13691BF1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:10:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 815A3AB6;
        Wed,  7 Jun 2023 04:10:20 -0700 (PDT)
Received: from [10.57.25.235] (unknown [10.57.25.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020193F6C4;
        Wed,  7 Jun 2023 04:09:33 -0700 (PDT)
Message-ID: <2d6d0012-7331-e2f9-dd97-ad661179b393@arm.com>
Date:   Wed, 7 Jun 2023 12:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH] coresight: etm4x: Match all ETM4 instances based on
 DEVARCH and DEVTYPE
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        linux@armlinux.org.uk
References: <20230605133031.1827626-1-suzuki.poulose@arm.com>
 <CAJ9a7VjypLQr3qUA5=BMvvdzS=-eCEjeO7azxK5AKJ4TTM1YSA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VjypLQr3qUA5=BMvvdzS=-eCEjeO7azxK5AKJ4TTM1YSA@mail.gmail.com>
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

On 07/06/2023 11:43, Mike Leach wrote:
> On Mon, 5 Jun 2023 at 14:30, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Instead of adding the PIDs forever to the list for the new CPUs, let us detect
>> a component to be ETMv4 based on the CoreSight CID, DEVTYPE=PE_TRACE and
>> DEVARCH=ETMv4. This is already done for some of the ETMs. We can extend the PID
>> matching to match the PIDR2:JEDEC, BIT[3], which must be 1 (RA0) always.

Fix RA0 => RAO

>>
>> Link: https://lkml.kernel.org/r/20230317030501.1811905-1-anshuman.khandual@arm.com
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: frowand.list@gmail.com
>> Cc: linux@armlinux.org.uk
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>> +#define PIDR2_JEDEC                    BIT(3)
>> +#define PID_PIDR2_JEDEC                        (PIDR2_JEDEC << 16)
>> +/*
>> + * Match all PIDs in a given CoreSight device type and architecture, defined
>> + * by the uci.
>> + */
>> +#define CS_AMBA_MATCH_ALL_UCI(uci)                                     \
>> +       __CS_AMBA_UCI_ID(PID_PIDR2_JEDEC, PID_PIDR2_JEDEC, uci)
>>
>>   /* extract the data value from a UCI structure given amba_id pointer. */
>>   static inline void *coresight_get_uci_data(const struct amba_id *id)
>> --
>> 2.34.1
>>
> Reviewed by:- Mike Leach <mike.leach@linaro.org>
> 

Thanks Mike, I have queued this, with the above fix:

[01] https://git.kernel.org/coresight/c/ab5ca6268afc


