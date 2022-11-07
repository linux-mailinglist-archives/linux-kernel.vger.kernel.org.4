Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC961FACA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiKGRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiKGRF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:05:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F0C60CD;
        Mon,  7 Nov 2022 09:05:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45E43225FE;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667840757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rn9xQxF1SiqI3hq3m8+HEoFWEg4sEnRP9PimT44lp+o=;
        b=0+UgC16voEobAqhc3TDmlKXe49ffMkXz+JYFLH8Q2VdizXmpUKArwb4F0qb9ogZsQDV7L9
        wW88bSLIej+5QA0d0SkjpYx20LpK/CK4yjk5exZLnoBvUKdhpH81dfleDuEf+JTU9ae2XU
        qpb/UxXIPhrHnw8QddJU2nlr9N6bVeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667840757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rn9xQxF1SiqI3hq3m8+HEoFWEg4sEnRP9PimT44lp+o=;
        b=BthGwYjhGhVwuVLPtrRxURFYyQF/G51vCTt54KbN5k/VQTH9Bquv9SYzU8DJCQrQ/5P/ME
        vcLfqjRaY89zTbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17DC113AC7;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9TkwBfU6aWOYfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Nov 2022 17:05:57 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/3] rearrange struct slab fields to allow larger rcu_head
Date:   Mon,  7 Nov 2022 18:05:51 +0100
Message-Id: <20221107170554.7869-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The previous version (RFC, no cover letter) is here:
https://lore.kernel.org/all/20220826090912.11292-1-vbabka@suse.cz/

Git branch is here:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.2/fit_rcu_head
(also in linux-next since late last week)

The rationale for doing all this is in patch 3 - I hope there are still
plans for the rcu_head debugging, Joel?

The previous version was in linux-next, which brought crash reports due
to causing false positive __PageMovable() tests. There were several
attempts to deal with it, as explained in Patch 2, which is an updated
version of one of those attempts. It hasn't been formally posted and
reviewed yet, hence this posting.

Thanks,
Vlastimil

Vlastimil Babka (3):
  mm/slub: perform free consistency checks before call_rcu
  mm/migrate: make isolate_movable_page() skip slab pages
  mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head

 mm/migrate.c | 15 ++++++++++++---
 mm/slab.c    |  6 +++++-
 mm/slab.h    | 54 +++++++++++++++++++++++++++++++---------------------
 mm/slub.c    | 26 ++++++++++++++-----------
 4 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.38.0

