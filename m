Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8716741D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF2BP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF2BP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005626A1;
        Wed, 28 Jun 2023 18:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7550E61475;
        Thu, 29 Jun 2023 01:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF505C433C9;
        Thu, 29 Jun 2023 01:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688001355;
        bh=H2ZbtIFJn89TCbWBNHVAXlla+3W0j5uuDXKtgBQEZoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=InL33tJZP0PP0Ig6CRbztEW/5Cffp7qnPiOCKmytyJJpANe96apu16Zbo/TmcppYx
         e5tDF5lrFDADUWIl6x+c3DiSmrVTImG6x/VnuNP9njF4Q6IVo1V2P9/rNS+26auOaY
         eejhfR6pu6Eg1Xq69K/pAMmsXwfUwLXC5dRcxMuE/vxAz9bsLxe0uAbk4Ey8CHXeGZ
         rELBqckcrkBXgphzMMl6T1AJcI5Q8sX+YGgKscaoSg2zCpiOc7Q48gUhxcr0DX8LiW
         4sNrDjA0DCkN1lfd70DpAQnG+Mg3kFU7J18Fu+Flc6uAxYcVBylJXaS/UkaBaOVwIa
         ilPgf6EXeTFog==
Message-ID: <6a9d6824-b1f1-c711-2e24-cac48eefd9e9@kernel.org>
Date:   Thu, 29 Jun 2023 10:15:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, Min Li <min15.li@samsung.com>,
        hch@lst.de
Cc:     axboe@kernel.dk, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, willy@infradead.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230628083839.GA26606@lst.de>
 <CGME20230628090918epcas5p3a5463f0fc421e435a363192e40d3f649@epcas5p3.samsung.com>
 <20230628170734.2960-1-min15.li@samsung.com>
 <f8a4e061-22ab-e30b-586b-3a569f5a379a@huaweicloud.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f8a4e061-22ab-e30b-586b-3a569f5a379a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 10:04, Yu Kuai wrote:
> Hi,
> 
> 在 2023/06/29 1:07, Min Li 写道:
>> On Mon, Jun 28, 2023 at 04:48:36PM +0000, Christoph Hellwig  wrote:
>>> They are long long in the UAPI, which is weird but has been that way
>>> for a long time.  So I think we need checks for negative values
>>> before they are shifted and converted to a sector_t.
>>
>> Do you mean that we need to check if p.start and p.length are negative?
>>
> 
> Perhaps this patch will make sense.
> 
> https://lore.kernel.org/all/20230525072041.3701176-1-zhongjinghua@huawei.com/

+ adding to it the logical block size alignment checks.

> 
> Thanks,
> Kuai
>> Thanks for your reply
>>
>> Min li
>> .
>>
> 

-- 
Damien Le Moal
Western Digital Research

