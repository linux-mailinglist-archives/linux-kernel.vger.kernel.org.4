Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25676BF523
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCQW20 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 18:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCQW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:28:24 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479DA42BF2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:28:21 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id A5F041A0350;
        Fri, 17 Mar 2023 22:28:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 3709B2002D;
        Fri, 17 Mar 2023 22:28:17 +0000 (UTC)
Message-ID: <8dcc23061db363d894a5c8219076cd41f99163c1.camel@perches.com>
Subject: Re: [PATCH v1] checkpatch: add missing bindings license check
From:   Joe Perches <joe@perches.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        krzysztof.kozlowski@linaro.org, robh@kernel.org, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com
Date:   Fri, 17 Mar 2023 15:28:16 -0700
In-Reply-To: <20230317201621.15518-1-ddrokosov@sberdevices.ru>
References: <20230317201621.15518-1-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: esn5uqi1k5ff48uwe1a4wgybc3h9ui1o
X-Rspamd-Server: rspamout06
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 3709B2002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/hma6p1Xg63blWcvzUdaEkvghYYOcTwkU=
X-HE-Tag: 1679092097-414464
X-HE-Meta: U2FsdGVkX19s18cjb3Y+Mwrh40IYZFEVZ05aPkFLCgQoPUrUHRqucqk7WiaPpt4qfwydC/OlVvWoxln9E6n5Qw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-17 at 23:16 +0300, Dmitry Rokosov wrote:
> All headers from 'include/dt-bindings/' must be verified by checkpatch
> together with Documentation bindings, because all of them are part of
> the whole DT bindings system.
> 
> The requirement is dual licensed and matching string:
>     'GPL-2.0-only OR BSD-2-Clause'
> 
> The issue was found during patch review:
> https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3709,7 +3709,8 @@ sub process {
>  						WARN("SPDX_LICENSE_TAG",
>  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
>  					}
> -					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> +					if (($realfile =~ m@^Documentation/devicetree/bindings/@ ||
> +					    $realfile =~ m@^include/dt-bindings/@) &&

I prefer aligning to open parens

>  					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {

And if it's really a strict bit about the required license,
why not make it match exactly?

 					    $spdx_license !~ /GPL-2\.0(?:-only|-or-later|\+)? OR BSD-2-Clause/) {

>  						my $msg_level = \&WARN;
>  						$msg_level = \&CHK if ($file);

$ git grep -oh 'SPDX-License.*$' -- Documentation/devicetree/bindings/ include/dt-bindings/ | \
  sort | uniq -c | sort -rn
   1597 SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
    611 SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
    540 SPDX-License-Identifier: GPL-2.0
    355 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
    285 SPDX-License-Identifier: GPL-2.0 */
    179 SPDX-License-Identifier: GPL-2.0-only */
    102 SPDX-License-Identifier: GPL-2.0-only
     93 SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
     56 SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
     47 SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
     36 SPDX-License-Identifier: GPL-2.0+ */
     34 SPDX-License-Identifier: GPL-2.0-or-later */
     33 SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
     28 SPDX-License-Identifier: GPL-2.0+
     21 SPDX-License-Identifier: (GPL-2.0+ OR MIT)
     19 SPDX-License-Identifier: (GPL-2.0+ or MIT) */
     17 SPDX-License-Identifier: (GPL-2.0 OR MIT) */
     12 SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
     11 SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
      9 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
      8 SPDX-License-Identifier: GPL-2.0 OR MIT */
      8 SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
      7 SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
      7 SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
      7 SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
      6 SPDX-License-Identifier: (GPL-2.0)
      5 SPDX-License-Identifier: GPL-2.0+ OR MIT */
      5 SPDX-License-Identifier: (GPL-2.0 OR MIT)
      5 SPDX-License-Identifier: (GPL-2.0 or MIT) */
      4 SPDX-License-Identifier: GPL-2.0-or-later
      3 SPDX-License-Identifier: (GPL-2.0+ OR X11)
      3 SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
      3 SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
      3 SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
      3 SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
      3 SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
      3 SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
      2 SPDX-License-Identifier: (GPL-2.0+ or MIT)
      2 SPDX-License-Identifier: GPL-2.0-or-later OR MIT */
      2 SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
      2 SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
      2 SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)*/
      1 SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
      1 SPDX-License-Identifier: (GPL-2.0-or-later or MIT) */
      1 SPDX-License-Identifier: GPL-2.0-or-later or BSD-2-Clause */
      1 SPDX-License-Identifier: (GPL-2.0-or-later)
      1 SPDX-License-Identifier: GPL-2.0+ or BSD-3-Clause */
      1 SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
      1 SPDX-License-Identifier: GPL-2.0-only or X11 */
      1 SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
      1 SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause */
      1 SPDX-License-Identifier: (GPL-2.0-only)
      1 SPDX-License-Identifier: BSD-2-Clause

