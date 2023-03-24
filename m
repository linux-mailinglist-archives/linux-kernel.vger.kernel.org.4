Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623406C80AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjCXPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCXPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:04:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FA6DBD6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:04:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D5371FE75;
        Fri, 24 Mar 2023 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679670294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xjkqv3qq9lK96uvcM7L0CVxArtqI/M2tYrb00mpOZgs=;
        b=XJmQhelex9Pe558wjy7zSA5HVTx9K5GMSp/7YFlYBWIVLCA4lRe+gwMEl3QiQ7yhmhnmPH
        sEcBYVWSqPsw88GeWH9CCxL0d4e/SfEPUaasN4mThWh6vdV+c398lCrDpImNsTCMod/DpR
        6FwHuuNOzGaGeJDH7GdfJGmkGVXlZBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679670294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xjkqv3qq9lK96uvcM7L0CVxArtqI/M2tYrb00mpOZgs=;
        b=3LNK4UHNz0nq73vpRKyQECwfTyjCgucIkqWQTI1qZKK7/ikw9rfRXSN0i1lz2KF6Q5PLCC
        pfx6Vnew1MNFNPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF28D138ED;
        Fri, 24 Mar 2023 15:04:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NBjWNRW8HWRcYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 24 Mar 2023 15:04:53 +0000
Message-ID: <a329d2a9-9617-e00f-3bb8-3f5dcf07329f@suse.cz>
Date:   Fri, 24 Mar 2023 16:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab fix for 6.3-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab fix from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fix-for-6.3-rc4

Note the tag was signed with a new subkey (of same gpg key). I'm not sure if
it's transparent for your tooling or not. It was uploaded to korg-pgpkeys git
(also ubuntu and keys.openpgp.org keyservers) a few weeks ago. The timing
with github ssh key rotation is pre coincidence :)

======================================

There's a single build fix for a corner case configuration that is
apparently possible to achieve on some arches, from Geert.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      mm/slab: Fix undefined init_cache_node_node() for NUMA and !SMP

 mm/slab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
