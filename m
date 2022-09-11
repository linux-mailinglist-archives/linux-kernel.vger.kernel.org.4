Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1675B4B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 04:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIKCsL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Sep 2022 22:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIKCsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 22:48:07 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642438457;
        Sat, 10 Sep 2022 19:48:03 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 9961580615;
        Sun, 11 Sep 2022 02:48:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id AEBEC1A;
        Sun, 11 Sep 2022 02:47:59 +0000 (UTC)
Message-ID: <2febb7893346b6234983453de7c037536e479bfc.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: warn for non-standard fixes tag style
From:   Joe Perches <joe@perches.com>
To:     "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>
Date:   Sat, 10 Sep 2022 19:47:57 -0700
In-Reply-To: <9f9a0740aef282d30af8fa02ca7c6479e80aa9a0.camel@perches.com>
References: <20220908164434.122106-1-niklas.soderlund@corigine.com>
         <3275d886491dc934e3277cde9cc766b0ce0886ea.camel@toradex.com>
         <Yxrt1aa60xY0H7j0@oden.dyn.berto.se>
         <9f9a0740aef282d30af8fa02ca7c6479e80aa9a0.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: AEBEC1A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: h13yutk9y9wri4g3qzr51mwk4xcmonzs
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19n7kE87D4jQzH7pcA7dlomOJhrJqeZPSk=
X-HE-Tag: 1662864479-88451
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 10:57 -0700, Joe Perches wrote:
> On Fri, 2022-09-09 at 09:40 +0200, niklas.soderlund@corigine.com wrote:
> > On 2022-09-08 17:49:14 +0000, Philippe Schenker wrote:
[]
> > > I would check all lines that start with fixes, even if there is
> > > whitespace in front (and then failing later on...)
> > > 
> > > if (!$in_header_lines && $line =~ /^\s*fixes:?/i) {
> 
> I think that's a poor idea.
> 
> You should really review git history for lines that start with fixes
> and look at the number of false positives that would give.
> 
> Try this grep:
> 
> $ git log -100000 --no-merges --grep="^\s*fixes" -i --format=email -P | \
>   grep -P -i "^\s*fixes)" | \
>   grep -P -v "^Fixes: [0-9a-f]{12,}'
> [...]
> 
> That is a greater than 10% false positive rate.

One day I'll be better at typing grep commands in the editor...

Try:

$ git log -100000 --no-merges --grep="^\s*fixes" -i --format=email -P | \
  grep -P -i "^\s*fixes" | \
  grep -P -v "^Fixes: [0-9a-f]{12,}"

