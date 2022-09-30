Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3505F5F0FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiI3QOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiI3QOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:14:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD42634E;
        Fri, 30 Sep 2022 09:14:41 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MfFdZ2fnrz67XMQ;
        Sat,  1 Oct 2022 00:13:22 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:14:39 +0200
Received: from [10.126.175.8] (10.126.175.8) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 17:14:38 +0100
Message-ID: <30a2631b-341c-8c41-52dd-becb40bfc4be@huawei.com>
Date:   Fri, 30 Sep 2022 17:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2] perf tools: Fix empty version number when building
 outside of a git repo
To:     Will Chandler <wfc@wfchandler.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220927195228.47304-1-wfc@wfchandler.org>
 <20220930151157.529674-1-wfc@wfchandler.org>
In-Reply-To: <20220930151157.529674-1-wfc@wfchandler.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.8]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 16:11, Will Chandler wrote:
> When perf is built in a full source tree that is not a git repository,
> e.g. from a kernel source tarball, `perf version` will print empty tag
> and commit strings:
> 
>    $ perf version
>    perf version
> 
> Currently the tag version is only generated from the root Makefile when
> building in a git repository. If PERF-VERSION-FILE has not been
> generated and the source tree is not in a git repository, then
> PERF-VERSION-GEN will return an empty version.
> 
> The problem can be reproduced with the following steps:
> 
>    $ wget https://git.kernel.org/torvalds/t/linux-6.0-rc7.tar.gz
>    $ tar -xf linux-6.0-rc7.tar.gz && cd linux-6.0-rc7
>    $ make -C tools/perf
>    $ tools/perf/perf -v
>    perf version
> 
> Builds from tarballs generated with `make perf-tar-src-pkg` are not
> impacted by this issue as PERF-VERSION-FILE is included in the archive.
> 
> The perf RPM provided by Fedora for 5.18+ is experiencing this problem.
> Package build logs[0] show that the build is attempting to fall back on
> PERF-VERSION-FILE, but it is not present.
> 
> To resolve this, revert back to the previous logic of using the kernel
> Makefile version if not in a git repository and PERF-VERSION-FILE does
> not exist.
> 
> [0] https://kojipkgs.fedoraproject.org/packages/kernel-tools/5.19.4/200.fc36/data/logs/x86_64/build.log
> 
> Fixes: 7572733b8499 ("perf tools: Fix version kernel tag, 2022-02-21")
> Signed-off-by: Will Chandler <wfc@wfchandler.org>

This looks fine, thanks.

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
> Range-diff against v1:
> 1:  8195a5ccd82d < -:  ------------ perf tools: Fix empty version number when building outside of a git repo
> -:  ------------ > 1:  a3beccdab700 perf tools: Fix empty version number when building outside of a git repo
> 
>   tools/perf/util/PERF-VERSION-GEN | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
> index 0ee5af529238..3cc42821d9b3 100755
> --- a/tools/perf/util/PERF-VERSION-GEN
> +++ b/tools/perf/util/PERF-VERSION-GEN
> @@ -11,7 +11,8 @@ LF='
>   '
>   
>   #
> -# Always try first to get the version from the kernel Makefile
> +# Use version from kernel Makefile unless not in a git repository and
> +# PERF-VERSION-FILE exists
>   #
>   CID=
>   TAG=
> @@ -19,9 +20,14 @@ if test -d ../../.git -o -f ../../.git
>   then
>   	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
>   	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
> -else
> +elif test -f ../../PERF-VERSION-FILE
> +then
>   	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
>   fi
> +if test -z "$TAG"
> +then
> +	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
> +fi
>   
>   VN="$TAG$CID"
>   if test -n "$CID"

