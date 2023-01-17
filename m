Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F9E66DD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjAQMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjAQMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:11:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA812A14C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:11:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8819D6865C;
        Tue, 17 Jan 2023 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673957506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Wfs4+0XvosXTKN+9ZseRbUtaNjCayrD+DsQV2o+gak=;
        b=cyfvTxQEwcBoMCtN7LeSNrKNgon7GCZ6K3Xzhi5P+QK7JeRuZedgNoHc4ukgVWtuZLIPdP
        9wD+XxHbHzpewE7POiuKcvVq1e2lpDG4NNYbEWhofyZ6liIiZbCIcLtbXbZ4EBRbdo8Qnb
        OlNnDmAh3d6EVhOO2sXHEzyHKYCQllY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3896F13357;
        Tue, 17 Jan 2023 12:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xns0DIKQxmMJWQAAMHmgww
        (envelope-from <mwilck@suse.com>); Tue, 17 Jan 2023 12:11:46 +0000
Message-ID: <59599137a9556355cb43563a4fbcc05b0fe769b4.camel@suse.com>
Subject: Re: regression on aarch64? panic on boot
From:   Martin Wilck <mwilck@suse.com>
To:     Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 13:11:45 +0100
In-Reply-To: <20230117063735.GA14468@lst.de>
References: <Y8XINx8fpGPKudW6@cormorant.local>
         <20230117055819.GB13795@lst.de> <Y8ZA30EoAFaFPwVC@cormorant.local>
         <20230117063735.GA14468@lst.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 07:37 +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > Good morning Christoph,
> >=20
> > Yep, the above works.
>=20
> Context for the newly added: This is dropping the newly added
> PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> other boot tests) to fail.=A0 Any idea what could be going wrong there
> probably in userspace?

If this is an aarch64 userspace issue, maybe related to
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D107678 ?

That bug causes segfaults of user space programs if for some reason the
unwind code is invoked. It happens only if libgcc_s.so is compiled with
gcc 13, and the pauth CPU feature is enabled in qemu.

Martin


