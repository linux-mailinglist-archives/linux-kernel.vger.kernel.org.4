Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75076606D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJUBs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJUBs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:48:27 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4813F1DF;
        Thu, 20 Oct 2022 18:48:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VShB2hj_1666316900;
Received: from 192.168.199.158(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0VShB2hj_1666316900)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 09:48:21 +0800
Message-ID: <8b2864bd-30b1-254f-ebd6-79967249da9b@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 18:48:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC] Documentation: kbuild: Add description of git for
 reproducible builds
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, corbet@lwn.net,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>
References: <20221020103823.31001-1-ashimida@linux.alibaba.com>
 <Y1FVphEyu23U0jho@debian.me>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <Y1FVphEyu23U0jho@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/22 07:05, Bagas Sanjaya wrote:
> On Thu, Oct 20, 2022 at 03:38:23AM -0700, Dan Li wrote:
>> diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
>> index 071f0151a7a4..13397f38c358 100644
>> --- a/Documentation/kbuild/reproducible-builds.rst
>> +++ b/Documentation/kbuild/reproducible-builds.rst
>> @@ -119,6 +119,16 @@ To avoid this, you can make the vDSO different for different
>>   kernel versions by including an arbitrary string of "salt" in it.
>>   This is specified by the Kconfig symbol ``CONFIG_BUILD_SALT``.
>>   
>> +Git
>> +-----------------------
>> +
>> +Uncommitted changes or different commit ids in git can also lead
>> +to different compilation results. For example, after executing
>> +``git reset HEAD^``, even if the code is the same, the
>> +``include/config/kernel.release`` generated during compilation
>> +will be different, which will eventually lead to binary differences.
>> +See ``scripts/setlocalversion`` for details.
>> +
> 
> Briefly read the script, I don't see what the correlation between git
> reset with LOCALVERSION thing is. Also, does the exact state of git
> repository required for reproducible builds?
> 

Hi Bagas,

The Makefile has the following code:
filechk_kernel.release = \
         echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"

The output of setlocalversion affects kernel.release, while the output
of setlocalversion is related to the state of git when the git repository
exists (see function scm_version).

So changes in git state will result in changes to kernel.release, and
this information will be included in the final output vmlinux/modules
and in turn affect reproducible builds.

For example:
$ git log
commit 4cd155a93eec......
$ make ...
$ cat include/config/kernel.release
6.0.0-rc4-00025-g4cd155a93eec

$ git reset HEAD^
$ git log
commit 7b4d266b0c41......
$ make ...
$ cat include/config/kernel.release
6.0.0-rc4-00024-g7b4d266b0c41-dirty


AFAICT, in the presence of a git repository, we can compile a reproducible
build kernel in any git state, but we need to ensure that the git state is
always the same between compilations (or the same from the perspective of
the scm_version function).

Thanks, Dan.

> Thanks.
> 
