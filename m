Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBCA7156C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjE3Hak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjE3HaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:30:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD732E59
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:29:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E942D21ADB;
        Tue, 30 May 2023 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685431756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Xc6akc9Ei8ibGMUWfaQORxwFlvDO9jwV9dDSv6wVcc=;
        b=TZi5XX6DoBQEj/yaMHNb4O2lS+t1lwGCaLpEv2A8uapRTYfKtbAmzCEN5XZssu4DmJsI8d
        9UiBzhKVG+pOZihyoDwsh1TyrQ8hX/lS0voIzeSMreQUtnFSenm8+XdI2IMnc5oxGYiGbV
        AoFtV82/ePRXeEGiI+9zAUIk0AVZ4e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685431756;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Xc6akc9Ei8ibGMUWfaQORxwFlvDO9jwV9dDSv6wVcc=;
        b=NkAS7pT3e3Tw88Shn7h2ELNdrNQTo2Sj7/v/O1RN4B6TPj5ZFrJ9yJ7F4KMNyiyaje07Di
        taujcoTCC0fZ/cCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4F0413478;
        Tue, 30 May 2023 07:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P4xnM8yldWT5GwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 May 2023 07:29:16 +0000
Message-ID: <6d5bbf96-74fa-590c-62c8-8aaf58d725a9@suse.cz>
Date:   Tue, 30 May 2023 09:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/6] mm: compaction: change fast_isolate_freepages() to
 void type
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
 <759fca20b22ebf4c81afa30496837b9e0fb2e53b.1685018752.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <759fca20b22ebf4c81afa30496837b9e0fb2e53b.1685018752.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 14:53, Baolin Wang wrote:
> No caller cares about the return value of fast_isolate_freepages(),
> void it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

