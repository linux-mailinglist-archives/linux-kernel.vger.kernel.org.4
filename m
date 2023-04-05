Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35CB6D7E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbjDEODH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjDEOCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:02:03 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660C6E8B;
        Wed,  5 Apr 2023 07:01:09 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id ed0487bf64cd18fb; Wed, 5 Apr 2023 16:01:08 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BECD71B4EA15;
        Wed,  5 Apr 2023 16:01:07 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 14/32] ACPICA: Avoid undefined behavior: member access within null pointer
Date:   Wed, 05 Apr 2023 15:43:28 +0200
Message-ID: <2173946.Mh6RI2rZIc@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tamir Duberstein <tamird@google.com>

ACPICA commit 2411e11ef88f42b08f33c38ed9c0d40282780e8c

84449c1eef1c0d092b037dc4c2c60cec5d5cc6c4 fixed this for Linux kernel
builds, but not Linux userspace builds.

Before this change we see the following UBSAN stack trace in Fuchsia:

  ../../third_party/acpica/source/components/tables/tbfadt.c:536:39: runtime error: member access within null pointer of type 'struct acpi_table_fadt' (aka 'struct acpi_table_fadt')
      #0 0x564860b5ee9b in acpi_tb_convert_fadt ../../third_party/acpica/source/components/tables/tbfadt.c:536:39
      #1 0x564860b5edb4 in acpi_tb_create_local_fadt ../../third_party/acpica/source/components/tables/tbfadt.c:461:5
      #2 0x564860b5e5c6 in acpi_tb_parse_fadt ../../third_party/acpica/source/components/tables/tbfadt.c:371:5
      #3 0x564860b5c485 in acpi_tb_parse_root_table ../../third_party/acpica/source/components/tables/tbutils.c:407:13
      #4 0x564860b6401a in acpi_initialize_tables ../../third_party/acpica/source/components/tables/tbxface.c:160:14
      #5 0x5648608fb417 in acpi_host_test::acpi_host_test::init_acpi_with_tables(char const*) ../../src/devices/board/tests/acpi-host-tests/acpi-host-test.cc:36:5
      #6 0x5648608f9095 in acpi_host_test::acpi_host_test_device_is_child_of_scope_test_Test::test_body() ../../src/devices/board/tests/acpi-host-tests/acpi-host-test.cc:85:3
      #7 0x564860c6007e in void testing::internal::handle_seh_exceptions_in_method_if_supported<testing::Test, void>(testing::Test*, void (testing::Test::*)(), char const*) ../../third_party/googletest/src/googletest/src/gtest.cc:2609:10
      #8 0x564860bbd5df in void testing::internal::handle_exceptions_in_method_if_supported<testing::Test, void>(testing::Test*, void (testing::Test::*)(), char const*) ../../third_party/googletest/src/googletest/src/gtest.cc:2664:12 #9 0x564860bbd141 in testing::Test::Run() ../../third_party/googletest/src/googletest/src/gtest.cc:2684:5  #10 0x564860bbff0a in testing::test_info::Run() ../../third_party/googletest/src/googletest/src/gtest.cc:2864:11   #11 0x564860bc40f1 in testing::test_suite::Run() ../../third_party/googletest/src/googletest/src/gtest.cc:3023:30   #12 0x564860beba40 in testing::internal::unit_test_impl::run_all_tests() ../../third_party/googletest/src/googletest/src/gtest.cc:5882:44
      #13 0x564860c7db6e in bool testing::internal::handle_seh_exceptions_in_method_if_supported<testing::internal::unit_test_impl, bool>(testing::internal::unit_test_impl*, bool (testing::internal::unit_test_impl::*)(), char const*) ../../third_party/googletest/src/googletest/src/gtest.cc:2609:10
      #14 0x564860bea71f in bool testing::internal::handle_exceptions_in_method_if_supported<testing::internal::unit_test_impl, bool>(testing::internal::unit_test_impl*, bool (testing::internal::unit_test_impl::*)(), char const*) ../../third_party/googletest/src/googletest/src/gtest.cc:2664:12 #15 0x564860bea1c5 in testing::unit_test::Run() ../../third_party/googletest/src/googletest/src/gtest.cc:5456:10 #16 0x5648608fccc0 in RUN_ALL_TESTS() ../../third_party/googletest/src/googletest/include/gtest/gtest.h:2304:73 #17 0x5648608fcb7e in main ../../src/devices/board/tests/acpi-host-tests/acpi-host-test.cc:121:10 #18 0x7f6defa2d189  (/lib/x86_64-linux-gnu/libc.so.6+0x27189) (build_id: c4f6727c560b1c33527ff9e0ca0cef13a7db64d2)
      #19 0x7f6defa2d244 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x27244) (build_id: c4f6727c560b1c33527ff9e0ca0cef13a7db64d2)
      #20 0x56486082e598  (/usr/local/google/home/tamird/src/fuchsia/out/core.x64/host_x64/acpi-host-test-bin+0x359598) (build_id: 851423b0e664df6a)

Link: https://github.com/acpica/acpica/commit/2411e11e
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/platform/aclinux.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 66285e054e1e..1ca450e35c0d 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -180,7 +180,10 @@
 #define ACPI_USE_STANDARD_HEADERS
 
 #ifdef ACPI_USE_STANDARD_HEADERS
+#include <stddef.h>
 #include <unistd.h>
+
+#define ACPI_OFFSET(d, f)   offsetof(d, f)
 #endif
 
 /* Define/disable kernel-specific declarators */
-- 
2.35.3





