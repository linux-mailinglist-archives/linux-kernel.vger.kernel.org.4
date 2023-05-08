Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681F6FB69C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEHTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjEHTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:06:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459330D0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Y+ibpDLg5jE2BiPolUWS6HiosTxx6XTt8WmlptxH7e8=; b=e3vnN8DhWcLDtX0DPJg3JpHZ6j
        L4k8Kfga4n/aprH8X4QKVnQEmHuUf/paZUnuQ4Vaa/7lN6uN/dvShEyjy5T6khHvRdwZHEpF9t1uc
        7aJzQc+o3H60y4aYHk1Une3Sf2eXSrqYxfhsHri6WVidLFLKCk+ct2/7m3UT0wd7qI9ONVbqUxxP5
        lF3yQE+V6NmGI02ld4VE2gayMccpBqXNtXadL7ZOiupEEPded2GfD+nTix4Qabuu/1AkAtuxyOfaD
        u4A6N5gc59RxQadtLbnHTi7HR1cSn3zj3D6fpHugW30KFsL30qM3FENc2Fxp2uZNVHOoLr/EAIjQL
        JsdW7hAQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw6Bm-001Aya-2O;
        Mon, 08 May 2023 19:06:26 +0000
Message-ID: <6c1124dc-c4fd-62d1-f1ea-b0a3d0b36fbb@infradead.org>
Date:   Mon, 8 May 2023 12:06:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH] workqueue: fix cast warnings on i386
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20230429044506.24843-1-rdunlap@infradead.org>
 <CAJhGHyBjTykZ3d-D-M_1eD5J8QgNcPZcCsCMnqbBcvRoEceSuQ@mail.gmail.com>
 <4143448b-fb4f-860d-da67-b864e5b33020@infradead.org>
 <eabf596d-8e19-484d-87b6-11222a5832eb@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <eabf596d-8e19-484d-87b6-11222a5832eb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/23 06:41, Arnd Bergmann wrote:
> On Mon, May 1, 2023, at 06:42, Randy Dunlap wrote:
>> On 4/30/23 21:37, Lai Jiangshan wrote:
>>> Both the type of the "data" and WORK_STRUCT_WQ_DATA_MASK are
>>> "unsigned long", so I don't think "(data & WORK_STRUCT_WQ_DATA_MASK)"
>>> needs to be converted to "unsigned long".
>>>
>>>         WORK_STRUCT_FLAG_MASK   = (1UL << WORK_STRUCT_FLAG_BITS) - 1,
>>>         WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
>>>
>>> This simple fix might hide the real problem.
>>
>> Thanks for replying.
>>
>> Do you have any suggestions for how to eliminate these warnings on i386
>> and ARCH=um SUBARCH=i386?
> 
> I'm pretty sure the patch I posted earlier is the correct one, see
> https://lore.kernel.org/all/20230117164041.1207412-1-arnd@kernel.org/
> 

Thanks for the reply. Your patch looks good. I appreciate the
explanation.

> Sorry I never followed up on this after the initial post, I have
> a backlog of patches that I sent out as build fixes but that for
> some reason have not made it in.

I know how that goes. I have quite a few as well.

-- 
~Randy
