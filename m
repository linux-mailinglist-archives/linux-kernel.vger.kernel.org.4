Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE86525E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiLTR4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiLTR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:56:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5870D113E;
        Tue, 20 Dec 2022 09:56:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so9435155wml.4;
        Tue, 20 Dec 2022 09:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kJi60gyNl4vOWh2qkNjesWcj3F4raPrJ4zGZO5DkXA=;
        b=e8iBypxUZgZtcbEL8EpvF8Ss/jFWdwfW1yDuM/JzslzL4vf+RQqb6QfNaD57Aa1E1L
         0NsLJCrdUj948YpvKboR/gTf/apbQAWMJz8zRdfE2X2yWa6p8yWmgJlaQEfBWtd5tL5o
         KksM3nsHyY6Vif2vibFKVzwoX4A5G3jYiJky7Hq1d9YQLk9WUQ8HOZFJjUY3350dJbap
         4B5/uz8q/KCYCnjF1p0zHj2HJirQv3oVtuL4hH+YyPkMkui41k3VM6D2vJPR6H4fNDvO
         vwBfCu4BFUCuK2/wzjPUXrJsiMMBXXwr9uIL7Soho7n+fX1r9E5GsQVkUV/JFvHRtzfd
         Xkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kJi60gyNl4vOWh2qkNjesWcj3F4raPrJ4zGZO5DkXA=;
        b=kF8CSArNXY8Kc2geXelJ4OAxaHvWEJ0zEoakIeeYgdQhWEWhaKQ4OmHVFKIku4cBDs
         LgGUR45NNwfWUqXI08w7JUckwNoROwuIlivAWd4MH98PseEkT3vvlYkSHqi9PmXsSn07
         dLFRUcDn8QK65dMZQqK8p+vieNziomypTZjDMP55pBpNy/vpgdiQN9QZ+i6Py4yqTzud
         7Ly/cNBI2cqDDSBw4zPWl0CGKJQVl0c9pXxUelCN7QFNini9JLhH47e8kQb3lq2WQ8cW
         iJGq+VuJlb1UmcH0CRUWHlKk0vbYVtf6ebZTf8sAe4qcjvinOaML03QpIjjumOvf7nIO
         e/xA==
X-Gm-Message-State: AFqh2kqMSflEcwNOZhIDmHSoO8ECNcyVsgOGGyM5nqNopc3b4Gooau52
        3Ibe8f4GuQCrRdRt2/pASDY=
X-Google-Smtp-Source: AMrXdXtYNrBycZR5dzrP5kix0ruh3Jny5N0M7sDeXlBMe1/AgKxrnzoUskBtKGE2J4+sL3biV6XhHQ==
X-Received: by 2002:a05:600c:3ba5:b0:3d5:3ab1:d630 with SMTP id n37-20020a05600c3ba500b003d53ab1d630mr2391276wms.8.1671558988473;
        Tue, 20 Dec 2022 09:56:28 -0800 (PST)
Received: from xws.localdomain ([194.126.177.41])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b002423dc3b1a9sm13206300wrn.52.2022.12.20.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:56:27 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/surface: aggregator: Rename top-level request functions to avoid ambiguities
Date:   Tue, 20 Dec 2022 18:56:08 +0100
Message-Id: <20221220175608.1436273-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221220175608.1436273-1-luzmaximilian@gmail.com>
References: <20221220175608.1436273-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have a struct ssam_request_sync and a function
ssam_request_sync(). While this is valid C, there are some downsides to
it.

One of these is that current Sphinx versions (>= 3.0) cannot
disambiguate between the two (see disucssion and pull request linked
below). It instead emits a "WARNING: Duplicate C declaration" and links
for the struct and function in the resulting documentation link to the
same entry (i.e. both to either function or struct documentation)
instead of their respective own entries.

While we could just ignore that and wait for a fix, there's also a point
to be made that the current naming can be somewhat confusing when
searching (e.g. via grep) or trying to understand the levels of
abstraction at play:

We currently have struct ssam_request_sync and associated functions
ssam_request_sync_[alloc|free|init|wait|...]() operating on this struct.
However, function ssam_request_sync() is one abstraction level above
this. Similarly, ssam_request_sync_with_buffer() is not a function
operating on struct ssam_request_sync, but rather a sibling to
ssam_request_sync(), both using the struct under the hood.

Therefore, rename the top level request functions:

  ssam_request_sync() -> ssam_request_do_sync()
  ssam_request_sync_with_buffer() -> ssam_request_do_sync_with_buffer()
  ssam_request_sync_onstack() -> ssam_request_do_sync_onstack()

Link: https://lore.kernel.org/all/085e0ada65c11da9303d07e70c510dc45f21315b.1656756450.git.mchehab@kernel.org/
Link: https://github.com/sphinx-doc/sphinx/pull/8313
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../driver-api/surface_aggregator/client.rst  |  8 +--
 drivers/hid/surface-hid/surface_hid.c         |  6 +-
 drivers/hid/surface-hid/surface_kbd.c         |  6 +-
 drivers/platform/surface/aggregator/bus.c     |  6 +-
 .../platform/surface/aggregator/controller.c  | 32 +++++------
 .../platform/surface/surface_acpi_notify.c    |  2 +-
 .../surface/surface_aggregator_cdev.c         |  6 +-
 .../surface/surface_aggregator_tabletsw.c     |  2 +-
 include/linux/surface_aggregator/controller.h | 56 +++++++++----------
 include/linux/surface_aggregator/device.h     |  8 +--
 10 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/client.rst b/Documentation/driver-api/surface_aggregator/client.rst
index 27f95abdbe99..dd96f8eb6578 100644
--- a/Documentation/driver-api/surface_aggregator/client.rst
+++ b/Documentation/driver-api/surface_aggregator/client.rst
@@ -19,7 +19,7 @@
 .. |ssam_notifier_unregister| replace:: :c:func:`ssam_notifier_unregister`
 .. |ssam_device_notifier_register| replace:: :c:func:`ssam_device_notifier_register`
 .. |ssam_device_notifier_unregister| replace:: :c:func:`ssam_device_notifier_unregister`
-.. |ssam_request_sync| replace:: :c:func:`ssam_request_sync`
+.. |ssam_request_do_sync| replace:: :c:func:`ssam_request_do_sync`
 .. |ssam_event_mask| replace:: :c:type:`enum ssam_event_mask <ssam_event_mask>`
 
 
@@ -209,12 +209,12 @@ data received from it is converted from little-endian to host endianness.
             * with the SSAM_REQUEST_HAS_RESPONSE flag set in the specification
             * above.
             */
-           status = ssam_request_sync(ctrl, &rqst, &resp);
+           status = ssam_request_do_sync(ctrl, &rqst, &resp);
 
            /*
             * Alternatively use
             *
-            *   ssam_request_sync_onstack(ctrl, &rqst, &resp, sizeof(arg_le));
+            *   ssam_request_do_sync_onstack(ctrl, &rqst, &resp, sizeof(arg_le));
             *
             * to perform the request, allocating the message buffer directly
             * on the stack as opposed to allocation via kzalloc().
@@ -230,7 +230,7 @@ data received from it is converted from little-endian to host endianness.
            return status;
    }
 
-Note that |ssam_request_sync| in its essence is a wrapper over lower-level
+Note that |ssam_request_do_sync| in its essence is a wrapper over lower-level
 request primitives, which may also be used to perform requests. Refer to its
 implementation and documentation for more details.
 
diff --git a/drivers/hid/surface-hid/surface_hid.c b/drivers/hid/surface-hid/surface_hid.c
index d4aa8c81903a..bcb6ffd0e6ff 100644
--- a/drivers/hid/surface-hid/surface_hid.c
+++ b/drivers/hid/surface-hid/surface_hid.c
@@ -80,7 +80,7 @@ static int ssam_hid_get_descriptor(struct surface_hid_device *shid, u8 entry, u8
 
 		rsp.length = 0;
 
-		status = ssam_retry(ssam_request_sync_onstack, shid->ctrl, &rqst, &rsp,
+		status = ssam_retry(ssam_request_do_sync_onstack, shid->ctrl, &rqst, &rsp,
 				    sizeof(*slice));
 		if (status)
 			return status;
@@ -131,7 +131,7 @@ static int ssam_hid_set_raw_report(struct surface_hid_device *shid, u8 rprt_id,
 
 	buf[0] = rprt_id;
 
-	return ssam_retry(ssam_request_sync, shid->ctrl, &rqst, NULL);
+	return ssam_retry(ssam_request_do_sync, shid->ctrl, &rqst, NULL);
 }
 
 static int ssam_hid_get_raw_report(struct surface_hid_device *shid, u8 rprt_id, u8 *buf, size_t len)
@@ -151,7 +151,7 @@ static int ssam_hid_get_raw_report(struct surface_hid_device *shid, u8 rprt_id,
 	rsp.length = 0;
 	rsp.pointer = buf;
 
-	return ssam_retry(ssam_request_sync_onstack, shid->ctrl, &rqst, &rsp, sizeof(rprt_id));
+	return ssam_retry(ssam_request_do_sync_onstack, shid->ctrl, &rqst, &rsp, sizeof(rprt_id));
 }
 
 static u32 ssam_hid_event_fn(struct ssam_event_notifier *nf, const struct ssam_event *event)
diff --git a/drivers/hid/surface-hid/surface_kbd.c b/drivers/hid/surface-hid/surface_kbd.c
index 0635341bc517..7ca8038026ce 100644
--- a/drivers/hid/surface-hid/surface_kbd.c
+++ b/drivers/hid/surface-hid/surface_kbd.c
@@ -49,7 +49,7 @@ static int ssam_kbd_get_descriptor(struct surface_hid_device *shid, u8 entry, u8
 	rsp.length = 0;
 	rsp.pointer = buf;
 
-	status = ssam_retry(ssam_request_sync_onstack, shid->ctrl, &rqst, &rsp, sizeof(entry));
+	status = ssam_retry(ssam_request_do_sync_onstack, shid->ctrl, &rqst, &rsp, sizeof(entry));
 	if (status)
 		return status;
 
@@ -75,7 +75,7 @@ static int ssam_kbd_set_caps_led(struct surface_hid_device *shid, bool value)
 	rqst.length = sizeof(value_u8);
 	rqst.payload = &value_u8;
 
-	return ssam_retry(ssam_request_sync_onstack, shid->ctrl, &rqst, NULL, sizeof(value_u8));
+	return ssam_retry(ssam_request_do_sync_onstack, shid->ctrl, &rqst, NULL, sizeof(value_u8));
 }
 
 static int ssam_kbd_get_feature_report(struct surface_hid_device *shid, u8 *buf, size_t len)
@@ -97,7 +97,7 @@ static int ssam_kbd_get_feature_report(struct surface_hid_device *shid, u8 *buf,
 	rsp.length = 0;
 	rsp.pointer = buf;
 
-	status = ssam_retry(ssam_request_sync_onstack, shid->ctrl, &rqst, &rsp, sizeof(payload));
+	status = ssam_retry(ssam_request_do_sync_onstack, shid->ctrl, &rqst, &rsp, sizeof(payload));
 	if (status)
 		return status;
 
diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index de539938896e..7004eb4a63a2 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -136,9 +136,9 @@ int ssam_device_add(struct ssam_device *sdev)
 	 * is always valid and can be used for requests as long as the client
 	 * device we add here is registered as child under it. This essentially
 	 * guarantees that the client driver can always expect the preconditions
-	 * for functions like ssam_request_sync (controller has to be started
-	 * and is not suspended) to hold and thus does not have to check for
-	 * them.
+	 * for functions like ssam_request_do_sync() (controller has to be
+	 * started and is not suspended) to hold and thus does not have to check
+	 * for them.
 	 *
 	 * Note that for this to work, the controller has to be a parent device.
 	 * If it is not a direct parent, care has to be taken that the device is
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index c6537a1b3a2e..9c43b9665a2c 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1674,7 +1674,7 @@ int ssam_request_sync_submit(struct ssam_controller *ctrl,
 EXPORT_SYMBOL_GPL(ssam_request_sync_submit);
 
 /**
- * ssam_request_sync() - Execute a synchronous request.
+ * ssam_request_do_sync() - Execute a synchronous request.
  * @ctrl: The controller via which the request will be submitted.
  * @spec: The request specification and payload.
  * @rsp:  The response buffer.
@@ -1686,9 +1686,9 @@ EXPORT_SYMBOL_GPL(ssam_request_sync_submit);
  *
  * Return: Returns the status of the request or any failure during setup.
  */
-int ssam_request_sync(struct ssam_controller *ctrl,
-		      const struct ssam_request *spec,
-		      struct ssam_response *rsp)
+int ssam_request_do_sync(struct ssam_controller *ctrl,
+			 const struct ssam_request *spec,
+			 struct ssam_response *rsp)
 {
 	struct ssam_request_sync *rqst;
 	struct ssam_span buf;
@@ -1722,10 +1722,10 @@ int ssam_request_sync(struct ssam_controller *ctrl,
 	ssam_request_sync_free(rqst);
 	return status;
 }
-EXPORT_SYMBOL_GPL(ssam_request_sync);
+EXPORT_SYMBOL_GPL(ssam_request_do_sync);
 
 /**
- * ssam_request_sync_with_buffer() - Execute a synchronous request with the
+ * ssam_request_do_sync_with_buffer() - Execute a synchronous request with the
  * provided buffer as back-end for the message buffer.
  * @ctrl: The controller via which the request will be submitted.
  * @spec: The request specification and payload.
@@ -1738,17 +1738,17 @@ EXPORT_SYMBOL_GPL(ssam_request_sync);
  * SSH_COMMAND_MESSAGE_LENGTH() macro can be used to compute the required
  * message buffer size.
  *
- * This function does essentially the same as ssam_request_sync(), but instead
- * of dynamically allocating the request and message data buffer, it uses the
- * provided message data buffer and stores the (small) request struct on the
- * heap.
+ * This function does essentially the same as ssam_request_do_sync(), but
+ * instead of dynamically allocating the request and message data buffer, it
+ * uses the provided message data buffer and stores the (small) request struct
+ * on the heap.
  *
  * Return: Returns the status of the request or any failure during setup.
  */
-int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
-				  const struct ssam_request *spec,
-				  struct ssam_response *rsp,
-				  struct ssam_span *buf)
+int ssam_request_do_sync_with_buffer(struct ssam_controller *ctrl,
+				     const struct ssam_request *spec,
+				     struct ssam_response *rsp,
+				     struct ssam_span *buf)
 {
 	struct ssam_request_sync rqst;
 	ssize_t len;
@@ -1772,7 +1772,7 @@ int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
 
 	return status;
 }
-EXPORT_SYMBOL_GPL(ssam_request_sync_with_buffer);
+EXPORT_SYMBOL_GPL(ssam_request_do_sync_with_buffer);
 
 
 /* -- Internal SAM requests. ------------------------------------------------ */
@@ -1864,7 +1864,7 @@ static int __ssam_ssh_event_request(struct ssam_controller *ctrl,
 	result.length = 0;
 	result.pointer = &buf;
 
-	status = ssam_retry(ssam_request_sync_onstack, ctrl, &rqst, &result,
+	status = ssam_retry(ssam_request_do_sync_onstack, ctrl, &rqst, &result,
 			    sizeof(params));
 
 	return status < 0 ? status : buf;
diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
index 50500e562963..897cdd9c3aae 100644
--- a/drivers/platform/surface/surface_acpi_notify.c
+++ b/drivers/platform/surface/surface_acpi_notify.c
@@ -590,7 +590,7 @@ static acpi_status san_rqst(struct san_data *d, struct gsb_buffer *buffer)
 		return san_rqst_fixup_suspended(d, &rqst, buffer);
 	}
 
-	status = __ssam_retry(ssam_request_sync_onstack, SAN_REQUEST_NUM_TRIES,
+	status = __ssam_retry(ssam_request_do_sync_onstack, SAN_REQUEST_NUM_TRIES,
 			      d->ctrl, &rqst, &rsp, SAN_GSB_MAX_RQSX_PAYLOAD);
 
 	if (!status) {
diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 492c82e69182..07f0ed658369 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -302,8 +302,8 @@ static long ssam_cdev_request(struct ssam_cdev_client *client, struct ssam_cdev_
 		 * theoretical maximum (SSH_COMMAND_MAX_PAYLOAD_SIZE) of the
 		 * underlying protocol (note that nothing remotely this size
 		 * should ever be allocated in any normal case). This size is
-		 * validated later in ssam_request_sync(), for allocation the
-		 * bound imposed by u16 should be enough.
+		 * validated later in ssam_request_do_sync(), for allocation
+		 * the bound imposed by u16 should be enough.
 		 */
 		spec.payload = kzalloc(spec.length, GFP_KERNEL);
 		if (!spec.payload) {
@@ -342,7 +342,7 @@ static long ssam_cdev_request(struct ssam_cdev_client *client, struct ssam_cdev_
 	}
 
 	/* Perform request. */
-	status = ssam_request_sync(client->cdev->ctrl, &spec, &rsp);
+	status = ssam_request_do_sync(client->cdev->ctrl, &spec, &rsp);
 	if (status)
 		goto out;
 
diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 27d95a6a7851..c3a5b7f56c8f 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -382,7 +382,7 @@ static int ssam_pos_get_sources_list(struct ssam_tablet_sw *sw, struct ssam_sour
 	rsp.length = 0;
 	rsp.pointer = (u8 *)sources;
 
-	status = ssam_retry(ssam_request_sync_onstack, sw->sdev->ctrl, &rqst, &rsp, 0);
+	status = ssam_retry(ssam_request_do_sync_onstack, sw->sdev->ctrl, &rqst, &rsp, 0);
 	if (status)
 		return status;
 
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index d11a1c6e3186..350d6c6c0a1d 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -207,17 +207,17 @@ static inline int ssam_request_sync_wait(struct ssam_request_sync *rqst)
 	return rqst->status;
 }
 
-int ssam_request_sync(struct ssam_controller *ctrl,
-		      const struct ssam_request *spec,
-		      struct ssam_response *rsp);
+int ssam_request_do_sync(struct ssam_controller *ctrl,
+			 const struct ssam_request *spec,
+			 struct ssam_response *rsp);
 
-int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
-				  const struct ssam_request *spec,
-				  struct ssam_response *rsp,
-				  struct ssam_span *buf);
+int ssam_request_do_sync_with_buffer(struct ssam_controller *ctrl,
+				     const struct ssam_request *spec,
+				     struct ssam_response *rsp,
+				     struct ssam_span *buf);
 
 /**
- * ssam_request_sync_onstack - Execute a synchronous request on the stack.
+ * ssam_request_do_sync_onstack - Execute a synchronous request on the stack.
  * @ctrl: The controller via which the request is submitted.
  * @rqst: The request specification.
  * @rsp:  The response buffer.
@@ -227,7 +227,7 @@ int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
  * fully initializes it via the provided request specification, submits it,
  * and finally waits for its completion before returning its status. This
  * helper macro essentially allocates the request message buffer on the stack
- * and then calls ssam_request_sync_with_buffer().
+ * and then calls ssam_request_do_sync_with_buffer().
  *
  * Note: The @payload_len parameter specifies the maximum payload length, used
  * for buffer allocation. The actual payload length may be smaller.
@@ -235,12 +235,12 @@ int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
  * Return: Returns the status of the request or any failure during setup, i.e.
  * zero on success and a negative value on failure.
  */
-#define ssam_request_sync_onstack(ctrl, rqst, rsp, payload_len)			\
+#define ssam_request_do_sync_onstack(ctrl, rqst, rsp, payload_len)		\
 	({									\
 		u8 __data[SSH_COMMAND_MESSAGE_LENGTH(payload_len)];		\
 		struct ssam_span __buf = { &__data[0], ARRAY_SIZE(__data) };	\
 										\
-		ssam_request_sync_with_buffer(ctrl, rqst, rsp, &__buf);		\
+		ssam_request_do_sync_with_buffer(ctrl, rqst, rsp, &__buf);	\
 	})
 
 /**
@@ -349,7 +349,7 @@ struct ssam_request_spec_md {
  * zero on success and negative on failure. The ``ctrl`` parameter is the
  * controller via which the request is being sent.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_N(name, spec...)				\
@@ -366,7 +366,7 @@ struct ssam_request_spec_md {
 		rqst.length = 0;						\
 		rqst.payload = NULL;						\
 										\
-		return ssam_request_sync_onstack(ctrl, &rqst, NULL, 0);		\
+		return ssam_request_do_sync_onstack(ctrl, &rqst, NULL, 0);	\
 	}
 
 /**
@@ -389,7 +389,7 @@ struct ssam_request_spec_md {
  * parameter is the controller via which the request is sent. The request
  * argument is specified via the ``arg`` pointer.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_W(name, atype, spec...)			\
@@ -406,8 +406,8 @@ struct ssam_request_spec_md {
 		rqst.length = sizeof(atype);					\
 		rqst.payload = (u8 *)arg;					\
 										\
-		return ssam_request_sync_onstack(ctrl, &rqst, NULL,		\
-						 sizeof(atype));		\
+		return ssam_request_do_sync_onstack(ctrl, &rqst, NULL,		\
+						    sizeof(atype));		\
 	}
 
 /**
@@ -430,7 +430,7 @@ struct ssam_request_spec_md {
  * the controller via which the request is sent. The request's return value is
  * written to the memory pointed to by the ``ret`` parameter.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_R(name, rtype, spec...)			\
@@ -453,7 +453,7 @@ struct ssam_request_spec_md {
 		rsp.length = 0;							\
 		rsp.pointer = (u8 *)ret;					\
 										\
-		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, 0);	\
+		status = ssam_request_do_sync_onstack(ctrl, &rqst, &rsp, 0);	\
 		if (status)							\
 			return status;						\
 										\
@@ -491,7 +491,7 @@ struct ssam_request_spec_md {
  * request argument is specified via the ``arg`` pointer. The request's return
  * value is written to the memory pointed to by the ``ret`` parameter.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_WR(name, atype, rtype, spec...)		\
@@ -514,7 +514,7 @@ struct ssam_request_spec_md {
 		rsp.length = 0;							\
 		rsp.pointer = (u8 *)ret;					\
 										\
-		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, sizeof(atype)); \
+		status = ssam_request_do_sync_onstack(ctrl, &rqst, &rsp, sizeof(atype)); \
 		if (status)							\
 			return status;						\
 										\
@@ -550,7 +550,7 @@ struct ssam_request_spec_md {
  * parameter is the controller via which the request is sent, ``tid`` the
  * target ID for the request, and ``iid`` the instance ID.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_MD_N(name, spec...)				\
@@ -567,7 +567,7 @@ struct ssam_request_spec_md {
 		rqst.length = 0;						\
 		rqst.payload = NULL;						\
 										\
-		return ssam_request_sync_onstack(ctrl, &rqst, NULL, 0);		\
+		return ssam_request_do_sync_onstack(ctrl, &rqst, NULL, 0);	\
 	}
 
 /**
@@ -592,7 +592,7 @@ struct ssam_request_spec_md {
  * ``tid`` the target ID for the request, and ``iid`` the instance ID. The
  * request argument is specified via the ``arg`` pointer.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_MD_W(name, atype, spec...)			\
@@ -609,7 +609,7 @@ struct ssam_request_spec_md {
 		rqst.length = sizeof(atype);					\
 		rqst.payload = (u8 *)arg;					\
 										\
-		return ssam_request_sync_onstack(ctrl, &rqst, NULL,		\
+		return ssam_request_do_sync_onstack(ctrl, &rqst, NULL,		\
 						 sizeof(atype));		\
 	}
 
@@ -635,7 +635,7 @@ struct ssam_request_spec_md {
  * the target ID for the request, and ``iid`` the instance ID. The request's
  * return value is written to the memory pointed to by the ``ret`` parameter.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_MD_R(name, rtype, spec...)			\
@@ -658,7 +658,7 @@ struct ssam_request_spec_md {
 		rsp.length = 0;							\
 		rsp.pointer = (u8 *)ret;					\
 										\
-		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, 0);	\
+		status = ssam_request_do_sync_onstack(ctrl, &rqst, &rsp, 0);	\
 		if (status)							\
 			return status;						\
 										\
@@ -698,7 +698,7 @@ struct ssam_request_spec_md {
  * The request argument is specified via the ``arg`` pointer. The request's
  * return value is written to the memory pointed to by the ``ret`` parameter.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_MD_WR(name, atype, rtype, spec...)		\
@@ -722,7 +722,7 @@ struct ssam_request_spec_md {
 		rsp.length = 0;							\
 		rsp.pointer = (u8 *)ret;					\
 										\
-		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, sizeof(atype)); \
+		status = ssam_request_do_sync_onstack(ctrl, &rqst, &rsp, sizeof(atype)); \
 		if (status)							\
 			return status;						\
 										\
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 46c45d1b6368..0e353f5cc2e6 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -456,7 +456,7 @@ static inline int ssam_device_register_clients(struct ssam_device *sdev)
  * device of the request and by association the controller via which the
  * request is sent.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_CL_N(name, spec...)			\
@@ -490,7 +490,7 @@ static inline int ssam_device_register_clients(struct ssam_device *sdev)
  * which the request is sent. The request's argument is specified via the
  * ``arg`` pointer.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_CL_W(name, atype, spec...)		\
@@ -524,7 +524,7 @@ static inline int ssam_device_register_clients(struct ssam_device *sdev)
  * the request is sent. The request's return value is written to the memory
  * pointed to by the ``ret`` parameter.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_CL_R(name, rtype, spec...)		\
@@ -560,7 +560,7 @@ static inline int ssam_device_register_clients(struct ssam_device *sdev)
  * specified via the ``arg`` pointer. The request's return value is written to
  * the memory pointed to by the ``ret`` parameter.
  *
- * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * Refer to ssam_request_do_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_CL_WR(name, atype, rtype, spec...)		\
-- 
2.39.0

