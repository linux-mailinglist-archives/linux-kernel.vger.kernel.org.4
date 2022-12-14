Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC264CF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiLNSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLNSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:36:06 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E7CFD05;
        Wed, 14 Dec 2022 10:36:03 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C11B7435AA;
        Wed, 14 Dec 2022 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671042961;
        bh=bDbADm2ytnQgP6masRJTsLpTidVZv8Elr+s7Ew1V3uc=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
        b=nf4Uc2gYA5CIxl5iCTGx9sFqLKF5aoO2Qi4vKoLIMCkijohZwE5MXoBflgBvwWU+p
         L3pUSZfvJUcRYF2UYJiU7xKyK57M9TKk9xYALgNpPqbTmwBmMr8HEcbvJOvcE08Jj+
         1navNMci8996puj6OEVcUU8RgqxFHK5xsCCEubQUQ9W+zs1jgVKxhsYxr1BcgZI/0V
         YsygVIS78ghK63IbWL5HdYAJU29yZl+JPbvhBfw46+NNkWa/ajyTy0Ih6dr1jiiv05
         v7h01K1x9c3UbPEgbuf+VnQYkNhD7y4Bpnjod/NWJbkrqcjqWgVzGLNNcDyrxwPXw/
         SD0QW4W2FMxug==
Message-ID: <218cac2c-47ae-435d-d7d0-48e4937a7f99@canonical.com>
Date:   Wed, 14 Dec 2022 10:35:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor changes for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Language: en-US
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following apparmor update for Linux 6.2-rc1

This apparmor update for 6.2 is primarily bug fixes and code
cleanup/refactoring.

+ Features
   - switch to zstd compression for profile raw data

+ Cleanups
   - Simplify obtain the newest label on a cred
   - remove useless static inline functions
   - compute permission conversion on policy unpack
   - refactor code to share common permissins
   - refactor unpack to group policy backwards compatiblity code
   - add __init annotation to aa_{setup/teardown}_dfa_engine()

+ Bug Fixes
   - fix a memleak in
     - multi_transaction_new()
     - free_ruleset()
     - unpack_profile()
     - alloc_ns()
   - fix lockdep warning when removing a namespace
   - fix regression in stacking due to label flags
   - fix loading of child before parent
   - fix kernel-doc comments that differ from fns
   - fix spelling errors in comments
   - store return value of unpack_perms_table() to signed variable


The bulk of the code is in a set of changes is a cleanup that moves
some permission computations from run time to policy is load. This
provides a small performance improvement but is also a step toward
us being able to merge and reduce the different permission lookup
code at runtime.


Please note this patch series has conflicts with the KUnit and LSM trees,
and has been coordinated to follow those merges as all the conflicts are
in apparmor

- The LSM tree conflict is a simple conflict in
     security/apparmor/domain.c
   between the apparmor permission cleanups and
     f6fbd8cbf3ed lsm,fs: fix vfs_getxattr_alloc() return type and caller error paths

- The KUnit tree conflict is large but fairly straight forward. It is
   large due to the code refactoring in the permissions cleanup, so it
   covers some code that does not get marked as having conflicts.
   The gist of the conflicting Kunit change is that to be able to make
   the apparmor KUnit tests as module several apparmor symbols that
   were previously static need to be exported. To do this the symbols
   are prefixed with the aa_ namespace and conditionally exported with
   VISIBLE_IF_KUNIT

   conflicts in
     security/apparmor/policy_unpack.c
     security/apparmor/policy_unpack_test.c

   with additional changes beyond the conflicts needed in
     security/apparmor/policy_unpack.c
     security/apparmor/include/policy_unpack.h

I have prepared two branches covering the merge conflict.


The first
   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-12-14-merge-breakout

branch breaks the changes into 3 patches.
- the merge and any changes that had associated conflicts
- a patch where Stephen Rothwell beat me to fixing a build failure
   in linux-next due to the merge needing changes beyond those with
   associated conflicts
- a patch covering the rest of changes that are required but did not
   have conflicts and are not covered by Stephen's patch.


The second
   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-12-14-merge

is all the changes from the first as a single merge commit


the above merge conflict resolution has been built and tested
with Kunit as built-in, module and disabled.

thanks
- john


The following changes since commit 3cc40a443a04d52b0c95255dce264068b01e9bfe:

   Merge tag 'nios2_fixes_v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux (2022-08-16 11:42:11 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-12-14

for you to fetch changes up to 4295c60bbe9e63e35d330546eeaa1d2b62dae303:

   apparmor: Fix uninitialized symbol 'array_size' in policy_unpack_test.c (2022-11-01 21:23:05 -0700)

----------------------------------------------------------------
+ Features
   - switch to zstd compression for profile raw data

+ Cleanups
   - Simplify obtain the newest label on a cred
   - remove useless static inline functions
   - compute permission conversion on policy unpack
   - refactor code to share common permissins
   - refactor unpack to group policy backwards compatiblity code
   - add __init annotation to aa_{setup/teardown}_dfa_engine()

+ Bug Fixes
   - fix a memleak in
     - multi_transaction_new()
     - free_ruleset()
     - unpack_profile()
     - alloc_ns()
   - fix lockdep warning when removing a namespace
   - fix regression in stacking due to label flags
   - fix loading of child before parent
   - fix kernel-doc comments that differ from fns
   - fix spelling errors in comments
   - store return value of unpack_perms_table() to signed variable

----------------------------------------------------------------
Gaosheng Cui (5):
       apparmor: fix a memleak in multi_transaction_new()
       apparmor: Simplify obtain the newest label on a cred
       apparmor: remove useless static inline functions
       apparmor: fix obsoleted comments for aa_getprocattr() and audit_resource()
       apparmor: fix a memleak in free_ruleset()

Jiapeng Chong (3):
       AppArmor: Fix kernel-doc
       LSM: Fix kernel-doc
       AppArmor: Fix kernel-doc

John Johansen (45):
       apparmor: fix lockdep warning when removing a namespace
       apparmor: reserve mediation classes
       apparmor: move fperm computation into policy_unpack
       apparmor: rework and cleanup fperm computation
       apparmor: convert xmatch to use aa_perms structure
       apparmor: compute policydb permission on profile load
       apparmor: combine file_rules and aa_policydb into a single shared struct
       apparmor: convert xmatch to using the new shared policydb struct
       apparmor: convert fperm lookup to use accept as an index
       apparmor: convert xmatch lookup to use accept as an index
       apparmor: cleanup shared permission struct
       apparmor: convert policy lookup to use accept as an index
       apparmor: preparse for state being more than just an integer
       apparmor: Fix abi check to include v8 abi
       apparmor: fix apparmor mediating locking non-fs unix sockets
       apparmor: extend policydb permission set by making use of the xbits
       apparmor: move dfa perm macros into policy_unpack
       apparmor: extend xindex size
       apparmor: isolate policy backwards compatibility to its own file
       apparmor: extend permissions to support a label and tag string
       apparmor: add mediation class information to auditing
       apparmor: add user mode flag
       apparmor: make transition table unpack generic so it can be reused
       apparmor: group dfa policydb unpacking
       apparmor: make unpack_array return a trianary value
       apparmor: add the ability for policy to specify a permission table
       apparmor: verify permission table indexes
       apparmor: make sure perm indexes are accumulated
       apparmor: cleanup: move perm accumulation into perms.h
       apparmor: verify loaded permission bits masks don't overlap
       apparmor: refactor profile rules and attachments
       apparmor: rework profile->rules to be a list
       apparmor: fix aa_class_names[] to match reserved classes
       apparmor: Fix regression in stacking due to label flags
       apparmor: Fix doc comment for compute_fperms
       apparmor: Remove unnecessary size check when unpacking trans_table
       apparmor: make sure the decompression ctx is promperly initialized
       apparmor: Fix undefined references to zstd_ symbols
       apparmor: Fix decompression of rawdata for read back to userspace
       apparmor: Fix kunit test for out of bounds array
       apparmor: fix uninitialize table variable in error in unpack_trans_table
       apparmor: Fix unpack_profile() warn: passing zero to 'ERR_PTR'
       apparmor: refactor code that alloc null profiles
       apparmor: Fix loading of child before parent
       apparmor: Fix uninitialized symbol 'array_size' in policy_unpack_test.c

Jon Tourville (2):
       apparmor: use zstd compression for profile data
       apparmor: expose compression level limits in sysfs

Mike Salvatore (2):
       apparmor: compute file permissions on profile load
       apparmor: compute xmatch permissions on profile load

Muhammad Usama Anjum (1):
       apparmor: store return value of unpack_perms_table() to signed variable

Xiu Jianfeng (5):
       apparmor: make __aa_path_perm() static
       apparmor: Use pointer to struct aa_label for lbs_cred
       apparmor: Fix memleak issue in unpack_profile()
       apparmor: Fix memleak in alloc_ns()
       apparmor: Add __init annotation to aa_{setup/teardown}_dfa_engine()

Yang Li (1):
       apparmor: Fix spelling of function name in comment block

  security/apparmor/Kconfig                 |   4 +-
  security/apparmor/Makefile                |   3 +-
  security/apparmor/apparmorfs.c            | 115 +++---
  security/apparmor/audit.c                 |  45 ++-
  security/apparmor/capability.c            |  16 +-
  security/apparmor/domain.c                | 149 ++++----
  security/apparmor/file.c                  | 125 ++-----
  security/apparmor/include/apparmor.h      |  23 +-
  security/apparmor/include/audit.h         |   8 +-
  security/apparmor/include/cred.h          |  13 -
  security/apparmor/include/domain.h        |   6 -
  security/apparmor/include/file.h          | 108 +-----
  security/apparmor/include/label.h         |  13 +-
  security/apparmor/include/lib.h           |  10 +-
  security/apparmor/include/match.h         |  28 +-
  security/apparmor/include/net.h           |   1 +
  security/apparmor/include/perms.h         |  91 ++++-
  security/apparmor/include/policy.h        | 141 +++++--
  security/apparmor/include/policy_compat.h |  33 ++
  security/apparmor/include/policy_unpack.h |   2 +
  security/apparmor/ipc.c                   |  16 +-
  security/apparmor/label.c                 |  75 ++--
  security/apparmor/lib.c                   | 125 ++-----
  security/apparmor/lsm.c                   |  25 +-
  security/apparmor/match.c                 |  62 ++--
  security/apparmor/mount.c                 |  93 +++--
  security/apparmor/net.c                   |  28 +-
  security/apparmor/policy.c                | 204 ++++++++--
  security/apparmor/policy_compat.c         | 319 ++++++++++++++++
  security/apparmor/policy_ns.c             |   6 +-
  security/apparmor/policy_unpack.c         | 598 ++++++++++++++++++++----------
  security/apparmor/policy_unpack_test.c    |  17 +-
  security/apparmor/procattr.c              |  11 +-
  security/apparmor/resource.c              |  29 +-
  security/apparmor/task.c                  |  14 +-
  35 files changed, 1644 insertions(+), 912 deletions(-)
  create mode 100644 security/apparmor/include/policy_compat.h
  create mode 100644 security/apparmor/policy_compat.c
