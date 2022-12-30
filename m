Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA746593A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 01:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiL3AMJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Dec 2022 19:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiL3AMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:12:06 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755F13D55
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 16:12:05 -0800 (PST)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 62EC6140A6D;
        Fri, 30 Dec 2022 00:12:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 40C5A20027;
        Fri, 30 Dec 2022 00:12:01 +0000 (UTC)
Message-ID: <50adab03166b69077ca49c74b40fffea60adb807.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Mark kunmap() and kunmap_atomic()
 deprecated
From:   Joe Perches <joe@perches.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Thu, 29 Dec 2022 16:12:00 -0800
In-Reply-To: <20221229-kmap-checkpatch-v2-1-919fc4d4e3c2@intel.com>
References: <20221229-kmap-checkpatch-v2-1-919fc4d4e3c2@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 40C5A20027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: m86ueskwm7kxgo1aooht5e7ffwj76jb1
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19n9z4HD4n9VZfqcmfnVAcCP0urPuFU6PQ=
X-HE-Tag: 1672359121-153747
X-HE-Meta: U2FsdGVkX1/bf+rgnuLPnahfxAG7rn+Oa6tHBiTsaD56jN4VL+nY3cXXgAptEEcGl75HeGW9QDrLyHaSXdoiKg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-29 at 14:17 -0800, Ira Weiny wrote:
> It was suggested by Fabio that kunmap() be marked deprecated in
> checkpatch.[1]  This did not seem necessary until an invalid conversion
> of kmap_local_page() appeared in mainline.[2][3]  The introduction of
> this bug would have been flagged with kunmap() being marked deprecated.
> 
> Add kunmap() and kunmap_atomic() to checkpatch to help prevent further
> confusion.

Acked-by: Joe Perches <joe@perches.com>

> 
> [1] https://lore.kernel.org/all/1884934.6tgchFWduM@suse/
> [2] d406d26745ab ("cifs: skip alloc when request has no pages")
> [3] https://lore.kernel.org/r/20221229-cifs-kmap-v1-1-c70d0e9a53eb@intel.com
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Suggested-by: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes in v2:
> - Add LKML and send directly to Andy and Joe (I'm still learning b4 send...)
> - Link to v1: https://lore.kernel.org/r/20221229-kmap-checkpatch-v1-1-6b86bcf5080a@intel.com
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 78cc595b98ce..a6d6d7e1d0cf 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -823,7 +823,9 @@ our %deprecated_apis = (
>  	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
>  	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
>  	"kmap"					=> "kmap_local_page",
> +	"kunmap"				=> "kunmap_local",
>  	"kmap_atomic"				=> "kmap_local_page",
> +	"kunmap_atomic"				=> "kunmap_local",
>  );
>  
>  #Create a search pattern for all these strings to speed up a loop below
> 
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20221229-kmap-checkpatch-763cc2ace8e5
> 
> Best regards,

