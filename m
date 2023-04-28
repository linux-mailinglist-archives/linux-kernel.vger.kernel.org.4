Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0D6F1A59
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjD1OSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjD1OST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:18:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AB2B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:18:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E71F21FAF;
        Fri, 28 Apr 2023 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682691497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IS1nK0m+CWCctegmczujMIOjlwU6219d7lftmKaacw0=;
        b=XtRXciJEsPqIYVYp0ZfMJ59k3YdRdM9rYSLCEah1ejom1QYDoD91QzSdy1uMo3f9oe7gV2
        sPouUbJ6WKUq4ZWRLmtO89jsWZA5BH+Ys2TEe3c4+fwwAnlcGNvNOkizawQ0HO2iv2eQ+h
        EkczV9LrbIUKh9EPCFuFlWcevUdeE4Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1992E1390E;
        Fri, 28 Apr 2023 14:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sz3NBKnVS2TKOAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 28 Apr 2023 14:18:17 +0000
Date:   Fri, 28 Apr 2023 16:18:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Frank van der Linden <fvdl@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Lsf-pc] Fwd: [LSF/MM/BPF TOPIC] userspace control of memory
 management
Message-ID: <ZEvVqMtnU142GMEU@dhcp22.suse.cz>
References: <CAPTztWYAiroY3E8pwB+rnPGA1K9HLhkpQp1Gy9C1dEuS1FhWGg@mail.gmail.com>
 <CAPTztWY49XP-7GDHuvV2fNDCeJzd0vAac6n+rJ9KfWr6cyZ5ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTztWY49XP-7GDHuvV2fNDCeJzd0vAac6n+rJ9KfWr6cyZ5ww@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason I cannot find this email in my linux-mm inbox and I
cannot find it in any archives so let me add linux-mm and lkml again for
future reference.

On Tue 28-02-23 21:20:57, Frank van der Linden via Lsf-pc wrote:
> ---------- Forwarded message ---------
> From: Frank van der Linden <fvdl@google.com>
> Date: Tue, Feb 28, 2023 at 4:15 PM
> Subject: [LSF/MM/BPF TOPIC] userspace control of memory management
> To: <linux-mm@kvack.org>
> 
> 
> I propose this discussion topic for LSF/MM/BPF.
> 
> In a world where memory topologies are becoming more complicated, is
> it still possible to have an approach where the kernel deals with
> memory management to everyone's satisfaction?
> 
> The answer seemingly has been "not quite", since madvise and mempolicy
> exist. With things like cxl.mem coming into existence, a heterogeneous
> memory setup will become more common.
> 
> The number of madvise options keeps growing. There is now a
> process_madvise, and there are proposed extensions for the mempolicy
> systemcalls, allowing one process to control the policy of another, as
> well. There are exported cgroup interfaces to control reclaim, and
> discussions have taken place on explicit control reclaim-as-demotion
> to other nodes.
> 
> Is this the right approach? If so, would it be a good idea to
> optionally provide BPF hooks to control certain behavior, and let
> userspace direct things even more? Is that even possible,
> performance-wise? Would it make sense to be able to influence the
> MGLRU generation process in a more direct way if needed?
> 
> I think a discussion about these points would be interesting. Or, I
> should say, further discussion.
> 
> What do you think?
> 
> Thanks,
> 
> - Frank
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc

-- 
Michal Hocko
SUSE Labs
