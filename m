Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5F722F08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjFES5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjFES5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:57:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93491EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:57:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1241F461;
        Mon,  5 Jun 2023 18:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685991436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lAK74wKICjZKq6Z1wMe75zwa0jIR4popokcZA9WPsQ=;
        b=IXge6bvJ5/bto22JVellUOlgLvXI6vAEu+lJslBeEQmtUfXdSQJZfwG/4BgeW5mzBeYj3f
        HDmpysr4G1EjVaJlukImmfjA2S8khlcgUoymLwHdVcZcb7hSNO4Qzn0au2fn2GLgn5aexu
        4ICWGBLzcNG++SrurBBlOOatMrmSVz0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33FE9139C8;
        Mon,  5 Jun 2023 18:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q4iDCgwwfmQCXQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Jun 2023 18:57:16 +0000
Date:   Mon, 5 Jun 2023 20:57:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/3] vmstat: skip periodic vmstat update for nohz full
 CPUs
Message-ID: <ZH4wC0gEbsz+H/Aa@dhcp22.suse.cz>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.521067386@redhat.com>
 <ZH2VDaF9uODTqAfV@dhcp22.suse.cz>
 <ZH33BI9//tAbLvz5@tpad>
 <ZH4FhQ5Lh6xFBjyz@dhcp22.suse.cz>
 <ZH4c/MqHoWiA0PaQ@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4c/MqHoWiA0PaQ@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-06-23 14:35:56, Marcelo Tosatti wrote:
> On Mon, Jun 05, 2023 at 05:55:49PM +0200, Michal Hocko wrote:
> > > The example above shows an additional 7us for the
> > > 
> > >         oslat -> kworker -> oslat
> > > 
> > > switches. In the case of a virtualized CPU, and the vmstat_update
> > > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > > observed in the guest is higher than 50us, violating the acceptable
> > > latency threshold.
> > > 
> > > The isolated vCPU can perform operations that modify per-CPU page counters,
> > > for example to complete I/O operations:
> > > 
> > >       CPU 11/KVM-9540    [001] dNh1.  2314.248584: mod_zone_page_state <-__folio_end_writeback
> > >       CPU 11/KVM-9540    [001] dNh1.  2314.248585: <stack trace>
> > >  => 0xffffffffc042b083
> > >  => mod_zone_page_state
> > >  => __folio_end_writeback
> > >  => folio_end_writeback
> > >  => iomap_finish_ioend
> > >  => blk_mq_end_request_batch
> > >  => nvme_irq
> > >  => __handle_irq_event_percpu
> > >  => handle_irq_event
> > >  => handle_edge_irq
> > >  => __common_interrupt
> > >  => common_interrupt
> > >  => asm_common_interrupt
> > >  => vmx_do_interrupt_nmi_irqoff
> > >  => vmx_handle_exit_irqoff
> > >  => vcpu_enter_guest
> > >  => vcpu_run
> > >  => kvm_arch_vcpu_ioctl_run
> > >  => kvm_vcpu_ioctl
> > >  => __x64_sys_ioctl
> > >  => do_syscall_64
> > >  => entry_SYSCALL_64_after_hwframe
> > 
> > OK, this is really useful. It is just not really clear whether the IO
> > triggered here is from the guest or it a host activity.
> 
> Guest initiated I/O, since the host CPU is isolated.

Make it explicit in the changelog.

I am just wondering how you can achieve your strict deadlines when IO is
involved but that is another story I guess.

-- 
Michal Hocko
SUSE Labs
