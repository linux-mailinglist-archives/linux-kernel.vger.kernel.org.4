Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED64705E17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjEQD1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjEQD1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:27:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2710D5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:27:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4872038B;
        Wed, 17 May 2023 03:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684294042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tI1tcjHSoO6fgre5R5aBLcGiGYE6dVQ4WHHEvad6hHI=;
        b=WH8qQWViH46DVpKqeBQfsDe4Xak04YgwaaP567DtUPRCimm0DuBQbZVr1jR92X5SLA+2Xb
        rINOTXnQ8XQU8LKw0IXpeQg0xANadvtCl2SuBnonT6ulZBLFhPKEhlfMYMYdUyOB8RbfJa
        tNmnUBwxXjuQtqN0w4CQtssg27JR2js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684294042;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tI1tcjHSoO6fgre5R5aBLcGiGYE6dVQ4WHHEvad6hHI=;
        b=4lbB+GiQql2kvwSL/15fWyXd+vdS+eAMiY3X1JbNy8goAGEcHclFNPSaCdE+k0qYaBH4rg
        sqyvONRUNtEVjUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70FB413466;
        Wed, 17 May 2023 03:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ixZoG5pJZGTuJgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 17 May 2023 03:27:22 +0000
MIME-Version: 1.0
Date:   Wed, 17 May 2023 05:27:22 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v5 0/3] page_owner: print stacks and their counter
In-Reply-To: <20230516141245.356200756ff3750ef4f12094@linux-foundation.org>
References: <20230516182537.3139-1-osalvador@suse.de>
 <20230516141245.356200756ff3750ef4f12094@linux-foundation.org>
User-Agent: Roundcube Webmail
Message-ID: <d2c5f359b0212a94390a97b04b874356@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-16 23:12, Andrew Morton wrote:
> Documentation/mm/page_owner.rst is feeling very sad.

I will definitely update the docs, sorry about that.

> I'll toss it in there for some testing for now.  The changelogs would
> benefit from a bit of proofreading, please - quite a few typos and
> grammaros.

Let me fix those.

Thanks Andrew

-- 
Oscar Salvador
SUSE Labs
