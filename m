Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA66EFE34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbjD0ALX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbjD0AKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791924483
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGwmBj013734;
        Thu, 27 Apr 2023 00:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=m5WZMJcDB0yDdPEBWmM9MnWGtmdsh6oAci435qRzgOU=;
 b=QewotladiR+frxDMWZyUDcfpo/8nqkUiKnfHSRs9SL+UuWgOSwzwz6Xrj6GTL5w9DtxW
 MsjduscPTtA/yoi3zzPoi++bDrBIHN5XH+yM6R4aRZgVRMh+Yn+wYEZctYXL2UHw5isz
 SZLBRu9mDnChGTVbBWeKV9emv7S6ny2RHEUkysCK3/Bby+X4HpppPpaRGC6yBauLJ509
 9vjIT4OFeFr0q6EhWumjwXuxVRWx582ycuLwg7Zj/NgyunYsJp0eat6mXnRj5WXKjUyz
 xHZNZdfR08moqTT7pVRXGXzUcoxSXd/0HnRaSj3A8t16cPPHaG5hUWiTMGDF5ASf3oX2 Kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47md2umn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMn2Cf007147;
        Thu, 27 Apr 2023 00:09:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mp9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938O013888;
        Thu, 27 Apr 2023 00:09:05 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-2;
        Thu, 27 Apr 2023 00:09:05 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 01/21] mm: add PKRAM API stubs and Kconfig
Date:   Wed, 26 Apr 2023 17:08:37 -0700
Message-Id: <1682554137-13938-2-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.9.4
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270000
X-Proofpoint-GUID: oZBoD9zIKFev_Cz5qJgpsNFO-hW5IASo
X-Proofpoint-ORIG-GUID: oZBoD9zIKFev_Cz5qJgpsNFO-hW5IASo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserved-across-kexec memory or PKRAM is a method for saving memory
pages of the currently executing kernel and restoring them after kexec
boot into a new one. This can be utilized for preserving guest VM state,
large in-memory databases, process memory, etc. across reboot. While
DRAM-as-PMEM or actual persistent memory could be used to accomplish
these things, PKRAM provides the latency of DRAM with the flexibility
of dynamically determining the amount of memory to preserve.

The proposed API:

 * Preserved memory is divided into nodes which can be saved or loaded
   independently of each other. The nodes are identified by unique name
   strings. A PKRAM node is created when save is initiated by calling
   pkram_prepare_save(). A PKRAM node is removed when load is initiated by
   calling pkram_prepare_load(). See below

 * A node is further divided into objects. An object represents closely
   coupled data in the form of a grouping of folios and/or a stream of
   byte data.  For example, the folios and attributes of a file.
   After initiating an operation on a PKRAM node, PKRAM objects are
   initialized for saving or loading by calling pkram_prepare_save_obj()
   or pkram_prepare_load_obj().

 * For saving/loading data from a PKRAM node/object instances of the
   pkram_stream and pkram_access structs are used.  pkram_stream tracks
   the node and object being operated on while pkram_access tracks the
   data type and position within an object.

   The pkram_stream struct is initialized by calling pkram_prepare_save()
   or pkram_prepare_load() and then pkram_prepare_save_obj() or
   pkram_prepare_load_obj().

   Once a pkram_stream is fully initialized, a pkram_access struct
   is initialized for each data type associated with the object.
   After save or load of a data type for the object is complete,
   pkram_finish_access() is called.

   After save or load is complete for the object, pkram_finish_save_obj()
   or pkram_finish_load_obj() must be called followed by pkram_finish_save()
   or pkram_finish_load() when save or load is completed for the node.
   If an error occurred during save, the saved data and the PKRAM node
   may be freed by calling pkram_discard_save() instead of
   pkram_finish_save().

 * Both folio data and byte data can separately be streamed to a PKRAM
   object.  pkram_save_folio() and pkram_load_folio() are used
   to stream folio data while pkram_write() and pkram_read() are used to
   stream byte data.

A sequence of operations for saving/loading data from PKRAM would
look like:

  * For saving data to PKRAM:

    /* create a PKRAM node and do initial stream setup */
    pkram_prepare_save()

    /* create a PKRAM object associated with the PKRAM node and complete stream initialization */
    pkram_prepare_save_obj()

    /* save data to the node/object */
    PKRAM_ACCESS(pa_folios,...)
    PKRAM_ACCESS(pa_bytes,...)
    pkram_save_folio(pa_folios,...)[,...]  /* for file folios */
    pkram_write(pa_bytes,...)[,...]        /* for a byte stream */
    pkram_finish_access(pa_folios)
    pkram_finish_access(pa_bytes)

    pkram_finish_save_obj()

    /* commit the save or discard and delete the node */
    pkram_finish_save()          /* on success, or
    pkram_discard_save()          * ... in case of error */

  * For loading data from PKRAM:

    /* remove a PKRAM node from the list and do initial stream setup */
    pkram_prepare_load()

    /* Remove a PKRAM object from the node and complete stream initializtion for loading data from it. */
    pkram_prepare_load_obj()

    /* load data from the node/object */
    PKRAM_ACCESS(pa_folios,...)
    PKRAM_ACCESS(pa_bytes,...)
    pkram_load_folio(pa_folios,...)[,...] /* for file folios */
    pkram_read(pa_bytes,...)[,...]        /* for a byte stream */
*/
    pkram_finish_access(pa_folios)
    pkram_finish_access(pa_bytes)

    /* free the object */
    pkram_finish_load_obj()

    /* free the node */
    pkram_finish_load()

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  47 +++++++++++++
 mm/Kconfig            |   9 +++
 mm/Makefile           |   2 +
 mm/pkram.c            | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 include/linux/pkram.h
 create mode 100644 mm/pkram.c

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
new file mode 100644
index 000000000000..57b8db4229a4
--- /dev/null
+++ b/include/linux/pkram.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PKRAM_H
+#define _LINUX_PKRAM_H
+
+#include <linux/gfp.h>
+#include <linux/types.h>
+#include <linux/mm_types.h>
+
+/**
+ * enum pkram_data_flags - definition of data types contained in a pkram obj
+ * @PKRAM_DATA_none: No data types configured
+ */
+enum pkram_data_flags {
+	PKRAM_DATA_none		= 0x0,  /* No data types configured */
+};
+
+struct pkram_stream;
+struct pkram_access;
+
+#define PKRAM_NAME_MAX		256	/* including nul */
+
+int pkram_prepare_save(struct pkram_stream *ps, const char *name,
+		       gfp_t gfp_mask);
+int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags);
+
+void pkram_finish_save(struct pkram_stream *ps);
+void pkram_finish_save_obj(struct pkram_stream *ps);
+void pkram_discard_save(struct pkram_stream *ps);
+
+int pkram_prepare_load(struct pkram_stream *ps, const char *name);
+int pkram_prepare_load_obj(struct pkram_stream *ps);
+
+void pkram_finish_load(struct pkram_stream *ps);
+void pkram_finish_load_obj(struct pkram_stream *ps);
+
+#define PKRAM_ACCESS(name, stream, type)			\
+	struct pkram_access name
+
+void pkram_finish_access(struct pkram_access *pa, bool status_ok);
+
+int pkram_save_folio(struct pkram_access *pa, struct folio *folio);
+struct folio *pkram_load_folio(struct pkram_access *pa, unsigned long *index);
+
+ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count);
+size_t pkram_read(struct pkram_access *pa, void *buf, size_t count);
+
+#endif /* _LINUX_PKRAM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f05..10f089f4a181 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1202,6 +1202,15 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config PKRAM
+	bool "Preserved-over-kexec memory storage"
+	default n
+	help
+	  This option adds the kernel API that enables saving memory pages of
+	  the currently executing kernel and restoring them after a kexec in
+	  the newly booted one. This can be utilized for speeding up reboot by
+	  leaving process memory and/or FS caches in-place.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..7a8d5a286d48 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,3 +138,5 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_PKRAM) += pkram.o
+>>>>>>> mm: add PKRAM API stubs and Kconfig
diff --git a/mm/pkram.c b/mm/pkram.c
new file mode 100644
index 000000000000..421de8211e05
--- /dev/null
+++ b/mm/pkram.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pkram.h>
+#include <linux/types.h>
+
+/**
+ * Create a preserved memory node with name @name and initialize stream @ps
+ * for saving data to it.
+ *
+ * @gfp_mask specifies the memory allocation mask to be used when saving data.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
+ * case of failure) is to be called.
+ */
+int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask)
+{
+	return -EINVAL;
+}
+
+/**
+ * Create a preserved memory object and initialize stream @ps for saving data
+ * to it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
+ * in case of failure) is to be called.
+ */
+int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
+{
+	return -EINVAL;
+}
+
+/**
+ * Commit the object started with pkram_prepare_save_obj() to preserved memory.
+ */
+void pkram_finish_save_obj(struct pkram_stream *ps)
+{
+	WARN_ON_ONCE(1);
+}
+
+/**
+ * Commit the save to preserved memory started with pkram_prepare_save().
+ * After the call, the stream may not be used any more.
+ */
+void pkram_finish_save(struct pkram_stream *ps)
+{
+	WARN_ON_ONCE(1);
+}
+
+/**
+ * Cancel the save to preserved memory started with pkram_prepare_save() and
+ * destroy the corresponding preserved memory node freeing any data already
+ * saved to it.
+ */
+void pkram_discard_save(struct pkram_stream *ps)
+{
+	WARN_ON_ONCE(1);
+}
+
+/**
+ * Remove the preserved memory node with name @name and initialize stream @ps
+ * for loading data from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the load has finished, pkram_finish_load() is to be called.
+ */
+int pkram_prepare_load(struct pkram_stream *ps, const char *name)
+{
+	return -EINVAL;
+}
+
+/**
+ * Remove the next preserved memory object from the stream @ps and
+ * initialize stream @ps for loading data from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the load has finished, pkram_finish_load_obj() is to be called.
+ */
+int pkram_prepare_load_obj(struct pkram_stream *ps)
+{
+	return -EINVAL;
+}
+
+/**
+ * Finish the load of a preserved memory object started with
+ * pkram_prepare_load_obj() freeing the object and any data that has not
+ * been loaded from it.
+ */
+void pkram_finish_load_obj(struct pkram_stream *ps)
+{
+	WARN_ON_ONCE(1);
+}
+
+/**
+ * Finish the load from preserved memory started with pkram_prepare_load()
+ * freeing the corresponding preserved memory node and any data that has
+ * not been loaded from it.
+ */
+void pkram_finish_load(struct pkram_stream *ps)
+{
+	WARN_ON_ONCE(1);
+}
+
+/**
+ * Finish the data access to or from the preserved memory node and object
+ * associated with pkram stream access @pa.  The access must have been
+ * initialized with PKRAM_ACCESS().
+ */
+void pkram_finish_access(struct pkram_access *pa, bool status_ok)
+{
+	WARN_ON_ONCE(1);
+}
+
+/**
+ * Save folio @folio to the preserved memory node and object associated
+ * with pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_save() and pkram_prepare_save_obj() and access initialized
+ * with PKRAM_ACCESS().
+ *
+ * Returns 0 on success, -errno on failure.
+ */
+int pkram_save_folio(struct pkram_access *pa, struct folio *folio)
+{
+	return -EINVAL;
+}
+
+/**
+ * Load the next folio from the preserved memory node and object associated
+ * with pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_load() and pkram_prepare_load_obj() and access initialized
+ * with PKRAM_ACCESS().
+ *
+ * If not NULL, @index is initialized with the preserved mapping offset of the
+ * folio loaded.
+ *
+ * Returns the folio loaded or NULL if the node is empty.
+ *
+ * The folio loaded has its refcount incremented.
+ */
+struct folio *pkram_load_folio(struct pkram_access *pa, unsigned long *index)
+{
+	return NULL;
+}
+
+/**
+ * Copy @count bytes from @buf to the preserved memory node and object
+ * associated with pkram stream access @pa. The stream must have been
+ * initialized with pkram_prepare_save() and pkram_prepare_save_obj()
+ * and access initialized with PKRAM_ACCESS();
+ *
+ * On success, returns the number of bytes written, which is always equal to
+ * @count. On failure, -errno is returned.
+ */
+ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
+{
+	return -EINVAL;
+}
+
+/**
+ * Copy up to @count bytes from the preserved memory node and object
+ * associated with pkram stream access @pa to @buf. The stream must have been
+ * initialized with pkram_prepare_load() and pkram_prepare_load_obj() and
+ * access initialized PKRAM_ACCESS().
+ *
+ * Returns the number of bytes read, which may be less than @count if the node
+ * has fewer bytes available.
+ */
+size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
+{
+	return 0;
+}
-- 
1.9.4

