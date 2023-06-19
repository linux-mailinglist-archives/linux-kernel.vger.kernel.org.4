Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5F735810
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjFSNKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFSNKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:10:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5319691
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:10:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5B351F86B;
        Mon, 19 Jun 2023 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687180203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAE+CBtRUNrrQSxU+aVeFZwu+WBKni72HGssIFuv27M=;
        b=EWrRImgTsAr3KLMV04eqYnJgwvHVzVmFoAQJuEh788dLQMvpwpOGuHa7SNOOpLgULLYQGr
        Qxp5fCvMjUFZeA0zuk7P4pDL+1aPTxCRehWhXAr4JpX+IC6y5NFkBffM3TSXPO3KoqdAmG
        o2yovANCsi0ZLhimrxE8DdwBlNQ6lnQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA528139C2;
        Mon, 19 Jun 2023 13:10:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QHYqK6tTkGQRBAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 19 Jun 2023 13:10:03 +0000
Date:   Mon, 19 Jun 2023 15:10:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Adam Majer <amajer@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm: Sync percpu mm RSS counters before querying
Message-ID: <ZJBTq/I5sLR9lp8i@dhcp22.suse.cz>
References: <20230616180718.17725-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616180718.17725-1-mkoutny@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-06-23 20:07:18, Michal Koutny wrote:
[...]
> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")

Please note there is a different regression from f1a7941243c1 reported
by Jan http://lkml.kernel.org/r/20230608111408.s2minsenlcjow7q3@quack3
-- 
Michal Hocko
SUSE Labs
