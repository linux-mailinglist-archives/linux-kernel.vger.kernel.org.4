Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677AB6C05F5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCSWKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCSWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:09:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F2D6E99;
        Sun, 19 Mar 2023 15:09:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BD2B1FFD4;
        Sun, 19 Mar 2023 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679263789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcKLt9U/8xQce8s4ATm4ybC+SdRvSBXCW4Wo7iUVV4Y=;
        b=xOhX2Fn3Rz0w79oprPw6eDEjcxfpAAdKSGioQy3Eua+t4gyUGYOPjd+kNDvvxW2K7uFQoL
        o/lipuAkByPwD2f0KnfQQi+CK65h25DLTXQZ+zgh5/zQ5J/HJ0Izg2NaJ9f/bF+TJ9UA1A
        vobz0qK6NTIm9Eeh4CZzGz6gGqFFmjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679263789;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcKLt9U/8xQce8s4ATm4ybC+SdRvSBXCW4Wo7iUVV4Y=;
        b=8E6F9s1CZxZzY3OwRJdytAQJH8uxScPdOzRAFxP1klgfgnCCdKdIIhPNP82cX3zVzGrURD
        LP0Mw2FkwYugcRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9CB1133E6;
        Sun, 19 Mar 2023 22:09:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BUPYFyqIF2SVZgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Mar 2023 22:09:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jes Sorensen" <jes@trained-monkey.org>
Cc:     "Mariusz Tkaczyk" <mariusz.tkaczyk@linux.intel.com>,
        "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
In-reply-to: <318ff554-0694-64e1-72bd-d941a775a16f@trained-monkey.org>
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>,
 <318ff554-0694-64e1-72bd-d941a775a16f@trained-monkey.org>
Date:   Mon, 20 Mar 2023 09:09:43 +1100
Message-id: <167926378352.8008.3450187952660050637@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, Jes Sorensen wrote:
> On 3/13/23 20:06, NeilBrown wrote:
> > 
> > mdopen() will use create_named_array() to ask the kernel to create the
> > given md array, but only if it is given a number or name.
> > If it is NOT given a name and is required to choose one itself using
> > find_free_devnm() it does NOT use create_named_array().
> > 
> > On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result in
> > failure to assemble an array.  This can particularly seen when the
> > "name" of the array begins with a host name different to the name of the
> > host running the command.
> > 
> > So add the missing call to create_named_array().
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217074
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Applied!

Thanks.

Do you have plans for releasing 4.3?  I'd like this patch to be in a
numbered release for at least a few months before we change the kernel
Kconfig to allow md to be built without CONFIG_BLOCK_LEGACY_AUTOLOAD.

Thanks,
NeilBrown
