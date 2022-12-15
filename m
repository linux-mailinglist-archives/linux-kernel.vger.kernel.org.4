Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527764E022
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiLOSAU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Dec 2022 13:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLOSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:00:16 -0500
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BACE3F05C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:00:14 -0800 (PST)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 0C0CAAB79A;
        Thu, 15 Dec 2022 18:00:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id B76A52E;
        Thu, 15 Dec 2022 18:00:10 +0000 (UTC)
Message-ID: <da8bc9f50f8e19de9937a65ad82c3367e70959bb.camel@perches.com>
Subject: Re: [PATCH 2/3] checkpatch: warn when Reported-by: is not followed
 by Link:
From:   Joe Perches <joe@perches.com>
To:     Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 15 Dec 2022 10:00:09 -0800
In-Reply-To: <26b72b039d4150418cd37598d50112719c684344.1671114724.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
         <cover.1671114724.git.kai@dev.carbon-project.org>
         <26b72b039d4150418cd37598d50112719c684344.1671114724.git.kai@dev.carbon-project.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: B76A52E
X-Stat-Signature: 6jr9em953bwxb9jtfw3smfxqj4y8tzuc
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+gtDP41/sSKyDObTGbJCbYLcRcqhgg2e8=
X-HE-Tag: 1671127210-72073
X-HE-Meta: U2FsdGVkX1/TN02vMQFc5OFMaOrgL/Fsv9Q991Mf07+0CLgHopqCpBU8idSvdXnExdr8rvp3QRROtp3AEb+MtA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-15 at 15:43 +0100, Kai Wasserbäch wrote:
> Encourage patch authors to link to reports by issuing a warning, if
> a Reported-by: is not accompanied by a link to the report.

Please also expand Documentation/ as appropriate to encourage this too.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3155,6 +3155,20 @@ sub process {
>  					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
>  				}
>  			}
> +
> +			# check if Reported-by: is followed by a Link:
> +			if ($sign_off =~ /^reported-by:$/i) {
> +				if (!defined $lines[$linenr]) {
> +					WARN("BAD_REPORTED_BY_LINK",
> +					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> +				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {

This capture group isn't necessary and does not guarantee there is
an actual link.  Also this is allowing spaces before "Link:" when
the reported-by test above does not allow spaces.  Please be
consistent.  My preference would be to not allow spaces.

> +					WARN("BAD_REPORTED_BY_LINK",
> +					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> +				} elsif ($lines[$linenr] !~ /https?:\/\//i) {

To make reading the match pattern easier, prefer m{} when the expected
content uses / instead of using / as a delimiter.

> +					WARN("BAD_REPORTED_BY_LINK",
> +					     "Link: following Reported-by: should contain a URL\n" . $herecurr . $rawlines[$linenr] . "\n");
> +				}
> +			}
>  		}
>  
>  # Check Fixes: styles is correct

