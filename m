Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64186C7D12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCXLPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCXLPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:15:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82225962
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:15:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0A0433777;
        Fri, 24 Mar 2023 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679656525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=i2iOJQ2cBwIeRh7jfmFtt3V7v9mVqIjDAe9mWv1x44U=;
        b=tYtBHkKnJMFuKvkIoLLY6nYBE0BzCtmtYZO6wi3h/nh4JoqIHotdlkNH5HZBtW7J/2XDX+
        l/38tbjS4b68QIN/okh7YS+rbPoTrsH82Y8NsCz9j+qCuHlByZydrvbUjAE3oHv3qBNshC
        3nT/DkhKWh4ddxa2laQSu1E5ugFrIJs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E614133E5;
        Fri, 24 Mar 2023 11:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3hIbHU2GHWS3XAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 24 Mar 2023 11:15:25 +0000
Date:   Fri, 24 Mar 2023 12:15:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: WARN_ON in move_normal_pmd
Message-ID: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
our QA is regularly hitting
[  544.198822][T20518] WARNING: CPU: 1 PID: 20518 at ../mm/mremap.c:255 move_pgt_entry+0x4c6/0x510
triggered by thp01 LTP test. This has been brought up in the past and
resulted in f81fdd0c4ab7 ("mm: document warning in move_normal_pmd() and
make it warn only once"). While it is good that the underlying problem
is understood, it doesn't seem there is enough interest to fix it
properly. Which is fair but I am wondering whether the WARN_ON gives
us anything here.

Our QA process collects all unexpected side effects of tests and a WARN*
in the log is certainly one of those. This trigger bugs which are mostly
ignored as there is no upstream fix for them. This alone is nothing
really critical but there are workloads which do run with panic on warn
configured and this issue would put the system down which is unnecessary
IMHO. Would it be sufficient to replace the WARN_ON_ONCE by
pr_warn_once?

Thanks!
-- 
Michal Hocko
SUSE Labs
