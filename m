Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057E46079DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJUOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJUOpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:45:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D5816A2;
        Fri, 21 Oct 2022 07:44:55 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29LEiZKD036346;
        Fri, 21 Oct 2022 09:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666363475;
        bh=zhUQ/gRdkp8LxqXF4f6PJGmUgaZpmB9M36LtuE30bQk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=KGul0+0UUsKtDPgazav4OzDdU8Y93bXzMm2sIJAJ2mtV980IX8dJcORWvP4cX2Aww
         yqCu3yjdlcJxmhsXqoOKQYSkeArBfpYh5Xcjo5kkPEfOSF9DkdlJ0NFj5sv/bLNqUp
         6v3xE+FlguHsJgeJSln12l45hI6u0F6qf727FZKo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29LEiZHk013182
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Oct 2022 09:44:35 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 21
 Oct 2022 09:44:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 21 Oct 2022 09:44:35 -0500
Received: from [10.250.33.68] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29LEiYFU015889;
        Fri, 21 Oct 2022 09:44:34 -0500
Message-ID: <f8b2a45e-cb6c-60ec-047e-6934dd4c4e1d@ti.com>
Date:   Fri, 21 Oct 2022 09:44:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] kbuild: Allow DTB overlays to built from .dtso named
 source files
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20221014151302.27641-1-afd@ti.com>
 <CAL_Jsq+O0_i3k_3S=W6C-n+ZE7GRKKhOQ7HR54QutmMJq54a_Q@mail.gmail.com>
 <CAMuHMdV2euzPQL35AqBsyeQTkMbkeFz4rk48wtyX7Hd6Lz5d-g@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAMuHMdV2euzPQL35AqBsyeQTkMbkeFz4rk48wtyX7Hd6Lz5d-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 1:52 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Fri, Oct 21, 2022 at 12:47 AM Rob Herring <robh+dt@kernel.org> wrote:
>> On Fri, Oct 14, 2022 at 10:13 AM Andrew Davis <afd@ti.com> wrote:
>>> Currently DTB Overlays (.dtbo) are build from source files with the same
>>> extension (.dts) as the base DTs (.dtb). This may become confusing and
>>> even lead to wrong results. For example, a composite DTB (created from a
>>> base DTB and a set of overlays) might have the same name as one of the
>>> overlays that create it.
>>>
>>> Different files should be generated from differently named sources.
>>>   .dtb  <-> .dts
>>>   .dtbo <-> .dtso
>>>
>>> We do not remove the ability to compile DTBO files from .dts files here,
>>> only add a new rule allowing the .dtso file name. The current .dts named
>>> overlays can be renamed with time. After all have been renamed we can
>>> remove the other rule.
>>
>> There was a patch from Geert converting everything. I'd rather not
>> support both ways.
> 
> Actually that was a patch from Frank?
> 

That series looks to have stalled?

It won't be easy to convert all the files in one go, especially with series
in-flight with both names, not sure how we avoid having both extensions for
at least one cycle. Plus having both allowed lets rename the existing files
in a more granular/bisectable way.

Thanks,
Andrew
