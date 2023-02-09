Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72905690888
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBIMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBIMTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:19:24 -0500
X-Greylist: delayed 1100 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 04:19:16 PST
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B4AD0D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:19:16 -0800 (PST)
Received: from 104.47.18.111_.trendmicro.com (unknown [172.21.10.134])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 1F79010237636
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:01:00 +0000 (UTC)
Received: from 104.47.18.111_.trendmicro.com (unknown [172.21.173.179])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9D0F310001768;
        Thu,  9 Feb 2023 12:00:44 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1675944043.155000
X-TM-MAIL-UUID: f2c03f0a-eabb-4028-b281-cd7ef4c37d77
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.111])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2623E100018BB;
        Thu,  9 Feb 2023 12:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX19UFZaUbsWhQkFM/OBZd/U49wEloLROgS1AMXzZGIFnD3YWdUK/XrJjD3DtiE9QjDqCM5e0f/07h3FnX8W0ezyn7GelbI84bslyQzOs7hIKjImRR7zJ2OsFjrx09IQlWppbjRVo3IPXYr+WH1PnNmS3oBONebLZPo8XnizSnHjgbLTnN/FftbxEBzNLtTMP3XvuZbku1l324TPfsS4e0mDIBQqTHqiikUwpN1McB57rE5+iPUPwj4SrveL9eZspX5Vm+iYCiT0KiRcei56Kqwc7L2BPQAQyoZ8tA6c69FGqxTFUZF41ppkY/Mzi0CcrFVbCImZoiiXmvlFWODSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ0fod6PqgxI5NtKKB9gqILHatptXrH2/XFh//A3jCA=;
 b=kxbHV5waMvvMzUdDTRu0h5wzZAkQ1aH3MbhZPeA8WJNYzrEf/wMzW7/DBkgtxAUwnrFCHozCs3O03iIS55M33J5viQOlOBeNeRECFEx5mBjVNZrkvMtR3nc+VCEug0ZCkzBB8+Y9GiqOzrX+cFSkMOJZTqBgiXa9bQS511ZqLkEf+vnHSFF1h+Yw95EjyeDTQX09SePIaiX2BWcfDWjjGQbw21X35XhVBD+n8vuEnZJiEJPBXxG3jwhZPT+uV+6TMiR3dTuW81TtC1+5rCsPZDzd+wqm6wrZyeFQWog/aR5QDow8CbraeVIR4FiNmoQ09rZCJxM9LZPqspPmxUDt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=opensynergy.com; dkim=none (message not signed);
 arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
To:     mst@redhat.com, jasowang@redhat.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Subject: [RESEND PATCH 1/1] ALSA: virtio: add support for audio controls
Date:   Thu,  9 Feb 2023 12:59:16 +0100
Message-Id: <20230209115916.917569-2-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
References: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT045:EE_|FR2P281MB2639:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a887923-4290-46dd-1cce-08db0a9543f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shJSw92iAf1tJMdyFhgE63KQQtyuyEPk0IpZG0F+N3gkPEZ1sEFUcAZFuO8OWLC8+kiiVREstOCQ7AyFNRuFJwWnvo1iUlQOE35WA9b/UbW1IJVDWlgcdVUT6b75gqwxGU8ES+5RZTUC/WxqFzXnht9t2x7gRe8y+jdiFAPCv7UUgqVPRVE4dbdyQMCbi4en191my2hZ3GVLoebFeQ3biBvHI+M3H9/J4CRTrr1DfHkoED1C8100vBB7cYYcJzgEc7TRUx/umG5/t6nA3l2gZBwiPNIlk7ObX4hBeWLhxoJswZMSD28uymF4pqakJg7oZ8i2L3SOSSRkxrlqDCen6oYHr+5kToWsJ7U9AFzgVs5+GMQHzwF3HS0n8EKKvx2jXO/mykjmR7f9/6edtEkirOiI0xGMB0PDdbYukOS4smrPtOL0+oxNyhFRbjtqMAK9uui2BrCL0V7yE02TCkGxSBKC5CVaYGnyygUv27BDiZAtNO/T+G7JlumPuT3jvdu8fO3z9T8AWT6fFnNmYyUPx/lQNDaY1wmzPBHJmghx/iMQeinfRBwJnaB+P0bRb5GaL8TPnvr0weEkDcg3fhImpP2aDzWH5InjYs6RzipnVRWqqqmfRCJXfQGJHPgU1pLdezm+EMfO6BFjHbMH1l5qZ7HWsrgN+VZ+VfvN1z8hBHjKk7DpycBfIQp+tOIM4P72PizH3rXCGHPndascDmpYY8oslTqKxxDBZp4OlJYD7YOndNj3b8TQ4PB5NapLNHkHHSbwWxyt3yDf+qVwEvRdTg==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(39830400003)(136003)(376002)(396003)(346002)(451199018)(46966006)(36840700001)(70206006)(4326008)(70586007)(8676002)(36860700001)(336012)(316002)(42186006)(83380400001)(54906003)(86362001)(5660300002)(966005)(81166007)(478600001)(1076003)(26005)(2906002)(44832011)(186003)(36756003)(107886003)(30864003)(47076005)(41300700001)(82310400005)(8936002)(2616005)(40480700001)(21314003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 12:00:40.8792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a887923-4290-46dd-1cce-08db0a9543f7
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT045.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2639
X-TM-AS-ERS: 104.47.18.111-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27436.006
X-TMASE-Result: 10--27.885200-4.000000
X-TMASE-MatchedRID: sHskM9Mmy835S+IvXI7mDb/HywF9D+dAp9XpWXAGZTRU0vVJesIjQIPc
        XuILVCbaBf9r+qXiOnCJfzqfv7bGu5V5QOheuUnN8Jb881FGn9mfmd9HsjZ0U8W712pGw184BjM
        Zi1W1qsECpm1brdPQmg0AAs58E54K3JTl7bSqvNXlMFX0LZQzcWl5nVxdmJvHOhR0VsdhRrCN3H
        kV2EiaAyL637QCIVpiNATLB4szPdAfwC9BQF15499JA2lmQRNUi/c1Us2QTkBxoF8AfqHkW0zs8
        mBEXXwIDefH7bnDkFUZBbsGVnnW7UlT9lfH/XsbkCThXPqsqiuicedyr5fQ0DclhAqYjfRnOcY/
        jkDGKiKwcLLU2//UpRcfV2p41YOpFlh98BIUXtILsPjFXByaSvlSepWcgdLPF45HquLQw3jdZii
        xSw6RgZjY5FaoNLuDSaGNrMgEu1ws8AejW2/5AQrcxrzwsv5uUrr7Qc5WhKhR965L821jzHlbNL
        JMhGkt/LF6HmtZY72GFT1Fsy+CXUPFZL7uftIdKiJEqUFWRggyhLY8urUHvskHbDtTC/XbILMvr
        u9XoSs45PBNB8uybYCvD3dEuDL/xJp9LQiVVvyeAiCmPx4NwFfCQl7y5/Xxr10pknZXGJrN9ts5
        vzVWciq2rl3dzGQ1A/3R8k/14e0=
X-TMASE-XGENCLOUD: 715b861f-656d-4881-a4bb-dcd9d28469c6-0-0-200-0
X-TM-Deliver-Signature: 2283E76AB1688A7CB5CCFE7233DC66D6
X-TM-Addin-Auth: FL/CspnSfXr3BFh7SrVaoLmv1prKPJEmBmm2OCNGq7bIp4qkHT6jqZmovP7
        Owm3Sl2CoEaSRN5SVjveKauDfGfqls1E+i5Isk9NYoULnPPaM1ducyWRDR8j2EMOsmI71njC+WV
        krv6X7JTB6HB7W+VXAJ6gpzPuhWdiLVKOPCsg/HOkyuJrZHlOlGosg608UqajnR3mGx+GFuNP2/
        rCqPleLkTvt4gquMe+t0pyTwd0leXm30dFp4SXbfbVsbiBgfuIA11oCvGUB9GlcEoqY257iQu0b
        YtSxOfMFkatxoC2Sfosy4+9LHAqWzOGoXgmZ.RMySCweQLyjPLaJW8d125rlL+VLD07QEBkVImy
        jSyodnI1WST/Py0YQTZMjqB/9MdMUlXw+gIpw3OaRYVP24t+xhppb5ENn5r2cH47FuT45GaLxHv
        M5xazfZHZ9Ntk+iJtRNkYHTlR82Thvrf0Fx0EDz6HkKQxDnsZxNg0EwVb+yDf4OJ0PwvtmDn7T4
        3kg2rdzapwd0NMm1D6YzFvbxjny3OF1chpIDs9kelp4FE3ktbR0kZiCmWZH8N18YKjNUXxkGdH1
        0jK2DIy7e4y7Xa71cMosC58MGeln3hUCowBx5+RH8XvU6ML5iQPlBbrhBkWiPu6ndAA4ZlwuIq7
        G8JA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1675944044;
        bh=8hyjGesPr78VBIfYom7Y4Cw9mdkhceZSADh3/6X1t6c=; l=24472;
        h=From:To:Date;
        b=ll/DRM9ysDqqm61qtrqAIumSMzOTG8MAkJIU6t26sJ7zXKVkbv44YpkYBrCtLZOc5
         oG2WTudk6BzA8ITtM2Bczzb/nhcMzzTN0jsCG62SESVss0dIUs7eUwvOsQRtK/vP4V
         Mk5xSUOP8HJblrBkpE4G0ICv0o6vlXdDhivosGPnyF0/mcI5ccpVRD28mOqdBMScAD
         lvEiyE9zyGsOWbbG4n1grrBWAJU/YOMNi5PGeZo9pQaLaJ/5X0toghHbX/WNjO2+2w
         ggdsm3gdBi0fPCOchZiCU6NJ0ffMPtE2F1ziThCVIMF5G3nR4rOhztM7KnLZiuf+kf
         pkgGGU32BOljw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Yakovlev <anton.yakovlev@opensynergy.com>

Implementation of support for audio controls in accordance with the
extension of the virtio sound device specification [1] planned for
virtio-v1.3-cs01.

The device can announce the VIRTIO_SND_F_CTLS feature. If the feature is
negotiated, then an additional field appears in the configuration space:

  struct virtio_snd_config {
    ...
    /* number of available control elements */
    __le32 controls;
  };

The driver can send the following requests to manage audio controls:

  enum {
    ...
    /* control element request types */
    VIRTIO_SND_R_CTL_INFO = 0x0300,
    VIRTIO_SND_R_CTL_ENUM_ITEMS,
    VIRTIO_SND_R_CTL_READ,
    VIRTIO_SND_R_CTL_WRITE,
    VIRTIO_SND_R_CTL_TLV_READ,
    VIRTIO_SND_R_CTL_TLV_WRITE,
    VIRTIO_SND_R_CTL_TLV_COMMAND,
    ...
  };

And the device can send the following audio control event notification:

  enum {
    ...
    /* control element event types */
    VIRTIO_SND_EVT_CTL_NOTIFY = 0x1200,
    ...
  };

See additional details in [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
---
 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 464 ++++++++++++++++++++++++++++++++
 5 files changed, 662 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
index dfe49547a7b0..5f4100c2cf04 100644
--- a/include/uapi/linux/virtio_snd.h
+++ b/include/uapi/linux/virtio_snd.h
@@ -7,6 +7,14 @@
 
 #include <linux/virtio_types.h>
 
+/*******************************************************************************
+ * FEATURE BITS
+ */
+enum {
+	/* device supports control elements */
+	VIRTIO_SND_F_CTLS = 0
+};
+
 /*******************************************************************************
  * CONFIGURATION SPACE
  */
@@ -17,6 +25,8 @@ struct virtio_snd_config {
 	__le32 streams;
 	/* # of available channel maps */
 	__le32 chmaps;
+	/* # of available control elements */
+	__le32 controls;
 };
 
 enum {
@@ -55,6 +65,15 @@ enum {
 	/* channel map control request types */
 	VIRTIO_SND_R_CHMAP_INFO = 0x0200,
 
+	/* control element request types */
+	VIRTIO_SND_R_CTL_INFO = 0x0300,
+	VIRTIO_SND_R_CTL_ENUM_ITEMS,
+	VIRTIO_SND_R_CTL_READ,
+	VIRTIO_SND_R_CTL_WRITE,
+	VIRTIO_SND_R_CTL_TLV_READ,
+	VIRTIO_SND_R_CTL_TLV_WRITE,
+	VIRTIO_SND_R_CTL_TLV_COMMAND,
+
 	/* jack event types */
 	VIRTIO_SND_EVT_JACK_CONNECTED = 0x1000,
 	VIRTIO_SND_EVT_JACK_DISCONNECTED,
@@ -63,6 +82,9 @@ enum {
 	VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED = 0x1100,
 	VIRTIO_SND_EVT_PCM_XRUN,
 
+	/* control element event types */
+	VIRTIO_SND_EVT_CTL_NOTIFY = 0x1200,
+
 	/* common status codes */
 	VIRTIO_SND_S_OK = 0x8000,
 	VIRTIO_SND_S_BAD_MSG,
@@ -331,4 +353,136 @@ struct virtio_snd_chmap_info {
 	__u8 positions[VIRTIO_SND_CHMAP_MAX_SIZE];
 };
 
+/*******************************************************************************
+ * CONTROL ELEMENTS MESSAGES
+ */
+struct virtio_snd_ctl_hdr {
+	/* VIRTIO_SND_R_CTL_XXX */
+	struct virtio_snd_hdr hdr;
+	/* 0 ... virtio_snd_config::controls - 1 */
+	__le32 control_id;
+};
+
+/* supported roles for control elements */
+enum {
+	VIRTIO_SND_CTL_ROLE_UNDEFINED = 0,
+	VIRTIO_SND_CTL_ROLE_VOLUME,
+	VIRTIO_SND_CTL_ROLE_MUTE,
+	VIRTIO_SND_CTL_ROLE_GAIN
+};
+
+/* supported value types for control elements */
+enum {
+	VIRTIO_SND_CTL_TYPE_BOOLEAN = 0,
+	VIRTIO_SND_CTL_TYPE_INTEGER,
+	VIRTIO_SND_CTL_TYPE_INTEGER64,
+	VIRTIO_SND_CTL_TYPE_ENUMERATED,
+	VIRTIO_SND_CTL_TYPE_BYTES,
+	VIRTIO_SND_CTL_TYPE_IEC958
+};
+
+/* supported access rights for control elements */
+enum {
+	VIRTIO_SND_CTL_ACCESS_READ = 0,
+	VIRTIO_SND_CTL_ACCESS_WRITE,
+	VIRTIO_SND_CTL_ACCESS_VOLATILE,
+	VIRTIO_SND_CTL_ACCESS_INACTIVE,
+	VIRTIO_SND_CTL_ACCESS_TLV_READ,
+	VIRTIO_SND_CTL_ACCESS_TLV_WRITE,
+	VIRTIO_SND_CTL_ACCESS_TLV_COMMAND
+};
+
+struct virtio_snd_ctl_info {
+	/* common header */
+	struct virtio_snd_info hdr;
+	/* element role (VIRTIO_SND_CTL_ROLE_XXX) */
+	__le32 role;
+	/* element value type (VIRTIO_SND_CTL_TYPE_XXX) */
+	__le32 type;
+	/* element access right bit map (1 << VIRTIO_SND_CTL_ACCESS_XXX) */
+	__le32 access;
+	/* # of members in the element value */
+	__le32 count;
+	/* index for an element with a non-unique name */
+	__le32 index;
+	/* name identifier string for the element */
+	__u8 name[44];
+	/* additional information about the element's value */
+	union {
+		/* VIRTIO_SND_CTL_TYPE_INTEGER */
+		struct {
+			/* minimum supported value */
+			__le32 min;
+			/* maximum supported value */
+			__le32 max;
+			/* fixed step size for value (0 = variable size) */
+			__le32 step;
+		} integer;
+		/* VIRTIO_SND_CTL_TYPE_INTEGER64 */
+		struct {
+			/* minimum supported value */
+			__le64 min;
+			/* maximum supported value */
+			__le64 max;
+			/* fixed step size for value (0 = variable size) */
+			__le64 step;
+		} integer64;
+		/* VIRTIO_SND_CTL_TYPE_ENUMERATED */
+		struct {
+			/* # of options supported for value */
+			__le32 items;
+		} enumerated;
+	} value;
+};
+
+struct virtio_snd_ctl_enum_item {
+	/* option name */
+	__u8 item[64];
+};
+
+struct virtio_snd_ctl_iec958 {
+	/* AES/IEC958 channel status bits */
+	__u8 status[24];
+	/* AES/IEC958 subcode bits */
+	__u8 subcode[147];
+	/* nothing */
+	__u8 pad;
+	/* AES/IEC958 subframe bits */
+	__u8 dig_subframe[4];
+};
+
+struct virtio_snd_ctl_value {
+	union {
+		/* VIRTIO_SND_CTL_TYPE_BOOLEAN|INTEGER value */
+		__le32 integer[128];
+		/* VIRTIO_SND_CTL_TYPE_INTEGER64 value */
+		__le64 integer64[64];
+		/* VIRTIO_SND_CTL_TYPE_ENUMERATED value (option indexes) */
+		__le32 enumerated[128];
+		/* VIRTIO_SND_CTL_TYPE_BYTES value */
+		__u8 bytes[512];
+		/* VIRTIO_SND_CTL_TYPE_IEC958 value */
+		struct virtio_snd_ctl_iec958 iec958;
+	} value;
+};
+
+/* supported event reason types */
+enum {
+	/* element's value has changed */
+	VIRTIO_SND_CTL_EVT_MASK_VALUE = 0,
+	/* element's information has changed */
+	VIRTIO_SND_CTL_EVT_MASK_INFO,
+	/* element's metadata has changed */
+	VIRTIO_SND_CTL_EVT_MASK_TLV
+};
+
+struct virtio_snd_ctl_event {
+	/* VIRTIO_SND_EVT_CTL_NOTIFY */
+	struct virtio_snd_hdr hdr;
+	/* 0 ... virtio_snd_config::controls - 1 */
+	__le16 control_id;
+	/* event reason bit map (1 << VIRTIO_SND_CTL_EVT_MASK_XXX) */
+	__le16 mask;
+};
+
 #endif /* VIRTIO_SND_IF_H */
diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 2742bddb8874..a839f8c8b5e6 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -7,6 +7,7 @@ virtio_snd-objs := \
 	virtio_chmap.o \
 	virtio_ctl_msg.o \
 	virtio_jack.o \
+	virtio_kctl.o \
 	virtio_pcm.o \
 	virtio_pcm_msg.o \
 	virtio_pcm_ops.o
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index e2847c040f75..61df3476cf70 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -64,6 +64,9 @@ static void virtsnd_event_dispatch(struct virtio_snd *snd,
 	case VIRTIO_SND_EVT_PCM_XRUN:
 		virtsnd_pcm_event(snd, event);
 		break;
+	case VIRTIO_SND_EVT_CTL_NOTIFY:
+		virtsnd_kctl_event(snd, event);
+		break;
 	}
 }
 
@@ -235,6 +238,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 	if (rc)
 		return rc;
 
+	if (virtio_has_feature(vdev, VIRTIO_SND_F_CTLS)) {
+		rc = virtsnd_kctl_parse_cfg(snd);
+		if (rc)
+			return rc;
+	}
+
 	if (snd->njacks) {
 		rc = virtsnd_jack_build_devs(snd);
 		if (rc)
@@ -253,6 +262,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 			return rc;
 	}
 
+	if (snd->nkctls) {
+		rc = virtsnd_kctl_build_devs(snd);
+		if (rc)
+			return rc;
+	}
+
 	return snd_card_register(snd->card);
 }
 
@@ -419,10 +434,16 @@ static const struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+static unsigned int features[] = {
+	VIRTIO_SND_F_CTLS
+};
+
 static struct virtio_driver virtsnd_driver = {
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.validate = virtsnd_validate,
 	.probe = virtsnd_probe,
 	.remove = virtsnd_remove,
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 86ef3941895e..3ceee4e416fc 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -31,6 +31,16 @@ struct virtio_snd_queue {
 	struct virtqueue *vqueue;
 };
 
+/**
+ * struct virtio_kctl - VirtIO control element.
+ * @kctl: ALSA control element.
+ * @items: Items for the ENUMERATED element type.
+ */
+struct virtio_kctl {
+	struct snd_kcontrol *kctl;
+	struct virtio_snd_ctl_enum_item *items;
+};
+
 /**
  * struct virtio_snd - VirtIO sound card device.
  * @vdev: Underlying virtio device.
@@ -45,6 +55,9 @@ struct virtio_snd_queue {
  * @nsubstreams: Number of PCM substreams.
  * @chmaps: VirtIO channel maps.
  * @nchmaps: Number of channel maps.
+ * @kctl_infos: VirtIO control element information.
+ * @kctls: VirtIO control elements.
+ * @nkctls: Number of control elements.
  */
 struct virtio_snd {
 	struct virtio_device *vdev;
@@ -59,6 +72,9 @@ struct virtio_snd {
 	u32 nsubstreams;
 	struct virtio_snd_chmap_info *chmaps;
 	u32 nchmaps;
+	struct virtio_snd_ctl_info *kctl_infos;
+	struct virtio_kctl *kctls;
+	u32 nkctls;
 };
 
 /* Message completion timeout in milliseconds (module parameter). */
@@ -108,4 +124,10 @@ int virtsnd_chmap_parse_cfg(struct virtio_snd *snd);
 
 int virtsnd_chmap_build_devs(struct virtio_snd *snd);
 
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_kctl_build_devs(struct virtio_snd *snd);
+
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *event);
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
new file mode 100644
index 000000000000..16c48abe0ca1
--- /dev/null
+++ b/sound/virtio/virtio_kctl.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2022 OpenSynergy GmbH
+ */
+#include <sound/control.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+/* Map for converting VirtIO types to ALSA types. */
+static const snd_ctl_elem_type_t g_v2a_type_map[] = {
+	[VIRTIO_SND_CTL_TYPE_BOOLEAN] = SNDRV_CTL_ELEM_TYPE_BOOLEAN,
+	[VIRTIO_SND_CTL_TYPE_INTEGER] = SNDRV_CTL_ELEM_TYPE_INTEGER,
+	[VIRTIO_SND_CTL_TYPE_INTEGER64] = SNDRV_CTL_ELEM_TYPE_INTEGER64,
+	[VIRTIO_SND_CTL_TYPE_ENUMERATED] = SNDRV_CTL_ELEM_TYPE_ENUMERATED,
+	[VIRTIO_SND_CTL_TYPE_BYTES] = SNDRV_CTL_ELEM_TYPE_BYTES,
+	[VIRTIO_SND_CTL_TYPE_IEC958] = SNDRV_CTL_ELEM_TYPE_IEC958
+};
+
+/* Map for converting VirtIO access rights to ALSA access rights. */
+static const unsigned int g_v2a_access_map[] = {
+	[VIRTIO_SND_CTL_ACCESS_READ] = SNDRV_CTL_ELEM_ACCESS_READ,
+	[VIRTIO_SND_CTL_ACCESS_WRITE] = SNDRV_CTL_ELEM_ACCESS_WRITE,
+	[VIRTIO_SND_CTL_ACCESS_VOLATILE] = SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	[VIRTIO_SND_CTL_ACCESS_INACTIVE] = SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+	[VIRTIO_SND_CTL_ACCESS_TLV_READ] = SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	[VIRTIO_SND_CTL_ACCESS_TLV_WRITE] = SNDRV_CTL_ELEM_ACCESS_TLV_WRITE,
+	[VIRTIO_SND_CTL_ACCESS_TLV_COMMAND] = SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND
+};
+
+/* Map for converting VirtIO event masks to ALSA event masks. */
+static const unsigned int g_v2a_mask_map[] = {
+	[VIRTIO_SND_CTL_EVT_MASK_VALUE] = SNDRV_CTL_EVENT_MASK_VALUE,
+	[VIRTIO_SND_CTL_EVT_MASK_INFO] = SNDRV_CTL_EVENT_MASK_INFO,
+	[VIRTIO_SND_CTL_EVT_MASK_TLV] = SNDRV_CTL_EVENT_MASK_TLV
+};
+
+/**
+ * virtsnd_kctl_info() - Returns information about the control.
+ * @kcontrol: ALSA control element.
+ * @uinfo: Element information.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_kctl *kctl = &snd->kctls[kcontrol->private_value];
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int i;
+
+	uinfo->type = g_v2a_type_map[le32_to_cpu(kinfo->type)];
+	uinfo->count = le32_to_cpu(kinfo->count);
+
+	switch (uinfo->type) {
+	case SNDRV_CTL_ELEM_TYPE_INTEGER:
+		uinfo->value.integer.min =
+			le32_to_cpu(kinfo->value.integer.min);
+		uinfo->value.integer.max =
+			le32_to_cpu(kinfo->value.integer.max);
+		uinfo->value.integer.step =
+			le32_to_cpu(kinfo->value.integer.step);
+
+		break;
+	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
+		uinfo->value.integer64.min =
+			le64_to_cpu(kinfo->value.integer64.min);
+		uinfo->value.integer64.max =
+			le64_to_cpu(kinfo->value.integer64.max);
+		uinfo->value.integer64.step =
+			le64_to_cpu(kinfo->value.integer64.step);
+
+		break;
+	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
+		i = uinfo->value.enumerated.item;
+		if (i >= le32_to_cpu(kinfo->value.enumerated.items))
+			return -EINVAL;
+
+		strscpy(uinfo->value.enumerated.name, kctl->items[i].item,
+			sizeof(uinfo->value.enumerated.name));
+
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_get() - Read the value from the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *uvalue)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	struct virtio_snd_ctl_value *kvalue;
+	size_t request_size = sizeof(*hdr);
+	size_t response_size = sizeof(struct virtio_snd_hdr) + sizeof(*kvalue);
+	unsigned int i;
+	int rc;
+
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	virtsnd_ctl_msg_ref(msg);
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_READ);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	rc = virtsnd_ctl_msg_send_sync(snd, msg);
+	if (rc)
+		goto on_failure;
+
+	kvalue = (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
+			  sizeof(struct virtio_snd_hdr));
+
+	switch (type) {
+	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+	case VIRTIO_SND_CTL_TYPE_INTEGER:
+		for (i = 0; i < count; ++i)
+			uvalue->value.integer.value[i] =
+				le32_to_cpu(kvalue->value.integer[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_INTEGER64:
+		for (i = 0; i < count; ++i)
+			uvalue->value.integer64.value[i] =
+				le64_to_cpu(kvalue->value.integer64[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+		for (i = 0; i < count; ++i)
+			uvalue->value.enumerated.item[i] =
+				le32_to_cpu(kvalue->value.enumerated[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_BYTES:
+		memcpy(uvalue->value.bytes.data, kvalue->value.bytes, count);
+		break;
+	case VIRTIO_SND_CTL_TYPE_IEC958:
+		memcpy(&uvalue->value.iec958, &kvalue->value.iec958,
+		       sizeof(uvalue->value.iec958));
+		break;
+	}
+
+on_failure:
+	virtsnd_ctl_msg_unref(msg);
+
+	return rc;
+}
+
+/**
+ * virtsnd_kctl_put() - Write the value to the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *uvalue)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	struct virtio_snd_ctl_value *kvalue;
+	size_t request_size = sizeof(*hdr) + sizeof(*kvalue);
+	size_t response_size = sizeof(struct virtio_snd_hdr);
+	unsigned int i;
+
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_WRITE);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	kvalue = (void *)((u8 *)hdr + sizeof(*hdr));
+
+	switch (type) {
+	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+	case VIRTIO_SND_CTL_TYPE_INTEGER:
+		for (i = 0; i < count; ++i)
+			kvalue->value.integer[i] =
+				cpu_to_le32(uvalue->value.integer.value[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_INTEGER64:
+		for (i = 0; i < count; ++i)
+			kvalue->value.integer64[i] =
+				cpu_to_le64(uvalue->value.integer64.value[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+		for (i = 0; i < count; ++i)
+			kvalue->value.enumerated[i] =
+				cpu_to_le32(uvalue->value.enumerated.item[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_BYTES:
+		memcpy(kvalue->value.bytes, uvalue->value.bytes.data, count);
+		break;
+	case VIRTIO_SND_CTL_TYPE_IEC958:
+		memcpy(&kvalue->value.iec958, &uvalue->value.iec958,
+		       sizeof(kvalue->value.iec958));
+		break;
+	}
+
+	return virtsnd_ctl_msg_send_sync(snd, msg);
+}
+
+/**
+ * virtsnd_kctl_tlv_op() - Perform an operation on the control's metadata.
+ * @kcontrol: ALSA control element.
+ * @op_flag: Operation code (SNDRV_CTL_TLV_OP_XXX).
+ * @size: Size of the TLV data in bytes.
+ * @utlv: TLV data.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
+			       unsigned int size, unsigned int __user *utlv)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	unsigned int *tlv;
+	struct scatterlist sg;
+	int rc;
+
+	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr), sizeof(struct virtio_snd_hdr),
+				    GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	tlv = kzalloc(size, GFP_KERNEL);
+	if (!tlv) {
+		virtsnd_ctl_msg_unref(msg);
+		return -ENOMEM;
+	}
+
+	sg_init_one(&sg, tlv, size);
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	switch (op_flag) {
+	case SNDRV_CTL_TLV_OP_READ:
+		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
+
+		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+		if (!rc) {
+			if (copy_to_user(utlv, tlv, size))
+				rc = -EFAULT;
+		}
+
+		break;
+	case SNDRV_CTL_TLV_OP_WRITE:
+	case SNDRV_CTL_TLV_OP_CMD:
+		if (op_flag == SNDRV_CTL_TLV_OP_WRITE)
+			hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_WRITE);
+		else
+			hdr->hdr.code =
+				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
+
+		if (copy_from_user(tlv, utlv, size))
+			rc = -EFAULT;
+		else
+			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
+
+		break;
+	}
+
+	kfree(tlv);
+
+	return rc;
+}
+
+/**
+ * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
+ * @snd: VirtIO sound device.
+ * @cid: Control element ID.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get_enum_items(struct virtio_snd *snd, unsigned int cid)
+{
+	struct virtio_device *vdev = snd->vdev;
+	struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[cid];
+	struct virtio_kctl *kctl = &snd->kctls[cid];
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	unsigned int n = le32_to_cpu(kinfo->value.enumerated.items);
+	struct scatterlist sg;
+
+	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr),
+				    sizeof(struct virtio_snd_hdr), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	kctl->items = devm_kcalloc(&vdev->dev, n, sizeof(*kctl->items),
+				   GFP_KERNEL);
+	if (!kctl->items) {
+		virtsnd_ctl_msg_unref(msg);
+		return -ENOMEM;
+	}
+
+	sg_init_one(&sg, kctl->items, n * sizeof(*kctl->items));
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_ENUM_ITEMS);
+	hdr->control_id = cpu_to_le32(cid);
+
+	return virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+}
+
+/**
+ * virtsnd_kctl_parse_cfg() - Parse the control element configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd)
+{
+	struct virtio_device *vdev = snd->vdev;
+	u32 i;
+	int rc;
+
+	virtio_cread_le(vdev, struct virtio_snd_config, controls,
+			&snd->nkctls);
+	if (!snd->nkctls)
+		return 0;
+
+	snd->kctl_infos = devm_kcalloc(&vdev->dev, snd->nkctls,
+				       sizeof(*snd->kctl_infos), GFP_KERNEL);
+	if (!snd->kctl_infos)
+		return -ENOMEM;
+
+	snd->kctls = devm_kcalloc(&vdev->dev, snd->nkctls, sizeof(*snd->kctls),
+				  GFP_KERNEL);
+	if (!snd->kctls)
+		return -ENOMEM;
+
+	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CTL_INFO, 0, snd->nkctls,
+				    sizeof(*snd->kctl_infos), snd->kctl_infos);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < snd->nkctls; ++i) {
+		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[i];
+		unsigned int type = le32_to_cpu(kinfo->type);
+
+		if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED) {
+			rc = virtsnd_kctl_get_enum_items(snd, i);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_build_devs() - Build ALSA control elements.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_build_devs(struct virtio_snd *snd)
+{
+	unsigned int cid;
+
+	for (cid = 0; cid < snd->nkctls; ++cid) {
+		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[cid];
+		struct virtio_kctl *kctl = &snd->kctls[cid];
+		struct snd_kcontrol_new kctl_new;
+		unsigned int i;
+		int rc;
+
+		memset(&kctl_new, 0, sizeof(kctl_new));
+
+		kctl_new.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		kctl_new.name = kinfo->name;
+		kctl_new.index = le32_to_cpu(kinfo->index);
+
+		for (i = 0; i < ARRAY_SIZE(g_v2a_access_map); ++i)
+			if (le32_to_cpu(kinfo->access) & (1 << i))
+				kctl_new.access |= g_v2a_access_map[i];
+
+		if (kctl_new.access & (SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				       SNDRV_CTL_ELEM_ACCESS_TLV_WRITE |
+				       SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND)) {
+			kctl_new.access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+			kctl_new.tlv.c = virtsnd_kctl_tlv_op;
+		}
+
+		kctl_new.info = virtsnd_kctl_info;
+		kctl_new.get = virtsnd_kctl_get;
+		kctl_new.put = virtsnd_kctl_put;
+		kctl_new.private_value = cid;
+
+		kctl->kctl = snd_ctl_new1(&kctl_new, snd);
+		if (!kctl->kctl)
+			return -ENOMEM;
+
+		rc = snd_ctl_add(snd->card, kctl->kctl);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_event() - Handle the control element event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *event)
+{
+	struct virtio_snd_ctl_event *kevent =
+		(struct virtio_snd_ctl_event *)event;
+	struct virtio_kctl *kctl;
+	unsigned int cid = le16_to_cpu(kevent->control_id);
+	unsigned int mask = 0;
+	unsigned int i;
+
+	if (cid >= snd->nkctls)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(g_v2a_mask_map); ++i)
+		if (le16_to_cpu(kevent->mask) & (1 << i))
+			mask |= g_v2a_mask_map[i];
+
+
+	kctl = &snd->kctls[cid];
+
+	snd_ctl_notify(snd->card, mask, &kctl->kctl->id);
+}
-- 
2.25.1

