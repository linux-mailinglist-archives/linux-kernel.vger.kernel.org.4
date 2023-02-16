Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2C698E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBPHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBPHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:51:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A341B6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:51:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAFBA21D72;
        Thu, 16 Feb 2023 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676533871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ajBmdtrtPrLwGMCnqDRXFKAEd2YXbkPSZ+MplyN1QkI=;
        b=Q00C+H4d4aX4jwiE1H0DMrADM4G6xFCOJA1WllHAQwVNzw5Jb/bu/OPMSrSgLqKHZ32odx
        YK6jZ3zsB6FFqJtw2wEMGjzsqJc9AswXpN17C8BiPKIqN/gylZd8QTkIuURCdEcgJdvvnf
        WmuEQPH371RkX991MshS6pFEw3++kto=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE907139B5;
        Thu, 16 Feb 2023 07:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rOUaLG/g7WNUfAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 16 Feb 2023 07:51:11 +0000
Date:   Thu, 16 Feb 2023 08:51:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 0/2] handle memoryless nodes more appropriately
Message-ID: <Y+3gb/blCDJnQ0Ik@dhcp22.suse.cz>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
 <Y+0KKnN8BU6ky6oP@dhcp22.suse.cz>
 <3426457c-99bf-9f7c-f663-c29474d9fa73@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3426457c-99bf-9f7c-f663-c29474d9fa73@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-02-23 07:11:19, Qi Zheng wrote:
> 
> 
> On 2023/2/16 00:36, Michal Hocko wrote:
> > On Wed 15-02-23 23:24:10, Qi Zheng wrote:
> > > Hi all,
> > > 
> > > Currently, in the process of initialization or offline memory, memoryless
> > > nodes will still be built into the fallback list of itself or other nodes.
> > > 
> > > This is not what we expected, so this patch series removes memoryless
> > > nodes from the fallback list entirely.
> > > 
> > > Comments and suggestions are welcome.
> 
> Hi Michal,
> 
> > 
> > This is a tricky area full of surprises and it is really easy to
> 
> Would you mind giving an example of a "new problem"?

The initialization is spread over several places and it is quite easy to
introduce bugs because it is hard to review this area. Been there done
that. Just look into the git log.

> > introduce new problems. What kind of problem/issue are you trying to
> > solve/handle by these changes?
> 
> IIUC, I think there are two reasons:
> 
> Firstly, as mentioned in commit message, the memoryless node has no
> memory to allocate (If it can be allocated, it may also cause the panic
> I mentioned in [1]), so we should not continue to traverse it when
> allocating memory at runtime, which will have a certain overhead.

Sure that is not the most optimal implementation but does this matter in
practice? Can you observe any actual measurable performance penalty?
Currently we are just sacrificing some tiny performance for a
simplicity.
 
> Secondly, from the perspective of semantic correctness, why do we remove
> the memoryless node from the fallback list of other normal nodes
> (N_MEMORY), but not from its own fallback list (PATCH[1/2])? Why should
> an upcoming memoryless node continue exist in the fallback list of
> itself and other normal nodes (PATCH[2/2])?

I am not sure I follow. What is the semantic correctness issue?

-- 
Michal Hocko
SUSE Labs
