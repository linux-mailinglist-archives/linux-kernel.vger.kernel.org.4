Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836965FC658
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJLNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJLNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:23:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7F1EC42;
        Wed, 12 Oct 2022 06:23:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1614721C46;
        Wed, 12 Oct 2022 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665581014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axxPf0w5DXM3j5NJDUDmXxmlQDnP+BGR3NcKUGmmygk=;
        b=bpbzjrYvyfEWNNdqbcE+1/xybLofs5vUcNiCggQ00eBKQM9/2KeJOSebD5u5LVoG/uL0WT
        C2yFlqF5ouupcJy3etp0WrlDOmA/+QP7FmA5IGNWtHHqlCvwZjmYytUDN0OzJA8nNQb84b
        Z7f3JD6zupuXEIA0/lkUwX3bY2X5pbY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAB0413ACD;
        Wed, 12 Oct 2022 13:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6eqeLtW/RmM7eQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Oct 2022 13:23:33 +0000
Date:   Wed, 12 Oct 2022 15:23:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vinicius Petrucci <vpetrucci@gmail.com>
Cc:     Frank van der Linden <fvdl@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0a/1SnV9kTz0hRG@dhcp22.suse.cz>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <CAPTztWYTGOb8ZQzfgThqJn+fyi4ZB8=JQQZi5_rUoDhdftKtvg@mail.gmail.com>
 <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz>
 <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
 <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz>
 <CAEZ6=UOA6=ikSdxN662xyhT3wauGuqZReKLOb=_9EmSRckNr=Q@mail.gmail.com>
 <Y0a8IxAXy43unTSb@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0a8IxAXy43unTSb@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-10-22 15:07:48, Michal Hocko wrote:
> On Wed 12-10-22 07:34:06, Vinicius Petrucci wrote:
[...]
> > Having a feature like "pidfd/process_mbind" would really simplify our
> > user-level agent implementation moving forward, as right now we are
> > adding a LD_PRELOAD wrapper (for signal handler) to listen and execute
> > "mbind" requests from another process. If there's any other
> > alternative solution to this already (via ptrace?), please let me
> > know.
> 
> userfaultfd sounds like the closest match if #PF handling under control
> of an external agent is viable.

And just to clarify. I haven't ever played with using userfaultfd for
numa balancing so I might be completely wrong here.
-- 
Michal Hocko
SUSE Labs
