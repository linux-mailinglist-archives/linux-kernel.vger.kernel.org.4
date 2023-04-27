Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D136EFE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjD0ALE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbjD0AKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6339D4205
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx6DB014740;
        Thu, 27 Apr 2023 00:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=BRj/3TfYOvjkwblw52yOiKUFYYErGZe4lSnIhVOYAHQ=;
 b=I0kieCx/ycmz6RyPLhJm3IfF3PB5a+grP7b67gzvPqQxqChV4KM13kJpH4NLc8WYyXDa
 +HkpypFJrv6T+eCnkED2zSuIUvWMPAb+iWJ9seI08TwfW5ljYnfb64PWbPHAkDeaET/f
 /+JXX0mOJcMdjWYEMts/G5L7goQwvnM5/sdXuanabg6U17uT0NmCk2zflQzG5/Jje5bR
 +L9PuDpzT8LMhnR5psLHEU4rL1aF8mXtHYck+n+gbbd8lEA7gdgdYT/2WNG8V5OlbCBt
 IFtMb3bwJfZczpej7ZgBCqoKnWLngowu4fDT+aIUW2g4j/jWoqxkI2Pp6vPpmb7zgd1L Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fatmrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QLgiYR007654;
        Thu, 27 Apr 2023 00:09:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mp8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938M013888;
        Thu, 27 Apr 2023 00:09:03 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-1;
        Thu, 27 Apr 2023 00:09:03 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 00/21] Preserved-over-Kexec RAM
Date:   Wed, 26 Apr 2023 17:08:36 -0700
Message-Id: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.9.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270000
X-Proofpoint-ORIG-GUID: kITeu-Uy-ebJonyaTei8eqLB7j2YAgRH
X-Proofpoint-GUID: kITeu-Uy-ebJonyaTei8eqLB7j2YAgRH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending out this RFC in part to guage community interest.
This patchset implements preserved-over-kexec memory storage or PKRAM as a
method for saving memory pages of the currently executing kernel so that
they may be restored after kexec into a new kernel. The patches are adapted
from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
introduce the PKRAM kernel API.

One use case for PKRAM is preserving guest memory and/or auxillary
supporting data (e.g. iommu data) across kexec to support reboot of the
host with minimal disruption to the guest. PKRAM provides a flexible way
for doing this without requiring that the amount of memory used by a fixed
size created a priori.  Another use case is for databases to preserve their
block caches in shared memory across reboot.

Changes since RFC v2
  - Rebased onto 6.3
  - Updated API to save/load folios rather than file pages
  - Omitted previous patches for implementing and optimizing preservation
    and restoration of shmem files to reduce the number of patches and
    focus on core functionality.

Changes since RFC v1
  - Rebased onto 5.12-rc4
  - Refined the API to reduce the number of calls
    and better support multithreading.
  - Allow preserving byte data of arbitrary length
    (was previously limited to one page).
  - Build a new memblock reserved list with the
    preserved ranges and then substitute it for
    the existing one. (Mike Rapoport)
  - Use mem_avoid_overlap() to avoid kaslr stepping
    on preserved ranges. (Kees Cook)

-- Implementation details --

 * To aid in quickly finding contiguous ranges of memory containing
   preserved pages a pseudo physical mapping pagetable is populated
   with pages as they are preserved.

 * If a page to be preserved is found to be in range of memory that was
   previously reserved during early boot or in range of memory where the
   kernel will be loaded to on kexec, the page will be copied to a page
   outside of those ranges and the new page will be preserved. A compound
   page will be copied to and preserved as individual base pages.
   Note that this means that a page that cannot be moved (e.g. pinned for
   DMA) currently cannot safely be preserved. This could be addressed by
   adding functionality to kexec to reconfigure the destination addreses
   for the sections of an already-loaded kexec kernel.

 * A single page is allocated for the PKRAM super block. For the next kernel
   kexec boot to find preserved memory metadata, the pfn of the PKRAM super
   block, which is exported via /sys/kernel/pkram, is passed in the 'pkram'
   boot option.

 * In the newly booted kernel, PKRAM adds all preserved pages to the memblock
   reserve list during early boot so that they will not be recycled.

 * Since kexec may load the new kernel code to any memory region, it could
   destroy preserved memory. When the kernel selects the memory region
   (kexec_file_load syscall), kexec will avoid preserved pages.  When the
   user selects the kexec memory region to use (kexec_load syscall) , kexec
   load will fail if there is conflict with preserved pages. Pages preserved
   after a kexec kernel is loaded will be relocated if they conflict with
   the selected memory region.

[1] https://lkml.org/lkml/2013/7/1/211

Anthony Yznaga (21):
  mm: add PKRAM API stubs and Kconfig
  mm: PKRAM: implement node load and save functions
  mm: PKRAM: implement object load and save functions
  mm: PKRAM: implement folio stream operations
  mm: PKRAM: implement byte stream operations
  mm: PKRAM: link nodes by pfn before reboot
  mm: PKRAM: introduce super block
  PKRAM: track preserved pages in a physical mapping pagetable
  PKRAM: pass a list of preserved ranges to the next kernel
  PKRAM: prepare for adding preserved ranges to memblock reserved
  mm: PKRAM: reserve preserved memory at boot
  PKRAM: free the preserved ranges list
  PKRAM: prevent inadvertent use of a stale superblock
  PKRAM: provide a way to ban pages from use by PKRAM
  kexec: PKRAM: prevent kexec clobbering preserved pages in some cases
  PKRAM: provide a way to check if a memory range has preserved pages
  kexec: PKRAM: avoid clobbering already preserved pages
  mm: PKRAM: allow preserved memory to be freed from userspace
  PKRAM: disable feature when running the kdump kernel
  x86/KASLR: PKRAM: support physical kaslr
  x86/boot/compressed/64: use 1GB pages for mappings

 arch/x86/boot/compressed/Makefile       |    3 +
 arch/x86/boot/compressed/ident_map_64.c |    9 +-
 arch/x86/boot/compressed/kaslr.c        |   10 +-
 arch/x86/boot/compressed/misc.h         |   10 +
 arch/x86/boot/compressed/pkram.c        |  110 ++
 arch/x86/kernel/setup.c                 |    3 +
 arch/x86/mm/init_64.c                   |    3 +
 include/linux/pkram.h                   |  116 ++
 kernel/kexec.c                          |    9 +
 kernel/kexec_core.c                     |    3 +
 kernel/kexec_file.c                     |   15 +
 mm/Kconfig                              |    9 +
 mm/Makefile                             |    2 +
 mm/pkram.c                              | 1753 +++++++++++++++++++++++++++++++
 mm/pkram_pagetable.c                    |  375 +++++++
 15 files changed, 2424 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pkram.c
 create mode 100644 include/linux/pkram.h
 create mode 100644 mm/pkram.c
 create mode 100644 mm/pkram_pagetable.c

-- 
1.9.4

