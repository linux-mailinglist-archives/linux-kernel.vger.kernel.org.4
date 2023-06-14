Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5872F77B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbjFNINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjFNINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:13:38 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22FAC7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:13:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgyqM3phLzBQgnw
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:13:35 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686730415; x=1689322416; bh=3w9dMnLJg9guCmvtB2SPkGPXXAx
        nryK3ecaXVioEy3M=; b=M4E2FvSMi0SdTPTpPe41sL5+fn09Fvjq6BnaKFhGkUn
        xCXneaEMIRrsjpSFXqt1TZfSF4+it1VmOTnHMaTuXBm5pCZKwCP5BOsa/4j/k8dl
        kRxLJj9bac74zy155P/tQ/dX8vFfUxA5COOJocjA0losezxcBkg79FOXpW93lWuL
        LIrozuGFo32tHeTlMsIrzMIdvxDuRbBQ2s0jOL6tkrYZhh44gTjbnnaEYrgwVkbu
        fqTmWZVQEKMw14LFsq8PXS6sg8l5iOgOckmneFuiH4VtEh+JON67QOyam5TrIwe5
        l7DvwKEpf+NByDfHs3xqol2vyY7gE+lZmpRWYKk6ckw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YpNGyVW42D0X for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:13:35 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgyqM1BQwzBQJZ2;
        Wed, 14 Jun 2023 16:13:35 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:13:35 +0800
From:   hexingwei001@208suo.com
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        wangdeming@inspur.com, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sample/acrn: fix uninitialized_var.cocci warning
In-Reply-To: <20230614080847.51136-1-panzhiai@cdjrlc.com>
References: <20230614080847.51136-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <90b3c525ca35cfc28c9445036c8327c2@208suo.com>
X-Sender: hexingwei001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:

samples/acrn/vm-sample.c:53:6-7: WARNING this kind of initialization is 
deprecated.
samples/acrn/vm-sample.c:54:6-7: WARNING this kind of initialization is 
deprecated.
samples/acrn/vm-sample.c:37:5-6: WARNING this kind of initialization is 
deprecated.

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  samples/acrn/vm-sample.c | 3 ---
  1 file changed, 3 deletions(-)

diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index 704402c64ea3..e60b2d0b7e20 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -34,7 +34,6 @@ int is_running = 1;

  void vm_exit(int sig)
  {
-    sig = sig;

      is_running = 0;
      ioctl(hsm_fd, ACRN_IOCTL_PAUSE_VM, vmid);
@@ -50,8 +49,6 @@ int main(int argc, char **argv)
      struct acrn_io_request *io_req;
      struct acrn_ioreq_notify __attribute__((aligned(8))) notify;

-    argc = argc;
-    argv = argv;

      ret = posix_memalign(&guest_memory, 4096, GUEST_MEMORY_SIZE);
      if (ret < 0) {
