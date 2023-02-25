Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBAE6A2A49
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 15:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBYOXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 09:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 09:23:00 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E3D309
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 06:22:57 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pVvRv-0003jp-Ek; Sat, 25 Feb 2023 15:22:55 +0100
Message-ID: <9f682c4d-e7b7-5e23-84f5-cea4fdac2085@leemhuis.info>
Date:   Sat, 25 Feb 2023 15:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        davidgow@google.com, rmoar@google.com, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CABXGCsO4=qKBF=2FRPVwW8FA4iLFh0Dt9n1BLMec3k10GUorpg@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [6.3][regression] after commit
 7170b7ed6acbde523c5d362c8978c60df4c30f30 my system stuck in initramfs forever
In-Reply-To: <CABXGCsO4=qKBF=2FRPVwW8FA4iLFh0Dt9n1BLMec3k10GUorpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1677334977;b15028ee;
X-HE-SMSGID: 1pVvRv-0003jp-Ek
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 25.02.23 14:51, Mikhail Gavrilov wrote:
> new kernel release cycle returning with new bugs
> Today my system got stuck in initramfs environment after updating to
> commit d2980d8d826554fa6981d621e569a453787472f8.
> 
> I still do not understand how to configure the network inside the
> initramfs environment to grab the logs.
> Since an attempt to rebuild the initramfs with all modules (dracut
> --no-hostonly --force) leads to the stuck initramfs environment and
> impossible entering into initramfs console.

Do you see any error messages? I have problems since Friday morning as
well (stuck in Fedora's initramfs) and see a lot of BPF warnings like
"BPF: invalid name" and "failed to validate module". Was able to do a
screenshot:

https://www.leemhuis.info/files/misc/Screenshot_ktst-f36-x86-64_2023-02-24_07:53:14.png

Funny detail: my Thursday morning built for my Fedora vanilla repos[1]
(which happened after the main net and thus bpf merge) worked; my Friday
morning built (which among others contained the kunit updates) was the
first to fail, so maybe we have the same problem. I did a quick
localmodconfig earlier today, which worked (but localmodconfig disabled
KUNIT, which might explain why it worked).

Ciao, Thorsten

[1] https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories

> But I can bisect the problem and bisection blames this commit:
> 
> ❯ git bisect good
> 7170b7ed6acbde523c5d362c8978c60df4c30f30 is the first bad commit
> commit 7170b7ed6acbde523c5d362c8978c60df4c30f30
> Author: David Gow <davidgow@google.com>
> Date:   Sat Jan 28 15:10:07 2023 +0800
> 
>     kunit: Add "hooks" to call into KUnit when it's built as a module
> 
>     KUnit has several macros and functions intended for use from non-test
>     code. These hooks, currently the kunit_get_current_test() and
>     kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.
> 
>     In order to support this case, the required functions and static data
>     need to be available unconditionally, even when KUnit itself is not
>     built-in. The new 'hooks.c' file is therefore always included, and has
>     both the static key required for kunit_get_current_test(), and a table
>     of function pointers in struct kunit_hooks_table. This is filled in with
>     the real implementations by kunit_install_hooks(), which is kept in
>     hooks-impl.h and called when the kunit module is loaded.
> 
>     This can  be extended for future features which require similar
>     "hook" behaviour, such as static stubs, by simply adding new entries to
>     the struct, and the appropriate code to set them.
> 
>     Fixed white-space errors during commit:
>     Shuah Khan <skhan@linuxfoundation.org>
> 
>     Resolved merge conflicts with:
>     db105c37a4d6 ("kunit: Export kunit_running()")
>     This patch supersedes the above.
>     Shuah Khan <skhan@linuxfoundation.org>
> 
>     Signed-off-by: David Gow <davidgow@google.com>
>     Reviewed-by: Rae Moar <rmoar@google.com>
>     Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
>  Documentation/dev-tools/kunit/usage.rst | 15 ++++++---------
>  include/kunit/test-bug.h                | 28 ++++++++++------------------
>  lib/Makefile                            |  8 ++++++++
>  lib/kunit/Makefile                      |  3 +++
>  lib/kunit/hooks-impl.h                  | 27 +++++++++++++++++++++++++++
>  lib/kunit/hooks.c                       | 21 +++++++++++++++++++++
>  lib/kunit/test.c                        | 15 +++++++--------
>  7 files changed, 82 insertions(+), 35 deletions(-)
>  create mode 100644 lib/kunit/hooks-impl.h
>  create mode 100644 lib/kunit/hooks.c
> 
> Unfortunately I couldn't revert this commit staying on
> d2980d8d826554fa6981d621e569a453787472f8 because of conflicts:
> ❯ git revert 7170b7ed6acbde523c5d362c8978c60df4c30f30 -n
> Auto-merging include/kunit/test-bug.h
> CONFLICT (content): Merge conflict in include/kunit/test-bug.h
> Auto-merging lib/Makefile
> Auto-merging lib/kunit/Makefile
> CONFLICT (modify/delete): lib/kunit/hooks-impl.h deleted in parent of
> 7170b7ed6acb (kunit: Add "hooks" to call into KUnit when it's built as
> a module) and modified in HEAD.  Version HEAD of
> lib/kunit/hooks-impl.h left in tree.
> Auto-merging lib/kunit/test.c
> CONFLICT (content): Merge conflict in lib/kunit/test.c
> error: could not revert 7170b7ed6acb... kunit: Add "hooks" to call
> into KUnit when it's built as a module
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> 
