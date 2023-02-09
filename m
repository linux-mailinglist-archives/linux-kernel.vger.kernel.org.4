Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04E690E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBIQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:40:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1A260BA1;
        Thu,  9 Feb 2023 08:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=TPnFqSRYi6nU6j8+VOenjna6W8SZ533wxZK25k9qttI=; b=ESfsIAVbNO0KOfYk5WhEaOC73f
        tIxFZeirv21u31x8lVoMrfhxvmi90l7Z3hh3MfswEZFcCz+Gep8juffbrDWaxGvxt2eHl1g5e7Qbj
        nr+11m+sBtXupCeKsGHKyiUG1SPwHXiPU57nDmlUKUHsr0KKaoBZPBa2Raqot6mVoglVy0gawtSxx
        hFKziTdHuLfyaimDNK9glsRFnJTricHCwznjDhtW7f9Mrdo8gyJbCY1vn4HidoiAWM6L9lipuZSPc
        YQUYDqTaFLrzCXDrzjqCyGqmBAeoJjIdz2uvm95ecXL9g1Heg2ncum7BpZ9R4KdDM5qqx4wxqs/JZ
        xsO9uPMw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ9yD-002SZc-14; Thu, 09 Feb 2023 16:40:25 +0000
Message-ID: <c7c7c482-0400-5ebb-9d1e-4c15c701e894@infradead.org>
Date:   Thu, 9 Feb 2023 08:40:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] m68k: /proc/hardware depends on PROC_FS
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
References: <20230209010825.24136-1-rdunlap@infradead.org>
 <CAMuHMdVi8YQbf3HiCXkcvcttoqQdDJ+Zn5fdTanvwR3Hi9g+MA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdVi8YQbf3HiCXkcvcttoqQdDJ+Zn5fdTanvwR3Hi9g+MA@mail.gmail.com>
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



On 2/9/23 05:54, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Thu, Feb 9, 2023 at 2:08 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> When CONFIG_PROC_FS is not set, there is a build error for an unused
>> function. Make PROC_HARDWARE depend on PROC_FS to prevent this error.
>>
>> In file included from ../arch/m68k/kernel/setup.c:3:
>> ../arch/m68k/kernel/setup_mm.c:477:12: error: 'hardware_proc_show' defined but not used [-Werror=unused-function]
>>   477 | static int hardware_proc_show(struct seq_file *m, void *v)
>>       |            ^~~~~~~~~~~~~~~~~~
>>
>> Fixes: 66d857b08b8c ("m68k: merge m68k and m68knommu arch directories") # v3.0
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for your patch!
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v6.3 branch.
> 
>> --- a/arch/m68k/Kconfig.devices
>> +++ b/arch/m68k/Kconfig.devices
>> @@ -18,6 +18,7 @@ config HEARTBEAT
>>
>>  # We have a dedicated heartbeat LED. :-)
>>  config PROC_HARDWARE
>> +       depends on PROC_FS
> 
> I'll move the "depends ..." line below the "bool ..." line while applying,
> as that's where the dependencies are usually listed.

Agreed. I don't know how I did it like that.

>>         bool "/proc/hardware support"
>>         help
>>           Say Y here to support the /proc/hardware file, which gives you


-- 
~Randy
