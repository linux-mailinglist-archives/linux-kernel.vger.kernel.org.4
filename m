Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5483065F6AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjAEWZG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 17:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjAEWYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:24:34 -0500
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112B6B180
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:24:32 -0800 (PST)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 372BC4099C;
        Thu,  5 Jan 2023 22:24:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id F0A4D1A;
        Thu,  5 Jan 2023 22:24:28 +0000 (UTC)
Message-ID: <435e1e0fd256bc2e58f0abe1255d9f13a786ca11.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Ignore ETHTOOL_LINK_MODE_ enum values
From:   Joe Perches <joe@perches.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Date:   Thu, 05 Jan 2023 14:24:27 -0800
In-Reply-To: <20230104201524.28078-1-gerhard@engleder-embedded.com>
References: <20230104201524.28078-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: F0A4D1A
X-Stat-Signature: 35icq1hyn9cdhiepgdkqkbwgpzcce8dp
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19m6apyys1znSTNSVp7hTXcBoETH8aCbbA=
X-HE-Tag: 1672957468-421589
X-HE-Meta: U2FsdGVkX18XfOpJ1qol28hLsx696dg5jhQaDAyXJ11Udt2ekWU0FdWTq7KxQkfNVp4BN2DFf12F8FZTVKKF2w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-04 at 21:15 +0100, Gerhard Engleder wrote:
> Since commit 4104a20646 enum values like
> ETHTOOL_LINK_MODE_Asym_Pause_BIT are ignored. But there are other enums
> like ETHTOOL_LINK_MODE_1000baseT_Full_BIT, which are not ignored
> because of the not matching '1000baseT' substring.
> 
> Add regex to match all ETHTOOL_LINK_MODE enums.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5783,6 +5783,8 @@ sub process {
>  			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
>  #Ignore Page<foo> variants
>  			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
> +#Ignore ETHTOOL_LINK_MODE_<foo> variants
> +			    $var !~ /^ETHTOOL_LINK_MODE_/ &&
>  #Ignore SI style variants like nS, mV and dB
>  #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
>  			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&

These ETHTOOL enums also exist but are caught by the SI style variants test

ETHTOOL_A_CABLE_PULSE_mV
ETHTOOL_A_CABLE_AMPLITUDE_mV

So I guess it's OK.  Thanks.

