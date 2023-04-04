Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19E6D7038
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjDDWkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbjDDWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:40:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A612709;
        Tue,  4 Apr 2023 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0i5Bbc0w1weKrsu/nCnfi4mk4ZRljnGWA85xKD9hlPA=; b=lsZG54/x6E1Vjm+EI4lpfbSaJz
        8qBe2Ju/q4siAqopbhW4VcR/AZyS+LkNNiy6t1TlLtd2iF3cMlfRJ0dOYIkYqsJsowaX4bDXe8/ta
        7NVzIaZLue9ohS7XE681YuluVUsWZ+tPorFNe/3aLA41bCUYiaOGmNf76Vig1iCCIqbLts08sEaVV
        dzrVEtGp/7YUv/dZw2kfpJqcfNvFSJFrFcheuveqVYul3aM1Ib2X3Gpd4GbSw1RxzI3Oi4OhPdmdB
        mDSqs02IdQqVXWGSi06cT9gERet0/fJ1w6zu5deGsInC60v/lvQDMpO4SorbA0/q/hm8X3BV4aZeT
        f8ptMkNw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjpKK-002yQQ-2n;
        Tue, 04 Apr 2023 22:40:32 +0000
Message-ID: <c3718ac3-3dd1-2273-68ef-3d2923778ab7@infradead.org>
Date:   Tue, 4 Apr 2023 15:40:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Build regressions/improvements in v6.3-rc4
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com>
 <20230327072641.3591802-1-geert@linux-m68k.org>
 <eb55ca34-ca71-ed19-dae2-6e5e87c170@linux-m68k.org>
 <CADVatmNHYar6tR3r9q42vZR5fsqZeeDb8LEmmBcrrOwhA7HpmQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADVatmNHYar6tR3r9q42vZR5fsqZeeDb8LEmmBcrrOwhA7HpmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/23 14:16, Sudip Mukherjee wrote:
> On Mon, 27 Mar 2023 at 08:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> On Mon, 27 Mar 2023, Geert Uytterhoeven wrote:
>>> JFYI, when comparing v6.3-rc4[1] to v6.3-rc3[3], the summaries are:
>>>  - build errors: +9/-1
>>
>>    + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45
>>
>> sh4-gcc11/sh-allmodconfig
>> seen before
>>
>>    + error: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>    + error: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>    + error: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>    + error: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>    + error: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>    + error: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>    + error: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>    + error: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>
>> sparc64-gcc11/sparc-allmodconfig
>> seen before
> 
> Tried sparc64 allmodconfig with gcc-11 and did not see the parport
> errors with 6ab608fe852b ("Merge tag 'for-6.3-rc4-tag' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux").
> Is it still being seen?
> 

This is reported at  http://kisskb.ellerman.id.au/kisskb/buildresult/14905002/

I still see it on sparc32 using gcc-12.2.0.

The compiler info vs. the sparc-allmodconfig is confusing IMO.
I am compiling with sparc-linux, not sparc64-linux.

The .config file says:
# CONFIG_64BIT is not set
CONFIG_SPARC=y
CONFIG_SPARC32=y


-- 
~Randy
