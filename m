Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CBE70D5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjEWHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjEWHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E1119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:46:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5F820400;
        Tue, 23 May 2023 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684827962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HE8Z1r+4tl2uPWUmoH+B2Mu5/vsobbHlaWuGe2SIGH0=;
        b=fdDAJd9CyqjSrnt3PsKFrRrefe+mjo30LoRyztAS20x9AjqcNg0GWxXukwc7b7Mec4DBU4
        H2vA0ca3ogceMD5R470OfC6cnigF7Zs4pCd0kXnpxTxrWqW/elZntnFtZf6bKqamEiGKab
        59gKyP6W/faL+zy8JQV+buAk5mtGmmY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0386B13588;
        Tue, 23 May 2023 07:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lSB7OTlvbGSPJwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 23 May 2023 07:46:01 +0000
Date:   Tue, 23 May 2023 09:46:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
Message-ID: <ZGxvOcmC8adflVcn@dhcp22.suse.cz>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
 <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com>
 <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
 <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-05-23 11:48:52, Linus Torvalds wrote:
> On Mon, May 22, 2023 at 11:39 AM David Rientjes <rientjes@google.com> wrote:
> >
> > I think VM_BUG_ON*() and friends are used to crash the kernel for
> > debugging so that we get a crash dump and because some variants don't
> > exist for VM_WARN_ON().
> 
> I do think that from a VM developer standpoint, I think it should be
> fine to just effectively turn VM_BUG_ON() into WARN_ON_ONCE() together
> with panic_on_warn.

This is a very good idea. VM_BUG_ON has always been rather special and
from my past experience people are not really sure when to use it. It is
a conditional thing so it cannot be really used for really BUG_ON cases.
Turning them into VM_WARN (not sure about ONCE) makes a lot of sense
because as you say you can make them panic easily.
-- 
Michal Hocko
SUSE Labs
