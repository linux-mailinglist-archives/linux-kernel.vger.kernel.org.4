Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6C618F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKDEvx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Nov 2022 00:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDEvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:51:50 -0400
X-Greylist: delayed 52579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 21:51:49 PDT
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019120F61;
        Thu,  3 Nov 2022 21:51:49 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 0B038C033F;
        Fri,  4 Nov 2022 04:51:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 4DDEB20027;
        Fri,  4 Nov 2022 04:50:53 +0000 (UTC)
Message-ID: <d5aad01b77072d065f47b89b1c0ff16edf906bc9.camel@perches.com>
Subject: Re: [PATCH] cpufreq: SPEAr: Make read-only array sys_clk_src static
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Nov 2022 21:51:44 -0700
In-Reply-To: <20221103143654.85275-1-colin.i.king@gmail.com>
References: <20221103143654.85275-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4DDEB20027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: uwnwjmkujh3r4d3igepfxgnq9pjwy8f7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX187jzT9iI/uQ5LIT5aSXQWCd3SiSHIShjY=
X-HE-Tag: 1667537453-657377
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-03 at 14:36 +0000, Colin Ian King wrote:
> Don't populate the read-only array sys_clk_src on the stack but instead
> make it static and add in a missing const. Also makes the object code a
> little smaller.
[]
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
[]
> @@ -39,7 +39,7 @@ static struct clk *spear1340_cpu_get_possible_parent(unsigned long newfreq)
>  	 * In SPEAr1340, cpu clk's parent sys clk can take input from
>  	 * following sources
>  	 */
> -	const char *sys_clk_src[] = {
> +	static const char * const sys_clk_src[] = {
>  		"sys_syn_clk",
>  		"pll1_clk",
>  		"pll2_clk",

sys_clk_src[2] isn't used and could be deleted with the
pclk indices changed.

Dunno what happened to the > 500000000 && != 600000000 range.
