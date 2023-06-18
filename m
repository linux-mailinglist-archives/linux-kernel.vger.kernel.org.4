Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528E973455C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjFRIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFRIIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:08:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CEC1706
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 01:08:12 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AnSCqLxfhonlZAnSCqJfqb; Sun, 18 Jun 2023 10:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687075689;
        bh=6WU86U56M483R8yCdnQ94w/Wv9IX0lwEV7xy79EtEyk=;
        h=From:To:Cc:Subject:Date;
        b=N36yDDgSCRkLrphXPqmm/dtSd1JNg5zw6b7jMluim6E3cM2Mo7DPbRvojniGDsKi8
         Tw6UGwhlHpoil/CCQfP9b9xGo78DEAZ+jbFfSPJYFnkwe+sNLr9XORsu1zIzV0dsh5
         8idwfq2cXOtQPdXM5dMvSlR2XKus3vAuC6KbMiChu1Am2VWr1GiYPRJWvUHinq8Nqx
         muQe+61ICsMm6NxJg2P7kGmoQndO3g88eLfvbyaayRNn8iI8IW5HKlvxbP1Gp6J3Py
         tSLijylbvIbIZH8eYncu53QEXmEPZBt14U68FVZ/juQ56V3k4EBqE30Z2RSmEYf+Ej
         YpFfIPuMpgmiA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Jun 2023 10:08:09 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: Reorder fields in 'struct hid_field'
Date:   Sun, 18 Jun 2023 10:08:07 +0200
Message-Id: <a804f2e91bc32cc5e17e012ed90972415606db4e.1687075665.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct hid_field'
from 136 to 128 bytes.

It saves a few bytes of memory and is more cache-line friendly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct hid_field {
	unsigned int               physical;             /*     0     4 */
	unsigned int               logical;              /*     4     4 */
	unsigned int               application;          /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	struct hid_usage *         usage;                /*    16     8 */
	unsigned int               maxusage;             /*    24     4 */
	unsigned int               flags;                /*    28     4 */
	unsigned int               report_offset;        /*    32     4 */
	unsigned int               report_size;          /*    36     4 */
	unsigned int               report_count;         /*    40     4 */
	unsigned int               report_type;          /*    44     4 */
	__s32 *                    value;                /*    48     8 */
	__s32 *                    new_value;            /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	__s32 *                    usages_priorities;    /*    64     8 */
	__s32                      logical_minimum;      /*    72     4 */
	__s32                      logical_maximum;      /*    76     4 */
	__s32                      physical_minimum;     /*    80     4 */
	__s32                      physical_maximum;     /*    84     4 */
	__s32                      unit_exponent;        /*    88     4 */
	unsigned int               unit;                 /*    92     4 */
	bool                       ignored;              /*    96     1 */

	/* XXX 7 bytes hole, try to pack */

	struct hid_report *        report;               /*   104     8 */
	unsigned int               index;                /*   112     4 */

	/* XXX 4 bytes hole, try to pack */

	struct hid_input *         hidinput;             /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	__u16                      dpad;                 /*   128     2 */

	/* XXX 2 bytes hole, try to pack */

	unsigned int               slot_idx;             /*   132     4 */

	/* size: 136, cachelines: 3, members: 25 */
	/* sum members: 119, holes: 4, sum holes: 17 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct hid_field {
	unsigned int               physical;             /*     0     4 */
	unsigned int               logical;              /*     4     4 */
	unsigned int               application;          /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	struct hid_usage *         usage;                /*    16     8 */
	unsigned int               maxusage;             /*    24     4 */
	unsigned int               flags;                /*    28     4 */
	unsigned int               report_offset;        /*    32     4 */
	unsigned int               report_size;          /*    36     4 */
	unsigned int               report_count;         /*    40     4 */
	unsigned int               report_type;          /*    44     4 */
	__s32 *                    value;                /*    48     8 */
	__s32 *                    new_value;            /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	__s32 *                    usages_priorities;    /*    64     8 */
	__s32                      logical_minimum;      /*    72     4 */
	__s32                      logical_maximum;      /*    76     4 */
	__s32                      physical_minimum;     /*    80     4 */
	__s32                      physical_maximum;     /*    84     4 */
	__s32                      unit_exponent;        /*    88     4 */
	unsigned int               unit;                 /*    92     4 */
	struct hid_report *        report;               /*    96     8 */
	unsigned int               index;                /*   104     4 */
	bool                       ignored;              /*   108     1 */

	/* XXX 3 bytes hole, try to pack */

	struct hid_input *         hidinput;             /*   112     8 */
	__u16                      dpad;                 /*   120     2 */

	/* XXX 2 bytes hole, try to pack */

	unsigned int               slot_idx;             /*   124     4 */

	/* size: 128, cachelines: 2, members: 25 */
	/* sum members: 119, holes: 3, sum holes: 9 */
};
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 39e21e3815ad..5be5e671c263 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -480,9 +480,9 @@ struct hid_field {
 	__s32     physical_maximum;
 	__s32     unit_exponent;
 	unsigned  unit;
-	bool      ignored;		/* this field is ignored in this event */
 	struct hid_report *report;	/* associated report */
 	unsigned index;			/* index into report->field[] */
+	bool      ignored;		/* this field is ignored in this event */
 	/* hidinput data */
 	struct hid_input *hidinput;	/* associated input structure */
 	__u16 dpad;			/* dpad input code */
-- 
2.34.1

