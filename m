Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33166F310C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjEAMlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjEAMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:41:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CC1716
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:41:10 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id tSpZpM6hwpwRItSpkpInb8; Mon, 01 May 2023 14:40:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682944848;
        bh=C43rYffzeLeuYm1ltXsP0tciLDt8iNhANcYULlPeETQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HQrssG6wByiAUvHE7mEaJaHjVvUhQyZjXSRSr4ruDx1SRpgEeS8XnMp4o3mQtwDFB
         KBfkH5y4ndSsmdjLjCbZsmYtbNSo92JROIcT3t1JDN/lzbvQC8E5vKYIDcVFWWY8Iw
         PoVzohoIiYtWqWty3vNTklmwKjjQ8az2XcWOko1YmtnGhnm1DK9MpkZNY03oeSOcxw
         EXEDzNN6NLRG1TPmP7dgPyi+IepdqHula80oVmG46HUajJ9HxmWhicjgBE84/UfgI0
         87Lp0fqqmz1Jg+vL1H3Ro9U+9Oxr/51Xi1nBJu0mDvC4fT3RnDIDETcmx9R+i+PoK6
         IWRKvy1z4HYzw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:48 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/5] nvmet: Reorder fields in 'struct nvmf_ctrl_options'
Date:   Mon,  1 May 2023 14:40:27 +0200
Message-Id: <78d06714ee7db7d977c390514b3bcfc71a07916f.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct nvmf_ctrl_options' from 136 to
128 bytes.

When such a structure is allocated in nvmf_create_ctrl(), because of the
way memory allocation works, when 136 bytes were requested, 192 bytes were
allocated.

So this saves 64 bytes per allocation, 1 cache line to hold the whole
structure and a few cycles when zeroing the memory in nvmf_create_ctrl().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct nvmf_ctrl_options {
	unsigned int               mask;                 /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     transport;            /*     8     8 */
	char *                     subsysnqn;            /*    16     8 */
	char *                     traddr;               /*    24     8 */
	char *                     trsvcid;              /*    32     8 */
	char *                     host_traddr;          /*    40     8 */
	char *                     host_iface;           /*    48     8 */
	size_t                     queue_size;           /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               nr_io_queues;         /*    64     4 */
	unsigned int               reconnect_delay;      /*    68     4 */
	bool                       discovery_nqn;        /*    72     1 */
	bool                       duplicate_connect;    /*    73     1 */

	/* XXX 2 bytes hole, try to pack */

	unsigned int               kato;                 /*    76     4 */
	struct nvmf_host *         host;                 /*    80     8 */
	int                        max_reconnects;       /*    88     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     dhchap_secret;        /*    96     8 */
	char *                     dhchap_ctrl_secret;   /*   104     8 */
	bool                       disable_sqflow;       /*   112     1 */
	bool                       hdr_digest;           /*   113     1 */
	bool                       data_digest;          /*   114     1 */

	/* XXX 1 byte hole, try to pack */

	unsigned int               nr_write_queues;      /*   116     4 */
	unsigned int               nr_poll_queues;       /*   120     4 */
	int                        tos;                  /*   124     4 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        fast_io_fail_tmo;     /*   128     4 */

	/* size: 136, cachelines: 3, members: 24 */
	/* sum members: 121, holes: 4, sum holes: 11 */
	/* padding: 4 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct nvmf_ctrl_options {
	unsigned int               mask;                 /*     0     4 */
	int                        max_reconnects;       /*     4     4 */
	char *                     transport;            /*     8     8 */
	char *                     subsysnqn;            /*    16     8 */
	char *                     traddr;               /*    24     8 */
	char *                     trsvcid;              /*    32     8 */
	char *                     host_traddr;          /*    40     8 */
	char *                     host_iface;           /*    48     8 */
	size_t                     queue_size;           /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               nr_io_queues;         /*    64     4 */
	unsigned int               reconnect_delay;      /*    68     4 */
	bool                       discovery_nqn;        /*    72     1 */
	bool                       duplicate_connect;    /*    73     1 */

	/* XXX 2 bytes hole, try to pack */

	unsigned int               kato;                 /*    76     4 */
	struct nvmf_host *         host;                 /*    80     8 */
	char *                     dhchap_secret;        /*    88     8 */
	char *                     dhchap_ctrl_secret;   /*    96     8 */
	bool                       disable_sqflow;       /*   104     1 */
	bool                       hdr_digest;           /*   105     1 */
	bool                       data_digest;          /*   106     1 */

	/* XXX 1 byte hole, try to pack */

	unsigned int               nr_write_queues;      /*   108     4 */
	unsigned int               nr_poll_queues;       /*   112     4 */
	int                        tos;                  /*   116     4 */
	int                        fast_io_fail_tmo;     /*   120     4 */

	/* size: 128, cachelines: 2, members: 24 */
	/* sum members: 121, holes: 2, sum holes: 3 */
	/* padding: 4 */
};
---
 drivers/nvme/host/fabrics.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..1bc57fb75825 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -77,6 +77,9 @@ enum {
  *			      with the parsing opts enum.
  * @mask:	Used by the fabrics library to parse through sysfs options
  *		on adding a NVMe controller.
+ * @max_reconnects: maximum number of allowed reconnect attempts before removing
+ *		the controller, (-1) means reconnect forever, zero means remove
+ *		immediately;
  * @transport:	Holds the fabric transport "technology name" (for a lack of
  *		better description) that will be used by an NVMe controller
  *		being added.
@@ -96,9 +99,6 @@ enum {
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
- * @max_reconnects: maximum number of allowed reconnect attempts before removing
- *              the controller, (-1) means reconnect forever, zero means remove
- *              immediately;
  * @dhchap_secret: DH-HMAC-CHAP secret
  * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
  *              authentication
@@ -112,6 +112,7 @@ enum {
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
+	int			max_reconnects;
 	char			*transport;
 	char			*subsysnqn;
 	char			*traddr;
@@ -125,7 +126,6 @@ struct nvmf_ctrl_options {
 	bool			duplicate_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
-	int			max_reconnects;
 	char			*dhchap_secret;
 	char			*dhchap_ctrl_secret;
 	bool			disable_sqflow;
-- 
2.34.1

