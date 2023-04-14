Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422826E24D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDNNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDNNzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:55:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ACEE73;
        Fri, 14 Apr 2023 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4riDwi82epKmnE7d/5W5DyjvMFTPTQCx9+hBpCrTkWM=;
        t=1681480515; x=1682690115; b=AfBGpkim7slFF45O+uqyYxZ8XcgaOtp88SgWvS3oxZ4m7v3
        fksl5XzeqGTk+EB95nk/MIAYFkY1Ufrc+gJeFDhZBoTBEba5KVHMy02GQLoIV9z2UhWIwTTzSYPsQ
        fZPPwwIwb0IY8VNabL3K2Y0DmF474H10zIiW0UosGs+MbZu1F8juZMuWYFdJel+DMq50Ia2KSUvCj
        hhQNUoW4I0G22DW9GC5fY7LvAPmUJKuL0wB5ONYPJbAme/h1nbvJL5TqhRVDV7rJW9jaETZji0xbP
        2DkWGyE6evPMYC2YznK/d0RU4ln2siSVq/8MGpiQDPkzk+MXL3JalAGtTFD+ILhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pnJtM-00Fc5q-29;
        Fri, 14 Apr 2023 15:55:08 +0200
Message-ID: <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Apr 2023 15:55:07 +0200
In-Reply-To: <20230410011325.26850-1-rdunlap@infradead.org>
References: <20230410011325.26850-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-04-09 at 18:13 -0700, Randy Dunlap wrote:
> Current build of pata_cs5536 for i386 UML fails with:
>=20
> ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] und=
efined!
> ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefin=
ed!
> ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] unde=
fined!
> ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefine=
d!
>=20
> Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
>=20

Hm. Does this make sense? I can't see it'd work on UML to configure an
IDE device through MSRs? Surely that can't work? IOW, that entire driver
can't really work anyway can it?

OTOH, maybe theoretically it could work in PCI, just not with MSRs, and
then this patch makes some sense?

johannes
