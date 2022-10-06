Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E2D5F69DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiJFOmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:42:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36596A99F1;
        Thu,  6 Oct 2022 07:42:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 296Eg7p8007809
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 10:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1665067329; bh=S2x0j0IMfjyHgJEcjGYF7+KaBoxh4wuOGf7JhVXcjJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IAetTbAqYiQV5GylQ6WUizemjFS+jog/L9doNU8rV1tn1SFK4r+vhdrTOuUbuuTls
         /U4G0xPiXz3Efu1pjUVi/u1wG4K59l/gzv8CIZcFlm6VJYZgCMNzCJ60Ua6CzFSz6k
         67oJH2lffqyMwBwcIq45kzrg1sOPD8Z/qUFpxUv8qHaXCQ6l+5bcQOqtMgvXxyzf1+
         IqQI6XJTIk6E43ucxFDSGppkCM/oC5RcFyg2cC4sLZzQU4yt40/I4I5FBU63FNYlJG
         AW70mHa+Fy4eOaL1gGNTymqHZL/kG5njC61rbKVGKgeJPDBpS70BFklh37zhZYvlcx
         icsaTZmBTvS0Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6CF8715C35F2; Thu,  6 Oct 2022 10:42:07 -0400 (EDT)
Date:   Thu, 6 Oct 2022 10:42:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] LSM patches for v6.1
Message-ID: <Yz7pPxopFQyUyr28@mit.edu>
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
 <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wihQGNanXu3aeN12rsq+2K9BDkZEij-9HWtbVxFbXg1rw@mail.gmail.com>
 <87h70h5d36.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h70h5d36.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, there's one thing I don't get about why you hate LSM's having
the ability to prevent user name spaces, and yet you are OK with
(indeed, touting) /proc/sys/user/max_user_namespaces.

If we set max_user_namespaces to N, won't the N+1'th application get
an error when they try to create a user namespace?  One of your
arguments about why having LSM's forcing a error of say, EPERM, is
that applications that don't check for error returns might get
confused.  (Those are buggy applications; so they should be fixed ---
isn't that your argument about why we shouldn't be freaking out over
security bugs caused by kernel bugs and user namespaces.)  But if you
set max_user_namespaces, that same application will now fail with say,
ENOSPC.

And if in fact there is a buggy application that will create a
security exposure because they aren't checking !@#@?! error returns,
an attacker can simply create N user namespaces --- and then trigger
the buggy applicaion, at which point, they will have 0wned the system.

    	  	      	       	      - Ted
