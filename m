Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87515ED8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiI1JVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiI1JVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:21:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA99CCC6;
        Wed, 28 Sep 2022 02:21:38 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McrbG1ywyz6HJT3;
        Wed, 28 Sep 2022 17:21:30 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 11:21:34 +0200
Received: from [10.126.175.219] (10.126.175.219) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 10:21:33 +0100
Message-ID: <c5181877-2998-b952-abe6-26d733ae2aeb@huawei.com>
Date:   Wed, 28 Sep 2022 10:21:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf tools: Fix empty version number when building
 outside of a git repo
To:     Will Chandler <wfc@wfchandler.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220927195228.47304-1-wfc@wfchandler.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220927195228.47304-1-wfc@wfchandler.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.219]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 20:52, Will Chandler wrote:
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
> To resolve this, always use the tag from the root Makefile if available.
> 
> [0] https://kojipkgs.fedoraproject.org/packages/kernel-tools/5.19.4/200.fc36/data/logs/x86_64/build.log
> 

Sorry for the breakage. I only considered perf-tar-src-pkg for 
out-of-git building.

> Fixes: 7572733b8499 ("perf tools: Fix version kernel tag, 2022-02-21")
> Signed-off-by: Will Chandler <wfc@wfchandler.org>
> ---
>   tools/perf/util/PERF-VERSION-GEN | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
> index 0ee5af529238..43b8a8ea6f53 100755
> --- a/tools/perf/util/PERF-VERSION-GEN
> +++ b/tools/perf/util/PERF-VERSION-GEN
> @@ -15,10 +15,13 @@ LF='
>   #
>   CID=
>   TAG=
> -if test -d ../../.git -o -f ../../.git
> +if test -r ../../Makefile
>   then
>   	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
> -	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
> +	if test -d ../../.git -o -f ../../.git
> +	then
> +	    CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
> +	fi
>   else
>   	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
>   fi

This looks ok. But did you consider going back to same flow as 
pre-7572733b8499 to avoid a Makefile check, like:

---8<----

CID=
TAG=
if test -d ../../.git -o -f ../../.git
then
TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && 
CID="-g$CID"
elif test -f ../../PERF-VERSION-FILE
then
TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
fi
if test -z "$TAG"
then
TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
fi

--->8---

The evaluation for $TAG is not really needed in the first leg since the 
fallback does the same thing, but just added for clarity.

Thanks,
John
