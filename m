Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606CA6D380E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDBNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:13:12 -0400
Received: from smtp26.services.sfr.fr (smtp26.services.sfr.fr [93.17.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC25FFA;
        Sun,  2 Apr 2023 06:13:08 -0700 (PDT)
X-mail-filterd: {"version":"1.6.0","queueID":"4PqDwg18gGz1LQKcd","contextId":
 "d5fbdbee-675f-4c3c-a303-2cad8805f6a4"}
Received: from [192.168.1.30] (atoulouse-656-1-945-91.w90-11.abo.wanadoo.fr [90.11.30.91])
        by msfrf2621.sfr.fr (SMTP Server) with ESMTP id 4PqDwg18gGz1LQKcd;
        Sun,  2 Apr 2023 15:13:07 +0200 (CEST)
X-mail-filterd: {"version":"1.6.0","queueID":"4PqDwd67f3z1LQKdJ","contextId":
 "d71c0dae-802e-4170-b039-caf56db25b78"}
X-sfr-mailing: LEGIT
X-sfr-spamrating: 36
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cegetel.net; s=202006;
 t=1680441187; h=Date:Subject:To:Cc:References:From:In-Reply-To; bh=T6bCBwYVBW
  WNvdSwubSv0cmUFyvnnKxXCzM7F4b5fQk=; b=EROc8NH5DOrUDIOUwb6AuLt56CF1PVrRXpIZRV
  NatK/XwW1CPmGOgPcHk8B2c1WXbu5G1Q5zJeNGEbO43KentlwJUzcdO8YLVS/+TTzjyGT+87Uz0f
  e3iTBn3PmQf0TkQfSq+AQUz+R6jm4H8jc4FlS1j7pOkqxG/aCRHdNH6wnTdYSVPXkVWtGRHJdYj9
  R6odu2OpecTU9gdy+5zwcen9U2mN/YLp3Fgs3DqaVrghA51QADZUzgDTjXiOJOXS4/Bljm7P04JG
  hNnZA0jSnfqkDObdal+7xi8sIb5akwUPro2MCPa5xf0XrAc8YLfT5F0ODX7ckMiR/0yYjAWIjcPQ
  ==
Received: from [192.168.1.30] (atoulouse-656-1-945-91.w90-11.abo.wanadoo.fr [90.11.30.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: guy.durrieu@cegetel.net)
        by msfrf2621.sfr.fr (SMTP Server) with ESMTPSA id 4PqDwd67f3z1LQKdJ;
        Sun,  2 Apr 2023 15:13:05 +0200 (CEST)
Authentication-Results: sfr.fr; auth=pass (PLAIN) smtp.auth=guy.durrieu@cegetel.net
Message-ID: <961f96d3-df1c-483d-f681-42a291d88740@cegetel.net>
Date:   Sun, 2 Apr 2023 15:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
To:     Borislav Petkov <bp@alien8.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>, 1033732@bugs.debian.org
References: <20230105041059.39366-1-kvijayab@amd.com>
 <c02a2a2f-2b40-e13e-ac40-e5d19a66b5ba@cegetel.net>
 <D2229CD1-CD5F-49E9-A0F5-BAB3940B6BFB@alien8.de>
Content-Language: fr
From:   Guy Durrieu <guy.durrieu@cegetel.net>
In-Reply-To: <D2229CD1-CD5F-49E9-A0F5-BAB3940B6BFB@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/04/2023 à 12:57, Borislav Petkov a écrit :

> On April 2, 2023 12:41:46 PM GMT+02:00, Guy Durrieu <guy.durrieu@cegetel.net> wrote:
>> My system worked fine with kernel 6.1.15, but stopped booting after
>> upgrading to 6.1.20 and resulted in a kernel panic:
> Does this fix it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent
>
> Thx.
>
Yes it does.

Regards.

-- Guy Durrieu

