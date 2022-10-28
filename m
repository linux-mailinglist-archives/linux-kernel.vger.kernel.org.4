Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794F96114A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiJ1Oe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiJ1Oer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:34:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DB413EAE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:34:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEKMGa012070;
        Fri, 28 Oct 2022 14:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Z9jwyf02uEBAHDaoKy0lpI59RpuxK41YrqCgmOxNeu0=;
 b=IRy/0jo3KP6eR9QFVlignJ1WmVkNHRQ1SUj7hxYimVZ8zZZnUghVKg+36hv39FRRp5NF
 q/ihXN0i+eOpG53JY2sBQKke1O9/8uZSAizmS+oVpndUyofj43USGi/NDW4Wc7srwuHr
 bsoNRe6J2HbMXASEdjy+LpuYUj7GKjosH1ve9W+MMmvO4PRx8uJrKJMxevHAOEWKfu9A
 kXGw4CagN0jeDN1Mv9E7wdn5BdYQBJtiHL4NZI18brtGC1gWbwy2jjE2ExSMHE3I4MTV
 0CUHXFn5A7Ml0LsPcNLRoD2U12AeVk55PT1Whc85+8TqWFIUAvGpvYNWF4AJaePn7P7B IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kggrr8f3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:34:11 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SELOKn019763;
        Fri, 28 Oct 2022 14:34:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kggrr8f1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:34:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SEL6lt026473;
        Fri, 28 Oct 2022 14:34:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3kfahu3wwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:34:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SEY5Us32244106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:34:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 455FFA4055;
        Fri, 28 Oct 2022 14:34:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D424CA4051;
        Fri, 28 Oct 2022 14:34:00 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.124.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 14:34:00 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v5 00/16] objtool: Enable and implement --mcount option on powerpc
Date:   Fri, 28 Oct 2022 20:03:30 +0530
Message-Id: <20221028143346.183569-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GZ6vP8lvD53jKvoYDs6v8jp7E4kzF8SN
X-Proofpoint-GUID: 0IGyuIaJxXuSmg5stm982thWdC_KCwoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280090
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
 arch/powerpc/kernel/entry_32.S                |   9 +-
 arch/powerpc/kernel/entry_64.S                |   2 +
 arch/powerpc/kernel/exceptions-64s.S          |   4 +-
 arch/powerpc/kernel/head_40x.S                |   5 +-
 arch/powerpc/kernel/head_64.S                 |   7 +-
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
 44 files changed, 408 insertions(+), 103 deletions(-)
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

