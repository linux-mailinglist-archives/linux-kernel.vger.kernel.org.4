Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1220D73298C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbjFPIKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244352AbjFPIKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:10:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10019295B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CIQPUkAARE5pbVWQiz2e7/Pw4fraej9LAymOY58fIss=; b=OEDwW8F77lxoxE5qv/tHEfal5U
        8WxGgVfCbLQEISku9NMR41IaMNNp8gPMXNfQck7QT6cd3rTNXLAAJ5xmKdwVkcEJjbjQ+TLcKwDqZ
        BlxwdXRnYLcfCuV4d+Q7b8dCpFOtaq114upiZNMuLl0/PKe+ZOvmr1ZRCNsRaedrDDhA5syuB1ZGc
        00oUX5ERRzDhpD5+6AsV9nP7P7qMWcwTcCWGhW7C7ig7j3o2h8mwQBmHOcc/JRQW5oSHm9L5Jjs3/
        9Hee9huSnxbZwrkNrcuBfWQZ5BPpumNE7q0M6dcXoqGMDBytzdMv9MYp+8DRts7jh6D0mxmtoYavo
        mfDtiiyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qA4XK-008iKq-4m; Fri, 16 Jun 2023 08:10:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA0523002F0;
        Fri, 16 Jun 2023 10:10:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DC712B5B5B74; Fri, 16 Jun 2023 10:10:25 +0200 (CEST)
Date:   Fri, 16 Jun 2023 10:10:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Tang, Feng" <feng.tang@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <20230616081025.GM38236@hirez.programming.kicks-ass.net>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
 <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:02:31AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 06:53:21AM +0000, Zhang, Rui wrote:
> > On Thu, 2023-06-15 at 11:20 +0200, Peter Zijlstra wrote:
> 
> > > So I have at least two machines where I boot with 'possible_cpus=#'
> > > because the BIOS MADT is reporting a stupid number of CPUs that
> > > aren't
> > > actually there.
> > 
> > Does the MADT report those CPUs as disabled but online capable?
> > can you send me a copy of the acpidmp?
> 
> Sent privately, it's a bit big.

So if I remove 'possible_cpus=40' it does crazy shit like this:

[    1.268447] setup_percpu: NR_CPUS:512 nr_cpumask_bits:160 nr_cpu_ids:160 nr_node_ids:2

[    1.303567] pcpu-alloc: [0] 000 001 002 003 004 005 006 007
[    1.309871] pcpu-alloc: [0] 008 009 020 021 022 023 024 025
[    1.316172] pcpu-alloc: [0] 026 027 028 029 040 042 044 046
[    1.322475] pcpu-alloc: [0] 048 050 052 054 056 058 060 062
[    1.328777] pcpu-alloc: [0] 064 066 068 070 072 074 076 078
[    1.335084] pcpu-alloc: [0] 080 082 084 086 088 090 092 094
[    1.341387] pcpu-alloc: [0] 096 098 100 102 104 106 108 110
[    1.347688] pcpu-alloc: [0] 112 114 116 118 120 122 124 126
[    1.353992] pcpu-alloc: [0] 128 130 132 134 136 138 140 142
[    1.360293] pcpu-alloc: [0] 144 146 148 150 152 154 156 158
[    1.366596] pcpu-alloc: [1] 010 011 012 013 014 015 016 017
[    1.372900] pcpu-alloc: [1] 018 019 030 031 032 033 034 035
[    1.379201] pcpu-alloc: [1] 036 037 038 039 041 043 045 047
[    1.385504] pcpu-alloc: [1] 049 051 053 055 057 059 061 063
[    1.391806] pcpu-alloc: [1] 065 067 069 071 073 075 077 079
[    1.398109] pcpu-alloc: [1] 081 083 085 087 089 091 093 095
[    1.404411] pcpu-alloc: [1] 097 099 101 103 105 107 109 111
[    1.410714] pcpu-alloc: [1] 113 115 117 119 121 123 125 127
[    1.417016] pcpu-alloc: [1] 129 131 133 135 137 139 141 143
[    1.423319] pcpu-alloc: [1] 145 147 149 151 153 155 157 159

[    2.110382] smp: Bringing up secondary CPUs ...
[    2.112255] x86: Booting SMP configuration:
[    2.113253] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7   #8   #9
[    2.221253] .... node  #1, CPUs:    #10
[    0.163522] smpboot: CPU 10 Converting physical 0 to logical die 1
[    2.337372]   #11  #12  #13  #14  #15  #16  #17  #18  #19
[    2.504253] .... node  #0, CPUs:    #20  #21  #22  #23  #24  #25  #26  #27  #28  #29
[    2.563253] .... node  #1, CPUs:    #30  #31  #32  #33  #34  #35  #36  #37  #38  #39
[    2.662321] smp: Brought up 2 nodes, 40 CPUs
[    2.664257] smpboot: Max logical packages: 8

It is an IVB-EP with *2* sockets, 10 cores and SMT, 40 is right, 160 is
quite insane.
