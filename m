Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6C7331D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbjFPNFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFPNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48C72D76;
        Fri, 16 Jun 2023 06:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5120B60C3C;
        Fri, 16 Jun 2023 13:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A142C433C0;
        Fri, 16 Jun 2023 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686920705;
        bh=SrO0CeEasmWz37MEWDUcwNmCFCb0teNkDoI5J3qhx4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGcQcMvEoVks3aMm/p5sUZangLQuMC4WBjKavKMF8tYvL5uw5QDalT/rvnIeOyegJ
         FdZPc7CODn20x7zxuex+qlTdIp6I3X3hnDkcYfdiij7QQ5RLAJkh8mWURZJR2o3AH+
         3FVLv0E9/KrZOVq+mdnkfMpdL2cpvsEHhWvD/wKmT3qVLyRyVbkgxOeuDOJV0dVGM/
         T9K1b3F9sMyVQQRQ8t+96Dgo3Y6giwkqgj8lUjj6SZP0M9O4frX/ExwsT58EuPuzR0
         sqOqmrb+IMyVkJdpi5zwRiNg9709EeTI7YH/qglKOPNy/qlksvizrT/oL/cT0K9U7g
         eYBGxI4DDn9qw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7A9540692; Fri, 16 Jun 2023 10:05:02 -0300 (-03)
Date:   Fri, 16 Jun 2023 10:05:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        kernel <kernel@axis.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf annotate: Work with vmlinux outside symfs
Message-ID: <ZIxd/kINrMLfZ8cD@kernel.org>
References: <20221125114210.2353820-1-vincent.whitchurch@axis.com>
 <28e5680b86806cb97f832f5646a0e2e9d8ee68f7.camel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e5680b86806cb97f832f5646a0e2e9d8ee68f7.camel@axis.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 16, 2023 at 10:21:52AM +0000, Vincent Whitchurch escreveu:
> On Fri, 2022-11-25 at 12:42 +0100, Vincent Whitchurch wrote:
> > It is currently possible to use --symfs along with a vmlinux which lies
> > outside of the symfs by passing an absolute path to --vmlinux, thanks to
> > the check in dso__load_vmlinux() which handles this explicitly.
> > 
> > However, the annotate code lacks this check and thus perf annotate does
> > not work ("Internal error: Invalid -1 error code") for kernel functions
> > with this combination.  Add the missing handling.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> This patch was not merged and I did not receive any comments on it
> either.  Should I resend it?  It still applies cleanly to current
> mainline.  Thanks.

Thanks for the ping, I checked  dso__load_vmlinux() and it has:

        if (vmlinux[0] == '/')
                snprintf(symfs_vmlinux, sizeof(symfs_vmlinux), "%s", vmlinux);
        else
                symbol__join_symfs(symfs_vmlinux, vmlinux)

Exactly as you pointed out, applied.

- Arnaldo
