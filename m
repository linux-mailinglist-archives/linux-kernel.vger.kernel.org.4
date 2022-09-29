Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497815EFDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiI2TQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiI2TQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECE122A6D;
        Thu, 29 Sep 2022 12:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 969F8B80D8B;
        Thu, 29 Sep 2022 19:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD12C433C1;
        Thu, 29 Sep 2022 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664479002;
        bh=TgE4K+FCSMRUmYJBn2OIluZDUtSZDaR0t/TiYWeD3rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orqzq82gTXk7cblh8HB4CZFXmOgaya65abJb3fsWXpxQ3dZByke20rdF6oD2ir99C
         3Jvx+ietuX3K7BVySQtP6SQAbgCybpD2oPwopatFgh2mX9W6y1y6O+iXT4cQjoTT5k
         psy6pUf68A/G5fluhNKiZYQWGJLU2dnpxwqflbYdYUrPFyimV6vsXSguqTiPwS4Nzh
         /LcvRhTcq+YMsgiSwTdIM2J2idYMVrmYT9zpkto7ZDKwD0DIGBWVa9RC56cg8szDs+
         5Byk1cB0uOl+t9JXTyEM51KqNRkLBo30e9Alo0YWU4/zrm6Od2/L0VW21BktaQQYV3
         rmDHPjqr29Leg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F0594062C; Thu, 29 Sep 2022 16:16:39 -0300 (-03)
Date:   Thu, 29 Sep 2022 16:16:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Will Chandler <wfc@wfchandler.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix empty version number when building
 outside of a git repo
Message-ID: <YzXvF1eIzJvAfe3U@kernel.org>
References: <20220927195228.47304-1-wfc@wfchandler.org>
 <c5181877-2998-b952-abe6-26d733ae2aeb@huawei.com>
 <87A1F5B6-3F60-4988-8BA6-A993E5789C80@wfchandler.org>
 <2a4a15a4-55cd-f98b-4b14-474f24e2c308@huawei.com>
 <B89DF3DD-B07E-427F-8D4B-1F8251345A4C@wfchandler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B89DF3DD-B07E-427F-8D4B-1F8251345A4C@wfchandler.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 29, 2022 at 03:06:06PM -0400, Will Chandler escreveu:
> On 29 Sep 2022, at 6:09, John Garry wrote:
> 
> > Hmmm... maybe someone would want to customise PERF-VERSION-FILE for their own distro. Not sure. But then fiddling with PERF-VERSION-FILE might break the parsing so...I guess not.
> 
> Yeah, seems like a bad idea. Doing a quick search, Void Linux does seem to be
> trying to set a custom version string in their build script[0], but I don't
> think passing PERF_VERSION as an argument to make has worked since 2013 with
> 3cecaa200227 ("perf tools: Do not include PERF-VERSION-FILE to Makefile, 2013-01-16").
> 
> [0] https://github.com/void-linux/void-packages/blob/fdb3515c33f2bb997392ea6992e6bbb82c4376c5/srcpkgs/linux-tools/template#L56
> 
> > BTW, is there any other method of building the perf code not considered? So far I know:
> > a. in git tree
> > b. perf-tar-src-pkg
> > c. tarball
> 
> Those are all that come to mind for me as well.
> 
> Let me know if you'd like me to re-roll the patch using the pre-7572733b8499
> approach.

Discussion is going well, proceed, reach a conclusion and from what I'm
seeing, I'll just have to apply it 8-)

- Arnaldo
