Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD23624912
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKJSIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiKJSIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:08:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0949B7C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TAqMJ9XEgcb7EhZe2sWVJH4nswduJ2xyoOUcpLbLbEM=; b=hfNGu4eXvHj3RG9HNpNohVHc16
        ipyrTZ3rsXdUovuTXkVMvNvcA9s8TrtXk46ii1oNq2be7fSpxn6H9eegzIIAWqSVBXTJcK+Ez8+ME
        pOohQG7JKCGxgTNvUSu6SVJSB8qaAcJEbh+/iu2qYAPFTQHYlwRHmMAHQnvuhFChodjPEahlNbJDM
        aKBfh5GytMaVXtYrg2V4hwEYK9qeBj8H7Jhh6YIPmYGzxi3ntCfEJmDD/eWv0aNF4pkmwcDlko2Kx
        27mtN6UPSwW5ZHDyfQFaxCUgc+ItsGMDVOkBT/pytFNCUiIliVRqVjHseXp0Yyg2bgDiXn6TI70/I
        VDHKTGcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otBxJ-00ALFj-P7; Thu, 10 Nov 2022 18:07:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5777E30041D;
        Thu, 10 Nov 2022 19:07:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CDAE2BB18BCD; Thu, 10 Nov 2022 19:07:12 +0100 (CET)
Date:   Thu, 10 Nov 2022 19:07:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        dave.hansen@linux.intel.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com, jailhouse-dev@googlegroups.com,
        jan.kiszka@siemens.com, xen-devel@lists.xenproject.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 2/2] x86: Check return values from early_ioremap calls
Message-ID: <Y2090DOT3q5CX9kV@hirez.programming.kicks-ass.net>
References: <20221110154521.613472-1-ross.philipson@oracle.com>
 <20221110154521.613472-3-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110154521.613472-3-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:45:21PM +0000, Ross Philipson wrote:
> On allocation failures, panic() was used since this seemed
> to be the action taken on other failures in the modules
> touched by this patch.

How is the panic() more useful than the obvious NULL deref that also
splats?
