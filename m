Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F715BFC89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIUKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:42:12 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494191D16
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:42:07 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-Eu-kxv1ONa-VuPXCa1cVSg-1; Wed, 21 Sep 2022 06:42:03 -0400
X-MC-Unique: Eu-kxv1ONa-VuPXCa1cVSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91ABE29DD9A0;
        Wed, 21 Sep 2022 10:42:02 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28D7817582;
        Wed, 21 Sep 2022 10:42:01 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH v3 0/3] Allow to change ipc/mq sysctls inside ipc namespace
Date:   Wed, 21 Sep 2022 12:41:46 +0200
Message-Id: <cover.1663756794.git.legion@kernel.org>
In-Reply-To: <202209211737.0Bu0F40t-lkp@intel.com>
References: <202209211737.0Bu0F40t-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now ipc and mq limits count as per ipc namespace, but only real
root can change them. By default, the current values of these limits are
such that it can only be reduced. Since only root can change the values,
it is impossible to reduce these limits in the rootless container.

We can allow limit changes within ipc namespace because mq parameters
are limited by RLIMIT_MSGQUEUE and ipc parameters are not limited to
anything other than cgroups.

--

Alexey Gladkov (3):
  sysctl: Allow change system v ipc sysctls inside ipc namespace
  sysctl: Allow to change limits for posix messages queues
  docs: Add information about ipc sysctls limitations

 Documentation/admin-guide/sysctl/kernel.rst | 14 ++++++--
 ipc/ipc_sysctl.c                            | 36 +++++++++++++++++++--
 ipc/mq_sysctl.c                             | 36 +++++++++++++++++++++
 3 files changed, 81 insertions(+), 5 deletions(-)

-- 
2.33.4

