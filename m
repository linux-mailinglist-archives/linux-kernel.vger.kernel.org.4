Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7A668E70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbjAMGz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbjAMGy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:54:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A8BA1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Ae0YtkSy6ycx5DxDjJ9hEzZMOUAvt0aVhp2q7qivpy0=; b=5Cmm9j5fxRhR4JfIWVBq/18XZD
        NQ1+y2ZbPL5Fpou6dQmO9FNHtXJ//Pf3VJgLZLy4OIZHrUQlLOvsMdvOZGo1RpSaFr61SxYU9nJbh
        gcsLqx/nGY85YdQ1KMuY06gaugfVsIxZain/TSnsISAicOrFGLfCrdMkAzUKdkG/pnYuRodHdEB/d
        4/6iMGtBVZPFmAJ/qQk4GKkJPDc6zv/kCNEUX7IBCoZ0TSZazqAYuuWUxBwA7O1wwFMvXgB+sZQbX
        6q6eptvagE4lXLNmn2AmI4yl8hnX/L+KxMdtecmUayAcQLNsuMIvUicepaWgINb7drVOAp5o0l/O4
        OOzDg5xQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDjA-000qXM-2N; Fri, 13 Jan 2023 06:39:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] most: fix kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:39:47 -0800
Message-Id: <20230113063947.23174-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various W=1 kernel-doc warnings in drivers/most/:

drivers/most/most_usb.c:669: warning: Excess function parameter 'data' description in 'link_stat_timer_handler'
drivers/most/most_usb.c:769: warning: cannot understand function prototype: 'const struct file_operations hdm_usb_fops = '
drivers/most/most_usb.c:776: warning: cannot understand function prototype: 'const struct usb_device_id usbid[] = '
drivers/most/most_cdev.c:301: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Initialization of struct file_operations
drivers/most/most_cdev.c:414: warning: Function parameter or member 'args' not described in 'comp_probe'
drivers/most/most_snd.c:56: warning: Function parameter or member 'pcm_hardware' not described in 'channel'
drivers/most/most_snd.c:56: warning: Function parameter or member 'copy_fn' not described in 'channel'
drivers/most/most_snd.c:404: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Initialization of struct snd_pcm_ops
drivers/most/most_snd.c:514: warning: Function parameter or member 'device_name' not described in 'audio_probe_channel'
drivers/most/most_snd.c:703: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Initialization of the struct most_component


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Also: what does MOST mean? Can that be added to drivers/most/Kconfig,
    in a prompt or help text?
Also: how about a MAINTAINERS entry for drivers/most/?

 drivers/most/most_cdev.c |    5 +++--
 drivers/most/most_snd.c  |   10 ++++++----
 drivers/most/most_usb.c  |    6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff -- a/drivers/most/most_usb.c b/drivers/most/most_usb.c
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -660,7 +660,7 @@ static void hdm_request_netinfo(struct m
 
 /**
  * link_stat_timer_handler - schedule work obtaining mac address and link status
- * @data: pointer to USB device instance
+ * @t: pointer to timer_list which holds a pointer to the USB device instance
  *
  * The handler runs in interrupt context. That's why we need to defer the
  * tasks to a work queue.
@@ -763,14 +763,14 @@ static void wq_clear_halt(struct work_st
 	mutex_unlock(&mdev->io_mutex);
 }
 
-/**
+/*
  * hdm_usb_fops - file operation table for USB driver
  */
 static const struct file_operations hdm_usb_fops = {
 	.owner = THIS_MODULE,
 };
 
-/**
+/*
  * usb_device_id - ID table for HCD device probing
  */
 static const struct usb_device_id usbid[] = {
diff -- a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -297,7 +297,7 @@ static __poll_t comp_poll(struct file *f
 	return mask;
 }
 
-/**
+/*
  * Initialization of struct file_operations
  */
 static const struct file_operations channel_fops = {
@@ -404,8 +404,9 @@ static int comp_tx_completion(struct mos
  * @channel_id: channel index/ID
  * @cfg: pointer to actual channel configuration
  * @name: name of the device to be created
+ * @args: pointer to array of component parameters (from configfs)
  *
- * This allocates achannel object and creates the device node in /dev
+ * This allocates a channel object and creates the device node in /dev
  *
  * Returns 0 on success or error code otherwise.
  */
diff -- a/drivers/most/most_snd.c b/drivers/most/most_snd.c
--- a/drivers/most/most_snd.c
+++ b/drivers/most/most_snd.c
@@ -27,6 +27,7 @@ static struct most_component comp;
 /**
  * struct channel - private structure to keep channel specific data
  * @substream: stores the substream structure
+ * @pcm_hardware: low-level hardware description
  * @iface: interface for which the channel belongs to
  * @cfg: channel configuration
  * @card: registered sound card
@@ -38,6 +39,7 @@ static struct most_component comp;
  * @opened: set when the stream is opened
  * @playback_task: playback thread
  * @playback_waitq: waitq used by playback thread
+ * @copy_fn: copy function for PCM-specific format and width
  */
 struct channel {
 	struct snd_pcm_substream *substream;
@@ -400,7 +402,7 @@ static snd_pcm_uframes_t pcm_pointer(str
 	return channel->buffer_pos;
 }
 
-/**
+/*
  * Initialization of struct snd_pcm_ops
  */
 static const struct snd_pcm_ops pcm_ops = {
@@ -501,8 +503,8 @@ static void release_adapter(struct sound
  * @iface: pointer to interface instance
  * @channel_id: channel index/ID
  * @cfg: pointer to actual channel configuration
- * @arg_list: string that provides the name of the device to be created in /dev
- *	      plus the desired audio resolution
+ * @device_name: name of the device to be created in /dev
+ * @arg_list: string that provides the desired audio resolution
  *
  * Creates sound card, pcm device, sets pcm ops and registers sound card.
  *
@@ -699,7 +701,7 @@ static int audio_tx_completion(struct mo
 	return 0;
 }
 
-/**
+/*
  * Initialization of the struct most_component
  */
 static struct most_component comp = {
