Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09159737C52
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjFUHdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUHc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:32:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42691988
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:32:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A48331F895;
        Wed, 21 Jun 2023 07:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687332777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gjfb2p19oiPYpe3DSMJrrCJ9yALR0S9IVL68sM6p2A=;
        b=aF0QiJBKBa9qywvk+4bhKGiE3WKMpPh7yemKSZhtxRe+/PjujnVs3PKLAPl/6H7BXmPOeg
        7KWCZbwjHEqBlp6MZMrXIAD+smMEzUCk1A9535nLjCG4pxmGFGliwIzYrLz9kpVWnDeSl4
        Sjns/iUpTmgPf8QbgPj03t4gboTWHHc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86CD8133E6;
        Wed, 21 Jun 2023 07:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0o2cHqmnkmSKOwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 21 Jun 2023 07:32:57 +0000
Date:   Wed, 21 Jun 2023 09:32:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     junfei fang <jefexiaomi@gmail.com>
Cc:     andrew.zhu@mediatek.com, colin.peng@mediatek.com,
        wangbiao3@xiaomi.com, yangjianlong@xiaomi.com,
        linux-kernel@vger.kernel.org
Subject: Re: kasan cgroup user-after-free in get_mem_cgroup_from_mm
Message-ID: <ZJKnqJ7XTvvt8MYM@dhcp22.suse.cz>
References: <20230620022120.27448-1-jefexiaomi@xiaomi.com>
 <ZJFLfRCZuPXN+p9I@dhcp22.suse.cz>
 <CAFtB3FY-0uyJchUtUPph-pUeQVRpddi-3xDSGzhJEhFqWck4XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFtB3FY-0uyJchUtUPph-pUeQVRpddi-3xDSGzhJEhFqWck4XQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:18:31, junfei fang wrote:
> Thank you for your prompt response.
> 
> We are using kernel-5.15 in our project and cannot change it.

It will be hard to get a community support for such a kernel I am
afraid. Especially when considering the kernel is heavily tainted
> CPU: 0 PID: 6071 Comm: elastic_postChe Tainted: P S      WC OE

by proprietary, out-of-tree modules, pre-existing warnings that might be
related and TAINT_CPU_OUT_OF_SPEC doesn't add much confidence into setup
either.

> Do you have any suggestions on how to fix this issue?

No, not really. From what I can see the report complains about cset
associated with the process' mm. I do not recall any specific bug where
css would be released prematurely. Maybe somebody else who is more
familiar with the cgroup core would know better.

Btw. you should be sending the full UAF report after you have CCed LKML.
-- 
Michal Hocko
SUSE Labs
