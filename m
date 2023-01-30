Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F23681E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjA3W1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjA3W1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:27:37 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62AA2FCFD;
        Mon, 30 Jan 2023 14:27:35 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i6so1924519ilq.8;
        Mon, 30 Jan 2023 14:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II+Jl8eZoU1E3b0fDfbf4ubv2PCTHVICkLREHENOVHM=;
        b=L8S9ZUkHW0AKjRS0uBpYEH1JIfpxI9WOsSlK6JW82xJ2PE7r/9A3gHfQrllYXfn/VJ
         v/dtyPsjpdBZ5LgiPBLOzE25DAPUua+eDirp2k4LOjg85YEn6J5grEOdbNh99+SpsttW
         k2UM4U/guCTR8Kyb+WWDmnwUF3lWe1TTblbTGylHgXtr+3M2eV44v68+aT5DHqaExC0/
         vJicUQGRBZxpMlCuSmDrX4AIbzyRwsROnuX1LracKT1MvFMDf26dx+GoT8ojnwm51N0D
         HyP/H87pNsa8nWYKMjWLx9zF4vpy2uHdWYJbUH+fiztWtCrhbm8hQYYn2Eyr2qL8wacM
         0cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II+Jl8eZoU1E3b0fDfbf4ubv2PCTHVICkLREHENOVHM=;
        b=r9qazdVA5J+pocLrI8rZIIzFH/YTcptM03E5giU2AM9DOjGd70v1s3IMMGUviGp5jS
         v6KyK2UvMYpbV4G0PgTADbokG1816cphpFMn8Ex7VFJsQOxQ9j2VNwXmVmS3xQO3F5sS
         kjXThqDXDhU+xmdxcAKA0xHU0/X9AM+RYhyKkULEhyil7prbQqRUVi2MjuRNKgXD0DPH
         TvI8uZOPEupBMGxKWFuvbV3wkSbSFyxXH13H3APjM37L1vjpx/vN23X0jghaUKLjlywL
         ZHxAIt9XrUKVshr9/7h+KZ7zQ361rr6qXNUamwVXGmoumAteEbF9srpGG8YJKIB9gkVI
         vSIQ==
X-Gm-Message-State: AO0yUKXdyvE8Fmuo3w+t8KHVfypXIBBE4a0/NUdfeH6vwyHp4BDNGPIG
        bqNzYrjuh75YAZ4gL/gV3NsM/xF5FIeofw==
X-Google-Smtp-Source: AK7set9tKAZvnRI98dKHGEtfJdxen3hCtr5hKEvUmSWCADlgdaO5PpW9+jOnbCupLocQCVh7jooajQ==
X-Received: by 2002:a05:6e02:1d8d:b0:310:e4e7:a9ab with SMTP id h13-20020a056e021d8d00b00310e4e7a9abmr7051790ila.31.1675117655055;
        Mon, 30 Jan 2023 14:27:35 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id h4-20020a92c084000000b00302632f0d20sm4332075ile.67.2023.01.30.14.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:27:34 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/2] misc: fastrpc: reject new invocations during device removal
Date:   Mon, 30 Jan 2023 17:27:16 -0500
Message-Id: <20230130222716.7016-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130222716.7016-1-mailingradian@gmail.com>
References: <20230130222716.7016-1-mailingradian@gmail.com>
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

The channel's rpmsg object allows new invocations to be made. After old
invocations are already interrupted, the driver shouldn't try to invoke
anymore. Invalidating the rpmsg at the end of the driver removal
function makes it easy to cause a race condition in userspace. Even
closing a file descriptor before the driver finishes its cleanup can
cause an invocation via fastrpc_release_current_dsp_process() and
subsequent timeout.

Invalidate the channel before the invocations are interrupted to make
sure that no invocations can be created to hang after the device closes.

Demonstration of the bug as performed on a Google Pixel 3a with
devicetree patches:

	#include <fcntl.h>
	#include <misc/fastrpc.h>
	#include <stdint.h>
	#include <stdio.h>
	#include <string.h>
	#include <sys/ioctl.h>
	#include <unistd.h>

	static int remotectl_open(int fd,
				  const char *name,
				  uint32_t *handle)
	{
		struct fastrpc_invoke invoke;
		struct fastrpc_invoke_args args[4];
		struct {
			uint32_t namelen;
			uint32_t errlen;
		} in;
		struct {
			uint32_t handle;
			uint32_t err;
		} out;
		char errstr[256];
		int ret;

		// Remoteproc expects to receive a null terminator
		in.namelen = strlen(name) + 1;
		in.errlen = 256;

		args[0].ptr = (__u64) &in;
		args[0].length = sizeof(in);
		args[0].fd = -1;

		args[1].ptr = (__u64) name;
		args[1].length = in.namelen;
		args[1].fd = -1;

		args[2].ptr = (__u64) &out;
		args[2].length = sizeof(out);
		args[2].fd = -1;

		args[3].ptr = (__u64) errstr;
		args[3].length = 256;
		args[3].fd = -1;

		invoke.handle = 0;
		invoke.sc = 0x00020200;
		invoke.args = (__u64) args;

		ret = ioctl(fd, FASTRPC_IOCTL_INVOKE, (__u64) &invoke);

		if (!ret)
			*handle = out.handle;

		return ret;
	}

	int main()
	{
		struct fastrpc_init_create_static create;
		uint32_t handle;
		int fd, ret;

		fd = open("/dev/fastrpc-adsp", O_RDWR);
		if (fd == -1) {
			perror("Could not open /dev/fastrpc-adsp");
			return 1;
		}

		ret = ioctl(fd, FASTRPC_IOCTL_INIT_ATTACH_SNS, NULL);
		if (ret) {
			perror("Could not attach to sensorspd");
			goto close_dev;
		}

		/*
		 * Under normal circumstances, the remote processor
		 * would request a file from a different client, and
		 * quickly find out that there is no such file. When
		 * this other client is not running, this procedure call
		 * conveniently waits for the ADSP to crash.
		 */
		ret = remotectl_open(fd, "a", &handle);
		if (ret == -1)
			perror("Could not open CHRE interface");

	close_dev:
		// This takes 10 seconds
		printf("Closing file descriptor\n");
		close(fd);
		printf("Closed file descriptor\n");

		return 0;
	}

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/misc/fastrpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 2334a4fd5869..c8a36b9cf4fe 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2351,7 +2351,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	// No invocations past this point
 	spin_lock_irqsave(&cctx->lock, flags);
+	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2370,7 +2372,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	of_platform_depopulate(&rpdev->dev);
 
-	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 
-- 
2.39.1

