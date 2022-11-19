Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA8630F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiKSQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKSQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9091317C4;
        Sat, 19 Nov 2022 08:24:05 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=044nh0fAocs34t2my+EmxZh6Xau/bd8rCjVZYOwpDww=;
        b=fxIkU7or/t5BKrJKH+WF4oqSGJ6iNLHyxTPLVsVe9WyVVnrYAXS8jdU4ET5aqeoXCunLTo
        Ey3AgIy+x18ti+hYBwVNj+uGjheT8u+sRhjTd1sJfDQtdv3v2GCDiJ2qGbvKpDZ56VyA4P
        eOOrRnsKb4JACOM0/mT1uOmIGqwO6DtQCFVR6jtQTxCEtUv3xj11qo/deVIubA1DIMLzW2
        Nl40AfwgZdCVSWuX8CROq9kq2OGz46UPUR8mLdRMFr/2cum82AsFp8swyIXRGcQTM4gp66
        F8M6Ftvo+RPWMjm/QO1gZ7MadyNa2nvak1pfspjKOlZEO2gsYTsNZ8tVGY4kkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=044nh0fAocs34t2my+EmxZh6Xau/bd8rCjVZYOwpDww=;
        b=c/smRKUynLuTKCwJG2dA9jMmuVppuL6EmWhcZEPQnN+56CWAG34pEn344LKvBDvcvGhGxE
        9Ata/ft9dvUZsOBQ==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117225039.30166-1-jithu.joseph@intel.com>
References: <20221117225039.30166-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504331.4906.2340046039874835740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     aa63e0fda85edf9a8431fc31a2b2d4f3f40592f9
Gitweb:        https://git.kernel.org/tip/aa63e0fda85edf9a8431fc31a2b2d4f3f40=
592f9
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Thu, 17 Nov 2022 14:50:39 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Nov 2022 11:12:06 +01:00

platform/x86/intel/ifs: Use generic microcode headers and functions

Existing implementation (broken) of IFS used a header format (for IFS
test images) which was very similar to microcode format, but didn=E2=80=99t
accommodate extended signatures. This meant same IFS test image had to
be duplicated for different steppings and the validation code in the
driver was only looking at the primary header parameters. Going forward,
IFS test image headers have been tweaked to become fully compatible with
the microcode format.

Newer IFS test image headers will use header version 2 in order to
distinguish it from microcode images and older IFS test images.

In light of the above, reuse struct microcode_header_intel directly in
the IFS driver and reuse microcode functions for validation and sanity
checking.

  [ bp: Massage commit message. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221117225039.30166-1-jithu.joseph@intel.com
---
 arch/x86/include/asm/microcode_intel.h |   1 +-
 drivers/platform/x86/intel/ifs/load.c  | 104 ++++--------------------
 2 files changed, 21 insertions(+), 84 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/mi=
crocode_intel.h
index 6af1e70..f1fa979 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -43,6 +43,7 @@ struct extended_sigtable {
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
 #define MC_HEADER_TYPE_MICROCODE	1
+#define MC_HEADER_TYPE_IFS		2
=20
 #define get_totalsize(mc) \
 	(((struct microcode_intel *)mc)->hdr.datasize ? \
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/int=
el/ifs/load.c
index 9228da5..8343416 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -7,22 +7,8 @@
=20
 #include "ifs.h"
=20
-struct ifs_header {
-	u32 header_ver;
-	u32 blob_revision;
-	u32 date;
-	u32 processor_sig;
-	u32 check_sum;
-	u32 loader_rev;
-	u32 processor_flags;
-	u32 metadata_size;
-	u32 total_size;
-	u32 fusa_info;
-	u64 reserved;
-};
-
-#define IFS_HEADER_SIZE	(sizeof(struct ifs_header))
-static struct ifs_header *ifs_header_ptr;	/* pointer to the ifs image header=
 */
+#define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
+static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs=
 image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
 static DECLARE_COMPLETION(ifs_done);
@@ -149,29 +135,14 @@ done:
  */
 static int scan_chunks_sanity_check(struct device *dev)
 {
-	int metadata_size, curr_pkg, cpu, ret;
 	struct ifs_data *ifsd =3D ifs_get_data(dev);
 	struct ifs_work local_work;
-	char *test_ptr;
-
-	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
-	metadata_size =3D ifs_header_ptr->metadata_size;
+	int curr_pkg, cpu, ret;
=20
-	/* Spec says that if the Meta Data Size =3D 0 then it should be treated as =
2000 */
-	if (metadata_size =3D=3D 0)
-		metadata_size =3D 2000;
=20
-	/* Scan chunk start must be 256 byte aligned */
-	if ((metadata_size + IFS_HEADER_SIZE) % 256) {
-		dev_err(dev, "Scan pattern offset within the binary is not 256 byte aligne=
d\n");
-		return -EINVAL;
-	}
-
-	test_ptr =3D (char *)ifs_header_ptr + IFS_HEADER_SIZE + metadata_size;
+	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
 	ifsd->loading_error =3D false;
-
-	ifs_test_image_ptr =3D (u64)test_ptr;
-	ifsd->loaded_version =3D ifs_header_ptr->blob_revision;
+	ifsd->loaded_version =3D ifs_header_ptr->rev;
=20
 	/* copy the scan hash and authenticate per package */
 	cpus_read_lock();
@@ -197,67 +168,33 @@ out:
 	return ret;
 }
=20
-static int ifs_sanity_check(struct device *dev,
-			    const struct microcode_header_intel *mc_header)
+static int image_sanity_check(struct device *dev, const struct microcode_hea=
der_intel *data)
 {
-	unsigned long total_size, data_size;
-	u32 sum, *mc;
-
-	total_size =3D get_totalsize(mc_header);
-	data_size =3D get_datasize(mc_header);
+	struct ucode_cpu_info uci;
=20
-	if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))=
) {
-		dev_err(dev, "bad ifs data file size.\n");
+	/* Provide a specific error message when loading an older/unsupported image=
 */
+	if (data->hdrver !=3D MC_HEADER_TYPE_IFS) {
+		dev_err(dev, "Header version %d not supported\n", data->hdrver);
 		return -EINVAL;
 	}
=20
-	if (mc_header->ldrver !=3D 1 || mc_header->hdrver !=3D 1) {
-		dev_err(dev, "invalid/unknown ifs update format.\n");
+	if (intel_microcode_sanity_check((void *)data, true, MC_HEADER_TYPE_IFS)) {
+		dev_err(dev, "sanity check failed\n");
 		return -EINVAL;
 	}
=20
-	mc =3D (u32 *)mc_header;
-	sum =3D 0;
-	for (int i =3D 0; i < total_size / sizeof(u32); i++)
-		sum +=3D mc[i];
+	intel_cpu_collect_info(&uci);
=20
-	if (sum) {
-		dev_err(dev, "bad ifs data checksum, aborting.\n");
+	if (!intel_find_matching_signature((void *)data,
+					   uci.cpu_sig.sig,
+					   uci.cpu_sig.pf)) {
+		dev_err(dev, "cpu signature, processor flags not matching\n");
 		return -EINVAL;
 	}
=20
 	return 0;
 }
=20
-static bool find_ifs_matching_signature(struct device *dev, struct ucode_cpu=
_info *uci,
-					const struct microcode_header_intel *shdr)
-{
-	unsigned int mc_size;
-
-	mc_size =3D get_totalsize(shdr);
-
-	if (!mc_size || ifs_sanity_check(dev, shdr) < 0) {
-		dev_err(dev, "ifs sanity check failure\n");
-		return false;
-	}
-
-	if (!intel_cpu_signatures_match(uci->cpu_sig.sig, uci->cpu_sig.pf, shdr->si=
g, shdr->pf)) {
-		dev_err(dev, "ifs signature, pf not matching\n");
-		return false;
-	}
-
-	return true;
-}
-
-static bool ifs_image_sanity_check(struct device *dev, const struct microcod=
e_header_intel *data)
-{
-	struct ucode_cpu_info uci;
-
-	intel_cpu_collect_info(&uci);
-
-	return find_ifs_matching_signature(dev, &uci, data);
-}
-
 /*
  * Load ifs image. Before loading ifs module, the ifs image must be located
  * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname=
}.
@@ -278,12 +215,11 @@ void ifs_load_firmware(struct device *dev)
 		goto done;
 	}
=20
-	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)=
) {
-		dev_err(dev, "ifs header sanity check failed\n");
+	ret =3D image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
+	if (ret)
 		goto release;
-	}
=20
-	ifs_header_ptr =3D (struct ifs_header *)fw->data;
+	ifs_header_ptr =3D (struct microcode_header_intel *)fw->data;
 	ifs_hash_ptr =3D (u64)(ifs_header_ptr + 1);
=20
 	ret =3D scan_chunks_sanity_check(dev);
