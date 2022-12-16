Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A664ED5F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiLPPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiLPPDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:03:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856605EDE2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:03:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F030C34338;
        Fri, 16 Dec 2022 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671203021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0TDp9CXE6EJ1v0ndnk2zrjrOeWR6PHCVWrWopj1g64=;
        b=yYicdBUfKyS7bvUq/IIfaKTzLwnGceStF+iWl2iTavJxSG9sOoKdKGE5nKHYqBlWaGScJk
        PZ0/LWWvPV9UKpniaxt0FzMSO2u9Iryr1vxO/UenvTc4q6A5h5c23lxqUPlSYWUESctZh/
        NBFVg//skOalfaq0m1K9vsdpNvDRM90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671203021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0TDp9CXE6EJ1v0ndnk2zrjrOeWR6PHCVWrWopj1g64=;
        b=7zJAOWt+YnLi2PcDaI9RaDnxjKu3Tp0XPNfpnN71uVg5Z4QakiwxxoZPpHwS6aLrUDfkmu
        HZt1mXuhZVsbq2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEE56138FD;
        Fri, 16 Dec 2022 15:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EbRlNs2InGOdewAAMHmgww
        (envelope-from <jwiesner@suse.de>); Fri, 16 Dec 2022 15:03:41 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 758A829798; Fri, 16 Dec 2022 16:03:41 +0100 (CET)
Date:   Fri, 16 Dec 2022 16:03:41 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v6 3/6] locking/rwsem: Disable preemption at all
 down_write*() and up_write() code paths
Message-ID: <20221216150341.GA19127@incl>
References: <20221118022016.462070-1-longman@redhat.com>
 <20221118022016.462070-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118022016.462070-4-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:20:13PM -0500, Waiman Long wrote:
> The previous patch has disabled preemption at all the down_read()
> and up_read() code paths. For symmetry, this patch extends commit
> 48dfb5d2560d ("locking/rwsem: Disable preemption while trying for rwsem
> lock") to have preemption disabled at all the down_write() and up_write()
> code path including downgrade_write().
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Tested-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
