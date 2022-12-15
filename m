Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7064D549
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 03:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLOCVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 21:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOCVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 21:21:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D177B554D4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:21:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE0E618CC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BE3C433D2;
        Thu, 15 Dec 2022 02:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671070903;
        bh=0iptShXCJSeoqtzCgX7jkKKJ6AltXplKHWxJjv7ZfSU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h8ApMoY4UCDFGj96nVZyZuCwCu6XJQ1VaOst3z1I6TELfMyQSThXcbqKUujpUMjhH
         ZqKCcS6uaLYbzRE6dbhYfo6cDci7/QDFARjcG5c5xOWnc3NFzsvmhml3tarWXwA8dH
         eo1EUGE/4rQe2uTQlw99JsVA2lmWSNFb2aeHZ20BvUZvgbTiY7peYVYLFRhipS/FND
         +/S+yZLpQj9lluurWUyqz8wgCrCwygeT+XVHQnkx57RPzXhzkiIcxYl7rHxuagcegd
         +WTrBl0R777uK2Ifh6SR4Q2bsY1YN4AYjqHhfCup7mk9HJM2mkb+6aZHW/h85vv8Mz
         +6ouq1VA6PA7Q==
Message-ID: <acc94cef-3d37-d1a3-21cc-3a514be3291e@kernel.org>
Date:   Thu, 15 Dec 2022 10:21:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: fix iostat parameter for discard
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <ddf243c9-f557-7f11-1964-8d2324f84092@kernel.org>
 <20221213115454.14885-1-frank.li@vivo.com> <Y5jOTL66ph3Nq/Hr@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y5jOTL66ph3Nq/Hr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/14 3:11, Jaegeuk Kim wrote:
> On 12/13, Yangtao Li wrote:
>>> What do you think of extending this function to support io_counts?
>>>
>>> void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
>>> 			enum iostat_type type, unsigned long long io_bytes,
>>> 			unsigned long long io_counts)
>>
>> Support to have extra io_count.
>>
>> But I don't think there is any need to add additional parameters to f2fs_update_iostat.
>> IIUC, each call to f2fs_update_iostat means that the corresponding count increases by 1,
>> so only the internal processing of the function is required.
>>
>> BTW, let's type out the iocount of the additional record in the following way?
>>
>> time:           1670930162
>> [WRITE]
>> app buffered data:      4096(1)
> 
> How about giving in another columns with additional stats like avg. len/call or max. len?

Maybe call is better? w/ it we can calculate avg. len/call.

Thanks,

> 
> app buffered data:      4096	1
> 
>>
>> Thx,
>> Yangtao
