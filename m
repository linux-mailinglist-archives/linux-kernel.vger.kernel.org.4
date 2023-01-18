Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B60672383
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjARQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjARQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:37:26 -0500
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556EB41B7E;
        Wed, 18 Jan 2023 08:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=pHXxnxZLzOGoKxbma4bKofhzaLgd2KSaWI6G8LAFKCg=; b=D4G5mLw+vwzwIOtrf1Ik8JoPVb
        2jbbsXY3/bX+/4wa7wCfjjYhxdEVTfZRFk2yZk8asjo6lqYlmEQcU3Il3N/bHStI1WGv79kb0wMQr
        QeSq/VNcd92/MszNpWMr/oi3Sz20vUleuLuVSQNRwU4kJqkalHBd0wwd8YkKSzGJlxfbfm94P2gSE
        3b5WfF4vRJsYjg2q2CU0iPgKnlPGUeUEMaDpwS0zoXeuJ9bUN56IcZh+G2O089NfH1jz6gyA/xfnF
        8sMTklEtAtLuUpujibgv6m7jDbuJAeRBLcDXiIHxWGKjpWfVHnhFu8ckkvUi5vIq/We0qiSV21jDE
        fO2VrIgQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pIBQu-000EdM-4s; Wed, 18 Jan 2023 17:37:04 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pIBQt-00077t-QB; Wed, 18 Jan 2023 17:37:03 +0100
Message-ID: <64406c4f-c9da-b434-360b-1050ff685d2d@metafoo.de>
Date:   Wed, 18 Jan 2023 08:37:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/2] iio: core: Replace
 iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
 <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
 <Y8gVDs0UoiHqCRsM@smile.fi.intel.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <Y8gVDs0UoiHqCRsM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26785/Wed Jan 18 09:42:40 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 07:49, Andy Shevchenko wrote:
> On Wed, Jan 18, 2023 at 07:22:30AM -0800, Lars-Peter Clausen wrote:
>> On 1/17/23 23:48, Andy Shevchenko wrote:
>>> None of the current users is using gaps in the list of the items.
>>> No need to have a specific function for that, just replace it by
>>> library available __sysfs_match_string().
>> Hm, I specifically remember adding this for a driver where there were gaps.
>> One of the DACs. But it might be that the driver itself never made it
>> upstream.
> I have checked all modules that have struct iio_enum and/or ("or" probably may
> not happen) IIO_ENUM() in them.
>
> It might be that I missed something.
I checked too, I can't find it either. The driver probably never made it 
upstream.
