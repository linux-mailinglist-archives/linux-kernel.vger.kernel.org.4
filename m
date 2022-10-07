Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DE5F79DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJGOnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJGOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB90FC1F2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ADC861D43
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ED5C433C1;
        Fri,  7 Oct 2022 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665153777;
        bh=LBsdgEgWGpm3BX3s8qMCaLUB5qE654Y2XMy0ZXH5+cM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m7TJGIa8lsAeUcDbWY0TlC6+PGoEMwf1fZOKXsuYT21bCZOi3Etx13yGYm4hEczqj
         VpfmYuQpYOJ3cw9ktDuQNTbN0dDM0yXCAqg/CNKv7FaFYRs4QxG5XLCF+8kdOQIOIs
         4x/EPYsMHFOw/osPEOoiatG5/7n6WRUnWhfdZnen4XyRPCQ15zO9KMUSr197ZaNgxe
         xUHBQBDa8yYge54bQaXAe2NjJ9BfMQeg/LaMLtN0iNtvQ0bnbqMriSn2kgeZpkzd39
         ah4u6Ejsy85omxpweY4cpU6altgpKgsQeY4cDKmVn/zUC6a1UvDja97aKlj61ro7EM
         PHyHZrvgxhBqA==
Message-ID: <de559e06-7391-b28e-2d59-50abc68c3034@kernel.org>
Date:   Fri, 7 Oct 2022 22:42:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: correct i_size change for atomic
 writes
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20221004171351.3678194-1-daeho43@gmail.com>
 <b1ca9048-99c5-1ab4-fb77-5fe0bbc6d4de@kernel.org>
 <CACOAw_zXTHzc5mjPchGNXkgnswZLxLEBfRoEztB7VFdV-rtpwQ@mail.gmail.com>
 <4d7f250d-19c0-acd0-dde4-752f95c5fc2a@kernel.org>
 <CACOAw_weAbKWs6qi5x9t2=L41tVUV+CKjG-BGn1gOOtgjdWYug@mail.gmail.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_weAbKWs6qi5x9t2=L41tVUV+CKjG-BGn1gOOtgjdWYug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/7 22:22, Daeho Jeong wrote:
>>
>> Fine to me.
>>
>> But another question is, now it allows GC to migrate blocks belong
>> to atomic files, so, during migration, it may update extent cache,
>> once largest extent was updated, it will mark inode dirty, but after
>> this patch, it may lose the extent change? thoughts?
>>
> 
> Oh, I missed that case. Maybe we could prevent updating the i_size of
> atomic files in f2fs_update_inode() while allowing inode dirtying.

Agreed. :)

Thanks,
