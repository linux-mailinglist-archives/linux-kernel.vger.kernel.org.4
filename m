Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84A167DAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjA0A54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjA0A5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:57:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A7358F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Sq5aYXXfyyNpc0H8ii9+zFl0bV7CjQBLfTj9RTjmMaU=; b=r9oNogqGQ3zoHfy5mD6OCWHMkN
        kWlUwBMzgs1gzLt+Jfp61AjtYzHG5mu66XzdJC/kUbVyL/hCKp40MqE8caRRe5CZiIP2Bf+FL8tTd
        37kWEsVAfOdPyVw/gZ5GCQ4BLZuP+h2NakTAM3is2m9K8lZSeV1EN0rqtMpVnNe6lj2IHUGTWpwMj
        c2a9JTIiij1xjg6v5ugitaARBG8LcbMvq6ucKV9f6qHsrV61Fbg5FveQQsgdDQo4ZD4uagPp666we
        3GDhCDHu9UlhIJ0bFGGOwRLbM5TayvHg8oooPDI9b1azc1aRAPcymyJEKjqTXf5LOqrI20wFJuGJi
        4H9h/pkw==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLD3Q-00D2Ym-D9; Fri, 27 Jan 2023 00:57:21 +0000
Message-ID: <70ab19eb-c41a-980d-46f6-2bb02163974e@infradead.org>
Date:   Thu, 26 Jan 2023 16:57:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command line
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, djakov@kernel.org
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com>
 <dca84e05-e376-c593-74fa-37c58f30767a@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <dca84e05-e376-c593-74fa-37c58f30767a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/23 10:51, Dave Hansen wrote:
> On 1/26/23 08:43, Georgi Djakov wrote:
>> From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>

  
>> +static int __init early_disable_dma32(char *buf)
>> +{
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	if (!strcmp(buf, "on"))
>> +		disable_dma32 = true;
>> +
>> +	return 0;
>> +}
>> +early_param("disable_dma32", early_disable_dma32);
> 
> Ick.  Is there no way to do this other than a cross-arch copy/paste?

I think that using __setup() instead of early_param() would allow that.

-- 
~Randy
