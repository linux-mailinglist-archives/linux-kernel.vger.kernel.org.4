Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4666F310A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjEAMlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjEAMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:41:44 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74323E52
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:41:09 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id tSpZpM6hwpwRItSpjpInb1; Mon, 01 May 2023 14:40:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682944847;
        bh=Y6jX0UsDm6a3lp5CHJtUMkKwAUFLiSnErUnf1hMH8N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EFN9WBZZ4HzqtmJmr+PAeusz/dEKjcn+ji/X+woIXvyf7jxlPZeY3IZiGi0zpxhVI
         yemqCzluDCowJFRfckb+4etAHcmFnWVN37j/iVSyBI/1LF3RnHBFrqVysUDdS6MNOY
         yviiQNl6t388hJf7MKyfxl9gsfqrH55CtVVF1RP0eq6fbKb84wy68E8NB78rjJhX45
         hXx2SboRQISzSUZxwnRgsJKd1RpnSLDJxmpjC0qDopVoV4/oOZw54X4c7bcPW/S1ar
         DxR7/gdcC9QboizEPICbCc/IEgtTl/J5YSuxlsC48vMVha8ukh8J0jBdGZpOIuDzOX
         ihpWYzUu01tgw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:47 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/5] nvmet: Reorder fields in 'struct nvme_ctrl'
Date:   Mon,  1 May 2023 14:40:26 +0200
Message-Id: <af016d2a5e7e7bb503eadb15037b80bc9813b94c.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct nvmet_sq' from 5368 to 5344
bytes when all CONFIG_* are defined.

This structure is embedded into some other structures, so it helps reducing
their size as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct nvme_ctrl {
	bool                       comp_seen;            /*     0     1 */

	/* XXX 3 bytes hole, try to pack */

	enum nvme_ctrl_state       state;                /*     4     4 */
	bool                       identified;           /*     8     1 */

	/* XXX 7 bytes hole, try to pack */

	spinlock_t                 lock;                 /*    16    72 */
	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
	struct mutex               scan_lock;            /*    88   160 */
	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
	const struct nvme_ctrl_ops  * ops;               /*   248     8 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	struct request_queue *     admin_q;              /*   256     8 */
	struct request_queue *     connect_q;            /*   264     8 */
	struct request_queue *     fabrics_q;            /*   272     8 */
	struct device *            dev;                  /*   280     8 */
	int                        instance;             /*   288     4 */
	int                        numa_node;            /*   292     4 */
	struct blk_mq_tag_set *    tagset;               /*   296     8 */
	struct blk_mq_tag_set *    admin_tagset;         /*   304     8 */
	struct list_head           namespaces;           /*   312    16 */
	/* --- cacheline 5 boundary (320 bytes) was 8 bytes ago --- */
	struct rw_semaphore        namespaces_rwsem;     /*   328   168 */
	/* --- cacheline 7 boundary (448 bytes) was 48 bytes ago --- */
	struct device              ctrl_device __attribute__((__aligned__(8))); /*   496  1400 */

	/* XXX last struct has 3 bytes of padding */

	/* --- cacheline 29 boundary (1856 bytes) was 40 bytes ago --- */
	struct device *            device;               /*  1896     8 */
	struct device *            hwmon_device;         /*  1904     8 */
	struct cdev                cdev;                 /*  1912   296 */
	/* --- cacheline 34 boundary (2176 bytes) was 32 bytes ago --- */
	struct work_struct         reset_work;           /*  2208    80 */
	/* --- cacheline 35 boundary (2240 bytes) was 48 bytes ago --- */
	struct work_struct         delete_work;          /*  2288    80 */
	/* --- cacheline 37 boundary (2368 bytes) --- */
	wait_queue_head_t          state_wq;             /*  2368    88 */
	/* --- cacheline 38 boundary (2432 bytes) was 24 bytes ago --- */
	struct nvme_subsystem *    subsys;               /*  2456     8 */
	struct list_head           subsys_entry;         /*  2464    16 */
	struct opal_dev *          opal_dev;             /*  2480     8 */
	char                       name[12];             /*  2488    12 */
	/* --- cacheline 39 boundary (2496 bytes) was 4 bytes ago --- */
	u16                        cntlid;               /*  2500     2 */

	/* XXX 2 bytes hole, try to pack */

	u32                        ctrl_config;          /*  2504     4 */
	u16                        mtfa;                 /*  2508     2 */

	/* XXX 2 bytes hole, try to pack */

	u32                        queue_count;          /*  2512     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        cap;                  /*  2520     8 */
	u32                        max_hw_sectors;       /*  2528     4 */
	u32                        max_segments;         /*  2532     4 */
	u32                        max_integrity_segments; /*  2536     4 */
	u32                        max_discard_sectors;  /*  2540     4 */
	u32                        max_discard_segments; /*  2544     4 */
	u32                        max_zeroes_sectors;   /*  2548     4 */
	u32                        max_zone_append;      /*  2552     4 */
	u16                        crdt[3];              /*  2556     6 */
	/* --- cacheline 40 boundary (2560 bytes) was 2 bytes ago --- */
	u16                        oncs;                 /*  2562     2 */
	u32                        dmrsl;                /*  2564     4 */
	u16                        oacs;                 /*  2568     2 */
	u16                        sqsize;               /*  2570     2 */
	u32                        max_namespaces;       /*  2572     4 */
	atomic_t                   abort_limit;          /*  2576     4 */
	u8                         vwc;                  /*  2580     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        vs;                   /*  2584     4 */
	u32                        sgls;                 /*  2588     4 */
	u16                        kas;                  /*  2592     2 */
	u8                         npss;                 /*  2594     1 */
	u8                         apsta;                /*  2595     1 */
	u16                        wctemp;               /*  2596     2 */
	u16                        cctemp;               /*  2598     2 */
	u32                        oaes;                 /*  2600     4 */
	u32                        aen_result;           /*  2604     4 */
	u32                        ctratt;               /*  2608     4 */
	unsigned int               shutdown_timeout;     /*  2612     4 */
	unsigned int               kato;                 /*  2616     4 */
	bool                       subsystem;            /*  2620     1 */

	/* XXX 3 bytes hole, try to pack */

	/* --- cacheline 41 boundary (2624 bytes) --- */
	long unsigned int          quirks;               /*  2624     8 */
	struct nvme_id_power_state psd[32];              /*  2632  1024 */
	/* --- cacheline 57 boundary (3648 bytes) was 8 bytes ago --- */
	struct nvme_effects_log *  effects;              /*  3656     8 */
	struct xarray              cels;                 /*  3664    88 */
	/* --- cacheline 58 boundary (3712 bytes) was 40 bytes ago --- */
	struct work_struct         scan_work;            /*  3752    80 */
	/* --- cacheline 59 boundary (3776 bytes) was 56 bytes ago --- */
	struct work_struct         async_event_work;     /*  3832    80 */
	/* --- cacheline 61 boundary (3904 bytes) was 8 bytes ago --- */
	struct delayed_work        ka_work;              /*  3912   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 64 boundary (4096 bytes) --- */
	struct delayed_work        failfast_work;        /*  4096   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 66 boundary (4224 bytes) was 56 bytes ago --- */
	struct nvme_command        ka_cmd;               /*  4280    64 */
	/* --- cacheline 67 boundary (4288 bytes) was 56 bytes ago --- */
	struct work_struct         fw_act_work;          /*  4344    80 */
	/* --- cacheline 69 boundary (4416 bytes) was 8 bytes ago --- */
	long unsigned int          events;               /*  4424     8 */
	u8                         anacap;               /*  4432     1 */
	u8                         anatt;                /*  4433     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        anagrpmax;            /*  4436     4 */
	u32                        nanagrpid;            /*  4440     4 */

	/* XXX 4 bytes hole, try to pack */

	struct mutex               ana_lock;             /*  4448   160 */
	/* --- cacheline 72 boundary (4608 bytes) --- */
	struct nvme_ana_rsp_hdr *  ana_log_buf;          /*  4608     8 */
	size_t                     ana_log_size;         /*  4616     8 */
	struct timer_list          anatt_timer;          /*  4624    88 */
	/* --- cacheline 73 boundary (4672 bytes) was 40 bytes ago --- */
	struct work_struct         ana_work;             /*  4712    80 */
	/* --- cacheline 74 boundary (4736 bytes) was 56 bytes ago --- */
	struct work_struct         dhchap_auth_work;     /*  4792    80 */
	/* --- cacheline 76 boundary (4864 bytes) was 8 bytes ago --- */
	struct mutex               dhchap_auth_mutex;    /*  4872   160 */
	/* --- cacheline 78 boundary (4992 bytes) was 40 bytes ago --- */
	struct nvme_dhchap_queue_context * dhchap_ctxs;  /*  5032     8 */
	struct nvme_dhchap_key *   host_key;             /*  5040     8 */
	struct nvme_dhchap_key *   ctrl_key;             /*  5048     8 */
	/* --- cacheline 79 boundary (5056 bytes) --- */
	u16                        transaction;          /*  5056     2 */

	/* XXX 6 bytes hole, try to pack */

	u64                        ps_max_latency_us;    /*  5064     8 */
	bool                       apst_enabled;         /*  5072     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        hmpre;                /*  5076     4 */
	u32                        hmmin;                /*  5080     4 */
	u32                        hmminds;              /*  5084     4 */
	u16                        hmmaxd;               /*  5088     2 */

	/* XXX 2 bytes hole, try to pack */

	u32                        ioccsz;               /*  5092     4 */
	u32                        iorcsz;               /*  5096     4 */
	u16                        icdoff;               /*  5100     2 */
	u16                        maxcmd;               /*  5102     2 */
	int                        nr_reconnects;        /*  5104     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          flags;                /*  5112     8 */
	/* --- cacheline 80 boundary (5120 bytes) --- */
	struct nvmf_ctrl_options * opts;                 /*  5120     8 */
	struct page *              discard_page;         /*  5128     8 */
	long unsigned int          discard_page_busy;    /*  5136     8 */
	struct nvme_fault_inject   fault_inject;         /*  5144   216 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 83 boundary (5312 bytes) was 48 bytes ago --- */
	enum nvme_ctrl_type        cntrltype;            /*  5360     4 */
	enum nvme_dctype           dctype;               /*  5364     4 */

	/* size: 5368, cachelines: 84, members: 104 */
	/* sum members: 5323, holes: 13, sum holes: 45 */
	/* paddings: 4, sum paddings: 15 */
	/* forced alignments: 1 */
	/* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));


After:
=====
struct nvme_ctrl {
	bool                       comp_seen;            /*     0     1 */
	bool                       identified;           /*     1     1 */

	/* XXX 2 bytes hole, try to pack */

	enum nvme_ctrl_state       state;                /*     4     4 */
	spinlock_t                 lock;                 /*     8    72 */
	/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
	struct mutex               scan_lock;            /*    80   160 */
	/* --- cacheline 3 boundary (192 bytes) was 48 bytes ago --- */
	const struct nvme_ctrl_ops  * ops;               /*   240     8 */
	struct request_queue *     admin_q;              /*   248     8 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	struct request_queue *     connect_q;            /*   256     8 */
	struct request_queue *     fabrics_q;            /*   264     8 */
	struct device *            dev;                  /*   272     8 */
	int                        instance;             /*   280     4 */
	int                        numa_node;            /*   284     4 */
	struct blk_mq_tag_set *    tagset;               /*   288     8 */
	struct blk_mq_tag_set *    admin_tagset;         /*   296     8 */
	struct list_head           namespaces;           /*   304    16 */
	/* --- cacheline 5 boundary (320 bytes) --- */
	struct rw_semaphore        namespaces_rwsem;     /*   320   168 */
	/* --- cacheline 7 boundary (448 bytes) was 40 bytes ago --- */
	struct device              ctrl_device __attribute__((__aligned__(8))); /*   488  1400 */

	/* XXX last struct has 3 bytes of padding */

	/* --- cacheline 29 boundary (1856 bytes) was 32 bytes ago --- */
	struct device *            device;               /*  1888     8 */
	struct device *            hwmon_device;         /*  1896     8 */
	struct cdev                cdev;                 /*  1904   296 */
	/* --- cacheline 34 boundary (2176 bytes) was 24 bytes ago --- */
	struct work_struct         reset_work;           /*  2200    80 */
	/* --- cacheline 35 boundary (2240 bytes) was 40 bytes ago --- */
	struct work_struct         delete_work;          /*  2280    80 */
	/* --- cacheline 36 boundary (2304 bytes) was 56 bytes ago --- */
	wait_queue_head_t          state_wq;             /*  2360    88 */
	/* --- cacheline 38 boundary (2432 bytes) was 16 bytes ago --- */
	struct nvme_subsystem *    subsys;               /*  2448     8 */
	struct list_head           subsys_entry;         /*  2456    16 */
	struct opal_dev *          opal_dev;             /*  2472     8 */
	char                       name[12];             /*  2480    12 */
	u16                        cntlid;               /*  2492     2 */
	u16                        mtfa;                 /*  2494     2 */
	/* --- cacheline 39 boundary (2496 bytes) --- */
	u32                        ctrl_config;          /*  2496     4 */
	u32                        queue_count;          /*  2500     4 */
	u64                        cap;                  /*  2504     8 */
	u32                        max_hw_sectors;       /*  2512     4 */
	u32                        max_segments;         /*  2516     4 */
	u32                        max_integrity_segments; /*  2520     4 */
	u32                        max_discard_sectors;  /*  2524     4 */
	u32                        max_discard_segments; /*  2528     4 */
	u32                        max_zeroes_sectors;   /*  2532     4 */
	u32                        max_zone_append;      /*  2536     4 */
	u16                        crdt[3];              /*  2540     6 */
	u16                        oncs;                 /*  2546     2 */
	u32                        dmrsl;                /*  2548     4 */
	u16                        oacs;                 /*  2552     2 */
	u16                        sqsize;               /*  2554     2 */
	u32                        max_namespaces;       /*  2556     4 */
	/* --- cacheline 40 boundary (2560 bytes) --- */
	atomic_t                   abort_limit;          /*  2560     4 */
	u8                         vwc;                  /*  2564     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        vs;                   /*  2568     4 */
	u32                        sgls;                 /*  2572     4 */
	u16                        kas;                  /*  2576     2 */
	u8                         npss;                 /*  2578     1 */
	u8                         apsta;                /*  2579     1 */
	u16                        wctemp;               /*  2580     2 */
	u16                        cctemp;               /*  2582     2 */
	u32                        oaes;                 /*  2584     4 */
	u32                        aen_result;           /*  2588     4 */
	u32                        ctratt;               /*  2592     4 */
	unsigned int               shutdown_timeout;     /*  2596     4 */
	unsigned int               kato;                 /*  2600     4 */
	bool                       subsystem;            /*  2604     1 */

	/* XXX 3 bytes hole, try to pack */

	long unsigned int          quirks;               /*  2608     8 */
	struct nvme_id_power_state psd[32];              /*  2616  1024 */
	/* --- cacheline 56 boundary (3584 bytes) was 56 bytes ago --- */
	struct nvme_effects_log *  effects;              /*  3640     8 */
	/* --- cacheline 57 boundary (3648 bytes) --- */
	struct xarray              cels;                 /*  3648    88 */
	/* --- cacheline 58 boundary (3712 bytes) was 24 bytes ago --- */
	struct work_struct         scan_work;            /*  3736    80 */
	/* --- cacheline 59 boundary (3776 bytes) was 40 bytes ago --- */
	struct work_struct         async_event_work;     /*  3816    80 */
	/* --- cacheline 60 boundary (3840 bytes) was 56 bytes ago --- */
	struct delayed_work        ka_work;              /*  3896   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 63 boundary (4032 bytes) was 48 bytes ago --- */
	struct delayed_work        failfast_work;        /*  4080   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 66 boundary (4224 bytes) was 40 bytes ago --- */
	struct nvme_command        ka_cmd;               /*  4264    64 */
	/* --- cacheline 67 boundary (4288 bytes) was 40 bytes ago --- */
	struct work_struct         fw_act_work;          /*  4328    80 */
	/* --- cacheline 68 boundary (4352 bytes) was 56 bytes ago --- */
	long unsigned int          events;               /*  4408     8 */
	/* --- cacheline 69 boundary (4416 bytes) --- */
	u8                         anacap;               /*  4416     1 */
	u8                         anatt;                /*  4417     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        anagrpmax;            /*  4420     4 */
	u32                        nanagrpid;            /*  4424     4 */

	/* XXX 4 bytes hole, try to pack */

	struct mutex               ana_lock;             /*  4432   160 */
	/* --- cacheline 71 boundary (4544 bytes) was 48 bytes ago --- */
	struct nvme_ana_rsp_hdr *  ana_log_buf;          /*  4592     8 */
	size_t                     ana_log_size;         /*  4600     8 */
	/* --- cacheline 72 boundary (4608 bytes) --- */
	struct timer_list          anatt_timer;          /*  4608    88 */
	/* --- cacheline 73 boundary (4672 bytes) was 24 bytes ago --- */
	struct work_struct         ana_work;             /*  4696    80 */
	/* --- cacheline 74 boundary (4736 bytes) was 40 bytes ago --- */
	struct work_struct         dhchap_auth_work;     /*  4776    80 */
	/* --- cacheline 75 boundary (4800 bytes) was 56 bytes ago --- */
	struct mutex               dhchap_auth_mutex;    /*  4856   160 */
	/* --- cacheline 78 boundary (4992 bytes) was 24 bytes ago --- */
	struct nvme_dhchap_queue_context * dhchap_ctxs;  /*  5016     8 */
	struct nvme_dhchap_key *   host_key;             /*  5024     8 */
	struct nvme_dhchap_key *   ctrl_key;             /*  5032     8 */
	u16                        transaction;          /*  5040     2 */

	/* XXX 6 bytes hole, try to pack */

	u64                        ps_max_latency_us;    /*  5048     8 */
	/* --- cacheline 79 boundary (5056 bytes) --- */
	bool                       apst_enabled;         /*  5056     1 */

	/* XXX 1 byte hole, try to pack */

	u16                        hmmaxd;               /*  5058     2 */
	u32                        hmpre;                /*  5060     4 */
	u32                        hmmin;                /*  5064     4 */
	u32                        hmminds;              /*  5068     4 */
	u32                        ioccsz;               /*  5072     4 */
	u32                        iorcsz;               /*  5076     4 */
	u16                        icdoff;               /*  5080     2 */
	u16                        maxcmd;               /*  5082     2 */
	int                        nr_reconnects;        /*  5084     4 */
	long unsigned int          flags;                /*  5088     8 */
	struct nvmf_ctrl_options * opts;                 /*  5096     8 */
	struct page *              discard_page;         /*  5104     8 */
	long unsigned int          discard_page_busy;    /*  5112     8 */
	/* --- cacheline 80 boundary (5120 bytes) --- */
	struct nvme_fault_inject   fault_inject;         /*  5120   216 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 83 boundary (5312 bytes) was 24 bytes ago --- */
	enum nvme_ctrl_type        cntrltype;            /*  5336     4 */
	enum nvme_dctype           dctype;               /*  5340     4 */

	/* size: 5344, cachelines: 84, members: 104 */
	/* sum members: 5323, holes: 7, sum holes: 21 */
	/* paddings: 4, sum paddings: 15 */
	/* forced alignments: 1 */
	/* last cacheline: 32 bytes */
} __attribute__((__aligned__(8)));
---
 drivers/nvme/host/nvme.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..53417b6439a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -246,8 +246,8 @@ enum nvme_ctrl_flags {
 
 struct nvme_ctrl {
 	bool comp_seen;
-	enum nvme_ctrl_state state;
 	bool identified;
+	enum nvme_ctrl_state state;
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
@@ -279,8 +279,8 @@ struct nvme_ctrl {
 	char name[12];
 	u16 cntlid;
 
-	u32 ctrl_config;
 	u16 mtfa;
+	u32 ctrl_config;
 	u32 queue_count;
 
 	u64 cap;
@@ -353,10 +353,10 @@ struct nvme_ctrl {
 	bool apst_enabled;
 
 	/* PCIe only: */
+	u16 hmmaxd;
 	u32 hmpre;
 	u32 hmmin;
 	u32 hmminds;
-	u16 hmmaxd;
 
 	/* Fabrics only */
 	u32 ioccsz;
-- 
2.34.1

