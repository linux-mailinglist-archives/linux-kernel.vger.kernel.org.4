Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7335B6435
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiILXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiILXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:33:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD11A813;
        Mon, 12 Sep 2022 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663025602; x=1694561602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bELxZrGLEVbNX7Um9kbFo9NMQR/NcfH5hMzfLSt+A9U=;
  b=YFmfWA9hAlORZphvF/+uWF+BBkkOTqJqf2UOAlhy9QQTBWmTGLdJchx8
   siFiUqmvkhWL8If1ty42rh997eyAhVw4sM9WzTiXP6XKu9dSwuhfaBNVD
   9TI3YHteOUCTqQSg7i7gqU/PkoWtaadQ9t/g8+HsXEjRfS4N60tgwYlID
   9p+qFa8Z/aI+Xyk2Sg+VJAfqQuelW3ssL2I2yz1SgeCvKOgfGxyv6vP/E
   xTNr/kgWmpJ6JIcYulsKVLQlr1kKKRcg6U/klQcJRqKXdzf0x8y1frhM+
   wynh7PK/9EAxgUFAneBVvLTM+ound8qrKzpdhL9uTlOOM5rBGg1FHm9YA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="299333159"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="299333159"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:33:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="618718562"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2022 16:33:21 -0700
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.24])
        by linux.intel.com (Postfix) with ESMTP id 09F72580871;
        Mon, 12 Sep 2022 16:33:21 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 1/2] x86/cpu: Add new Raptor Lake CPU model number
Date:   Mon, 12 Sep 2022 16:33:06 -0700
Message-Id: <20220912233307.409954-1-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Note1: Model 0xB7 already claimed the "no suffix" #define for a regular
client part, so add (yet another) suffix "S" to distinguish this new
part from the earlier one.

Note2: the RAPTORLAKE* and ALDERLAKE* processors are very similar from a
software enabling point of view.  There are no known features that have
model-specific enabling and also differ between the two.  In other words,
every single place that list *one* or more RAPTORLAKE* or ALDERLAKE*
processors should list all of them.

Note3: This is being merged before there is an in-tree user.  Merging
this provides an "anchor" so that the different folks can update their
subsystems (like perf) in parallel to use this define and test it.

[ dhansen: add a note about why this has no in-tree users yet ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220823174819.223941-1-tony.luck@intel.com
---
Changes since v1:
1) This patch is a dependency patch to patch 2 and not part of the series.

 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index def6ca121111..aeb38023a703 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -27,6 +27,7 @@
  *		_X	- regular server parts
  *		_D	- micro server parts
  *		_N,_P	- other mobile parts
+ *		_S	- other client parts
  *
  *		Historical OPTDIFFs:
  *
@@ -112,6 +113,7 @@
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 /* "Small Core" Processors (Atom) */
 

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
prerequisite-patch-id: 13fd278d705cd8aabfdc7886d600fc7571653c8b
prerequisite-patch-id: 9a4548398c948e2fc812e1a79394a6f9aac4f8c1
prerequisite-patch-id: c461754892ce3cbb07fd3d31f7011effe89ec67a
prerequisite-patch-id: b89d6c41dce66a2b3c9f48547db42f092b3f1123
prerequisite-patch-id: 47af20aed9beb5ae75a9c7c19962abb164c26688
prerequisite-patch-id: 53c095530345794655a1785f253bea0f19468d7a
prerequisite-patch-id: 6e373de512c4b6775dcaff53ef343f11966a8506
prerequisite-patch-id: cb482389129932b9a8f9a4277bc0be67fb3061a0
prerequisite-patch-id: c5b69a89b60ad98b27b21bd845a96433c7a46a04
prerequisite-patch-id: 5fca4c7abb02dbfbf5bce11e789c2e782c779a49
prerequisite-patch-id: aec3bb8820a5ac048afaecca0c0d7678007b1fa2
prerequisite-patch-id: 40c7bfe879b44daa81d078a08380149706fb485c
prerequisite-patch-id: f871caebf0b3d75b844bd948eef80ee0299aa828
prerequisite-patch-id: ee12e07fcf52cf0e996eccc038530d5a8f96f5f1
prerequisite-patch-id: c526f2ffd873ce417ed2ee614407ba2620483e50
prerequisite-patch-id: 80ed0d93f12247e89681baa53c512d2272c89dfa
prerequisite-patch-id: 12c50190234f4dcfb669b6e32eda7ee1e330e225
prerequisite-patch-id: 3e8b662a06e8235a985c6e955353788089c08705
prerequisite-patch-id: c09718d58bfa1d5a475bd01520474843638d2290
prerequisite-patch-id: c3f400162375235e05ae03a64c08738c5f4fab7f
prerequisite-patch-id: e4a2d87b0e0403c76d4ac1420bf2a49b10401561
prerequisite-patch-id: 59e81bfc45102d8a9444f7706d5d18a6540dc689
prerequisite-patch-id: 760e9ab684498adeb758ba3d39619352faf159f2
prerequisite-patch-id: 645fe30325517a068b8c7fcbdb39c3b294b18689
prerequisite-patch-id: 76e3f620cb94829b4b6b103abbe2a8d21d98a653
prerequisite-patch-id: ad34f688b9bc1bf35c491fbcf87bc0d1c3b62e97
prerequisite-patch-id: bc535fa7fc1105faa1cf8a07dbd305b7ad1f9ded
prerequisite-patch-id: 0e15c92bbbddf043206576ac83dbad94dd4b720b
prerequisite-patch-id: 927cca9d2a0c7f5134a21a9c0276ad023008ef96
prerequisite-patch-id: d0f590fd58174acda1092447eec1e66218f409da
prerequisite-patch-id: be7934614e4fdb98aa2a1fe2854d177bf4ca7521
prerequisite-patch-id: c4b4015a054367e210c8183ab6e89e5107c5795b
prerequisite-patch-id: 9651d012558cb8450e9dc9360cc2009ae44dd6f3
prerequisite-patch-id: 8c8ea2026831d7963f189b648d444685c15cf444
prerequisite-patch-id: 852a1bc9ac988fac5ee5eefb536761d8f0359ab3
prerequisite-patch-id: ceadda9919b844162d89c2b42bd0402db11151e8
prerequisite-patch-id: 00cc38c37f26cf3f59f43ce345593f8248901111
prerequisite-patch-id: 98c87a68ec9d1102f78acf37e2e8feac339cc2f0
prerequisite-patch-id: 51c94605e435b9e1d5e6b859e78f96c6ffb37c60
prerequisite-patch-id: 5696d012be81f984be6c0ff9d60f37d203ae2eb3
prerequisite-patch-id: 5e68e32d219c898a9346950602c9f9039c8c59cc
prerequisite-patch-id: caccc3bc983cb00ddaaa70d46596da523b16563c
prerequisite-patch-id: 83417f1543e24c4466d8cb5986c9de369c4abb36
prerequisite-patch-id: 02a21ce5240896d890db90e1cf025240cdbbb07c
prerequisite-patch-id: b7e83da4997538399150d3853f221390e56c6752
prerequisite-patch-id: aa1aa78493ad32e96e9e9cee261525e91551c7d0
prerequisite-patch-id: adf1dd5da05c697ec96526f0d85990bff76d529f
prerequisite-patch-id: faf7cca20818fcb3b2349c56e4a4840b9e39918a
prerequisite-patch-id: 2310cb00b225a2a9200916e87495883b29834af5
prerequisite-patch-id: 0e2550693caebad4d3e5abc9decd3e066cc744dd
prerequisite-patch-id: 2d67ddab1042f72c8a69e99732df23f46ddca975
prerequisite-patch-id: e06deb93df59656e5fbd13fc93b11408f55d4bce
prerequisite-patch-id: 76d1af3681d235163e620974d5532f414acdb164
prerequisite-patch-id: c7ca88d485d90c9b1c197c02346d6d194bee142b
prerequisite-patch-id: 2bbf920865d9027f3ff1b89228b32dc4ba53907b
prerequisite-patch-id: e41713da77541c344ee7193e6e531d43b7f781f7
prerequisite-patch-id: f0bdcad4ec90e05dabd149b51f5880e35ab03489
prerequisite-patch-id: dec7fa35613224553f921cdb59de507447e31d6d
prerequisite-patch-id: 5098a30f7ada91f2662f96494e3df41ad3beb568
prerequisite-patch-id: 178f2cdc8116f55cccfa1242e4bad8f288451533
prerequisite-patch-id: 007fe438207a7a82f99a2f9335228ba6277d39d6
prerequisite-patch-id: 46cb8ef8afe050f7436973fc3365710c62521f43
prerequisite-patch-id: b114ff788bbdd40bc8a53a46bd1316832130d805
prerequisite-patch-id: e4c30bebc489ccaa72f90917346ed87b2d3f18d4
prerequisite-patch-id: a0c04699b39ce90a47291d2337cad8f571bbf20d
prerequisite-patch-id: 990d8305cee937d80c874da47a557debb9059718
prerequisite-patch-id: 82e0d397596ed099efa6df44b76e0eb97026b99d
prerequisite-patch-id: db90c32e55af09a8f503e5dedf9cc756c6e5a12e
prerequisite-patch-id: 82b4c3d6bf3816f6069c8d3ec084f3eba3e669fe
prerequisite-patch-id: 3b6772eff379181f9696bc411888ef28de1bd851
prerequisite-patch-id: e6562ca3ebb4a2edcc0fa894751c22f607b2044a
prerequisite-patch-id: 11af22366364502a22b05a4df6ceec515605e3d6
prerequisite-patch-id: d38d49d8c61e5450fc684ce4b92cba05c91fb620
prerequisite-patch-id: 1c2c0823b96676c7d9358e2f8abf17f3dbb93fa4
prerequisite-patch-id: 2d54cdbf06a586dd1e591a23d584b48897c56011
prerequisite-patch-id: 9b377b753821778ffe61b3dce986557b48e1e5fc
prerequisite-patch-id: 4e39b06d8e77a84a859b64d02bc6234f783122f9
prerequisite-patch-id: 832b891206efeef44c569c102ea0d84d26a01aba
prerequisite-patch-id: 8adda2d1140508701965dd1f0428366263982f53
prerequisite-patch-id: 736d1fa7880230596cc5af73d2f66102be1a31b1
prerequisite-patch-id: e6c19229f24a7ebcb004c4c1a77ce204f81d8437
prerequisite-patch-id: 6d7c60aef49579a1b0c61f9b23786627d31b22a3
prerequisite-patch-id: bd70e95023163a375e31e9eb00a87bbfe59e8e77
prerequisite-patch-id: 2cdd80a60e9d6f8159db2a0b8ba75a6cfea2090f
prerequisite-patch-id: f84a1b331f4515ac01cb0a69e5dbda35c1256e3c
prerequisite-patch-id: 486a5bfe37713c7cf93b6c12aba9f8067599c0e2
prerequisite-patch-id: a0e634bad6a6de0ac398ad65880796f62d024c83
prerequisite-patch-id: db9f771be2274f67564c07b1edee7a9688f74e77
prerequisite-patch-id: 216c93370b4216f9e804da0ad8bffbf23fd027cb
prerequisite-patch-id: 158e901c9ba9ae6fae6abac2d915f470afb0c5b3
prerequisite-patch-id: e7b008ac7649ca4ab011961527f5cf238bcd916b
prerequisite-patch-id: d31b68322279e864f1bb954f5e869f82a5b83be0
prerequisite-patch-id: 03f1051d03418c4ff535ff89eadde82636a832a5
prerequisite-patch-id: 2c64eee0c1138a4ccf25f995ac528927cf4914df
prerequisite-patch-id: d889f2e88cd14eecf5689dda980de0f31d4cc796
prerequisite-patch-id: 35d8609dac37c76a5f37a8826795624434d920a9
prerequisite-patch-id: 4643a57a7ce93e9ab61797db0c64e5ff35ce4e37
prerequisite-patch-id: 269b1641e5526d42429dcf9bc76b9a3eedda998a
prerequisite-patch-id: 89b18bdeb81f0a0a193408a8bd1355cc92773c55
prerequisite-patch-id: b19bb18fd99cfc56d0950c177445c823e2481e70
prerequisite-patch-id: a2e2fe363f255a7feeeeab9b5fb3a9f8c8164eea
prerequisite-patch-id: 3dde7306e2549cfd98a7058f2012a8a2cfcbc196
prerequisite-patch-id: dc0030049406676ecb3620b9a328e396e118ab47
prerequisite-patch-id: 7d007046ad8a40a05c6c836b6bff54e5e5fd630c
prerequisite-patch-id: af0005e456f4eb8346384929efb8a936ee9759be
prerequisite-patch-id: c4d679bfdf97b37b9720efeacc487c4926abf8b7
prerequisite-patch-id: a5542affe2faa87e56e7f595d2ebda02cfaf362a
prerequisite-patch-id: 110c140cfa29a9565cbb4fd94b129245dc6d4c43
prerequisite-patch-id: f2a3f665eabd45d7baaf3e8479bf663ff42da8f9
prerequisite-patch-id: 8d7c4fcbd69903c8c42968c34f9a56935ab70232
prerequisite-patch-id: 2edacadc6df80e6712b52680a8cf185e35a9b707
prerequisite-patch-id: c411bdd8d1df7278d8096c17b440c14701ab13b5
prerequisite-patch-id: da9644ff3d0b37b68c8e4665123c05882ff7b242
prerequisite-patch-id: a4448d5f530600a31f64024e1b04918a0cedff82
prerequisite-patch-id: bc08ae895c5d3d4d5ca083d7f2808081b1bfa765
-- 
2.25.1

