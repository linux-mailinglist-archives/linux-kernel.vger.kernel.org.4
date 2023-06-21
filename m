Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D950738A31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjFUP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjFUP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BFDBC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687362927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fCHQizRwe6wJfjeGABMJ7EtlC6+tAboqmFJcKVi+fI=;
        b=L8o1e/Sh/x/QhxtTFKYWBbaCRCcfhTnkq6ev9VE4qYP8tskBtgoLOgFLGLkuC4xNE3Opge
        lNz1epNAoQ8zvhjLIiqXsbJuYgQ77Rc6jbLiKaKsddl43++FjlZV1fDxmpQJNqDWWnl61a
        /DcU3iJT5Eh8T64wXcxgGH5Z0w1VkYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-Ped06gAhMRSuMJP75JcHxg-1; Wed, 21 Jun 2023 11:55:25 -0400
X-MC-Unique: Ped06gAhMRSuMJP75JcHxg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33F24915180;
        Wed, 21 Jun 2023 15:55:25 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.45.224.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B81CF492B02;
        Wed, 21 Jun 2023 15:55:23 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hidraw: fix data race on device refcount
Date:   Wed, 21 Jun 2023 17:55:14 +0200
Message-Id: <168736288418.3423010.16497710719241305762.b4-ty@redhat.com>
In-Reply-To: <20230621-hidraw-race-v1-1-a58e6ac69bab@yubico.com>
References: <20230621-hidraw-race-v1-1-a58e6ac69bab@yubico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 13:17:43 +0200, Ludvig Michaelsson wrote:
> The hidraw_open() function increments the hidraw device reference
> counter. The counter has no dedicated synchronization mechanism,
> resulting in a potential data race when concurrently opening a device.
> 
> The race is a regression introduced by commit 8590222e4b02 ("HID:
> hidraw: Replace hidraw device table mutex with a rwsem"). While
> minors_rwsem is intended to protect the hidraw_table itself, by instead
> acquiring the lock for writing, the reference counter is also protected.
> This is symmetrical to hidraw_release().
> 
> [...]

Added stable@ cc tags and

Applied to hid/hid.git (for-6.4/upstream-fixes), thanks!

[1/1] HID: hidraw: fix data race on device refcount
      https://git.kernel.org/hid/hid/c/944ee77dc6ec

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

