Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB539710113
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbjEXWlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjEXWlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:41:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D0990;
        Wed, 24 May 2023 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hX1KbZVI7WlSKqZln6S3tgkwGmtBBzyb+4HKGxZ8Nno=; b=FNjtgEcEv3Wx6JqykxSTh1pRH+
        LEZ2F98NfKPi2Qc1J7AN5JWPvbB9jFo0iHzabFVzgHH9vto4dYIyTXWBm3mgGkQu5RGHLxYSJNkXP
        6jtUxjb9+W1lJyh5SwjlF1CedxDCjw0jDeU3lw0JbUtwc8VI1kbmMa/JO20tIwyLpNSEJiVIiE8+t
        X9KbJvD5tAbn11feiTjy+gZRlkfaRRRfVPHpIWvqYRhqStRc+urdVZVWx8B63tBRv024j8U7OrMyF
        BQ32oGOSGPGXMMTnzo0wtoPFixCBiM7sYAhAZsyNYm73dtDUMFx5KnHBYm6ychZK6O9rjy7hoUQzR
        1LCzfuXw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1xAU-00EpSy-0v;
        Wed, 24 May 2023 22:41:18 +0000
Message-ID: <8af1acf1-64a5-5868-9702-0929fe279761@infradead.org>
Date:   Wed, 24 May 2023 15:41:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
References: <mhng-e172207d-d67d-46ab-ab95-85f0a854ace2@palmer-ri-x1c9a>
 <65124759-26de-4111-bc54-545a00620d75@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <65124759-26de-4111-bc54-545a00620d75@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 23:23, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 03:29, Palmer Dabbelt wrote:
>> On Tue, 23 May 2023 17:22:20 PDT (-0700), rdunlap@infradead.org wrote:
>>> On 5/23/23 06:07, Alexandre Ghiti wrote:
>>>> On 23/05/2023 04:28, Randy Dunlap wrote:
>>>>> On 5/19/23 03:42, Alexandre Ghiti wrote:
>>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section .text LMA [00000000000f09d4,00000000033562ab]
>>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps section .data LMA [000000000041a000,00000000075bffd7]
>>>>>>>
>>>>>>> I'll check this one too which seems to be related to kernel/pi introduction.
>>>>>>
>>>>>> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have limited size, hence the overlap, so no fix for this one. Is there a way to exclude this config from randconfig?
>>>>> Does this mean exclude XIP_KERNEL or something else from randconfigs?
>>>>
>>>>
>>>> I meant excluding XIP_KERNEL from randconfigs: it has very strict constraints regarding what can/can't be enabled then it needs human intervention to make sure the error above does not happen. So I would not bother testing this in randconfigs if possible.
>>>
>>> I can exclude it from my randconfig builds, but I don't know of a way to exclude it from randconfig builds in general (i.e., for everyone).
>>
>> Arnd had suggested a trick related to menus that would result in 
>> randconfig never enabling some config.  It'd suggested for 
>> CONFIG_NONPORTABLE, but we didn't use it because it'd reduce randconfig 
>> coverage.
>>
>> Maybe we should add a CONFIG_VERYSPECIAL of some sort and hide things 
>> like XIP behind it (maybe M-mode too)?
> 
> I usually add 'depends on !COMPILE_TEST', that excludes it from most
> build bots.

XIP_KERNEL already has "depends on !COMPILE_TEST", since April of 2021.

-- 
~Randy
