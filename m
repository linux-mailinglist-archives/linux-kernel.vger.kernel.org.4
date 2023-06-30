Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB068744135
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjF3R13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjF3R1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:27:24 -0400
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9851FF2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:27:20 -0700 (PDT)
Received: from 104.47.11.177_.trendmicro.com (unknown [172.21.19.51])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id BC2B7108FF1DB;
        Fri, 30 Jun 2023 17:12:34 +0000 (UTC)
Received: from 104.47.11.177_.trendmicro.com (unknown [172.21.178.36])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 32A4C100004FF;
        Fri, 30 Jun 2023 17:12:33 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1688145152.682000
X-TM-MAIL-UUID: 3871fe6c-b6a5-4d22-b8ba-6073f2918062
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.177])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A6CF2100003DA;
        Fri, 30 Jun 2023 17:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhxmdl2MY8W4kWuMPZaBD6E7Hje4A29VJ8ZGykf2vG1cGU2ifxPm5JRcNoS/cniyAHoKaqRVkONTEk7d1JTPqb0tYPfNambhtv0iqV3SnXGcoCq9nTjO5bJvwdrYWc31UulvCVuYUlYUv1vvF0VtNpFIwUdtPb3OS8vr+1cz/DT0pVGTyG7G2k8pkNezM7wKHafpU7xUhl7Qmk82dBuFLUZbpbrAjxgcpOQjf88w2WPpsKWDGYo3wPoeorBBWB9S5IebSP5l/XoZxuIHOAFl3EZ2qt+DsNQPsmv3iIE2OQNfgLDZuWapbAiKgTpA1EIqlucEQvleUNvn9NztZvWQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtTkodt8TjTUIJXjHXZ5ggCtrxGe55E6vmqBOnZiztw=;
 b=FvdIkuDm5ivoDV5i/q6QzOMAuDFSK3LVlL90c1FTJ1JEUJ/vdL1p0P66szN2qg/Qv+32LPQ/3mivYwUqWG0+WGVRM3PJFonOeFaEQCIvMCDormGTJCww4ZJnXPDw1YTzcFX3dZlFEV4QYURR5hFWvHX38DnNfBQPhIM92h2dDZ39sMMPuGEIhW1zLfJLJmyl0J7oSMa/rqJgzhZ37/mpr906dn5KlV2AdNsGPbbXmxqubGcO4q6+N9/ep9jj/LN8bAIosoYKe0KSzMcFYveDU6rRoyRrTqFPP+p1aPnLvhwqd2HB2vh4EO778BlBgM6g01WjhwoPqAvljVUh14Tmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org
Subject: [RFC PATCH 6/7] virtio_rtc: Add PTP clocks
Date:   Fri, 30 Jun 2023 19:10:49 +0200
Message-Id: <20230630171052.985577-7-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630171052.985577-1-peter.hilber@opensynergy.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT005:EE_|FR2P281MB0282:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4cfacfd-980d-44b7-0e19-08db798d305d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE8ZUmmKrnnqU7aS4l2Jbei9XqbQWkyl4lu1CRfd8mwftT/JI8qodJAA5XhiSnN0SDKL6/1opsxx6GhwpPcQt6r4ZW6nw3AP2PuzSynX4s1TXX6NqAFUmiNSdgw1tV9l7QRUKagvDWzF5awB65fSfoy5h2CmWEamxyBEFM/Yz87WQfGpvO3mr8/Xlnyqiu6sB24ZCEY2O5301U9GfjOyLmX71YagZxCv/EJ472o69Mpqqp/XasRfse+NnuuTDIIJ2lHaLip9xG32J3cmRkQ4F9NAkC/Gz3orVlleban40hiJ/8nOFHbzz3vRqCWAsCta9kvD4iOnM9QU4O1OK5+5eOjn/0XC1kd3sz8TmMZQkVE3Mlq5SsP+1UboNAd8T+bgJ7vKxhYFjblCFOyqJ9Mwmc+66Gr3B+b26eKd2Vdm6FZwAy1aLgqA+XuwlV0j2Twg+Tm1poaQ8BQdwKdLlb+zvAYpzKZ50UxYGO5OUsmd6DmhA5b/x1zkRUvi2HAu+ND218h7DO/CM6OzxWvUOQ8UrsvGdo/WG24P0VOsddSWYSoYHNOvJldlpgfaEaAR4aKccyA29OBN9FnFfrKtSmp1VC1B6KIIc8QkC9eRA6Pd/uwxrGUJ9vCqTueDWzbklYUdkwNtIRrcE8tuELXExPc4aFuZQP6dWzekS9KBPBIVKvFDRQw2wy4OM6I2kZWresVxsDO5QLLmliBo3fHpayjmAglfXMpVUEaNP76hNBi+KC2WHnjZ5t+Tz0LPEhmOE6Xwo/ZYE+ChRArIFh8/vRafsw==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39830400003)(451199021)(46966006)(36840700001)(2616005)(81166007)(186003)(1076003)(83380400001)(36860700001)(47076005)(40480700001)(26005)(336012)(30864003)(44832011)(41300700001)(5660300002)(8936002)(8676002)(2906002)(36756003)(42186006)(316002)(86362001)(70206006)(70586007)(4326008)(478600001)(54906003)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:31.0717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cfacfd-980d-44b7-0e19-08db798d305d
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT005.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0282
X-TM-AS-ERS: 104.47.11.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--16.843500-4.000000
X-TMASE-MatchedRID: vv7MY3lDOKoY9bhGrdH9F9wy9mwTudtiRyG5SSR7mMGmopAzNrNOJn+F
        psIKKIVlk8IAUKtJYbMmnuaVQc5qV4oSaqhQo1toHW+C8sNk3WDFZzmk4ajzuCe5CWghtIzPb1O
        21F3h9PlzEFhMBQYFa/6kCjQkL+3Saroq2fxRivXHfwwbjh/dN1pMWq1GqY9jyEYRIXZC1hKyCR
        +docAU/Ob1Nz8aB8UnAW1a55mUwfQHfNbJzbBb9f0hW+Pi7Cos3V8nMuq8B6LlbwjdfEVENOqqk
        o1PXeESs2CEDKA6J1Ob2SBPGBzRQQIfpHdEtL3FiL+RrlWsewoHgEx+rhLN4ngwJo5QMsV9KMNS
        xwZpXDY9yytr4YofCE5yycj+UwCjMUcXkeXNyfeK7q7iyFn58WnTqal/GlimkVj8lcfFncZldff
        r8GYLT6jZdiFdYobCo9RNpYDQkvQTevXTasglgVY9XYa1m8xAIQdkvxKngOsC28FWVjkhF9ho/I
        sfJ5coNljDlR2ZyXisiaeLjSuHt97BQ4zNEspZGwz+ElW8lobsrnN2nOWPXqiqsiuuQaXipVLP8
        mlEC5lKjlC2ODrqQEGt9OJES2KrzNq26dMbJoCjmpJtigrtbnJ8bM38R9gpJsfJJdVp3fqvngkj
        HjojpH2fbnp7T2HmiXG+DOC9637Q6QzQbo9igznxJqun3snzJQhrLH5KSJ0=
X-TMASE-XGENCLOUD: b584f51f-8ad7-4750-a884-cb78ad6a3201-0-0-200-0
X-TM-Deliver-Signature: 25589D73EFA9610A5AC4D72DD90123B8
X-TM-Addin-Auth: 0RD+6gItsc0HPlz1WG6qHUNsXbWh7UcZmeBxvMejIeHxSXtbXZIR4iVD90X
        cbVhNpkOJPA24HMxUCx9U6wWZqZ3QwGrhgz6lCE40i4TxEkM6l1iqylsX4n4KyZGTELijOS6KUp
        sbQAOHfXjq5aJBi370BaRunWPAYgSY9GDhjcylHO7isbNuOUA5JMg+AWwQBKndX7s1ieCKeRFG5
        wWdSUPfI22qEmLThkkzOxfwIn/EPhDzl9ImZIIMFNC1p/BOIZWBf1ZeYGIO/SOqglEQnNt3UzwI
        g6aKOsVmJRrdXsM=.UKRAVygnQxQ4NR8AjlO+iFdbxMafzR7kKUEl5Pxz3+O4SeRTkp76ppUfx/
        hzNwwk44Ex+p2Pyg+BGabUxE67Nvoa+IPpQ/FjDI4O26YE//C+dHsHAGX0D0xSgOI/CsX+2GpAk
        uC36YebagjxBS8C1Vk+Esw9sjppV44uaw5zybPfpvVnTMKQnnTLVaNMvbnsWD588AW9lsDyCa0l
        EFV5fh1bju/s876iZko0sIlYP0M1ISvIJqJwIveesiFaE5bMrImiR7z7KAfOV33wI4zEebYZyI6
        8XU9/d6sbWYWIWV4/NTzaW10kkdXTEcxOUkGjRwJuZGFsvgsG9ahd7EzyzA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1688145153;
        bh=s2A5FGg6U2xNr2VnGVaTfvO0HLF7T3Yy42ZePqFzDEY=; l=20488;
        h=From:To:Date;
        b=aKHkpqPxrepG+Ju8Oc41Vplt2Rbas1JR/ije0oGPvOBXFzsXw+k17bpDjvFF0crO5
         TCzMi/WQPc67utO6e6+bVO12kirBIHKeAB5WkbpuBOqpvnh/kTRb8JTmN5WV8ffbqA
         4IVL/wiDCxAmkJ9ARIURYVnXBLkLjXVQwzwsNH3oa1hqn/OFcElm9FqBb4VbdESMpJ
         zLuvvAQG0jLWRnVWQ9P4HP9/ULquAmu3iygiuJ34VtpIOW7z48U3aa2OjZB0C6Wfc2
         /BDByYKo7wbwxqoYKtDw7lUObP+07svSdTpyA3RY0PnKsvhVuIgiffPjnpeZQaPNbA
         wNHwORRiiO6wA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the virtio_rtc clocks as PTP clocks to userspace, similar to
ptp_kvm. virtio_rtc can expose multiple clocks, e.g. a UTC clock and a
monotonic clock. Userspace should distinguish different clocks through the
name assigned by the driver. A udev rule such as the following can be used
to get a symlink /dev/ptp_virtio to the UTC clock:

	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP UTC", SYMLINK += "ptp_virtio"

The preferred PTP clock reading method is ioctl PTP_SYS_OFFSET_PRECISE2,
through the ptp_clock_info.getcrosststamp() op. For now,
PTP_SYS_OFFSET_PRECISE2 will return -EOPNOTSUPP through a weak function.
PTP_SYS_OFFSET_PRECISE2 requires cross-timestamping support for specific
clocksources, which will be added in the following. If the clocksource
specific code is enabled, check that the Virtio RTC device supports the
respective HW counter before obtaining an actual cross-timestamp from the
Virtio device.

The Virtio RTC device response time may be higher than the timekeeper
seqcount increment interval. Therefore, obtain the cross-timestamp before
calling get_device_system_crosststamp().

As a fallback, support the ioctl PTP_SYS_OFFSET_EXTENDED2 for all
platforms.

Assume that concurrency issues during PTP clock removal are avoided by the
posix_clock framework.

Kconfig recursive dependencies prevent virtio_rtc from implicitly enabling
PTP_1588_CLOCK, therefore just warn the user if PTP_1588_CLOCK is not
available. Since virtio_rtc should in the future also expose clocks as RTC
class devices, it should make sense to not have VIRTIO_RTC depend on
PTP_1588_CLOCK.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/virtio/Kconfig               |  16 ++
 drivers/virtio/Makefile              |   1 +
 drivers/virtio/virtio_rtc_driver.c   | 111 +++++++-
 drivers/virtio/virtio_rtc_internal.h |  62 +++++
 drivers/virtio/virtio_rtc_ptp.c      | 384 +++++++++++++++++++++++++++
 5 files changed, 571 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index e3dbf16fa977..7369ecd7dd01 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -187,4 +187,20 @@ config VIRTIO_RTC
 
 	 If unsure, say M.
 
+comment "WARNING: The Virtio RTC driver is useless without VIRTIO_RTC_PTP."
+	depends on VIRTIO_RTC && !VIRTIO_RTC_PTP
+
+comment "Enable PTP_1588_CLOCK in order to enable VIRTIO_RTC_PTP."
+	depends on VIRTIO_RTC && PTP_1588_CLOCK=n
+
+config VIRTIO_RTC_PTP
+	bool "Virtio RTC PTP clocks"
+	default y
+	depends on VIRTIO_RTC && PTP_1588_CLOCK
+	help
+	 This exposes any Virtio RTC clocks as PTP Hardware Clocks (PHCs) to
+	 userspace.
+
+	 If unsure, say Y.
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index f760414ed6ab..4d48cbcae6bb 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
 obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
 obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 virtio_rtc-y := virtio_rtc_driver.o
+virtio_rtc-$(CONFIG_VIRTIO_RTC_PTP) += virtio_rtc_ptp.o
diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index 424500d2c4f7..3c11fa95b9a7 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -36,11 +36,16 @@ struct viortc_vq {
  * struct viortc_dev - virtio_rtc device data
  * @vdev: virtio device
  * @vqs: virtqueues
+ * @clocks_to_unregister: Clock references, which are only used during device
+ *                        removal.
+ *			  For other uses, there would be a race between device
+ *			  creation and setting the pointers here.
  * @num_clocks: # of virtio_rtc clocks
  */
 struct viortc_dev {
 	struct virtio_device *vdev;
 	struct viortc_vq vqs[VIORTC_MAX_NR_QUEUES];
+	struct viortc_ptp_clock **clocks_to_unregister;
 	u16 num_clocks;
 };
 
@@ -588,6 +593,89 @@ int viortc_cross_cap(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
  * init, deinit
  */
 
+/**
+ * viortc_init_clock() - init local representation of virtio_rtc clock (PHC)
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_init_clock(struct viortc_dev *viortc, u64 vio_clk_id)
+{
+	int ret;
+	u16 clock_type;
+	char ptp_clock_name[PTP_CLOCK_NAME_LEN];
+	const char *type_name;
+	/* fit prefix + u16 in decimal */
+	char type_name_buf[5 + 5 + 1];
+	bool has_xtstamp_feature;
+	struct viortc_ptp_clock *vio_ptp;
+	struct virtio_device *vdev = viortc->vdev;
+
+	ret = viortc_clock_cap(viortc, vio_clk_id, &clock_type);
+	if (ret)
+		return ret;
+
+	switch (clock_type) {
+	case VIRTIO_RTC_CLOCK_UTC:
+		type_name = "UTC";
+		break;
+	case VIRTIO_RTC_CLOCK_TAI:
+		type_name = "TAI";
+		break;
+	case VIRTIO_RTC_CLOCK_MONO:
+		type_name = "monotonic";
+		break;
+	default:
+		snprintf(type_name_buf, sizeof(type_name_buf), "type %hu",
+			 clock_type);
+		type_name = type_name_buf;
+	}
+
+	snprintf(ptp_clock_name, PTP_CLOCK_NAME_LEN, "Virtio PTP %s",
+		 type_name);
+
+	has_xtstamp_feature = virtio_has_feature(vdev, VIRTIO_RTC_F_READ_CROSS);
+
+	vio_ptp = viortc_ptp_register(viortc, &vdev->dev, vio_clk_id,
+				      ptp_clock_name, has_xtstamp_feature);
+	if (IS_ERR(vio_ptp)) {
+		dev_err(&vdev->dev, "failed to register PTP clock '%s'\n",
+			ptp_clock_name);
+		return PTR_ERR(vio_ptp);
+	}
+
+	viortc->clocks_to_unregister[vio_clk_id] = vio_ptp;
+
+	if (!vio_ptp)
+		dev_warn(&vdev->dev, "clock %llu is not exposed to userspace\n",
+			 vio_clk_id);
+
+	return 0;
+}
+
+/**
+ * viortc_clocks_exit() - unregister PHCs
+ * @viortc: device data
+ */
+static void viortc_clocks_exit(struct viortc_dev *viortc)
+{
+	unsigned int i;
+	struct viortc_ptp_clock *vio_ptp;
+
+	for (i = 0; i < viortc->num_clocks; i++) {
+		vio_ptp = viortc->clocks_to_unregister[i];
+
+		if (!vio_ptp)
+			continue;
+
+		viortc->clocks_to_unregister[i] = NULL;
+
+		WARN_ON(viortc_ptp_unregister(vio_ptp, &viortc->vdev->dev));
+	}
+}
+
 /**
  * viortc_clocks_init() - init local representations of virtio_rtc clocks
  * @viortc: device data
@@ -599,6 +687,7 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 {
 	int ret;
 	u16 num_clocks;
+	unsigned int i;
 
 	ret = viortc_cfg(viortc, &num_clocks);
 	if (ret)
@@ -611,10 +700,24 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 
 	viortc->num_clocks = num_clocks;
 
-	/* In the future, PTP clocks will be initialized here. */
-	(void)viortc_clock_cap;
+	viortc->clocks_to_unregister =
+		devm_kcalloc(&viortc->vdev->dev, num_clocks,
+			     sizeof(*viortc->clocks_to_unregister), GFP_KERNEL);
+	if (!viortc->clocks_to_unregister)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clocks; i++) {
+		ret = viortc_init_clock(viortc, i);
+		if (ret)
+			goto err_free_clocks;
+	}
 
 	return 0;
+
+err_free_clocks:
+	viortc_clocks_exit(viortc);
+
+	return ret;
 }
 
 /**
@@ -703,7 +806,9 @@ static int viortc_probe(struct virtio_device *vdev)
  */
 static void viortc_remove(struct virtio_device *vdev)
 {
-	/* In the future, PTP clocks will be deinitialized here. */
+	struct viortc_dev *viortc = vdev->priv;
+
+	viortc_clocks_exit(viortc);
 
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
diff --git a/drivers/virtio/virtio_rtc_internal.h b/drivers/virtio/virtio_rtc_internal.h
index c2b5387f506f..d8bd008cb8f6 100644
--- a/drivers/virtio/virtio_rtc_internal.h
+++ b/drivers/virtio/virtio_rtc_internal.h
@@ -9,6 +9,7 @@
 #define _VIRTIO_RTC_INTERNAL_H_
 
 #include <linux/types.h>
+#include <linux/ptp_clock_kernel.h>
 
 /* driver core IFs */
 
@@ -20,4 +21,65 @@ int viortc_read_cross(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
 int viortc_cross_cap(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
 		     bool *supported);
 
+/* PTP IFs */
+
+struct viortc_ptp_clock;
+
+#if IS_ENABLED(CONFIG_VIRTIO_RTC_PTP)
+
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u64 vio_clk_id,
+					     const char *ptp_clock_name,
+					     bool try_enable_xtstamp);
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev);
+
+#else
+
+static inline struct viortc_ptp_clock *
+viortc_ptp_register(struct viortc_dev *viortc, struct device *parent_dev,
+		    u64 vio_clk_id, const char *ptp_clock_name,
+		    bool try_enable_xtstamp)
+{
+	return NULL;
+}
+
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev)
+{
+	return -ENODEV;
+}
+
+#endif
+
+/* HW counter IFs */
+
+/**
+ * Maximum # of HW counters which the driver can support - can be increased.
+ */
+#define VIORTC_CAP_HW_COUNTERS 4
+
+/**
+ * viortc_hw_get_counters() - get HW counters present
+ * @hw_counters: virtio_rtc HW counters
+ * @num_hw_counters: number of HW counters
+ *
+ * num_hw_counters must not exceed VIORTC_CAP_HW_COUNTERS.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_hw_get_counters(const u16 **hw_counters, int *num_hw_counters);
+
+/**
+ * viortc_hw_xtstamp_params() - get HW-specific xtstamp params
+ * @hw_counter: virtio_rtc HW counter type
+ * @cs: clocksource corresponding to hw_counter
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_hw_xtstamp_params(u16 *hw_counter, struct clocksource **cs);
+
 #endif /* _VIRTIO_RTC_INTERNAL_H_ */
diff --git a/drivers/virtio/virtio_rtc_ptp.c b/drivers/virtio/virtio_rtc_ptp.c
new file mode 100644
index 000000000000..e52205a1caa9
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Expose virtio_rtc clocks as PTP clocks.
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ *
+ * Derived from ptp_kvm_common.c, virtual PTP 1588 clock for use with KVM
+ * guests.
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/**
+ * struct viortc_ptp_clock - PTP clock abstraction
+ * @vio_clk_id: virtio_rtc clock id
+ * @ptp_clock: PTP clock handle
+ * @viortc: virtio_rtc device data
+ * @ptp_info: PTP clock description
+ * @num_hw_counters: actual # of hw_counters
+ * @hw_counters: HW clocks which are supported for xtstamping
+ */
+struct viortc_ptp_clock {
+	u64 vio_clk_id;
+	struct ptp_clock *ptp_clock;
+	struct viortc_dev *viortc;
+	struct ptp_clock_info ptp_info;
+	u32 num_hw_counters;
+	u16 hw_counters[VIORTC_CAP_HW_COUNTERS];
+};
+
+/**
+ * struct viortc_ptp_cross_ctx - context for get_device_system_crosststamp()
+ * @device_time: device clock reading
+ * @system_counterval: HW counter value at device_time
+ *
+ * Provides the already obtained crosststamp to get_device_system_crosststamp().
+ */
+struct viortc_ptp_cross_ctx {
+	ktime_t device_time;
+	struct system_counterval_t system_counterval;
+};
+
+/* Weak functions in case get_device_system_crosststamp() is not supported */
+
+int __weak viortc_hw_get_counters(const u16 **hw_counters, int *num_hw_counters)
+{
+	*hw_counters = NULL;
+	*num_hw_counters = 0;
+	return 0;
+}
+
+int __weak viortc_hw_xtstamp_params(u16 *hw_counter, struct clocksource **cs)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_get_time_fn() - callback for get_device_system_crosststamp()
+ * @device_time: device clock reading
+ * @system_counterval: HW counter value at device_time
+ * @ctx: context with already obtained crosststamp
+ *
+ * Return: zero (success).
+ */
+static int viortc_ptp_get_time_fn(ktime_t *device_time,
+				  struct system_counterval_t *system_counterval,
+				  void *ctx)
+{
+	struct viortc_ptp_cross_ctx *vio_ctx = ctx;
+
+	*device_time = vio_ctx->device_time;
+	*system_counterval = vio_ctx->system_counterval;
+
+	return 0;
+}
+
+/**
+ * viortc_ptp_check_hw_counter_supported() - look up if xtstamp supported
+ * @vio_ptp: virtio_rtc PTP clock
+ * @hw_counter: virtio_rtc HW counter type
+ *
+ * Return: Zero if xtstamp is supported for hw_counter, negative error code
+ *         otherwise.
+ */
+static int
+viortc_ptp_check_hw_counter_supported(struct viortc_ptp_clock *vio_ptp,
+				      u16 hw_counter)
+{
+	u32 i;
+
+	for (i = 0; i < vio_ptp->num_hw_counters; i++) {
+		if (vio_ptp->hw_counters[i] == hw_counter)
+			return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_do_xtstamp() - get HW-specific crosststamp from device
+ * @vio_ptp: virtio_rtc PTP clock
+ * @ctx: context for get_device_system_crosststamp()
+ *
+ * Gets HW-specific crosststamp params and reads crosststamp from device.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_do_xtstamp(struct viortc_ptp_clock *vio_ptp,
+				 struct viortc_ptp_cross_ctx *ctx)
+{
+	u16 hw_counter;
+	u64 ns;
+	u64 max_ns;
+	int ret;
+
+	ret = viortc_hw_xtstamp_params(&hw_counter, &ctx->system_counterval.cs);
+	if (ret)
+		return ret;
+
+	ret = viortc_ptp_check_hw_counter_supported(vio_ptp, hw_counter);
+	if (ret)
+		return ret;
+
+	ret = viortc_read_cross(vio_ptp->viortc, vio_ptp->vio_clk_id,
+				hw_counter, &ns,
+				&ctx->system_counterval.cycles);
+	if (ret)
+		return ret;
+
+	max_ns = (u64)ktime_to_ns(KTIME_MAX);
+	if (ns > max_ns)
+		return -EINVAL;
+
+	ctx->device_time = ns_to_ktime(ns);
+
+	return 0;
+}
+
+/*
+ * PTP clock operations
+ */
+
+/**
+ * viortc_ptp_getcrosststamp() - PTP clock getcrosststamp op
+ * @vio_ptp: virtio_rtc PTP clock
+ * @xtstamp: crosststamp
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
+				     struct system_device_crosststamp *xtstamp)
+{
+	struct viortc_ptp_clock *vio_ptp =
+		container_of(ptp, struct viortc_ptp_clock, ptp_info);
+	int ret;
+	struct system_time_snapshot history_begin;
+	struct viortc_ptp_cross_ctx ctx;
+
+	ktime_get_snapshot(&history_begin);
+
+	/*
+	 * Getting the timestamp can take many milliseconds with a slow Virtio
+	 * device. This is too long for viortc_ptp_get_time_fn() passed to
+	 * get_device_system_crosststamp(), which has to usually return before
+	 * the timekeeper seqcount increases (every tick or so).
+	 *
+	 * So, get the actual cross-timestamp first.
+	 */
+	ret = viortc_ptp_do_xtstamp(vio_ptp, &ctx);
+	if (ret)
+		return ret;
+
+	ret = get_device_system_crosststamp(viortc_ptp_get_time_fn, &ctx,
+					    &history_begin, xtstamp);
+	if (ret) {
+		pr_debug("%s: get_device_system_crosststamp() returned %d\n",
+			 __func__, ret);
+	}
+
+	return ret;
+}
+
+/** viortc_ptp_adjfine() - unsupported PTP clock adjfine op */
+static int viortc_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+/** viortc_ptp_adjtime() - unsupported PTP clock adjtime op */
+static int viortc_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+/** viortc_ptp_settime64() - unsupported PTP clock settime64 op */
+static int viortc_ptp_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_gettimex64() - PTP clock gettimex64 op
+ *
+ * Context: Process context.
+ */
+static int viortc_ptp_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct viortc_ptp_clock *vio_ptp =
+		container_of(ptp, struct viortc_ptp_clock, ptp_info);
+	u64 ns;
+	int ret;
+
+	ptp_read_system_prets(sts);
+	ret = viortc_read(vio_ptp->viortc, vio_ptp->vio_clk_id, &ns);
+	ptp_read_system_postts(sts);
+
+	if (ret)
+		return ret;
+
+	if (ns > (u64)S64_MAX)
+		return -EINVAL;
+
+	*ts = ns_to_timespec64((s64)ns);
+
+	return 0;
+}
+
+/** viortc_ptp_enable() - unsupported PTP clock enable op */
+static int viortc_ptp_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_info_template - ptp_clock_info template
+ *
+ * The .name member will be set for individual virtio_rtc PTP clocks.
+ */
+static const struct ptp_clock_info viortc_ptp_info_template = {
+	.owner = THIS_MODULE,
+	/* .name is set according to clock type */
+	.adjfine = viortc_ptp_adjfine,
+	.adjtime = viortc_ptp_adjtime,
+	.gettimex64 = viortc_ptp_gettimex64,
+	.settime64 = viortc_ptp_settime64,
+	.enable = viortc_ptp_enable,
+	.getcrosststamp = viortc_ptp_getcrosststamp,
+};
+
+/**
+ * viortc_ptp_unregister() - PTP clock unregistering wrapper
+ * @vio_ptp: virtio_rtc PTP clock
+ * @parent_dev: parent device of PTP clock
+ *
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev)
+{
+	int ret = ptp_clock_unregister(vio_ptp->ptp_clock);
+
+	if (!ret)
+		devm_kfree(parent_dev, vio_ptp);
+
+	return ret;
+}
+
+/**
+ * viortc_ptp_get_cross_cap() - get xtstamp support info from device
+ * @viortc: virtio_rtc device data
+ * @vio_ptp: virtio_rtc PTP clock abstraction
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_get_cross_cap(struct viortc_dev *viortc,
+				    struct viortc_ptp_clock *vio_ptp)
+{
+	int ret;
+	const u16 *hw_counters_driver;
+	u32 num_hw_counters_driver;
+	u32 i;
+	u32 num_hw_counters = 0;
+
+	ret = viortc_hw_get_counters(&hw_counters_driver,
+				     &num_hw_counters_driver);
+	if (ret)
+		return ret;
+
+	if (num_hw_counters_driver > VIORTC_CAP_HW_COUNTERS) {
+		pr_err("%s: HW counter capacity exceeded\n", __func__);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_hw_counters_driver; i++) {
+		u16 hw_counter = hw_counters_driver[i];
+		bool xtstamp_supported;
+
+		ret = viortc_cross_cap(viortc, vio_ptp->vio_clk_id, hw_counter,
+				       &xtstamp_supported);
+		if (ret)
+			return ret;
+
+		if (xtstamp_supported)
+			vio_ptp->hw_counters[num_hw_counters++] = hw_counter;
+	}
+
+	vio_ptp->num_hw_counters = num_hw_counters;
+
+	return 0;
+}
+
+/**
+ * viortc_ptp_register() - prepare and register PTP clock
+ * @viortc: virtio_rtc device data
+ * @parent_dev: parent device for PTP clock
+ * @vio_clk_id: id of virtio_rtc clock which backs PTP clock
+ * @ptp_clock_name: PTP clock name
+ * @try_enable_xtstamp: enable xtstamp op, if available
+ *
+ * Context: Process context.
+ * Return: Pointer on success, ERR_PTR() otherwise; NULL if PTP clock support
+ *         not available.
+ */
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u64 vio_clk_id,
+					     const char *ptp_clock_name,
+					     bool try_enable_xtstamp)
+{
+	struct viortc_ptp_clock *vio_ptp;
+	struct ptp_clock *ptp_clock;
+	ssize_t len;
+	int ret;
+
+	vio_ptp = devm_kzalloc(parent_dev, sizeof(*vio_ptp), GFP_KERNEL);
+	if (!vio_ptp)
+		return ERR_PTR(-ENOMEM);
+
+	vio_ptp->viortc = viortc;
+	vio_ptp->vio_clk_id = vio_clk_id;
+	vio_ptp->ptp_info = viortc_ptp_info_template;
+	len = strscpy(vio_ptp->ptp_info.name, ptp_clock_name,
+		      sizeof(vio_ptp->ptp_info.name));
+	if (len < 0) {
+		ret = len;
+		goto err_free_dev;
+	}
+
+	if (try_enable_xtstamp) {
+		ret = viortc_ptp_get_cross_cap(viortc, vio_ptp);
+		if (ret)
+			goto err_free_dev;
+	}
+
+	ptp_clock = ptp_clock_register(&vio_ptp->ptp_info, parent_dev);
+	if (IS_ERR(ptp_clock))
+		goto err_on_register;
+
+	vio_ptp->ptp_clock = ptp_clock;
+
+	return vio_ptp;
+
+err_on_register:
+	ret = PTR_ERR(ptp_clock);
+
+err_free_dev:
+	devm_kfree(parent_dev, vio_ptp);
+	return ERR_PTR(ret);
+}
-- 
2.39.2

