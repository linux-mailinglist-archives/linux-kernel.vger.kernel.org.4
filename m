Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94976DF43A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDLLvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDLLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:51:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632DB185
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:51:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2090C1F890;
        Wed, 12 Apr 2023 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681300273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ja8WfyqHG8SWsn6zQcE3DA6xHw8zgmqdkFLfVd1nao=;
        b=tj9RiEfFRgbjaA9JmzsqO4x/V60MF6VLKzGIqS6XajSnbTsXJ7c2z4Pk0jpEXOl0YnupOS
        nq7LTOrycoLteJejYRhoTbuGnpE0IluZkIG6IV9JG/OWBOCC7JbMoK/QRVcLLn6lO1HoAI
        4s21ECcJc0DO47X+sQklSGnIwO1o/BE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F27FC13498;
        Wed, 12 Apr 2023 11:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /I5NODCbNmQ8QwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Apr 2023 11:51:12 +0000
Date:   Wed, 12 Apr 2023 13:51:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH v3] dma-buf/heaps: system_heap: avoid too much allocation
Message-ID: <ZDabMEUFE2N3dvxZ@dhcp22.suse.cz>
References: <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
 <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
 <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
 <20230410073228.23043-1-jaewon31.kim@samsung.com>
 <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
 <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
 <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p8>
 <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-04-23 20:37:59, Jaewon Kim wrote:
> Limiting dmabuf memory may be required. But I think there
> is no nice and reasonable way so far.

If that is really the way then the patch doesn't really add a big
benefit. It doesn't really prevent OOMs (or panics due to OOM) as the
allocator still allows to consume arbitrary amount of memory. The
provided check is not able to tell between buggy and legit calls.
-- 
Michal Hocko
SUSE Labs
