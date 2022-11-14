Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4737C6287A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiKNR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiKNR6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:58:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842DB24BC7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:58:51 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEGTYnf014192;
        Mon, 14 Nov 2022 17:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lt0LzME4yHuzeeFSemhEFnHnurbITRdro2viUsMDfQw=;
 b=Swijqf/hm6Y0WET46NogKDIoIcUDh5NNPWIYygp7Af7lE5U+eD+QJr9nbftDNjLX6pUX
 JWzg6fR4gcIetdyqtzL6ujA4PLfRnoB45ns3b1C935kngQhdt2jMLNAFWgCOSZsWhX6C
 M3+q92BJR20o0Uj6y1cNlRe3u2HB1j8SnYzvwPDIzwveNwdAfFLkq+GW/T6aF5qOI+D4
 bqylTaLBr+dHFdvf4uYSExi0SrvAEtz08JGH0PrYMbvmV9cBeakobdixd/22qYDhgTrh
 llUcIf50LA3S5My370CV+jQsjDbCWFskd735ws+POyPP4cWbrTlCBLOpty21ePg+odtW xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kus88j86b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:58:23 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEHlWAk009668;
        Mon, 14 Nov 2022 17:58:23 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kus88j85a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:58:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEHpcUc009567;
        Mon, 14 Nov 2022 17:58:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3kt348txub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:58:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEHwIOe8192274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:58:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF6A611C04C;
        Mon, 14 Nov 2022 17:58:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B68011C04A;
        Mon, 14 Nov 2022 17:58:13 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.116.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 17:58:13 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v6 00/16] objtool: Enable and implement --mcount option on powerpc
Date:   Mon, 14 Nov 2022 23:27:38 +0530
Message-Id: <20221114175754.1131267-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: boPTZKOD5SKdC4P2Idutvbiy0YCfHnl4
X-Proofpoint-GUID: uUuF3t6nchN4O_OxyGh5ZQumj6D8Jmjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables and implements objtool --mcount
option on powerpc. This applies atop powerpc/merge branch.

Changelog:

----
v6:

* Patch 06/16 - Add annotations to assembly files
		arch/powerpc/kernel/cpu_setup_e500.S and arch/powerpc/kernel/head_85xx.S
----
v5:

* Patch 02/16 - Add Reviewed-by tag from Christophe Leroy

* Patch 03/16 - Fix merge conflicts with latest powerpc/merge branch

* Patch 06/16 - Files arch/powerpc/kernel/cpu_setup_fsl_booke.S and
		arch/powerpc/kernel/head_fsl_booke.S are not present
		today. Removed annotations in those assembly files.

* Patch 11/16 - Add Reviewed-by tag from Christophe Leroy
	      - Changed scripts/Makefile.lib file to make
	        CONFIG_HAVE_OBJTOOL_NOP_MCOUNT depend on
		CONFIG_FTRACE_MCOUNT_USE_OBJTOOL.

* Patch 12/16 - Add Reviewed-by tag from Christophe Leroy

* Patch 16/16 - Add Reviewed-by tag from Christophe Leroy 

* For this series - Add Acked-by tag from Josh Poimboeuf
		  - Add Tested-by tag from Naveen N. Rao
		  - Add Reviewed-by tag from Naveen N. Rao
----
v4:

* Patch 11/16 - Introduce a new config option
                CONFIG_HAVE_OBJTOOL_NOP_MCOUNT as a means for
                architectures to enable nop'ing ftrace locations.

              - Remove Acked-by tag from Peter Zijlstra (Intel),
                and Reviewed-by tag from Christophe Leroy.
                [This is done because I reworked the patch to add
                a new config option to objtool. Please let me know
                if you want me to retain the tags. Thanks!]

* Patch 16/16 - Rework the patch to handle only 'bl' instruction
                decoding.

----
v3:

* Patch 01/16 - Rework patch subject.
              - Rework changelog.
              - Add Reviewed-by tag from Christophe Leroy.

* Patch 02/16 - Rework changelog to update details based on feedback
                from Nicholas Piggin and Michael Ellerman.
              - Use quotes instead of __stringify macro, based on
                suggestion from Christophe Leroy.

* Patch 03/16 - Add Reviewed-by tag from Christophe Leroy.
              - Based on Christophe's suggestion, keep all <linux/...>
                before <asm/...>.
              - Rework changelog.

* Patch 04/16 - Add Reviewed-by tag from Christophe Leroy.

* Patch 05/16 - Add Reviewed-by tag from Christophe Leroy.

* Patch 06/16 - No change.

* Patch 07/16 - Add Reviewed-by tag from Christophe Leroy.

* Patch 08/16 - Add Acked-by tag from Peter Zijlstra.

* Patch 09/16 - Add Acked-by tag from Peter Zijlstra.

* Patch 10/16 - Reorder local variable declarations to use reverse
                xmas tree format.
              - Add Signed-off-by tag from Sathvika Vasireddy indicating
                changes done.
              - Add Acked-by tag from Peter Zijlstra.

* Patch 11/16 - Update changelog to indicate that powerpc kernel does
                not support nop'ed out ftrace locations.
              - Add Acked-by tag from Peter Zijlstra.
              - Add Reviewed-by tag from Christophe Leroy.

* Patch 12/16 - Per Christophe's comment, rework changelog.

* Patch 13/16 - Add Acked-by tag from Peter Zijlstra.
              - Add Reviewed-by tag from Christophe Leroy.

* Patch 14/16 - Simplify arch_ftrace_match() function, based on
                Christophe's suggestion.
              - Add Reviewed-by tag from Christophe Leroy.

* Patch 15/16 - Include code from Christophe Leroy to use local vars for
                type and imm, and to adapt len for prefixed
                instructions.

* Patch 16/16 - Based on suggestion from Christophe Leroy, setup
                immediate value calculation outside the check for
                specific instruction under case 18.
              - Set instruction type to INSN_CALL for 'bla'
                instruction as well.

----
v2:

* Change subject of patch 01/16
* As suggested by Christophe Leroy, add barrier_before_unreachable()
before __builtin_unreachable() to work around a gcc problem.
* Fix issues reported by Kernel Test Robot.
* Include suggestions from Christophe Leroy, and change commit
messages for patches 01/16, 02/16, 03/16, 05/16.

----

Christophe Leroy (4):
  objtool: Fix SEGFAULT
  objtool: Use target file endianness instead of a compiled constant
  objtool: Use target file class size instead of a compiled constant
  powerpc: Fix objtool unannotated intra-function call warnings on PPC32

Sathvika Vasireddy (12):
  powerpc: Fix __WARN_FLAGS() for use with Objtool
  powerpc: Override __ALIGN and __ALIGN_STR macros
  powerpc: Fix objtool unannotated intra-function call warnings
  powerpc: Curb objtool unannotated intra-function warnings
  powerpc: Skip objtool from running on drivers/crypto/vmx/aesp8-ppc.o
  powerpc: Skip objtool from running on VDSO files
  objtool: Add --mnop as an option to --mcount
  objtool: Read special sections with alts only when specific options are selected
  objtool: Use macros to define arch specific reloc types
  objtool: Add arch specific function arch_ftrace_match()
  objtool/powerpc: Enable objtool to be built on ppc
  objtool/powerpc: Add --mcount specific implementation

 Makefile                                      |   4 +-
 arch/powerpc/Kconfig                          |   2 +
 arch/powerpc/include/asm/asm.h                |   7 ++
 arch/powerpc/include/asm/bug.h                |   3 +-
 arch/powerpc/include/asm/linkage.h            |   3 +
 arch/powerpc/kernel/cpu_setup_6xx.S           |  26 +++--
 arch/powerpc/kernel/cpu_setup_e500.S          |   8 +-
 arch/powerpc/kernel/entry_32.S                |   9 +-
 arch/powerpc/kernel/entry_64.S                |   2 +
 arch/powerpc/kernel/exceptions-64s.S          |   4 +-
 arch/powerpc/kernel/head_40x.S                |   5 +-
 arch/powerpc/kernel/head_64.S                 |   7 +-
 arch/powerpc/kernel/head_85xx.S               |   5 +-
 arch/powerpc/kernel/head_8xx.S                |   5 +-
 arch/powerpc/kernel/head_book3s_32.S          |  29 +++--
 arch/powerpc/kernel/misc_64.S                 |   4 +-
 arch/powerpc/kernel/swsusp_32.S               |   5 +-
 arch/powerpc/kernel/vdso/Makefile             |   2 +
 arch/powerpc/kernel/vector.S                  |   4 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S       |   4 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |  25 +++--
 arch/powerpc/kvm/fpu.S                        |  17 ++-
 arch/powerpc/platforms/52xx/lite5200_sleep.S  |  15 ++-
 arch/x86/Kconfig                              |   1 +
 drivers/crypto/vmx/Makefile                   |   2 +
 kernel/trace/Kconfig                          |   7 ++
 scripts/Makefile.lib                          |   3 +
 tools/objtool/arch/powerpc/Build              |   2 +
 tools/objtool/arch/powerpc/decode.c           | 101 ++++++++++++++++++
 .../arch/powerpc/include/arch/cfi_regs.h      |  11 ++
 tools/objtool/arch/powerpc/include/arch/elf.h |  10 ++
 .../arch/powerpc/include/arch/special.h       |  21 ++++
 tools/objtool/arch/powerpc/special.c          |  19 ++++
 tools/objtool/arch/x86/decode.c               |   5 +
 tools/objtool/arch/x86/include/arch/elf.h     |   2 +
 .../arch/x86/include/arch/endianness.h        |   9 --
 tools/objtool/builtin-check.c                 |  14 +++
 tools/objtool/check.c                         |  53 ++++-----
 tools/objtool/elf.c                           |   8 +-
 tools/objtool/include/objtool/arch.h          |   2 +
 tools/objtool/include/objtool/builtin.h       |   1 +
 tools/objtool/include/objtool/elf.h           |   8 ++
 tools/objtool/include/objtool/endianness.h    |  32 +++---
 tools/objtool/orc_dump.c                      |  11 +-
 tools/objtool/orc_gen.c                       |   4 +-
 tools/objtool/special.c                       |   3 +-
 46 files changed, 418 insertions(+), 106 deletions(-)
 create mode 100644 arch/powerpc/include/asm/asm.h
 create mode 100644 tools/objtool/arch/powerpc/Build
 create mode 100644 tools/objtool/arch/powerpc/decode.c
 create mode 100644 tools/objtool/arch/powerpc/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/elf.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/special.h
 create mode 100644 tools/objtool/arch/powerpc/special.c
 delete mode 100644 tools/objtool/arch/x86/include/arch/endianness.h

-- 
2.31.1

