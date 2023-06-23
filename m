Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AFA73BB18
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjFWPIU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFWPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:08:14 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 892772139
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:08:08 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id 62CB315360;
        Fri, 23 Jun 2023 15:58:03 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 5590D219FD4; Fri, 23 Jun 2023 15:58:03 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        netdev@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
        <20161028155213.2t3nwwe3lqaynaer@atomide.com>
        <d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
        <20161028181914.mskebckucukzhxhz@atomide.com>
Date:   Fri, 23 Jun 2023 15:58:03 +0100
In-Reply-To: <20161028181914.mskebckucukzhxhz@atomide.com> (Tony Lindgren's
        message of "Fri, 28 Oct 2016 11:19:14 -0700")
Message-ID: <yw1x7cru445g.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 11:19]:
>> Hello Tony,
>> 
>> On 28-10-16 17:52, Tony Lindgren wrote:
>> > * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 08:33]:
>> > > Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
>> > > id to common file") did not only move the code for an am3517, it also
>> > > added the slave parameter, resulting in an invalid (all zero) mac address
>> > > being returned for an am3517, since it only has a single emac and the slave
>> > > parameter is pointing to the second. So simply always read the first and
>> > > valid mac-address for a ti,am3517-emac.
>> > And others davinci_emac.c users can have more than one. So is the
>> > reason the slave parameter points to the second instance because
>> > of the location in the hardware?
>> 
>> Sort of, the slave parameter gets determined by the fact if there is one
>> or two register range(s) associated with the davinci_emac. In davinci_emac.c
>> 
>>     res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>     ...
>>     rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1,
>>                           priv->mac_addr);
>> 
>> So it there are two ranges, the slave param becomes 0. It there is only one,
>> it
>> will be 1. Since the am3517 only has a single regs entry it ends up with
>> slave 1,
>> while there is only a single davinci_emac.
>
> OK thanks for clarifying it:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Is there some reason this patch was never picked up, or was it simply
forgotten?

-- 
Måns Rullgård
