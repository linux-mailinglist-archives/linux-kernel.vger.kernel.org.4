Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D61698100
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBOQhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBOQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:37:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8933C22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:37:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7F40339B4;
        Wed, 15 Feb 2023 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676479019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLQ6rU7zz0HJVa8gDPYeX8nHAvog15O6NivjpTe4eMg=;
        b=V22reOGYwN8altkRfmZtMUKWNeSgDcBVzdOC0Hr3wEuoEoy0wGsweVJs3DNGsXb/laMCxi
        eJcEyb3ZYfM/4XAC7sp+B7TlegjIguX+8s0OSkwtyhIRTrdd9oPLStd1PXRmSbK2SQYFqX
        Hg0/L3wlLblgW56Mys652DTmw2HNGqw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FBC713483;
        Wed, 15 Feb 2023 16:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9JcYJCsK7WP+QwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 15 Feb 2023 16:36:59 +0000
Date:   Wed, 15 Feb 2023 17:36:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] handle memoryless nodes more appropriately
Message-ID: <Y+0KKnN8BU6ky6oP@dhcp22.suse.cz>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-02-23 23:24:10, Qi Zheng wrote:
> Hi all,
> 
> Currently, in the process of initialization or offline memory, memoryless
> nodes will still be built into the fallback list of itself or other nodes.
> 
> This is not what we expected, so this patch series removes memoryless
> nodes from the fallback list entirely.
> 
> Comments and suggestions are welcome.

This is a tricky area full of surprises and it is really easy to
introduce new problems. What kind of problem/issue are you trying to
solve/handle by these changes?

-- 
Michal Hocko
SUSE Labs
