Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3635FDA34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJMNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJMNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:17:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1CAC4AD;
        Thu, 13 Oct 2022 06:17:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2507226AB;
        Thu, 13 Oct 2022 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665667063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pQcd7QYBrfrcu/BD1EO4wF8Gr1oJqdtW3FRbiiR9OCI=;
        b=a8zrA3w+OB8AUhikPpmcrktA7TTbopwkxEHR63dbznsNKrkeiyiGBLxlZmVBO1wwG3sWKy
        +nY5oD+LL6Ggwu57/D1k0SLfrwVSK76TojCXHaEzoyP1/68hY3w6XYcKArB8zTlF33aOpa
        26gcGvM8VH03AkwqrMlL84xxfk8C+MM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70C9113AAA;
        Thu, 13 Oct 2022 13:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uN66GfcPSGPeKwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 13 Oct 2022 13:17:43 +0000
Date:   Thu, 13 Oct 2022 15:17:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [External] Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0gP9i8KZKt4/EcG@dhcp22.suse.cz>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <Y0WEbCqJHjnqsg8n@dhcp22.suse.cz>
 <582cf257-bc0d-c96e-e72e-9164cff4fce1@bytedance.com>
 <Y0aCiYMQ4liL2azT@dhcp22.suse.cz>
 <a0421769-c2b9-d59a-0358-3cc84b2cb2bd@bytedance.com>
 <Y0avztF7QU8P/OoB@dhcp22.suse.cz>
 <e825a27a-646b-9723-f774-947501c04ec2@bytedance.com>
 <Y0f17v1c3aAszlbk@dhcp22.suse.cz>
 <db41c662-19ce-fc1a-21ba-38ecda7d09c8@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db41c662-19ce-fc1a-21ba-38ecda7d09c8@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-10-22 20:50:48, Zhongkun He wrote:
> > > Hi Michal
> > > 
> > > Could we try to change the MPOL_F_SHARED flag to MPOL_F_STATIC to
> > > mark static mempolicy which cannot be freed, and mpol_needs_cond_ref
> > > can use MPOL_F_STATIC to avoid freeing  the static mempolicy.
> > 
> > Wouldn't it make more sense to get rid of a different treatment and
> > treat all memory policies the same way?
> 
> I found a case, not sure if it makes sense. If there is no policy
> in task->mempolicy, the use of atomic_{inc,dec} can be skiped
> according  to MPOL_F_STATIC. Atomic_{inc,dec} in hot path may reduces
> performance.

I would start with a simple conversion and do any potential
optimizations on top of that based on actual numbers. Maybe we can
special case default_policy to avoid reference counting a default (no
policy case). A simple check for pol == &default_policy should be
negligible.
-- 
Michal Hocko
SUSE Labs
