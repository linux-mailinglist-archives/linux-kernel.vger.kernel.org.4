Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFD636F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKXBIL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 20:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiKXBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:08:07 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592763B9A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:08:06 -0800 (PST)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 5A72CAB37A;
        Thu, 24 Nov 2022 01:08:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id AC1C92D;
        Thu, 24 Nov 2022 01:07:35 +0000 (UTC)
Message-ID: <1820d317cd8447d88d666c7d8c3e47c89a8324bb.camel@perches.com>
Subject: Re: [PATCH v2 5/5] checkpatch: ignore a file named b
From:   Joe Perches <joe@perches.com>
To:     Robert Elliott <elliott@hpe.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 17:08:01 -0800
In-Reply-To: <20221123011202.939319-6-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
         <20221123011202.939319-1-elliott@hpe.com>
         <20221123011202.939319-6-elliott@hpe.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: AC1C92D
X-Stat-Signature: jdc75kdrqtccebmzzqgwycmh754du8kd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/0O2so2WHCRtGPPrnnUhwKomdAUBg0znE=
X-HE-Tag: 1669252055-328934
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 19:12 -0600, Robert Elliott wrote:
> If a file named "b" happens to exist, checkpatch complains
> as it parses the patch lines specifying the filenames.
> 
> 	WARNING: patch prefix 'b' exists, appears to be a -p0 patch
> 
> Squelch that by only complaining if that is a directory,
> not a regular file, and print the whole path causing concern.
> 	WARNING: patch prefix './b' exists, appears to be a -p0 patch

Seems OK

> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d11d58e36ee9..5a0252265d3f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2834,9 +2834,9 @@ sub process {
>  
>  			$p1_prefix = $1;
>  			if (!$file && $tree && $p1_prefix ne '' &&
> -			    -e "$root/$p1_prefix") {
> +			    -d "$root/$p1_prefix") {
>  				WARN("PATCH_PREFIX",
> -				     "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
> +				     "patch prefix '$root/$p1_prefix' exists, appears to be a -p0 patch\n");
>  			}
>  
>  			if ($realfile =~ m@^include/asm/@) {

