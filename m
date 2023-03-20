Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93026C1D97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjCTRSO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjCTRRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:17:42 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22082886A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:13:44 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 5A8BB80EB5;
        Mon, 20 Mar 2023 17:12:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 96EF119;
        Mon, 20 Mar 2023 17:12:28 +0000 (UTC)
Message-ID: <cb29cc23e6b2a261eafa0a2baf6acf61e44829de.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add missing bindings license check
From:   Joe Perches <joe@perches.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        krzysztof.kozlowski@linaro.org, robh@kernel.org, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com
Date:   Mon, 20 Mar 2023 10:12:27 -0700
In-Reply-To: <20230320100027.27788-1-ddrokosov@sberdevices.ru>
References: <20230320100027.27788-1-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 96EF119
X-Stat-Signature: m7he5hojpjxfjfk8sw3ouu3hsgfowhwb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/6Z0LYqiIG0TCbYNw98luFoYwCTf/y0ZA=
X-HE-Tag: 1679332348-501209
X-HE-Meta: U2FsdGVkX186kcPf3w3bAwLMHrUiLiA2XxiNTBYdRTPEcWBbhLSGD4yMztI4LlGFh9XxnDESb03cS2gACm+5sA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 13:00 +0300, Dmitry Rokosov wrote:
> All headers from 'include/dt-bindings/' must be verified by checkpatch
> together with Documentation bindings, because all of them are part of
> the whole DT bindings system.
> 
> The requirement is dual licensed and matching pattern:
>     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> 
> The issue was found during patch review:
> https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
> Changes v2 since v1 at [1]:
>     - include/dt-bindings check is aligned to open parens
>     - introduce more strict pattern for bindings license:
>       /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> 
> Links:
>     [1] https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sberdevices.ru/
> ---
>  scripts/checkpatch.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

OK but:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3709,8 +3709,9 @@ sub process {
>  						WARN("SPDX_LICENSE_TAG",
>  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
>  					}
> -					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> -					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
> +					if (($realfile =~ m@^Documentation/devicetree/bindings/@ ||
> +					     $realfile =~ m@^include/dt-bindings/@) &&
> +					    not $spdx_license =~ /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/) {

I believe this is the only checkpatch use of
	not <foo> =~ <bar>
instead of
	<foo> !~ <bar>

I prefer !~

