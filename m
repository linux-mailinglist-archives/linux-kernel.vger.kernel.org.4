Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFE691993
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjBJIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjBJIEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:04:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0E7B393;
        Fri, 10 Feb 2023 00:04:34 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7scLY025404;
        Fri, 10 Feb 2023 08:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=m43nioP44C8NgtlBmpkoMJ81/ALcxURsxuVWgJil+qY=;
 b=ajLKEiH7BxSxmiEOpSHB0l3AnX+OKPtXM+Z6pHNcEPvcL4jTQ23ZO6+CDQ1q69lyOuC/
 jGiiDMoY4HImjk/8VDq9RTkGv3fEC2Y95pyepgKI6HKyk5XPBTZyUkgbtNvzs0DkeMow
 4ESX9T62BB8qCb9Lht+6iH83TgF6fpcHMjVD9nZTAi1Vba1oyRF+dqPFnoN2Z9n1W9uV
 Oj6yy3k5P+7DOCFY3qqczox72uDM4UAZbAteMJ2BGWxIkCrEp5XcpYK01P7nHs4o1Anz
 z5TLTGdE7aFttSAm/j2Pee/plqFh6j2S1nUu3Ej0WEXWVbLRvIKDVSYftufPzLZkj66d kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhxxg9a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:24 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A7uxdM031798;
        Fri, 10 Feb 2023 08:04:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhxxg98n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A5nqHc002355;
        Fri, 10 Feb 2023 08:04:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06q4vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A84IwV48693518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:04:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA5CE20043;
        Fri, 10 Feb 2023 08:04:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3E0220040;
        Fri, 10 Feb 2023 08:04:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 08:04:17 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 81A80605F1;
        Fri, 10 Feb 2023 19:04:14 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v6 00/26] pSeries dynamic secure boot secvar interface + platform keyring loading
Date:   Fri, 10 Feb 2023 19:03:35 +1100
Message-Id: <20230210080401.345462-1-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U4qqNd5BFduuGHZ3TS39HOLvVCmcDPA4
X-Proofpoint-GUID: 5BpZ42joUH1eMLiF9O0kHqVit71exjyg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series exposes an interface to userspace for reading and writing
secure variables contained within the PowerVM LPAR Platform KeyStore
(PLPKS) for the purpose of configuring dynamic secure boot, and adds
the glue required to load keys from the PLPKS into the platform keyring.

This series builds on past work by Nayna Jain[0] in exposing PLPKS
variables to userspace.  Rather than being a generic interface for
interacting with the keystore, however, we use the existing powerpc
secvar infrastructure to only expose objects in the keystore used
for dynamic secure boot.  This has the benefit of leveraging an
existing interface and making the implementation relatively minimal.

This series integrates a previous series to fix some bugs in PLPKS
and implement support for signed updates[1], and a cleanup patch from
Michael Ellerman[2].

There are a few relevant details to note about the implementation:

 * New additions to the secvar API: format(), max_size(), config_attrs,
   var_names

 * New optional sysfs directory "config/" for arbitrary ASCII variables

 * Some OPAL-specific code has been relocated from secvar-sysfs.c to
   powernv platform code.  Would appreciate any powernv testing!

 * Variable names are fixed and only those used for secure boot are
   exposed.  This is not a generic PLPKS interface, but also doesn't
   preclude one being added in future.

With this series, both powernv and pseries platforms support dynamic
secure boot through the same interface.

Many thanks to Nayna Jain, Ben Gray, Sudhakar Kuppusamy, Shubham Pandey,
Mimi Zohar, George Wilson and the others at IBM who have helped us with
developing this series, and to everyone who has provided review comments
and feedback.

[0]: https://lore.kernel.org/linuxppc-dev/20221106210744.603240-1-nayna@linux.ibm.com/
[1]: https://lore.kernel.org/linuxppc-dev/20221220071626.1426786-1-ajd@linux.ibm.com/
[2]: https://lore.kernel.org/linuxppc-dev/20230112023819.1692452-1-mpe@ellerman.id.au/

v1: https://lore.kernel.org/linuxppc-dev/20221228072943.429266-1-ruscur@russell.cc/
v2: https://lore.kernel.org/linuxppc-dev/20221230042014.154483-1-ruscur@russell.cc/
v3: https://lore.kernel.org/linuxppc-dev/20230118061049.1006141-1-ajd@linux.ibm.com/
v4: https://lore.kernel.org/linuxppc-dev/20230120074306.1326298-1-ajd@linux.ibm.com/
v5: https://lore.kernel.org/linuxppc-dev/20230131063928.388035-1-ajd@linux.ibm.com/

=================

Changes in v6:

    Minor code style + commit message fixes (stefanb)

    Get rid of an unneeded kzalloc (npiggin)

    Don't allocate extra space in the FDT on kexec (ruscur)

    Clarify the warning message in cases where password is already set (ajd)

Changes in v5:

    New patch to fix incorrect return value in secvar_sysfs_load() (ruscur)

    Better explanation of power of 2 kmalloc rounding (mpe)

    Add null component check on signed updates (npiggin)

    Don't export plpks_signed_update_var() (npiggin)

    Fix all the feedback we got on kexec handling, including removing the
    password from the FDT (npiggin, mpe)

    Enable plpks-secvar.c using CONFIG_PPC_SECURE_BOOT rather than
    CONFIG_PPC_SECVAR_SYSFS (ajd)

    Clarify handling of ibm,secvar-backend vs ibm,edk2-compat-v1
    compatible string (zohar)

    Lots of miscellaneous improvements (npiggin)

Changes in v4:

    Fix the build when CONFIG_PSERIES_PLPKS=n (snowpatch)

    Shuffled fixes to the front the series (npiggin)

    Pass buffer size in secvar_operations->format() (stefanb, npiggin)

    Return an error when set_secvar_ops() fails (npiggin)

    Add some extra null checks (stefanb, gjoyce)

    Add commit message comment elaborating on PAGE_SIZE issues (joel)

    Fix error handling in the kexec code (ruscur)

    Fix hvcall.h MAX_HCALL_OPCODE rebasing issue (npiggin)

Changes in v3:

    Integrate Andrew's PLPKS bugfixes and enhancements series and Michael
    Ellerman's u64 cleanup patch into this series (and update the other
    patches to use u64)

    New patches to load keys from the PLPKS into the kernel's platform
    keyring (ruscur)

    New patches to pass PLPKS password to new kernels when kexecing
    (ruscur)

    Improve handling of format strings (ruscur)

    Clean up secvar error messages (ajd)

    Merge config attributes into secvar_operations (mpe)

    Add a new static variable names API rather than (ab)using get_next()
    (ajd/mpe)

    Warning message when PAGE_SIZE is smaller than the max object size
    (ajd)

    Move plpks.h to the include directory, and move a bunch of constants
    in there with a consistent naming scheme

    Refresh PLPKS config values whenever plpks_get_usedspace() is called
    (ajd)

    Extra validation on PLPKS config values (ruscur)

    Return maxobjlabelsize to userspace as is without subtracting overhead (ruscur)

    Fix error code handling in plpks_confirm_object_flushed() (ruscur)

    Pass plpks_var struct to plpks_signed_update_var() by reference (mpe)

    Make the data buffer in plpks_read_var() caller-allocated to reduce
    number of allocations/copies (mpe)

    Rework the Kconfig options so that PSERIES_PLPKS is a hidden option,
    turned on by enabling PPC_SECURE_BOOT, and the PLPKS secvar code is
    activated by PPC_SECVAR_SYSFS to match powernv (ajd)

    Use machine_arch_initcall() rather than device_initcall() so we don't
    break powernv (mpe)

    Improve ABI documentation (mpe)

    Return -EIO on most read errors (mpe)

    Add "grubdbx" variable (Sudhakar)

    Use utf8s_to_utf16s() rather than our own "UCS-2" conversion code (mpe)

    Fix SB_VERSION data length (ruscur)

    Stop prepending policy data on read (ruscur)

    Don't print errors to the kernel log when reading non-existent
    variables (Sudhakar)

    Miscellaneous code style, checkpatch cleanups

Changes in v2:

    Remove unnecessary config vars from sysfs and document the others,
    thanks to review from Greg.  If we end up needing to expose more, we
    can add them later and update the docs.

    Use sysfs_emit() instead of sprintf() for all sysfs strings

    Change the size of the sysfs binary attributes to include the 8-byte
    flags header, preventing truncation of large writes.

Andrew Donnellan (9):
  powerpc/pseries: Fix handling of PLPKS object flushing timeout
  powerpc/pseries: Fix alignment of PLPKS structures and buffers
  powerpc/secvar: Clean up init error messages
  powerpc/secvar: Allow backend to populate static list of variable
    names
  powerpc/secvar: Warn when PAGE_SIZE is smaller than max object size
  powerpc/secvar: Don't print error on ENOENT when reading variables
  powerpc/pseries: Make caller pass buffer to plpks_read_var()
  powerpc/pseries: Turn PSERIES_PLPKS into a hidden option
  powerpc/pseries: Clarify warning when PLPKS password already set

Michael Ellerman (1):
  powerpc/secvar: Use u64 in secvar_operations

Nayna Jain (2):
  powerpc/pseries: Expose PLPKS config values, support additional fields
  powerpc/pseries: Implement signed update for PLPKS objects

Russell Currey (14):
  powerpc/secvar: Fix incorrect return in secvar_sysfs_load()
  powerpc/secvar: Warn and error if multiple secvar ops are set
  powerpc/secvar: Use sysfs_emit() instead of sprintf()
  powerpc/secvar: Handle format string in the consumer
  powerpc/secvar: Handle max object size in the consumer
  powerpc/secvar: Extend sysfs to include config vars
  powerpc/pseries: Move plpks.h to include directory
  powerpc/pseries: Move PLPKS constants to header file
  powerpc/pseries: Log hcall return codes for PLPKS debug
  powerpc/pseries: Add helper to get PLPKS password length
  powerpc/pseries: Pass PLPKS password on kexec
  powerpc/pseries: Implement secvars for dynamic secure boot
  integrity/powerpc: Improve error handling & reporting when loading
    certs
  integrity/powerpc: Support loading keys from PLPKS

 Documentation/ABI/testing/sysfs-secvar        |  75 +++-
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/hvcall.h             |   1 +
 arch/powerpc/include/asm/plpks.h              | 195 +++++++++
 arch/powerpc/include/asm/secvar.h             |  21 +-
 arch/powerpc/kernel/prom.c                    |   4 +
 arch/powerpc/kernel/secvar-ops.c              |  10 +-
 arch/powerpc/kernel/secvar-sysfs.c            | 178 ++++----
 arch/powerpc/kexec/file_load_64.c             |  18 +-
 arch/powerpc/platforms/powernv/opal-secvar.c  |  60 ++-
 arch/powerpc/platforms/pseries/Kconfig        |  19 +-
 arch/powerpc/platforms/pseries/Makefile       |   4 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 218 ++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 381 +++++++++++++++---
 arch/powerpc/platforms/pseries/plpks.h        |  71 ----
 .../integrity/platform_certs/load_powerpc.c   |  47 ++-
 16 files changed, 1046 insertions(+), 257 deletions(-)
 create mode 100644 arch/powerpc/include/asm/plpks.h
 create mode 100644 arch/powerpc/platforms/pseries/plpks-secvar.c
 delete mode 100644 arch/powerpc/platforms/pseries/plpks.h

-- 
2.39.1
