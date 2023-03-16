Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3B6BCF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCPMMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCPMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:12:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D8C97F6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:12:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CEE821A3D;
        Thu, 16 Mar 2023 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678968754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHaedlz+6PJdRiBIO280UYU0+qJudLUsHrt8K4W6gl0=;
        b=J5ntyVYB/EyIfey+Y1gv60/GLFc0S3vRYrT65jDAsfsakX0a2cVz0tzh0plgjCxJP7RoQu
        Ep/5X1WkaD+ZIxLsxANNAGDRG+/K5Lo/HxPQbUtek3trMXoYOTqGGt8lRehq6aExoXsL5Y
        qm7A/nt4hiL38kmHST49OY7OwFhTIWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678968754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHaedlz+6PJdRiBIO280UYU0+qJudLUsHrt8K4W6gl0=;
        b=qECEkxutGnHzG3qHNM6078FQtmGNqd9LL2L18Sl7dTOQV+G8sGF3eQIDSo5bvv8NztbxxR
        71ReDV00K7S4TwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 564CA133E0;
        Thu, 16 Mar 2023 12:12:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hzs+FLIHE2RNHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Mar 2023 12:12:34 +0000
Message-ID: <3c77182b-5c41-65ec-afca-42625eadfae4@suse.cz>
Date:   Thu, 16 Mar 2023 13:12:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] mm: compaction: consider the number of scanning
 compound pages in isolate fail path
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, osalvador@suse.de,
        william.lam@bytedance.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <73d6250a90707649cc010731aedc27f946d722ed.1678962352.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <73d6250a90707649cc010731aedc27f946d722ed.1678962352.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 12:06, Baolin Wang wrote:
> The commit b717d6b93b54 ("mm: compaction: include compound page count
> for scanning in pageblock isolation") had added compound page statistics
> for scanning in pageblock isolation, to make sure the number of scanned
> pages are always larger than the number of isolated pages when isolating
> mirgratable or free pageblock.
> 
> However, when failed to isolate the pages when scanning the mirgratable or
> free pageblock, the isolation failure path did not consider the scanning
> statistics of the compound pages, which can show the incorrect number of
> scanned pages in tracepoints or the vmstats to make people confusing about
> the page scanning pressure in memory compaction.
> 
> Thus we should take into account the number of scanning pages when failed
> to isolate the compound pages to make the statistics accurate.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

