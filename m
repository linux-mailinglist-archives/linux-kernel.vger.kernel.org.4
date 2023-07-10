Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65D74D7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjGJNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGJNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:35:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6F103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:34:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 028401FFAA;
        Mon, 10 Jul 2023 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688996085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ch8v1j9KqUdgNhXghUXhSgDwfmZmfZTDZcPXN8CPyyM=;
        b=fUgHbXoC9vexqaiULBqumApDn61z/TPRkL/nfj5G+4Rl3OS3WZgZBKqWuxqreThcF9lTbt
        7PqWakoXqtTXYZmFTryTJr7HbHMzmgm/QIha/f2046r/G5cmIiDvO3XB9AZuPIOPL2aw6M
        lWq3nmYzPQl+kRNFUTd5xB0jrw2oT48=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D37A41361C;
        Mon, 10 Jul 2023 13:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GWg7MfQIrGS+JgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 10 Jul 2023 13:34:44 +0000
Date:   Mon, 10 Jul 2023 15:34:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
Message-ID: <ZKwI9LYDFkDd0+9O@dhcp22.suse.cz>
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
 <ZKfFVfZovt4PnMsy@dhcp22.suse.cz>
 <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
 <ZKgk0HfuuxsyBBXI@dhcp22.suse.cz>
 <CACSyD1NX7sfPu2Wi1ep0gJ-wt1O8-+++321Uhw4YK1Uz4rxj-g@mail.gmail.com>
 <ZKvgTTqwTnUXiY3m@dhcp22.suse.cz>
 <CACSyD1NkvXuyjUEc_pb_89B-5XyBd8sSSD1XmKKkDBssMV5FhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1NkvXuyjUEc_pb_89B-5XyBd8sSSD1XmKKkDBssMV5FhA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-07-23 21:16:42, 贺中坤 wrote:
> >
> > OK, this is an important detail to mention. Also have tried to get some
> > numbers of how much excess is happening for a mixed bag of compressible
> > memory?
> 
> Yes, I've done the test many times.  The numbers of excess depend on the
> compression ratio only. The maximum amount will not exceed 400KB,and will be
> smaller than the hard limit finally.

Again, important data point for your changelog.

-- 
Michal Hocko
SUSE Labs
