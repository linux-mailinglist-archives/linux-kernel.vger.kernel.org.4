Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D2469BDFF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBRXnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:43:52 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3459EEE;
        Sat, 18 Feb 2023 15:43:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z27so664963iow.1;
        Sat, 18 Feb 2023 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSXD3ilVFUjn3r3UdDo5g/qYtuvwljXGZQiBBN41sWs=;
        b=SgefFv7J51pfexZzH5kvItD600MQ21QNiQgSpmPLObpBD7IYfvMqYy+n3IyGN+GEvc
         YrwRVJDtpii3cqbq6xh9aZlGJRDesyyM3YEwJ3VxUnkX7AI865SE8EQmEBhKFX9oQEBM
         CPhdLyhCXaNg7mnMzXaqgRp8SjHfTKix1m2I+iMlvU27FkcPGtzi/nF7btU5nQ852R0a
         kEM/Ap7mqTNBILwQAVl3/x4oJsYcXGBIt/t5uKt4o4AlWX4PlAF3mlvsD+DcdHZUIoEn
         07g1tQRfp3UCqgOSi3g6oknGG3rwxhd+UQDlPt3L6b8vhnz37G6WL2XHMmOTAcNcAN/Q
         sABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSXD3ilVFUjn3r3UdDo5g/qYtuvwljXGZQiBBN41sWs=;
        b=m69xNXeuuUe53c1mmXN5S4roDt2odmU7fZfta++MpRTwuLa0OaZq/WiUDqtyuPAbi6
         31fcQbJO8nAJAenuR/+obym4/TiS87kYWeTX4TJ7Y9vy+wUmHDGRa5wAqqNROsKyfJTT
         m1BBd4iuvK+jLlhDsxe8yB794q6RuCQ9Q17KFXnUNrP3+m3Ihia7CAViq5udJquhzJip
         zzdw+5fEnVWRJxSP8zQ4zjPnhs5ZzU2ex8H9c6oQGjYQRG/hzAfKA4rRnMmP7ThJZKZp
         kTdYaiPQAErgqtCHzXbgSqwzkbFv4c0yz1Byy/0F9d7xLXzNMBwb2wDWNDZehPijEexs
         TK4w==
X-Gm-Message-State: AO0yUKXoqklIj/ywXDWk+nh14y0C+/2FVQYAt6y9WhYoaLBSp/5SHd8i
        hFyusElVmpyICyZ3BWOIAo4Bq4lTCdM=
X-Google-Smtp-Source: AK7set+bAXIl1jTp1MQpTGilUAEoR3R9tOw3B7vePkuAEKvuDKGixQOHfgcodRLOQk9gVlXqOUnWIg==
X-Received: by 2002:a5e:a801:0:b0:6bc:d714:520f with SMTP id c1-20020a5ea801000000b006bcd714520fmr4361719ioa.15.1676763829906;
        Sat, 18 Feb 2023 15:43:49 -0800 (PST)
Received: from james-x399.localdomain (97-118-149-35.hlrn.qwest.net. [97.118.149.35])
        by smtp.gmail.com with ESMTPSA id k17-20020a6b6f11000000b0071db3975335sm2167064ioc.12.2023.02.18.15.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 15:43:49 -0800 (PST)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Pawel Osciak <posciak@chromium.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] uvcvideo: Unify UVC payload header parsing.
Date:   Sat, 18 Feb 2023 16:43:33 -0700
Message-Id: <20230218234334.1261631-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Osciak <posciak@chromium.org>

Create a separate function for parsing UVC payload headers and extract code
from other functions into it. Store the parsed values in a header struct.

Signed-off-by: Pawel Osciak <posciak@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - rebase
---
 drivers/media/usb/uvc/uvc_video.c | 263 +++++++++++++++---------------
 drivers/media/usb/uvc/uvcvideo.h  |  21 +++
 2 files changed, 152 insertions(+), 132 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2eb9066e4dc..ef6ac978ef87 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -466,39 +466,14 @@ static inline ktime_t uvc_video_get_time(void)
 
 static void
 uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
-		       const u8 *data, int len)
+		       struct uvc_payload_header *header)
 {
 	struct uvc_clock_sample *sample;
-	unsigned int header_size;
-	bool has_pts = false;
-	bool has_scr = false;
 	unsigned long flags;
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;
 
-	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
-	case UVC_STREAM_PTS | UVC_STREAM_SCR:
-		header_size = 12;
-		has_pts = true;
-		has_scr = true;
-		break;
-	case UVC_STREAM_PTS:
-		header_size = 6;
-		has_pts = true;
-		break;
-	case UVC_STREAM_SCR:
-		header_size = 8;
-		has_scr = true;
-		break;
-	default:
-		header_size = 2;
-		break;
-	}
-
-	/* Check for invalid headers. */
-	if (len < header_size)
-		return;
 
 	/*
 	 * Extract the timestamps:
@@ -508,17 +483,17 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 *   kernel timestamps and store them with the SCR STC and SOF fields
 	 *   in the ring buffer
 	 */
-	if (has_pts && buf != NULL)
-		buf->pts = get_unaligned_le32(&data[2]);
+	if (header->has_pts && buf != NULL)
+		buf->pts = header->pts;
 
-	if (!has_scr)
+	if (!header->has_scr)
 		return;
 
 	/*
 	 * To limit the amount of data, drop SCRs with an SOF identical to the
 	 * previous one.
 	 */
-	dev_sof = get_unaligned_le16(&data[header_size - 2]);
+	dev_sof = header->sof;
 	if (dev_sof == stream->clock.last_sof)
 		return;
 
@@ -560,7 +535,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	spin_lock_irqsave(&stream->clock.lock, flags);
 
 	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample->dev_stc = header->stc;
 	sample->dev_sof = dev_sof;
 	sample->host_sof = host_sof;
 	sample->host_time = time;
@@ -804,65 +779,24 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
  */
 
 static void uvc_video_stats_decode(struct uvc_streaming *stream,
-		const u8 *data, int len)
+		struct uvc_payload_header *header)
 {
-	unsigned int header_size;
-	bool has_pts = false;
-	bool has_scr = false;
-	u16 scr_sof;
-	u32 scr_stc;
-	u32 pts;
-
 	if (stream->stats.stream.nb_frames == 0 &&
 	    stream->stats.frame.nb_packets == 0)
 		stream->stats.stream.start_ts = ktime_get();
 
-	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
-	case UVC_STREAM_PTS | UVC_STREAM_SCR:
-		header_size = 12;
-		has_pts = true;
-		has_scr = true;
-		break;
-	case UVC_STREAM_PTS:
-		header_size = 6;
-		has_pts = true;
-		break;
-	case UVC_STREAM_SCR:
-		header_size = 8;
-		has_scr = true;
-		break;
-	default:
-		header_size = 2;
-		break;
-	}
-
-	/* Check for invalid headers. */
-	if (len < header_size || data[0] < header_size) {
-		stream->stats.frame.nb_invalid++;
-		return;
-	}
-
-	/* Extract the timestamps. */
-	if (has_pts)
-		pts = get_unaligned_le32(&data[2]);
-
-	if (has_scr) {
-		scr_stc = get_unaligned_le32(&data[header_size - 6]);
-		scr_sof = get_unaligned_le16(&data[header_size - 2]);
-	}
-
 	/* Is PTS constant through the whole frame ? */
-	if (has_pts && stream->stats.frame.nb_pts) {
-		if (stream->stats.frame.pts != pts) {
+	if (header->has_pts && stream->stats.frame.nb_pts) {
+		if (stream->stats.frame.pts != header->pts) {
 			stream->stats.frame.nb_pts_diffs++;
 			stream->stats.frame.last_pts_diff =
 				stream->stats.frame.nb_packets;
 		}
 	}
 
-	if (has_pts) {
+	if (header->has_pts) {
 		stream->stats.frame.nb_pts++;
-		stream->stats.frame.pts = pts;
+		stream->stats.frame.pts = header->pts;
 	}
 
 	/*
@@ -870,49 +804,49 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 	 * their first empty packet ?
 	 */
 	if (stream->stats.frame.size == 0) {
-		if (len > header_size)
-			stream->stats.frame.has_initial_pts = has_pts;
-		if (len == header_size && has_pts)
+		if (header->payload_size > 0)
+			stream->stats.frame.has_initial_pts = header->has_pts;
+		if (header->payload_size == 0 && header->has_pts)
 			stream->stats.frame.has_early_pts = true;
 	}
 
 	/* Do the SCR.STC and SCR.SOF fields vary through the frame ? */
-	if (has_scr && stream->stats.frame.nb_scr) {
-		if (stream->stats.frame.scr_stc != scr_stc)
+	if (header->has_scr && stream->stats.frame.nb_scr) {
+		if (stream->stats.frame.scr_stc != header->stc)
 			stream->stats.frame.nb_scr_diffs++;
 	}
 
-	if (has_scr) {
+	if (header->has_scr) {
 		/* Expand the SOF counter to 32 bits and store its value. */
 		if (stream->stats.stream.nb_frames > 0 ||
 		    stream->stats.frame.nb_scr > 0)
 			stream->stats.stream.scr_sof_count +=
-				(scr_sof - stream->stats.stream.scr_sof) % 2048;
-		stream->stats.stream.scr_sof = scr_sof;
+				(header->sof - stream->stats.stream.scr_sof) % 2048;
+		stream->stats.stream.scr_sof = header->sof;
 
 		stream->stats.frame.nb_scr++;
-		stream->stats.frame.scr_stc = scr_stc;
-		stream->stats.frame.scr_sof = scr_sof;
+		stream->stats.frame.scr_stc = header->stc;
+		stream->stats.frame.scr_sof = header->sof;
 
-		if (scr_sof < stream->stats.stream.min_sof)
-			stream->stats.stream.min_sof = scr_sof;
-		if (scr_sof > stream->stats.stream.max_sof)
-			stream->stats.stream.max_sof = scr_sof;
+		if (header->sof < stream->stats.stream.min_sof)
+			stream->stats.stream.min_sof = header->sof;
+		if (header->sof > stream->stats.stream.max_sof)
+			stream->stats.stream.max_sof = header->sof;
 	}
 
 	/* Record the first non-empty packet number. */
-	if (stream->stats.frame.size == 0 && len > header_size)
+	if (stream->stats.frame.size == 0 && header->payload_size > 0)
 		stream->stats.frame.first_data = stream->stats.frame.nb_packets;
 
 	/* Update the frame size. */
-	stream->stats.frame.size += len - header_size;
+	stream->stats.frame.size += header->payload_size;
 
 	/* Update the packets counters. */
 	stream->stats.frame.nb_packets++;
-	if (len <= header_size)
+	if (header->payload_size == 0)
 		stream->stats.frame.nb_empty++;
 
-	if (data[1] & UVC_STREAM_ERR)
+	if (header->has_err)
 		stream->stats.frame.nb_errors++;
 }
 
@@ -1047,22 +981,9 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
  * uvc_video_decode_end will never be called with a NULL buffer.
  */
 static int uvc_video_decode_start(struct uvc_streaming *stream,
-		struct uvc_buffer *buf, const u8 *data, int len)
+		struct uvc_buffer *buf, struct uvc_payload_header *header)
 {
-	u8 fid;
-
-	/*
-	 * Sanity checks:
-	 * - packet must be at least 2 bytes long
-	 * - bHeaderLength value must be at least 2 bytes (see above)
-	 * - bHeaderLength value can't be larger than the packet size.
-	 */
-	if (len < 2 || data[0] < 2 || data[0] > len) {
-		stream->stats.frame.nb_invalid++;
-		return -EINVAL;
-	}
-
-	fid = data[1] & UVC_STREAM_FID;
+	u8 fid = header->fid;
 
 	/*
 	 * Increase the sequence number regardless of any buffer states, so
@@ -1074,8 +995,8 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			uvc_video_stats_update(stream);
 	}
 
-	uvc_video_clock_decode(stream, buf, data, len);
-	uvc_video_stats_decode(stream, data, len);
+	uvc_video_clock_decode(stream, buf, header);
+	uvc_video_stats_decode(stream, header);
 
 	/*
 	 * Store the payload FID bit and return immediately when the buffer is
@@ -1087,7 +1008,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	}
 
 	/* Mark the buffer as bad if the error bit is set. */
-	if (data[1] & UVC_STREAM_ERR) {
+	if (header->has_err) {
 		uvc_dbg(stream->dev, FRAME,
 			"Marking buffer as bad (error bit set)\n");
 		buf->error = 1;
@@ -1107,7 +1028,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			uvc_dbg(stream->dev, FRAME,
 				"Dropping payload (out of sync)\n");
 			if ((stream->dev->quirks & UVC_QUIRK_STREAM_NO_FID) &&
-			    (data[1] & UVC_STREAM_EOF))
+			    (header->has_eof))
 				stream->last_fid ^= UVC_STREAM_FID;
 			return -ENODATA;
 		}
@@ -1145,7 +1066,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 
 	stream->last_fid = fid;
 
-	return data[0];
+	return 0;
 }
 
 static inline enum dma_data_direction uvc_stream_dir(
@@ -1232,12 +1153,12 @@ static void uvc_video_decode_data(struct uvc_urb *uvc_urb,
 }
 
 static void uvc_video_decode_end(struct uvc_streaming *stream,
-		struct uvc_buffer *buf, const u8 *data, int len)
+		struct uvc_buffer *buf, struct uvc_payload_header *header)
 {
 	/* Mark the buffer as done if the EOF marker is set. */
-	if (data[1] & UVC_STREAM_EOF && buf->bytesused != 0) {
+	if (header->has_eof && buf->bytesused != 0) {
 		uvc_dbg(stream->dev, FRAME, "Frame complete (EOF found)\n");
-		if (data[0] == len)
+		if (header->payload_size == 0)
 			uvc_dbg(stream->dev, FRAME, "EOF in empty payload\n");
 		buf->state = UVC_BUF_STATE_READY;
 		if (stream->dev->quirks & UVC_QUIRK_STREAM_NO_FID)
@@ -1285,6 +1206,75 @@ static int uvc_video_encode_data(struct uvc_streaming *stream,
 	return nbytes;
 }
 
+static int uvc_video_parse_header(struct uvc_streaming *stream,
+		const __u8 *data, int len, struct uvc_payload_header *header)
+{
+	unsigned int off = 2;
+
+	/* Sanity checks:
+	 * - packet must be at least 2 bytes long
+	 * - bHeaderLength value must be at least 2 bytes (see above)
+	 */
+	if (len < 2 || len < data[0] || data[0] < 2 )
+		goto error;
+
+	header->length = 2; /* 1 byte of header length + 1 byte of BFH. */
+
+	header->has_sli = false;
+	header->has_eof = data[1] & UVC_STREAM_EOF;
+	header->has_pts = data[1] & UVC_STREAM_PTS;
+	header->has_scr = data[1] & UVC_STREAM_SCR;
+	header->has_err = data[1] & UVC_STREAM_ERR;
+
+	if (header->has_pts)
+		header->length += 4;
+
+	if (header->has_scr)
+		header->length += 6;
+
+	if (stream->cur_format->fcc == V4L2_PIX_FMT_VP8) {
+		/* VP8 payload has 2 additional bytes of BFH. */
+		header->length += 2;
+		off += 2;
+
+		/* SLI always present for VP8 simulcast (at the end of header),
+		 * allowed for VP8 non-simulcast.
+		 */
+		header->has_sli = data[1] & UVC_STREAM_EOH;
+		if (header->has_sli)
+			header->length += 2;
+	}
+
+	/* - bHeaderLength value can't be larger than the packet size. */
+	if (data[0] != header->length)
+		goto error;
+
+	/* PTS 4 bytes, STC 4 bytes, SOF 2 bytes. */
+	if (header->has_pts) {
+		header->pts = get_unaligned_le32(&data[off]);
+		off += 4;
+	}
+
+	if (header->has_scr) {
+		header->stc = get_unaligned_le32(&data[off]);
+		off += 4;
+		header->sof = get_unaligned_le16(&data[off]);
+		off += 2;
+	}
+
+	if (header->has_sli)
+		header->sli = get_unaligned_le16(&data[off]);
+
+	header->payload_size = len - header->length;
+	header->fid = data[1] & UVC_STREAM_FID;
+
+	return 0;
+
+error:
+	stream->stats.frame.nb_invalid++;
+	return -EINVAL;
+}
+
 /* ------------------------------------------------------------------------
  * Metadata
  */
@@ -1409,7 +1399,9 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
 			struct uvc_buffer *buf, struct uvc_buffer *meta_buf)
 {
 	struct urb *urb = uvc_urb->urb;
+	struct uvc_payload_header header;
 	struct uvc_streaming *stream = uvc_urb->stream;
+	unsigned int len;
 	u8 *mem;
 	int ret, i;
 
@@ -1424,11 +1416,15 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
 			continue;
 		}
 
-		/* Decode the payload header. */
 		mem = urb->transfer_buffer + urb->iso_frame_desc[i].offset;
+		len = urb->iso_frame_desc[i].actual_length;
+
+		ret = uvc_video_parse_header(stream, mem, len, &header);
+		if (ret < 0)
+			continue;
+
 		do {
-			ret = uvc_video_decode_start(stream, buf, mem,
-				urb->iso_frame_desc[i].actual_length);
+			ret = uvc_video_decode_start(stream, buf, &header);
 			if (ret == -EAGAIN)
 				uvc_video_next_buffers(stream, &buf, &meta_buf);
 		} while (ret == -EAGAIN);
@@ -1439,12 +1435,11 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
 		uvc_video_decode_meta(stream, meta_buf, mem, ret);
 
 		/* Decode the payload data. */
-		uvc_video_decode_data(uvc_urb, buf, mem + ret,
-			urb->iso_frame_desc[i].actual_length - ret);
+		uvc_video_decode_data(uvc_urb, buf, mem + header.length,
+			urb->iso_frame_desc[i].actual_length - header.length);
 
 		/* Process the header again. */
-		uvc_video_decode_end(stream, buf, mem,
-			urb->iso_frame_desc[i].actual_length);
+		uvc_video_decode_end(stream, buf, &header);
 
 		if (buf->state == UVC_BUF_STATE_READY)
 			uvc_video_next_buffers(stream, &buf, &meta_buf);
@@ -1455,6 +1450,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 			struct uvc_buffer *buf, struct uvc_buffer *meta_buf)
 {
 	struct urb *urb = uvc_urb->urb;
+	struct uvc_payload_header header;
 	struct uvc_streaming *stream = uvc_urb->stream;
 	u8 *mem;
 	int len, ret;
@@ -1475,8 +1471,12 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 	 * header.
 	 */
 	if (stream->bulk.header_size == 0 && !stream->bulk.skip_payload) {
+		ret = uvc_video_parse_header(stream, mem, len, &header);
+		if (ret < 0)
+			return;
+
 		do {
-			ret = uvc_video_decode_start(stream, buf, mem, len);
+			ret = uvc_video_decode_start(stream, buf, &header);
 			if (ret == -EAGAIN)
 				uvc_video_next_buffers(stream, &buf, &meta_buf);
 		} while (ret == -EAGAIN);
@@ -1485,13 +1485,13 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 		if (ret < 0 || buf == NULL) {
 			stream->bulk.skip_payload = 1;
 		} else {
-			memcpy(stream->bulk.header, mem, ret);
-			stream->bulk.header_size = ret;
+			memcpy(stream->bulk.header, mem, header.length);
+			stream->bulk.header_size = header.length;
 
 			uvc_video_decode_meta(stream, meta_buf, mem, ret);
 
-			mem += ret;
-			len -= ret;
+			mem += header.length;
+			len -= header.length;
 		}
 	}
 
@@ -1512,8 +1512,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 	if (urb->actual_length < urb->transfer_buffer_length ||
 	    stream->bulk.payload_size >= stream->bulk.max_payload_size) {
 		if (!stream->bulk.skip_payload && buf != NULL) {
-			uvc_video_decode_end(stream, buf, stream->bulk.header,
-				stream->bulk.payload_size);
+			uvc_video_decode_end(stream, buf, &header);
 			if (buf->state == UVC_BUF_STATE_READY)
 				uvc_video_next_buffers(stream, &buf, &meta_buf);
 		}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..2678c680f6bc 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -425,6 +425,27 @@ struct uvc_urb {
 	struct work_struct work;
 };
 
+struct uvc_payload_header {
+	bool has_eof;
+
+	bool has_pts;
+	u32 pts;
+
+	bool has_scr;
+	u16 sof;
+	u32 stc;
+
+	bool has_sli;
+	u16 sli;
+
+	u8 fid;
+
+	bool has_err;
+
+	int length;
+	int payload_size;
+};
+
 struct uvc_streaming {
 	struct list_head list;
 	struct uvc_device *dev;
-- 
2.34.1

