Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388546B8E75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCNJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCNJTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:19:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2270434
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:19:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75FA221A1B;
        Tue, 14 Mar 2023 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678785590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtLd46OIrgmZYAXx0MQF0O9mmYT+bX7aUyCHRdJ8Qnk=;
        b=jzRq+GyB5/xUQp7ane+Z4iYT36MHRc+0dxdh4NWT0jF22SHHJ7jkt1Wld5Z2NtZdVLJMAK
        FYDH/zJBtV2iQcTL/tjnPvtC4kSeUAYvX8tyx1mO9qXW322i32BsjgJrj7FKoHkVZut7dD
        wsXCAnasDEbgnBN6RyYcpo4v2TJfcwM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6721913A1B;
        Tue, 14 Mar 2023 09:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UTVQGDY8EGQJZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Mar 2023 09:19:50 +0000
Date:   Tue, 14 Mar 2023 10:19:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     shakeelb@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/oom_kill: don't kill exiting tasks in
 oom_kill_memcg_member
Message-ID: <ZBA8NlwBTprShO3e@dhcp22.suse.cz>
References: <20230314091136.264878-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314091136.264878-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-03-23 09:11:36, Haifeng Xu wrote:
> If oom_group is set, oom_kill_process() invokes oom_kill_memcg_member()
> to kill all processes in the memcg. When scanning tasks in memcg, maybe
> the provided task is marked as oom victim. Also, some tasks are likely
> to release their address space. There is no need to kill the exiting tasks.

This doesn't state any actual problem. Could you be more specific? Is
this a bug fix, a behavior change or an optimization?
-- 
Michal Hocko
SUSE Labs
