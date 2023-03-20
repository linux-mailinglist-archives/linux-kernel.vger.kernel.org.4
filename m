Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9796C24D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCTWkz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 18:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCTWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:40:52 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253C32E5A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:40:51 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id A6E501202AC;
        Mon, 20 Mar 2023 22:40:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id EEBE517;
        Mon, 20 Mar 2023 22:40:46 +0000 (UTC)
Message-ID: <c544814c20db7ae7662aa4c3b0ca728dced19f41.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add missing bindings license check
From:   Joe Perches <joe@perches.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        krzysztof.kozlowski@linaro.org, robh@kernel.org, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com
Date:   Mon, 20 Mar 2023 15:40:46 -0700
In-Reply-To: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
References: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: EEBE517
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Stat-Signature: 4mu3pe9mq17qtkie6rgkc69zjrpaoy1s
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19e0rNjjBnNCLCdKXeMepoKqGghTFLRgzA=
X-HE-Tag: 1679352046-599620
X-HE-Meta: U2FsdGVkX1/Dx1KRG3TbIvIP1xhFDOMwg5Jmm5iP0RRU6gEj6atYBqcySl1U2wL/m+ctt9ZzK6mNGZLblwAA1Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 23:33 +0300, Dmitry Rokosov wrote:
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

Assuming the devicetree people are good with this change:

Acked-by: Joe Perches <joe@perches.com>

> Changes v3 since v2 at [2]:
>     - replace 'not =~' expression with '!~' to be aligned with other
>       checkpatch lines
> 
> Changes v2 since v1 at [1]:
>     - include/dt-bindings check is aligned to open parens
>     - introduce more strict pattern for bindings license:
>       /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> 
> Links:
>     [1] https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sberdevices.ru/
>     [2] https://lore.kernel.org/all/20230320100027.27788-1-ddrokosov@sberdevices.ru/
> ---
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl

> @@ -3709,8 +3709,9 @@ sub process {
>  						WARN("SPDX_LICENSE_TAG",
>  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
>  					}
> -					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> -					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
> +					if (($realfile =~ m@^Documentation/devicetree/bindings/@ ||
> +					     $realfile =~ m@^include/dt-bindings/@) &&
> +					    $spdx_license !~ /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/) {
>  						my $msg_level = \&WARN;
>  						$msg_level = \&CHK if ($file);
>  						if (&{$msg_level}("SPDX_LICENSE_TAG",

