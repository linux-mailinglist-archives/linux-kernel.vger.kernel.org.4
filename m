Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81F6690D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjBIPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBIPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115639BAC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675956801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ofXkymEHUHbiccFSxfE3RKhTo0FLU9PUEYKbx6pPdBY=;
        b=V3kBSbGWUdC6ZSVgMu5UlD4aG2eeN3M3L0+1CCd0MR5QIc7V8damQWm6BKn4Y3BA0KjJ1h
        2qoyJVFNCtjWQcwul+hX15yJszISlozQOtk6Z0Y4IUfzHKPRWRHaOvSr+W+IY4rVej5AYG
        6cpGmJYDf2v47D7uhka4yVOVYXBDRsU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-w-j-N1OhMzS0AJa82rbJ1A-1; Thu, 09 Feb 2023 10:33:18 -0500
X-MC-Unique: w-j-N1OhMzS0AJa82rbJ1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 799E13C10ED3;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C3921121314;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 7BB57403CC07A; Thu,  9 Feb 2023 12:32:51 -0300 (-03)
Message-ID: <20230209153204.818774692@redhat.com>
User-Agent: quilt/0.67
Date:   Thu, 09 Feb 2023 12:01:57 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 07/11] convert this_cpu_cmpxchg users to this_cpu_cmpxchg_local
References: <20230209150150.380060673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this_cpu_cmpxchg was modified to atomic version, which 
can be more costly than non-atomic version.

Switch users of this_cpu_cmpxchg to this_cpu_cmpxchg_local
(which preserves pre-non-atomic this_cpu_cmpxchg behaviour).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/kernel/fork.c
===================================================================
--- linux-vmstat-remote.orig/kernel/fork.c
+++ linux-vmstat-remote/kernel/fork.c
@@ -203,7 +203,7 @@ static bool try_release_thread_stack_to_
 	unsigned int i;
 
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
-		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) != NULL)
+		if (this_cpu_cmpxchg_local(cached_stacks[i], NULL, vm) != NULL)
 			continue;
 		return true;
 	}
Index: linux-vmstat-remote/kernel/scs.c
===================================================================
--- linux-vmstat-remote.orig/kernel/scs.c
+++ linux-vmstat-remote/kernel/scs.c
@@ -79,7 +79,7 @@ void scs_free(void *s)
 	 */
 
 	for (i = 0; i < NR_CACHED_SCS; i++)
-		if (this_cpu_cmpxchg(scs_cache[i], 0, s) == NULL)
+		if (this_cpu_cmpxchg_local(scs_cache[i], 0, s) == NULL)
 			return;
 
 	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_PROT_NORMAL);


