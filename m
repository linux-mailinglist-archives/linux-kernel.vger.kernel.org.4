Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB7272597A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjFGJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjFGJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:05:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94FE82137;
        Wed,  7 Jun 2023 02:04:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28CFEAB6;
        Wed,  7 Jun 2023 02:05:28 -0700 (PDT)
Received: from [10.57.25.235] (unknown [10.57.25.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2612D3F587;
        Wed,  7 Jun 2023 02:04:40 -0700 (PDT)
Message-ID: <95530dcc-aad3-cf4d-f5cc-9ba504ac7abf@arm.com>
Date:   Wed, 7 Jun 2023 10:04:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH V5 5/6] coresight: platform: acpi: Ignore the absence of
 graph
To:     Mike Leach <mike.leach@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        scclevenger@os.amperecomputing.com,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230529062511.52016-1-anshuman.khandual@arm.com>
 <20230529062511.52016-6-anshuman.khandual@arm.com>
 <CAJ9a7ViWiSuabBVPASHO-MDs9z7wGSLuCLCpPezFrh6p3AOgyA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7ViWiSuabBVPASHO-MDs9z7wGSLuCLCpPezFrh6p3AOgyA@mail.gmail.com>
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

On 07/06/2023 09:58, Mike Leach wrote:
> HI Ansuman,
> 
> On Mon, 29 May 2023 at 07:26, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Some components may not have graph connections for describing
>> the trace path. e.g., ETE, where it could directly use the per
>> CPU TRBE. Ignore the absence of graph connections
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-platform.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 475899714104..c4b4fbde8550 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -692,8 +692,12 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>>
>>          pdata->nr_inport = pdata->nr_outport = 0;
>>          graph = acpi_get_coresight_graph(adev);
>> +       /*
>> +        * There are no graph connections, which is fine for some components.
>> +        * e.g., ETE
>> +        */
>>          if (!graph)
>> -               return -ENOENT;
>> +               return 0;
>>
> 
> Should we not determine if it is valid for a particular component not
> to have a graph connection?
> Prior to this patch an incorrectly configured ETMv4 - which must have
> a graph would return an error, after this it will fail silently

I think it doesn't call for a failure. The ETM could still
be probed but is not usable. We provide enough information via the
sysfs, i.e., connection links, which should be sufficient for the
user to detect this case. Also, this change is inline with what
we do for ETMv4 with DT.

Suzuki

