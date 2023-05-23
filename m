Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153DE70D929
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjEWJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjEWJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:34:21 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA851AE;
        Tue, 23 May 2023 02:34:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C42B1C000B;
        Tue, 23 May 2023 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684834449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irbxTtFMj36QTztSinqx+K6zvjiLXjiZS7Tr5vGVeQA=;
        b=MQH74+mtNlOf4mUA+OQUVAFl8W+eC7RN11ueU2RMGlh+Uwq1wcbbyomCcUxSlkAI5NyNG3
        2TMaEiXyqLQolV9rwaPYpsE7eB6oq9qRgjQ7lXGv9e5Fkqy8eud0VjNM1Bd3o3RQCcqQLZ
        vikDp7RYUdmVy46Cv2NGjbr3pvHIDJNW4A6cX6ZD//6P8rdQyWozGOFmTEtNE+bl6sFbi5
        SRNppfd8ppRl7dBbbP6XTyvLL1K1FwSlmvyDZVICHBlkJjNG+Z+ux/uEvVGchQGOIWBi3a
        eOuUZbU5hKu1s5WmPVeQhF9hEE29NCLi5+s57dwJShnlXv/oGEnNobOwXkW7dw==
Date:   Tue, 23 May 2023 11:34:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 23/24] mtd: block2mtd: don't call early_lookup_bdev
 after the system is running
Message-ID: <20230523113402.32fa86ba@xps-13>
In-Reply-To: <20230523074535.249802-24-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
        <20230523074535.249802-24-hch@lst.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

hch@lst.de wrote on Tue, 23 May 2023 09:45:34 +0200:

> early_lookup_bdev is supposed to only be called from the early boot
> code, but mdtblock_early_get_bdev is called as a general fallback when
> lookup_bdev fails, which is problematic because early_lookup_bdev
> bypasses all normal path based permission checking, and might cause
> problems with certain container environments renaming devices.
>=20
> Switch to only call early_lookup_bdev when dm is built-in and the system
> state in not running yet.
>=20
> Note that this strictly speaking changes the kernel ABI as the PARTUUID=3D
> and PARTLABEL=3D style syntax is now not available during a running
> systems.  They never were intended for that, but this breaks things
> we'll have to figure out a way to make them available again.  But if
> avoidable in any way I'd rather avoid that.

Sounds reasonable to me. Richard?

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
