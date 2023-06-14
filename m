Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030FF730613
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjFNRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFNRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:30:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E3BACE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:30:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48BC01FB;
        Wed, 14 Jun 2023 10:30:47 -0700 (PDT)
Received: from [10.57.85.233] (unknown [10.57.85.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55223F71E;
        Wed, 14 Jun 2023 10:30:01 -0700 (PDT)
Message-ID: <570d8563-6e28-8d11-2d3c-83cbda9ac4a3@arm.com>
Date:   Wed, 14 Jun 2023 18:29:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] perf/arm-cmn: Add sysfs identifier
Content-Language: en-GB
To:     John Garry <john.g.garry@oracle.com>, will@kernel.org
Cc:     mark.rutland@arm.com, ilkka@os.amperecomputing.com,
        renyu.zj@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1686588640.git.robin.murphy@arm.com>
 <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
 <5efa7af9-6347-a409-370c-b8b78b3d53aa@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5efa7af9-6347-a409-370c-b8b78b3d53aa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-14 15:55, John Garry wrote:
> On 12/06/2023 18:16, Robin Murphy wrote:
>> Expose a sysfs identifier encapsulating the CMN part number and revision
>> so that jevents can narrow down a fundamental set of possible events for
>> calculating metrics. Configuration-dependent aspects - such as whether a
>> given node type is present, and/or a given node ID is valid - are still
>> not covered, and in general it's hard to see how userspace could handle
>> them, so we won't be removing any data or validation logic from the
>> driver any time soon, but at least it's a step in a useful direction.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> FWIW, Reviewed-by:
> John Garry <john.g.garry@oracle.com>
> 
> However a comment, below.
> 
>> ---
>>   drivers/perf/arm-cmn.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 8cf4ed932950..088dc5c690a4 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -1199,19 +1199,31 @@ static ssize_t arm_cmn_cpumask_show(struct 
>> device *dev,
>>   static struct device_attribute arm_cmn_cpumask_attr =
>>           __ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
>> -static struct attribute *arm_cmn_cpumask_attrs[] = {
>> +static ssize_t arm_cmn_identifier_show(struct device *dev,
>> +                       struct device_attribute *attr, char *buf)
>> +{
>> +    struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>> +
>> +    return sysfs_emit(buf, "%03x%02x\n", cmn->part, cmn->rev);
> 
> I don't think that this gives the "0x" prefix, right? It is just an 
> encoded string of values, so not strictly necessary or even appropriate, 
> I suppose.

Indeed that was deliberate, to emphasise that this is still a string (of 
hex digits), not a single numeric value.

> However, if userspace wants to improve scalability by, say, matching an 
> event for all revs of a model, userspace (perf tool) needs to be 
> programmed in the JSONs somehow since we have no delimiter.

FWIW I don't mind the original idea of prefix-based string matching - it 
feels like about the right level of compromise to give a sufficient 
degree of expressiveness without having to go as far as inventing some 
whole crazy expression syntax for interpreting values - so all I've 
really done here vs. Jing's patch is streamline the string itself. I'm 
still assuming the same general usage model, such that a hypothetical 
JSON encoding of, say, the hnf_snp_sent_cluster event could have:

	"Compat": {"43603","43c??"} /* CMN-650 r2p0, all CMN-700 */

(array and explicit wildcard syntax made up for the sake of implied 
debate - not sure if I have a particular preference either way)

If we assume that over time, events are more likely to be added and 
stick around than to be removed, then what might be handy would be the 
additional notion of something like a "CompatExcept" property to 
describe negative matches. That could definitely scale better for the 
NOT_CMN600 and CMN_650ON cases in the current driver logic. Then what 
would also be really cool would be the ability to define events 
hierarchically based on other aliases - e.g. the driver could just 
expose a general "sbsx" sysfs alias as "type=5,eventid=?" if SBSX nodes 
are present, then the detailed events like "sbsx_rd_req" are somehow 
encoded in JSON as the equivalent of "sbsx,eventid=1" such that they're 
hidden if not relevant - at which point I think I could actually punt 
all the fiddly bits out of driver code into JSON :D

Cheers,
Robin.
