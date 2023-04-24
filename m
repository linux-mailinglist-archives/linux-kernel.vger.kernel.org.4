Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD246D6EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjDDVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjDDVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:15:09 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F149EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:15:04 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334KMqXm020217;
        Tue, 4 Apr 2023 21:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=+if/oK1oGmXDElFGJrWjoBYG4rtzdXPLni8MlhgqQBc=;
 b=V5hkIuL4WyI5MduguhZOf6d+rSpfO9tFloPAzHY+XUxaAWDonmEJqPQAVDqJuohC/Zlb
 A8hbqEBR0yzCm65tqFfKWAgF/vvYGjyL7lIceHxhy5OcrsaWwy1M5T+PXpAYc9i3ZkJD
 s9apxf3FCbdjL54sGbGy/2675XgcnPOqM77G5G35opiKekdm5xva3GB0LMAnNaiH5/MT
 Ki9bdGZmYasIV8E0Sep4BouzgbpkWOIZ4Yy5jOfUrGvTjw8ZDyduRBBufFxIwzgzFWGS
 AN81JfeH0fTqrJBkigzTG7gMGPH33M8jLoTrKjSXKLl4tup4HkvbW8iCNa9jmiOdKvAS aQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3prtvegbcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 21:14:34 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C3B7113047;
        Tue,  4 Apr 2023 21:14:33 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 1D24F81664E;
        Tue,  4 Apr 2023 21:14:33 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id EEAB5302F4727; Tue,  4 Apr 2023 16:14:31 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] Support sub-NUMA clustering on UV
Date:   Tue,  4 Apr 2023 16:14:23 -0500
Message-Id: <20230404211431.776248-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C84M0MZwhvMp7ux8Y-e1e8nwz9mrC7AK
X-Proofpoint-ORIG-GUID: C84M0MZwhvMp7ux8Y-e1e8nwz9mrC7AK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040193
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sub-NUMA clustering (SNC) invalidates previous assumptions of a 1:1
relationship between blades, sockets, and nodes.  Make changes
necessary to support this, including some general improvements along the
way.

Steve Wahl (8):
  x86/platform/uv: Add platform resolving #defines for misc
    GAM_MMIOH_REDIRECT*
  x86/platform/uv: Introduce helper function uv_pnode_to_socket.
  x86/platform/uv: Fix incorrect mask define use in calc_mmioh_map
  x86/platform/uv: When searching for minimums, start at INT_MAX not
    99999
  x86/platform/uv: helper functions for allocating and freeing
    conversion tables
  x86/platform/uv: UV support for sub-NUMA clustering
  x86/platform/uv: Remove remaining BUG_ON() and BUG() calls
  x86/platform/uv: Update UV[23] platform code for SNC

 arch/x86/include/asm/uv/uv_hub.h   |  32 ++-
 arch/x86/include/asm/uv/uv_mmrs.h  |  18 +-
 arch/x86/kernel/apic/x2apic_uv_x.c | 318 ++++++++++++++++++-----------
 3 files changed, 232 insertions(+), 136 deletions(-)

-- 
v2: Include the subsystem name (x86/platform/uv:) on the first line of
the commit (subject line).

v3: Use return from WARN_ON_ONCE() to simplify the code, remove memory
leaks from memory allocation failure conditions, and remove an
unnecessary set of curly braces, per comments from Ingo Molnar.

v4: Testing found that some configurations required adding a check for
"uv_blade_to_node(bid) == SOCK_EMPTY" in uv_system_init_hub().
Testing also found that some uv3 configurations didn't work correctly
with the new blade number handling.  The range of blade numbers is now
needed, not just the count, so calc_mmioh_map() and
boot_init_possible_blades() needed some adjustment.  And a reviewer
suggested using INT_MAX instead of 999999.

v5: Break up a single patch into smaller patches and re-factor a bit to
make the changes more understandable.  Unfortunately, the fundamental
change of the relationship between nodes, pnodes, and hubs touches a
lot of places that need to be changed at the same time, so patch 6 is
still rather large.

2.26.2

