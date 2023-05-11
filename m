Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27C6FF2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjEKNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbjEKNZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:25:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C0100E9;
        Thu, 11 May 2023 06:23:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A0691FEC0;
        Thu, 11 May 2023 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683811395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXN1X+z5ambEAc+bzP74ebt1H+9gjSv5BYNzgZqPVgY=;
        b=BkTFKGG5GivUO6HQEAQ6qq5PbLw5r5KEokIsQ/ZYvhPO6btOeYZXW21TPdn2h4jYfmZ2oo
        8S51Xs5Tzl3oivc+wVI8+c90gWjc1EEaM3W++wEBDC9TpPKtFtE/lpcXTxjEU+mP+2T5Of
        v8yMXj4ZoeXxT8hX1tsVHF5S2uExeWc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F1E4138FA;
        Thu, 11 May 2023 13:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y8IrEUPsXGSuIwAAMHmgww
        (envelope-from <mwilck@suse.com>); Thu, 11 May 2023 13:23:15 +0000
Message-ID: <e7c5f4334ab6ff897547c68ea216fbcba22d4929.camel@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
From:   Martin Wilck <mwilck@suse.com>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Date:   Thu, 11 May 2023 15:23:14 +0200
In-Reply-To: <85a7dc28-74ec-f4d6-b5c3-ca456ce9d380@suse.com>
References: <20230511123432.5793-1-jgross@suse.com>
         <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>
         <85a7dc28-74ec-f4d6-b5c3-ca456ce9d380@suse.com>
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

On Thu, 2023-05-11 at 15:17 +0200, Juergen Gross wrote:
> >=20
> > We know for certain that sizeof(*sshdr) is 8 bytes, and will most
> > probably remain so. Thus
> >=20
> > =A0=A0=A0=A0 memset(sshdr, 0, sizeof(*sshdr))
> >=20
> > would result in more efficient code.
>=20
> I fail to see why zeroing a single byte would be less efficient than
> zeroing
> a possibly unaligned 8-byte area.

I don't think it can be unaligned. gcc seems to think the same. It
compiles the memset(sshdr, ...) in scsi_normalize_sense() into a single
instruction on x86_64.

0xffffffff8177e9d0 <scsi_normalize_sense>:      nopl   0x0(%rax,%rax,1) [FT=
RACE NOP]
0xffffffff8177e9d5 <scsi_normalize_sense+5>:    test   %rdi,%rdi
0xffffffff8177e9d8 <scsi_normalize_sense+8>:    movq   $0x0,(%rdx)

Martin

