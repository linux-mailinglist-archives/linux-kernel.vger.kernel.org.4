Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C36697AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbjAMMpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbjAMMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF323E0E0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mp20so5395971ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q42egUmEzuPqHWtFCe0+w1qRK0bznL4xm46gw6YdelU=;
        b=N5XvOWhmZAIxoqz0Mv8fo7mI6busGg9qPdX3HilGBwZQxgFvj+4vVuZndJoENqpEsa
         hLEsBoy3BrNWRRpFJMhjrKnFtsW5QRZ1vVOZK2Z8+8kYz8uy12xZ2+JNMz+Km8bSQ5/F
         KVLf/VgDjgMfxaPkrWX5QZhf3xVU6+BJqrgUE8MamG4P3iojy8MDaI6WxLI8R5jyDzbg
         x2UISx1ynqccb1aK4lvyzA5luhJOHxj6SmMHtA0rm6dKYxhCsocA4seaj+taXZD1LH+A
         qzwrwnHNJqE1ko9RHKZvjI0dKkwvnRvycZsFWC6TxiO7s2V3WnlyCkptC9ywktGJevvS
         Tdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q42egUmEzuPqHWtFCe0+w1qRK0bznL4xm46gw6YdelU=;
        b=g5uJXkShfw85obAvOMVdaicO1IyDBHhaV8OYn/A1w6yk+C/K10Ef68N28KlQRzWxOf
         hzB/gyAmmi1wkxIh2aPEDsBfMf4brFCiY+Rfu3MUmznlJcsGiymB4vDE+VQgOwygbfpG
         SOosNnQ6l3672cXDYyDC6iq5xRbHjmSxOdlJLlPGpEuv27QS3WEXUaRhHxrdeDyvg5nH
         U7w6+iN+mT+L5098IhglWwUlsnIoNP7sjjbaAzu5Sul2PmWGsZefc3vtJu+tvjnUDfWg
         Y+pflPtoIIARexTCpvLZB/fFEU7XmnT+rn/bK7DZDQqzE3FobCIK+CyXMz0zawsnFE/w
         X85w==
X-Gm-Message-State: AFqh2kq1hIENCKpxC+ddhlCO67LRF5hrMUzUGy5KOdRhjqiTPG3anLc+
        vEf43/FoMWnm1CcmoDp8IvfNGA==
X-Google-Smtp-Source: AMrXdXvd2pKW/mm3VjXyhZ3M1Vlb7+wisqmEQArEMCnS1+zu55X8UKGjZK6dCSM/+mYx+2MdWiBl6A==
X-Received: by 2002:a17:906:5f98:b0:84d:1b67:cecb with SMTP id a24-20020a1709065f9800b0084d1b67cecbmr22933542eju.43.1673613345049;
        Fri, 13 Jan 2023 04:35:45 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:44 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 3/8] drbd: make limits unsigned
Date:   Fri, 13 Jan 2023 13:35:33 +0100
Message-Id: <20230113123538.144276-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are almost always used as unsigned integers, so mark them as such.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 include/linux/drbd_limits.h | 202 ++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 058f7600f79c..5b042fb427e9 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -16,123 +16,123 @@
 
 #define DEBUG_RANGE_CHECK 0
 
-#define DRBD_MINOR_COUNT_MIN 1
-#define DRBD_MINOR_COUNT_MAX 255
-#define DRBD_MINOR_COUNT_DEF 32
+#define DRBD_MINOR_COUNT_MIN 1U
+#define DRBD_MINOR_COUNT_MAX 255U
+#define DRBD_MINOR_COUNT_DEF 32U
 #define DRBD_MINOR_COUNT_SCALE '1'
 
-#define DRBD_VOLUME_MAX 65534
+#define DRBD_VOLUME_MAX 65534U
 
-#define DRBD_DIALOG_REFRESH_MIN 0
-#define DRBD_DIALOG_REFRESH_MAX 600
+#define DRBD_DIALOG_REFRESH_MIN 0U
+#define DRBD_DIALOG_REFRESH_MAX 600U
 #define DRBD_DIALOG_REFRESH_SCALE '1'
 
 /* valid port number */
-#define DRBD_PORT_MIN 1
-#define DRBD_PORT_MAX 0xffff
+#define DRBD_PORT_MIN 1U
+#define DRBD_PORT_MAX 0xffffU
 #define DRBD_PORT_SCALE '1'
 
 /* startup { */
   /* if you want more than 3.4 days, disable */
-#define DRBD_WFC_TIMEOUT_MIN 0
-#define DRBD_WFC_TIMEOUT_MAX 300000
-#define DRBD_WFC_TIMEOUT_DEF 0
+#define DRBD_WFC_TIMEOUT_MIN 0U
+#define DRBD_WFC_TIMEOUT_MAX 300000U
+#define DRBD_WFC_TIMEOUT_DEF 0U
 #define DRBD_WFC_TIMEOUT_SCALE '1'
 
-#define DRBD_DEGR_WFC_TIMEOUT_MIN 0
-#define DRBD_DEGR_WFC_TIMEOUT_MAX 300000
-#define DRBD_DEGR_WFC_TIMEOUT_DEF 0
+#define DRBD_DEGR_WFC_TIMEOUT_MIN 0U
+#define DRBD_DEGR_WFC_TIMEOUT_MAX 300000U
+#define DRBD_DEGR_WFC_TIMEOUT_DEF 0U
 #define DRBD_DEGR_WFC_TIMEOUT_SCALE '1'
 
-#define DRBD_OUTDATED_WFC_TIMEOUT_MIN 0
-#define DRBD_OUTDATED_WFC_TIMEOUT_MAX 300000
-#define DRBD_OUTDATED_WFC_TIMEOUT_DEF 0
+#define DRBD_OUTDATED_WFC_TIMEOUT_MIN 0U
+#define DRBD_OUTDATED_WFC_TIMEOUT_MAX 300000U
+#define DRBD_OUTDATED_WFC_TIMEOUT_DEF 0U
 #define DRBD_OUTDATED_WFC_TIMEOUT_SCALE '1'
 /* }*/
 
 /* net { */
   /* timeout, unit centi seconds
    * more than one minute timeout is not useful */
-#define DRBD_TIMEOUT_MIN 1
-#define DRBD_TIMEOUT_MAX 600
-#define DRBD_TIMEOUT_DEF 60       /* 6 seconds */
+#define DRBD_TIMEOUT_MIN 1U
+#define DRBD_TIMEOUT_MAX 600U
+#define DRBD_TIMEOUT_DEF 60U       /* 6 seconds */
 #define DRBD_TIMEOUT_SCALE '1'
 
  /* If backing disk takes longer than disk_timeout, mark the disk as failed */
-#define DRBD_DISK_TIMEOUT_MIN 0    /* 0 = disabled */
-#define DRBD_DISK_TIMEOUT_MAX 6000 /* 10 Minutes */
-#define DRBD_DISK_TIMEOUT_DEF 0    /* disabled */
+#define DRBD_DISK_TIMEOUT_MIN 0U    /* 0 = disabled */
+#define DRBD_DISK_TIMEOUT_MAX 6000U /* 10 Minutes */
+#define DRBD_DISK_TIMEOUT_DEF 0U    /* disabled */
 #define DRBD_DISK_TIMEOUT_SCALE '1'
 
   /* active connection retries when C_WF_CONNECTION */
-#define DRBD_CONNECT_INT_MIN 1
-#define DRBD_CONNECT_INT_MAX 120
-#define DRBD_CONNECT_INT_DEF 10   /* seconds */
+#define DRBD_CONNECT_INT_MIN 1U
+#define DRBD_CONNECT_INT_MAX 120U
+#define DRBD_CONNECT_INT_DEF 10U   /* seconds */
 #define DRBD_CONNECT_INT_SCALE '1'
 
   /* keep-alive probes when idle */
-#define DRBD_PING_INT_MIN 1
-#define DRBD_PING_INT_MAX 120
-#define DRBD_PING_INT_DEF 10
+#define DRBD_PING_INT_MIN 1U
+#define DRBD_PING_INT_MAX 120U
+#define DRBD_PING_INT_DEF 10U
 #define DRBD_PING_INT_SCALE '1'
 
  /* timeout for the ping packets.*/
-#define DRBD_PING_TIMEO_MIN  1
-#define DRBD_PING_TIMEO_MAX  300
-#define DRBD_PING_TIMEO_DEF  5
+#define DRBD_PING_TIMEO_MIN  1U
+#define DRBD_PING_TIMEO_MAX  300U
+#define DRBD_PING_TIMEO_DEF  5U
 #define DRBD_PING_TIMEO_SCALE '1'
 
   /* max number of write requests between write barriers */
-#define DRBD_MAX_EPOCH_SIZE_MIN 1
-#define DRBD_MAX_EPOCH_SIZE_MAX 20000
-#define DRBD_MAX_EPOCH_SIZE_DEF 2048
+#define DRBD_MAX_EPOCH_SIZE_MIN 1U
+#define DRBD_MAX_EPOCH_SIZE_MAX 20000U
+#define DRBD_MAX_EPOCH_SIZE_DEF 2048U
 #define DRBD_MAX_EPOCH_SIZE_SCALE '1'
 
   /* I don't think that a tcp send buffer of more than 10M is useful */
-#define DRBD_SNDBUF_SIZE_MIN  0
-#define DRBD_SNDBUF_SIZE_MAX  (10<<20)
-#define DRBD_SNDBUF_SIZE_DEF  0
+#define DRBD_SNDBUF_SIZE_MIN  0U
+#define DRBD_SNDBUF_SIZE_MAX  (10U<<20)
+#define DRBD_SNDBUF_SIZE_DEF  0U
 #define DRBD_SNDBUF_SIZE_SCALE '1'
 
-#define DRBD_RCVBUF_SIZE_MIN  0
-#define DRBD_RCVBUF_SIZE_MAX  (10<<20)
-#define DRBD_RCVBUF_SIZE_DEF  0
+#define DRBD_RCVBUF_SIZE_MIN  0U
+#define DRBD_RCVBUF_SIZE_MAX  (10U<<20)
+#define DRBD_RCVBUF_SIZE_DEF  0U
 #define DRBD_RCVBUF_SIZE_SCALE '1'
 
   /* @4k PageSize -> 128kB - 512MB */
-#define DRBD_MAX_BUFFERS_MIN  32
-#define DRBD_MAX_BUFFERS_MAX  131072
-#define DRBD_MAX_BUFFERS_DEF  2048
+#define DRBD_MAX_BUFFERS_MIN  32U
+#define DRBD_MAX_BUFFERS_MAX  131072U
+#define DRBD_MAX_BUFFERS_DEF  2048U
 #define DRBD_MAX_BUFFERS_SCALE '1'
 
   /* @4k PageSize -> 4kB - 512MB */
-#define DRBD_UNPLUG_WATERMARK_MIN  1
-#define DRBD_UNPLUG_WATERMARK_MAX  131072
+#define DRBD_UNPLUG_WATERMARK_MIN  1U
+#define DRBD_UNPLUG_WATERMARK_MAX  131072U
 #define DRBD_UNPLUG_WATERMARK_DEF (DRBD_MAX_BUFFERS_DEF/16)
 #define DRBD_UNPLUG_WATERMARK_SCALE '1'
 
   /* 0 is disabled.
    * 200 should be more than enough even for very short timeouts */
-#define DRBD_KO_COUNT_MIN  0
-#define DRBD_KO_COUNT_MAX  200
-#define DRBD_KO_COUNT_DEF  7
+#define DRBD_KO_COUNT_MIN  0U
+#define DRBD_KO_COUNT_MAX  200U
+#define DRBD_KO_COUNT_DEF  7U
 #define DRBD_KO_COUNT_SCALE '1'
 /* } */
 
 /* syncer { */
   /* FIXME allow rate to be zero? */
-#define DRBD_RESYNC_RATE_MIN 1
+#define DRBD_RESYNC_RATE_MIN 1U
 /* channel bonding 10 GbE, or other hardware */
 #define DRBD_RESYNC_RATE_MAX (4 << 20)
-#define DRBD_RESYNC_RATE_DEF 250
+#define DRBD_RESYNC_RATE_DEF 250U
 #define DRBD_RESYNC_RATE_SCALE 'k'  /* kilobytes */
 
-#define DRBD_AL_EXTENTS_MIN  67
+#define DRBD_AL_EXTENTS_MIN  67U
   /* we use u16 as "slot number", (u16)~0 is "FREE".
    * If you use >= 292 kB on-disk ring buffer,
    * this is the maximum you can use: */
-#define DRBD_AL_EXTENTS_MAX  0xfffe
-#define DRBD_AL_EXTENTS_DEF  1237
+#define DRBD_AL_EXTENTS_MAX  0xfffeU
+#define DRBD_AL_EXTENTS_DEF  1237U
 #define DRBD_AL_EXTENTS_SCALE '1'
 
 #define DRBD_MINOR_NUMBER_MIN  -1
@@ -147,9 +147,9 @@
  * the upper limit with 64bit kernel, enough ram and flexible meta data
  * is 1 PiB, currently. */
 /* DRBD_MAX_SECTORS */
-#define DRBD_DISK_SIZE_MIN  0
-#define DRBD_DISK_SIZE_MAX  (1 * (2LLU << 40))
-#define DRBD_DISK_SIZE_DEF  0 /* = disabled = no user size... */
+#define DRBD_DISK_SIZE_MIN  0LLU
+#define DRBD_DISK_SIZE_MAX  (1LLU * (2LLU << 40))
+#define DRBD_DISK_SIZE_DEF  0LLU /* = disabled = no user size... */
 #define DRBD_DISK_SIZE_SCALE 's'  /* sectors */
 
 #define DRBD_ON_IO_ERROR_DEF EP_DETACH
@@ -162,39 +162,39 @@
 #define DRBD_ON_CONGESTION_DEF OC_BLOCK
 #define DRBD_READ_BALANCING_DEF RB_PREFER_LOCAL
 
-#define DRBD_MAX_BIO_BVECS_MIN 0
-#define DRBD_MAX_BIO_BVECS_MAX 128
-#define DRBD_MAX_BIO_BVECS_DEF 0
+#define DRBD_MAX_BIO_BVECS_MIN 0U
+#define DRBD_MAX_BIO_BVECS_MAX 128U
+#define DRBD_MAX_BIO_BVECS_DEF 0U
 #define DRBD_MAX_BIO_BVECS_SCALE '1'
 
-#define DRBD_C_PLAN_AHEAD_MIN  0
-#define DRBD_C_PLAN_AHEAD_MAX  300
-#define DRBD_C_PLAN_AHEAD_DEF  20
+#define DRBD_C_PLAN_AHEAD_MIN  0U
+#define DRBD_C_PLAN_AHEAD_MAX  300U
+#define DRBD_C_PLAN_AHEAD_DEF  20U
 #define DRBD_C_PLAN_AHEAD_SCALE '1'
 
-#define DRBD_C_DELAY_TARGET_MIN 1
-#define DRBD_C_DELAY_TARGET_MAX 100
-#define DRBD_C_DELAY_TARGET_DEF 10
+#define DRBD_C_DELAY_TARGET_MIN 1U
+#define DRBD_C_DELAY_TARGET_MAX 100U
+#define DRBD_C_DELAY_TARGET_DEF 10U
 #define DRBD_C_DELAY_TARGET_SCALE '1'
 
-#define DRBD_C_FILL_TARGET_MIN 0
-#define DRBD_C_FILL_TARGET_MAX (1<<20) /* 500MByte in sec */
-#define DRBD_C_FILL_TARGET_DEF 100 /* Try to place 50KiB in socket send buffer during resync */
+#define DRBD_C_FILL_TARGET_MIN 0U
+#define DRBD_C_FILL_TARGET_MAX (1U<<20) /* 500MByte in sec */
+#define DRBD_C_FILL_TARGET_DEF 100U /* Try to place 50KiB in socket send buffer during resync */
 #define DRBD_C_FILL_TARGET_SCALE 's'  /* sectors */
 
-#define DRBD_C_MAX_RATE_MIN     250
-#define DRBD_C_MAX_RATE_MAX     (4 << 20)
-#define DRBD_C_MAX_RATE_DEF     102400
+#define DRBD_C_MAX_RATE_MIN     250U
+#define DRBD_C_MAX_RATE_MAX     (4U << 20)
+#define DRBD_C_MAX_RATE_DEF     102400U
 #define DRBD_C_MAX_RATE_SCALE	'k'  /* kilobytes */
 
-#define DRBD_C_MIN_RATE_MIN     0
-#define DRBD_C_MIN_RATE_MAX     (4 << 20)
-#define DRBD_C_MIN_RATE_DEF     250
+#define DRBD_C_MIN_RATE_MIN     0U
+#define DRBD_C_MIN_RATE_MAX     (4U << 20)
+#define DRBD_C_MIN_RATE_DEF     250U
 #define DRBD_C_MIN_RATE_SCALE	'k'  /* kilobytes */
 
-#define DRBD_CONG_FILL_MIN	0
-#define DRBD_CONG_FILL_MAX	(10<<21) /* 10GByte in sectors */
-#define DRBD_CONG_FILL_DEF	0
+#define DRBD_CONG_FILL_MIN	0U
+#define DRBD_CONG_FILL_MAX	(10U<<21) /* 10GByte in sectors */
+#define DRBD_CONG_FILL_DEF	0U
 #define DRBD_CONG_FILL_SCALE	's'  /* sectors */
 
 #define DRBD_CONG_EXTENTS_MIN	DRBD_AL_EXTENTS_MIN
@@ -204,48 +204,48 @@
 
 #define DRBD_PROTOCOL_DEF DRBD_PROT_C
 
-#define DRBD_DISK_BARRIER_DEF	0
-#define DRBD_DISK_FLUSHES_DEF	1
-#define DRBD_DISK_DRAIN_DEF	1
-#define DRBD_MD_FLUSHES_DEF	1
-#define DRBD_TCP_CORK_DEF	1
-#define DRBD_AL_UPDATES_DEF     1
+#define DRBD_DISK_BARRIER_DEF	0U
+#define DRBD_DISK_FLUSHES_DEF	1U
+#define DRBD_DISK_DRAIN_DEF	1U
+#define DRBD_MD_FLUSHES_DEF	1U
+#define DRBD_TCP_CORK_DEF	1U
+#define DRBD_AL_UPDATES_DEF     1U
 
 /* We used to ignore the discard_zeroes_data setting.
  * To not change established (and expected) behaviour,
  * by default assume that, for discard_zeroes_data=0,
  * we can make that an effective discard_zeroes_data=1,
  * if we only explicitly zero-out unaligned partial chunks. */
-#define DRBD_DISCARD_ZEROES_IF_ALIGNED_DEF 1
+#define DRBD_DISCARD_ZEROES_IF_ALIGNED_DEF 1U
 
 /* Some backends pretend to support WRITE SAME,
  * but fail such requests when they are actually submitted.
  * This is to tell DRBD to not even try. */
-#define DRBD_DISABLE_WRITE_SAME_DEF 0
+#define DRBD_DISABLE_WRITE_SAME_DEF 0U
 
-#define DRBD_ALLOW_TWO_PRIMARIES_DEF	0
-#define DRBD_ALWAYS_ASBP_DEF	0
-#define DRBD_USE_RLE_DEF	1
-#define DRBD_CSUMS_AFTER_CRASH_ONLY_DEF 0
+#define DRBD_ALLOW_TWO_PRIMARIES_DEF	0U
+#define DRBD_ALWAYS_ASBP_DEF	0U
+#define DRBD_USE_RLE_DEF	1U
+#define DRBD_CSUMS_AFTER_CRASH_ONLY_DEF 0U
 
-#define DRBD_AL_STRIPES_MIN     1
-#define DRBD_AL_STRIPES_MAX     1024
-#define DRBD_AL_STRIPES_DEF     1
+#define DRBD_AL_STRIPES_MIN     1U
+#define DRBD_AL_STRIPES_MAX     1024U
+#define DRBD_AL_STRIPES_DEF     1U
 #define DRBD_AL_STRIPES_SCALE   '1'
 
-#define DRBD_AL_STRIPE_SIZE_MIN   4
-#define DRBD_AL_STRIPE_SIZE_MAX   16777216
-#define DRBD_AL_STRIPE_SIZE_DEF   32
+#define DRBD_AL_STRIPE_SIZE_MIN   4U
+#define DRBD_AL_STRIPE_SIZE_MAX   16777216U
+#define DRBD_AL_STRIPE_SIZE_DEF   32U
 #define DRBD_AL_STRIPE_SIZE_SCALE 'k' /* kilobytes */
 
-#define DRBD_SOCKET_CHECK_TIMEO_MIN 0
+#define DRBD_SOCKET_CHECK_TIMEO_MIN 0U
 #define DRBD_SOCKET_CHECK_TIMEO_MAX DRBD_PING_TIMEO_MAX
-#define DRBD_SOCKET_CHECK_TIMEO_DEF 0
+#define DRBD_SOCKET_CHECK_TIMEO_DEF 0U
 #define DRBD_SOCKET_CHECK_TIMEO_SCALE '1'
 
-#define DRBD_RS_DISCARD_GRANULARITY_MIN 0
-#define DRBD_RS_DISCARD_GRANULARITY_MAX (1<<20)  /* 1MiByte */
-#define DRBD_RS_DISCARD_GRANULARITY_DEF 0     /* disabled by default */
+#define DRBD_RS_DISCARD_GRANULARITY_MIN 0U
+#define DRBD_RS_DISCARD_GRANULARITY_MAX (1U<<20)  /* 1MiByte */
+#define DRBD_RS_DISCARD_GRANULARITY_DEF 0U     /* disabled by default */
 #define DRBD_RS_DISCARD_GRANULARITY_SCALE '1' /* bytes */
 
 #endif
-- 
2.38.1

