Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0348B6FF6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjEKP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEKP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:59:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CB40E7;
        Thu, 11 May 2023 08:59:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54A6B21E29;
        Thu, 11 May 2023 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683820767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Lj/YCJutpaNLuZIg73eRPmiuF7Hnb98ZHvSFAVP82o=;
        b=o9OwJS0sfYehKFlOmkW54Waa0TK4gS9tf132nZp2uvhNtEAMuEM2Fu9M+t7ib6MpkTTi3q
        S0THxkKqJYOj+sWBDHwmdvrtvjC6Yp8eVr++hLZo0mOlxzmAscKa5WqaN4CQgthBwTfz3M
        EwijcuVizAUfHKAfSQd3uLZTUUILn2Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12EA6134B2;
        Thu, 11 May 2023 15:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oB3ZAt8QXWRpfwAAMHmgww
        (envelope-from <mwilck@suse.com>); Thu, 11 May 2023 15:59:27 +0000
Message-ID: <7fc38a4a124caef6cb96a00000043a3288f4f004.camel@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
From:   Martin Wilck <mwilck@suse.com>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Date:   Thu, 11 May 2023 17:59:26 +0200
In-Reply-To: <45d127c4-71e9-2959-b69c-d31c46ec721e@suse.com>
References: <20230511123432.5793-1-jgross@suse.com>
         <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>
         <85a7dc28-74ec-f4d6-b5c3-ca456ce9d380@suse.com>
         <e7c5f4334ab6ff897547c68ea216fbcba22d4929.camel@suse.com>
         <45d127c4-71e9-2959-b69c-d31c46ec721e@suse.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-11 at 15:32 +0200, Juergen Gross wrote:
> On 11.05.23 15:23, Martin Wilck wrote:
> > On Thu, 2023-05-11 at 15:17 +0200, Juergen Gross wrote:
> > > >=20
> > > > We know for certain that sizeof(*sshdr) is 8 bytes, and will
> > > > most
> > > > probably remain so. Thus
> > > >=20
> > > > =A0=A0=A0=A0=A0 memset(sshdr, 0, sizeof(*sshdr))
> > > >=20
> > > > would result in more efficient code.
> > >=20
> > > I fail to see why zeroing a single byte would be less efficient
> > > than
> > > zeroing
> > > a possibly unaligned 8-byte area.
> >=20
> > I don't think it can be unaligned. gcc seems to think the same. It
> > compiles the memset(sshdr, ...) in scsi_normalize_sense() into a
> > single
> > instruction on x86_64.
> >=20
> > 0xffffffff8177e9d0 <scsi_normalize_sense>:=A0=A0=A0=A0=A0 nopl=A0=A0
> > 0x0(%rax,%rax,1) [FTRACE NOP]
> > 0xffffffff8177e9d5 <scsi_normalize_sense+5>:=A0=A0=A0 test=A0=A0 %rdi,%=
rdi
> > 0xffffffff8177e9d8 <scsi_normalize_sense+8>:=A0=A0=A0 movq=A0=A0 $0x0,(=
%rdx)
>=20
> A struct with 8 "u8" fields can be unaligned.

Right. I wrongly assumed this would be aligned like an u64. "The
alignment of any given struct or union type is required by the ISO C
standard to be at least a perfect multiple of the lowest common
multiple of the alignments of all of the members of the struct".

I wonder if this (non-)alignment of struct scsi_sense_hdr is
intentional, but that's a different discussion.

Thanks,
Martin

