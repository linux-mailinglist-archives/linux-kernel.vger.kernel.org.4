Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66169C7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjBTJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBTJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E12B46F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676886195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7P4ISHC5W0WcWMJhiYnMDDTZTDG1y9ksbw4WkrhdO8w=;
        b=LLTKNslQGp1aoRe8SXQee3bR90z5FTKdQOD6AK3i2HnKIrh/9NN3zU3NVzKEfbZUrfW6jf
        nMChiiG8coVL7iDSmbSOfpT4YIcFy4Tx8Pgdv7Tt18KMRbY6wnc1izY2XYwQ1hB21rgbeO
        FVrdGN/KnnnzQv7vvG6tCSVORHEpK3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-mJwTSewtNNmO3RZuuJom1Q-1; Mon, 20 Feb 2023 04:43:14 -0500
X-MC-Unique: mJwTSewtNNmO3RZuuJom1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA034802314;
        Mon, 20 Feb 2023 09:43:13 +0000 (UTC)
Received: from plouf.local (unknown [10.45.224.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6092404CD84;
        Mon, 20 Feb 2023 09:43:12 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230215-wip-mcp2221-v2-1-109f71fd036e@redhat.com>
References: <20230215-wip-mcp2221-v2-1-109f71fd036e@redhat.com>
Subject: Re: [PATCH v2] HID: mcp-2221: prevent UAF in delayed work
Message-Id: <167688619223.2031822.11362974798628061939.b4-ty@redhat.com>
Date:   Mon, 20 Feb 2023 10:43:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 11:22:58 +0100, Benjamin Tissoires wrote:
> If the device is plugged/unplugged without giving time for mcp_init_work()
> to complete, we might kick in the devm free code path and thus have
> unavailable struct mcp_2221 while in delayed work.
> 
> Canceling the delayed_work item is enough to solve the issue, because
> cancel_delayed_work_sync will prevent the work item to requeue itself.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.3/mcp2221), thanks!

[1/1] HID: mcp-2221: prevent UAF in delayed work
      https://git.kernel.org/hid/hid/c/47e91fdfa511

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

