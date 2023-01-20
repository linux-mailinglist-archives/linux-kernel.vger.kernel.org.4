Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511A66754D9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjATMn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjATMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:43:55 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CC5F7A50A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:43:52 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 583BB262AD8;
        Fri, 20 Jan 2023 13:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1674218631;
        bh=sZNmqKbvZoiovCzlI6WBiaIn/1uSYIe/nS6jVFFARMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPQE8Zu4cQksOFQUyswavYY4LJUrlMt8lxJm+3ahDYd+mZFXwGtyKeIQiaTg9xx6t
         XoR/R4zuZsPcWpd9otIOIqrWFKbf0GyoVlPAjf7IhQpqGh1zw08+91/R5sFqDlxF36
         6X3Iigbgw0xZG1NFBkWTE/fIj3zY1tK+FSVOC7yBrZtGOWxNW+nsLLmSbs+C4H1kP3
         mk9MA5YIesE4zA1Aabvkey/nokvwF4sQaoft0Cm4GSIXGJ1MS3iEJ2sPjAATJGGzkB
         SZ5XVMlEyaoXBpIi4mwhOn4QXQHrOE8MkL0RbA3pDV9iCa5bFlLis+fL7yqLWrCJNZ
         IVfun9JOL6CwQ==
Date:   Fri, 20 Jan 2023 13:43:50 +0100
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/7] x86/boot: Delay sev_verify_cbit() a bit
Message-ID: <Y8qMhhEOA6MuGMxm@8bytes.org>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.649204101@infradead.org>
 <Y8lDN73cNOmNuciV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lDN73cNOmNuciV@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:18:47PM +0100, Borislav Petkov wrote:
> So, can we do that C-bit verification once on the BSP, *in C* which would be a
> lot easier, and be done with it?
> 
> Once it is verified there, the bit is the same on all APs so all good.

Yes, I think this is safe to do. The page-table the APs will use to boot
already has the correct C-bit set, and the position is verified on the
BSP. Further, the C-bit position is a hardware capability and there is
no chance the APs will have it at a different position than the BSP.

Even if the HV is lying to the VM by faking CPUID on the APs it wouldn't
matter, because the position is not read again on the APs.

Regards,

	Joerg
