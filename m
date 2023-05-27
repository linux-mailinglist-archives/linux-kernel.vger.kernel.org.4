Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCAB71371C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE0Wkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE0Wkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 18:40:42 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A476B9
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 15:40:40 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3CEB91C0E75; Sun, 28 May 2023 00:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1685227238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EC1K0rb07F3gmc/jAs4MvJRPUa46wf6TzTzwnAkPzCo=;
        b=DU3F6DB2qpLdidmagZR/WH+jnubdVxflcemVOs9XNBFvESLFRUdpM+Z/lMKWxmgls3ws8n
        H2/t2/zBmQUrYeiQhrv7eqA5t0j39fY0iVBtxcI1x6hpKPwUNo+Ims4CKCGADkSVyrt7KW
        1A5QphiCmzojLCFVh9Bs2n56O9oOW2s=
Date:   Sun, 28 May 2023 00:40:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Preble, Adam C'" <adam.c.preble@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How do I force an IBT trap in a demo kernel module?
Message-ID: <ZHKG4xQ8vma7lfRQ@localhost>
References: <PH7PR11MB65237A81D8258BB1E10969A9A9409@PH7PR11MB6523.namprd11.prod.outlook.com>
 <82034ea784e44c5b929f519ceac6c4e0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82034ea784e44c5b929f519ceac6c4e0@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-05-24 08:00:36, David Laight wrote:
> From: Preble, Adam C
> > Sent: 23 May 2023 20:29
> > 
> > I am debugging why a kernel module of ours triggers the IBT (Indirect Branch Tracking) trap, and while
> > doing that, I was trying to write a standalone demo that would forcefully trigger it on purpose. This
> > has turned out to be much more difficult than I thought! What can I do to get a module to generate an
> > indirect branch without an endbr64? Creating the indirect branch itself doesn't appear to be hard:
> > 
> > 1. Set up a function call
> > 2. Assign it to a function pointer
> > 3. Call the function pointer
> > 4. ...maybe add a compiler flag so it doesn't optimize the call to a direct branch.
> > 
> > I am primarily building in a Debian environment with gcc (Debian 10.2.1-6) 10.2.1 20210110. By
> > default, the branch does get optimized away. I had to set the -mforce-indirect-call flag. The endbr64
> > instruction would still emit so I added a function attribute to suppress it:
> ...
> > So what do I have to do to tell objtool to allow to me deliberately shoot myself in the foot here?
> 
> You could try adjusting the function pointer by the size of the endbr64 instrauction.
> 
> Oh, put the function pointer variable into static data.
> That should stop it all being optimised away.

volatile will help, too.

Or simply write the code in assembly.
								Pavel

-- 
