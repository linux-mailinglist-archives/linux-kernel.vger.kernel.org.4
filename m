Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231A6CB1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjC0WoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjC0WoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:44:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BF01BD1;
        Mon, 27 Mar 2023 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3g6wrOP7fKxt/ZVlUPBVhcv7vJaeGOQ/4naxxL5n228=; b=bXdnNqZKSsW04shlVsw3UTYp6M
        UdUf5PIAtk/AgH49ibVY5y8mrMnLiG+XW+jMXz7MbdNKFWiVYyXnF+yk2wbuYZj9VA/njMn9+07dB
        UJoI7JZJqA3B48PvTJ4E/Qln9JcVBYQBLFYXQoxcurj8aUo5YGkxp3kHThZk8kOvmiQFyww9SmKlS
        Sk6zmV5KzP6TjT+QfXkNSEvgs/Z0cMLCozHxF21LodxIntPZOHt6Zh3EZ4u5lRzrQ5+7Hird2vIGA
        EmXtJ/8VLLDbQzLU+Kk4c27vTI4cV42cVPiPvws1JLFjhJ3ie3sRQ6OcH0Z0dVY9QxiX8c+NjF32h
        hR2jx/FA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgvZP-00CayC-2d;
        Mon, 27 Mar 2023 22:44:07 +0000
Message-ID: <5946f189-c564-e196-a375-cb03edcacaa0@infradead.org>
Date:   Mon, 27 Mar 2023 15:44:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Bug in recent changes to builddeb
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Ron Economos <re@w6rz.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <54a519ec-bfe5-60f3-fc43-707a11d38d2a@w6rz.net>
 <642d6944-4488-4dc6-99e9-209849b9771c@infradead.org>
In-Reply-To: <642d6944-4488-4dc6-99e9-209849b9771c@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/23 15:41, Randy Dunlap wrote:
> at least Cc linux-kbuild.
> 

or just see https://patchwork.kernel.org/project/linux-kbuild/patch/3351f907cfd0b5d8372e858a8ec9065cc2bd91df.1679434718.git.kevin@kevinlocke.name/

and use a later git tree.

I.e., it's fixed now.

> On 3/27/23 13:55, Ron Economos wrote:
>> Looks like there's a bug in /scripts/package/builddeb. On lines 188, 197 and 198, the variable $version is used. However, it's not defined (removed with recent changes).
>>
>> This causes the headers to be put into /usr/src/linux-headers-. When the next version is attempted to be installed, the following error occurs.
>>
>> $ sudo dpkg -i linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb
>> Selecting previously unselected package linux-headers-6.3.0-rc4.
>> (Reading database ... 376925 files and directories currently installed.)
>> Preparing to unpack linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb ...
>> Unpacking linux-headers-6.3.0-rc4 (6.3.0-rc4-2) ...
>> dpkg: error processing archive linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb (--install):
>>  trying to overwrite '/usr/src/linux-headers-/.config', which is also in package linux-headers-6.3.0-rc3 6.3.0-rc3-4
>> dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)
>> Errors were encountered while processing:
>>  linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb
>>
> 

-- 
~Randy
