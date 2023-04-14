Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24846E2706
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjDNPaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDNP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:29:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF976D326;
        Fri, 14 Apr 2023 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zr/eMIDU6fNQdVXHYix8RopaDwoinY/hck5t8BeuRww=; b=1x16gJNUbhYezoJPzmtJ3livjI
        hIWERi72JYLkykXtQ3Vk+dG1HP8hJfy9Xm95x5/1FKdGXt+gWztmKchGIJ24/DH4ZvodX7gCPwWLo
        Dt2poVDwIy6jlZvSLA9njBR1D+yzO6hC3qzWnLS9YfQHb0KZq+ok/BP0lY3bS5wO15t8++unoLPsK
        1TNtyyVuuyqPEIdJwbNV8+FwaeOgWIl1gJPNQvWayODs+lnt9TH12kPWTxEAiZP6ZWW66Q2gip1Se
        LXbJhTqm3pgst5+xf3msvmFboxsZquPnkUIu9BbRV49dpmiYcrig/uTQTxV+jsRS4QBAol3MuCwF/
        6ucmxJDA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnLMd-009y7r-0c;
        Fri, 14 Apr 2023 15:29:27 +0000
Message-ID: <5e040d45-ab76-c62d-d7f4-e7a6a35fa8fd@infradead.org>
Date:   Fri, 14 Apr 2023 08:29:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230410011325.26850-1-rdunlap@infradead.org>
 <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/23 06:55, Johannes Berg wrote:
> On Sun, 2023-04-09 at 18:13 -0700, Randy Dunlap wrote:
>> Current build of pata_cs5536 for i386 UML fails with:
>>
>> ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
>> ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
>> ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
>> ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
>>
>> Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
>>
> 
> Hm. Does this make sense? I can't see it'd work on UML to configure an
> IDE device through MSRs? Surely that can't work? IOW, that entire driver
> can't really work anyway can it?
> 
> OTOH, maybe theoretically it could work in PCI, just not with MSRs, and
> then this patch makes some sense?

Hi,
I was happy with v1, which just did "depends on !UML".
Anyway, I'll drop this part of the quest to make UML build cleanly.

Thanks.
-- 
~Randy
