Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8E6CF5A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjC2VwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC2VwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:52:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F9524F;
        Wed, 29 Mar 2023 14:52:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E56821ABF;
        Wed, 29 Mar 2023 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680126724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbyasE+U5G0etNVXeDJPsM6LV+TgTAw9J2CMCHV/AKk=;
        b=bJWmz8jbUMFtFdRf84YxkPJz179Q8SYLD8FkEV/Ai+5Kwf0zn/qsjQAhKQPcgmAAaEBXUD
        ZHVOTAPDEgnphqEXXh/c2Phhes5xzpDHHakoGi2chnlRHo+H0V1k8eJR1NCvi1y9RNs/hq
        xwpianAeCln+vtsuD8RjPnW5aHlmL08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680126724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbyasE+U5G0etNVXeDJPsM6LV+TgTAw9J2CMCHV/AKk=;
        b=cp+/JNy6F1c42CVnU5n0CDpAbXfsyYWkk5DlKhbkDm9yokxdP28jIOn14Umj2GJXUnNE/Z
        bmegeFteuLxUEKBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C10A139D3;
        Wed, 29 Mar 2023 21:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r5u+CAGzJGSvCwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 29 Mar 2023 21:52:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Xiao Ni" <xni@redhat.com>
Cc:     "Jes Sorensen" <jes@trained-monkey.org>,
        "Mariusz Tkaczyk" <mariusz.tkaczyk@linux.intel.com>,
        "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
In-reply-to: <167945548970.8008.8910680813298326328@noble.neil.brown.name>
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>,
 <CALTww2916uiO8_ViJQXutO2BPasFmiUJtfz8MxW0HKjDzwGFeQ@mail.gmail.com>,
 <167945548970.8008.8910680813298326328@noble.neil.brown.name>
Date:   Thu, 30 Mar 2023 08:51:54 +1100
Message-id: <168012671413.8106.6812573281942242445@noble.neil.brown.name>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, NeilBrown wrote:
> On Wed, 22 Mar 2023, Xiao Ni wrote:
> 
> > 
> > Second, are there possibilities that the arguments "dev" and "name" of
> > function create_mddev
> > are null at the same time?
> 
> No.  For Build or Create, dev is never NULL.  For Assemble and
> Incremental, name is never NULL.
> 

I should clarify this a bit.  For Assemble and Incremental, "name" is
never NULL *but* it might be an empty string.
So:
	if (name && name[0] == 0)
		name = NULL;

might cause it to become NULL.  So you cannot assume there is always
either a valid "dev" or a valid "name".  "dev" might be NULL, and "name"
might be "".

NeilBrown
