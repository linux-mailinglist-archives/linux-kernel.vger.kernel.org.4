Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1871FF8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjFBKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjFBKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:39:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496E195
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:39:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE76721A30;
        Fri,  2 Jun 2023 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685702345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OXVCVLEq/yIdpec66Wgx6FzW4hiPq4nQMk/OB4ZUx7E=;
        b=R0tdKg7n1zQ8NlEZMf9EMFNJDbFb3iOTRt3Vc+9oxlrhAgw1H5U2Ym3xB1BpnRGeShlNpO
        NLUFcvOST78osOhKrcubiS3AWLEs06cGx0c2L/sXFRG+7bg0OMynn9U40pnwv8ER0Q8fL7
        aSA3hDPzfIhtA+YDTSajXfDouUPcq+A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF22E13A2E;
        Fri,  2 Jun 2023 10:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4fxOHsnGeWR5WwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 02 Jun 2023 10:39:05 +0000
Date:   Fri, 2 Jun 2023 12:39:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/4] vmstat: skip periodic vmstat update for nohz full
 CPUs
Message-ID: <ZHnGyNd4lHz/pwKr@dhcp22.suse.cz>
References: <20230530145234.968927611@redhat.com>
 <20230530145335.828634764@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530145335.828634764@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-05-23 11:52:36, Marcelo Tosatti wrote:
> @@ -2022,6 +2023,16 @@ static void vmstat_shepherd(struct work_
>  	for_each_online_cpu(cpu) {
>  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
>  
> +		/*
> +		 * Skip periodic updates for nohz full CPUs.
> +		 * Any callers who need precise values should use
> +		 * a snapshot of the per-CPU counters, or use the global
> +		 * counters with measures to handle errors up to
> +		 * thresholds (see calculate_normal_threshold).
> +		 */
> +		if (tick_nohz_full_cpu(cpu))
> +			continue;

In other code path we have used cpu_is_isolated, is there any reason to
diverge from that here? Isn't this effectivelly the same kind of
problem?

> +
>  		if (!delayed_work_pending(dw) && need_update(cpu))
>  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
>  
> 

-- 
Michal Hocko
SUSE Labs
