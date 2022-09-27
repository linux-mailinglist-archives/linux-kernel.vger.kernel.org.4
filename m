Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A905EB9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiI0Frr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Sep 2022 01:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiI0Frp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:47:45 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5588E4C8;
        Mon, 26 Sep 2022 22:47:43 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id AF9ACA0D72;
        Tue, 27 Sep 2022 05:40:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 169972002A;
        Tue, 27 Sep 2022 05:40:32 +0000 (UTC)
Message-ID: <91bb341a01ad5cfe4269ef6857387cf3db9619d0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Don't count URLs for "line too long"
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>, yashsri421@gmail.com
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Mon, 26 Sep 2022 22:40:50 -0700
In-Reply-To: <20220927021517.1952202-1-keescook@chromium.org>
References: <20220927021517.1952202-1-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: iqx7qcstj1cqprifg97q5eq6tr6fho6e
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 169972002A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19u5rYw6zYJbV9ie37VuTxpInUkuOIix0Y=
X-HE-Tag: 1664257232-817644
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 19:15 -0700, Kees Cook wrote:
> URLs (not in a Link: field) should be ignored for "line too long"
> warnings. Allow any line containing "https://" or "http://".

More generally, this should be for any URI

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3175,6 +3175,8 @@ sub process {
>  					# file delta changes
>  		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
>  					# filename then :
> +		      $line =~ /https?:\/\// ||
> +					# URLs
>  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
>  					# A Fixes: or Link: line or signature tag line
>  		      $commit_log_possible_stack_dump)) {

And I don't recollect why this wasn't applied, but I think it's a rather better,
more complete, patch:

https://lore.kernel.org/lkml/20210114073513.15773-2-yashsri421@gmail.com/

I believe I did ack it and forward it to Andrew Morton, but I don't
see it on a lore list.

