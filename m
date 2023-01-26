Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7EE67D3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjAZSSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjAZSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:18:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8C28D10;
        Thu, 26 Jan 2023 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=A/EAsoQpv98BbnAFg4jyK3LuF4jsXP2f5+Cbw1ShfTs=; b=b9cCEL1kzEWMjbYFzFb0wgufGU
        3nL88FuO4VhxpSq5sFH8vKVPqM7bHI+NCcBivAtDo3sQGvREjekdLki6EMb8N92DkED38zpNwursR
        zYKJM9Z6hQMaCoBbdzf5SmtYcRQ/WuIQ1z1b2UHkDrp4nGjY4hwU9hswbWev9PvGlW42nZOozaIt5
        0xSQHvzLSb4q32M67trAxPf6zUj5uDS+nbUMYbbAQksYc0JLk2TiUBbm5/uJDpP+sCkY8tY23P080
        QCHMcP5gMkv1wEW8wcNNBErX25FvkxvCgNW3O20akCAlO3g0bdxxitAPtvhARNYISN6K+Q0K3yp+J
        n+v4A/mQ==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL6pf-00C8GL-4a; Thu, 26 Jan 2023 18:18:43 +0000
Message-ID: <2a54ce4b-e16f-d4a0-0850-15520f99248e@infradead.org>
Date:   Thu, 26 Jan 2023 10:18:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
Content-Language: en-US
To:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <b41ea008-d9c4-fd76-a5ce-00fe435deed5@mkarcher.dialup.fu-berlin.de>
 <f540c26e-baa8-5c18-9502-622a4091b675@infradead.org>
 <CAMuHMdUUq0FLmsRPw122My7tOUyRLJxsEKOSFgtfG3ec5OiyKQ@mail.gmail.com>
 <0dcf23d3-09d5-802f-d9cc-2900d2cdaa53@mkarcher.dialup.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0dcf23d3-09d5-802f-d9cc-2900d2cdaa53@mkarcher.dialup.fu-berlin.de>
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

Hi Michael,

On 1/24/23 14:05, Michael Karcher wrote:
> Am 24.01.2023 um 14:07 schrieb Geert Uytterhoeven:
> 
>> On Mon, Jan 23, 2023 at 8:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>> I'm curious how you generated this patch.
> 
> I'm currently using Thunderbird in a GUI environment as my only mail client,
> and I pasted just the +/- lines of the patch into the pre-composed mail. The
> copious amounts of bad mails I generated this way are a good point to set up
> git-send-email in my linux environment to avoid bad patches / badly formatted
> mails
> 

If there is anything that you told Thunderbird about as far as sending plain text
patches that is not already documented[1], please consider adding it to the
documentation.

[1] https://docs.kernel.org/process/email-clients.html (+ search for Thunderbird)
or linux/Documentation/process/email-clients.rst

Thanks.
-- 
~Randy
