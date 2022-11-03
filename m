Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2C617F55
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKCOVw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Nov 2022 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiKCOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:21:47 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23811A2F;
        Thu,  3 Nov 2022 07:21:44 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id BA2A51C6E3C;
        Thu,  3 Nov 2022 14:15:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 6C49E20028;
        Thu,  3 Nov 2022 14:15:25 +0000 (UTC)
Message-ID: <aec9ee4b771b70d0839d51b836e6301f0a2a1276.camel@perches.com>
Subject: Re: [PATCH] cpufreq: longhaul: Make array speeds static const
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Nov 2022 07:15:24 -0700
In-Reply-To: <20221103132141.79671-1-colin.i.king@gmail.com>
References: <20221103132141.79671-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: juf6noichzo31sn5pnmdnohcwbefk415
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 6C49E20028
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+0rYv0RZQBQuYXkqWzGykvjJA0douUVFc=
X-HE-Tag: 1667484925-846150
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-03 at 13:21 +0000, Colin Ian King wrote:
> Don't populate the read-only array speeds on the stack but instead
> make it static. Also makes the object code a little smaller.
[]
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
[]
> @@ -407,7 +407,7 @@ static int guess_fsb(int mult)
>  {
>  	int speed = cpu_khz / 1000;
>  	int i;
> -	int speeds[] = { 666, 1000, 1333, 2000 };
> +	static const int speeds[] = { 666, 1000, 1333, 2000 };
>  	int f_max, f_min;
>  
>  	for (i = 0; i < 4; i++) {

style trivia:  the loop test is probably better using ARRAY_SIZE

	for (i = 0; i < ARRAY_SIZE(speeds); i++)

