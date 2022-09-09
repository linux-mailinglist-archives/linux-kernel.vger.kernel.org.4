Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8C5B38BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIINTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIINTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:19:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1754AB1B4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uu4FKZ6m8FqFuZxmlF95kxb0xNsagokSRxqsYzwUQsI=; b=ut5fVKXMdS+luwtzvFplggRB2M
        O4LjNb16pGtC/zWiwMotqWJWFimyX9raS8SgcXGAExwIHDhEwnhgVDODCFwI/+2z4ms0vMPyuaMqy
        nSk5n6JBabnvBGEYxdwDu/MWRO84OjlfgIL6R7pIhsPZrf0zNiILBbiHQDaQ/qsk7HwJ0taNPDhuH
        dPCKFvRf9OV+3wdzi0MnzxVuYq6RqzeArE8pKvZ4Ajuq177bywBsUXfhMzxrorQCEyFSwe7IXNfln
        n3u/IArizmeE7KodnB3Q2jwSWTHBRyTku2ae/1HRHQckbr5vTK87I8byBR0v0PZSRBU6ERsEpiNil
        fLvDa1QA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWdu8-00DHcd-QL; Fri, 09 Sep 2022 13:18:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D84D6300023;
        Fri,  9 Sep 2022 15:18:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEA33201AF2DB; Fri,  9 Sep 2022 15:18:40 +0200 (CEST)
Date:   Fri, 9 Sep 2022 15:18:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manikandan Jagatheesan <mjagatheesan@vmware.com>
Cc:     "bp@suse.de" <bp@suse.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Peter Jonasson <pjonasson@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        Kodeswaran Kumarasamy <kkumarasamy@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: Re: Performance Regression in Linux Kernel 5.19
Message-ID: <Yxs9MGGmSShJGaXs@hirez.programming.kicks-ass.net>
References: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:46:08AM +0000, Manikandan Jagatheesan wrote:
> As part of VMware's performance regression testing for Linux
> Kernel upstream releases, we have evaluated the performance
> of Linux kernel 5.19 against the 5.18 release and we have 
> noticed performance regressions in Linux VMs on ESXi as shown 
> below.
> - Compute(up to -70%)
> - Networking(up to -30%)
> - Storage(up to -13%) 
>  
> After performing the bisect between kernel 5.18 and 5.19, we 
> identified the root cause to be the enablement of IBRS mitigation 
> for spectre_v2 vulnerability by commit 6ad0ad2bf8a6 ("x86/bugs: 
> Report Intel retbleed vulnerability").
>  
> To confirm this, we have disabled the above security mitigation
> through kernel boot parameter(spectre_v2=off) in 5.19 and re-ran
> our tests & confirmed that the performance was on-par with 
> 5.18 release. 

Well, duh.. :-)
