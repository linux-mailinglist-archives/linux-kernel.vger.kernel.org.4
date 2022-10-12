Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFCC5FC517
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJLMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJLMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:15:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB543607;
        Wed, 12 Oct 2022 05:15:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6069C21BF9;
        Wed, 12 Oct 2022 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665576911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCQ2WpDCxrbeT5GJTKPF0LqosNd9RnwLmJ2qJ7436Gs=;
        b=K/IlkhgrX+2welPakjC0Axi79t2kTcd8AbUB/YTbrcVymSQOLha6U/tbxVDRKT4KIKkyAZ
        7Sy+HUDJFDfhIl82HhHEsetW0xrPGq6muCTweAJz5vkYuZvsAKtGgGbGBpLJ0vamfcQ6gE
        79FoAkuLBJcGOH2Op8WMHHngsqv5zn4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21B9313A5C;
        Wed, 12 Oct 2022 12:15:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n/pZB8+vRmM4UgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Oct 2022 12:15:11 +0000
Date:   Wed, 12 Oct 2022 14:15:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [External] Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0avztF7QU8P/OoB@dhcp22.suse.cz>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <Y0WEbCqJHjnqsg8n@dhcp22.suse.cz>
 <582cf257-bc0d-c96e-e72e-9164cff4fce1@bytedance.com>
 <Y0aCiYMQ4liL2azT@dhcp22.suse.cz>
 <a0421769-c2b9-d59a-0358-3cc84b2cb2bd@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0421769-c2b9-d59a-0358-3cc84b2cb2bd@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-10-22 19:22:21, Zhongkun He wrote:
> > 
> > Yes, this will require some refactoring and one potential way is to make
> > mpol ref counting unconditional. The conditional ref. counting has
> > already caused issues in the past and the code is rather hard to follow
> > anyway. I am not really sure this optimization is worth it.
> > 
> > Another option would be to block the pidfd side of things on completion
> > which would wake it up from the task_work context but I would rather
> > explore the ref counting approach first and only if this is proven to be
> > too expensive to go with hacks like this.
> 
> Hi Michal
> 
> The counting approach means executing mpol_get/put() when start/finish using
> mempolicy,right?

We already do that via mpol_{get,put} but there are cases where the
reference counting is ignored because it cannot be freed and also mpol_cond_put
resp. open coded versions of mpol_needs_cond_ref.
-- 
Michal Hocko
SUSE Labs
