Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405E35B8C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiINQJo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Sep 2022 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiINQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:09:33 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF7BED;
        Wed, 14 Sep 2022 09:09:29 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 952D880C18;
        Wed, 14 Sep 2022 16:09:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 09AAD20025;
        Wed, 14 Sep 2022 16:09:25 +0000 (UTC)
Message-ID: <aa858ac592679fdf512debe17e0612c575450860.camel@perches.com>
Subject: Re: [PATCH v7] checkpatch: warn for non-standard fixes tag style
From:   Joe Perches <joe@perches.com>
To:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Date:   Wed, 14 Sep 2022 09:09:25 -0700
In-Reply-To: <20220914100255.1048460-1-niklas.soderlund@corigine.com>
References: <20220914100255.1048460-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 09AAD20025
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 9md5hxrn71chdp7f1f7hcsjjgts5nfpt
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX183LY6G42xmDTBsfnC5aVm3gnaz6IMy0ks=
X-HE-Tag: 1663171765-135009
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-14 at 12:02 +0200, Niklas Söderlund wrote:
> Add a warning for fixes tags that does not follow community conventions.
[]
> * Changes since v6
> - Update first check to make sure that there is a likely SHA1 of some
>   minimum length after the fixes line.

https://lore.kernel.org/lkml/2febb7893346b6234983453de7c037536e479bfc.camel@perches.com/

The goal here should be to identify a line that looks like a commit
reference.

So find lines that starts with 'fixes' and have a SHA1 commit id as
broadly as reasonable.

Did you run the grep pattern and look at the results?

One grep pattern to verify the non canonical fixes format that
are mistakenly used is:

$ git log --since=5-years-ago --no-merges --grep='^\s*fixes' -i --format=email -P | \
  grep -P -i '^\s*fixes' | \
  grep -P -v '^Fixes: [0-9a-f]{12,12}\s*\(".*")'

[]

There are many different styles.
Parenthesea are sometimes not used.

> +			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {

How about some pattern like

	/fixes\s*:?\s*(?:commit:?\s*)?[0-9a-f]{5,}/i

or maybe even more broadly:

	/fixes\b.*\b[0-9a-f]{5,}\b/i

