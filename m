Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFFD600A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJQJ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJQJ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:26:10 -0400
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:103:465::209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CCB1572E;
        Mon, 17 Oct 2022 02:26:03 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4MrWng1gwgz9tcv;
        Mon, 17 Oct 2022 11:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1665998759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqG+FnY6cgw2Y7pCQVtHWPTcq9pUdNMukJJetYXzLCw=;
        b=Jiyoawga2QgnFZvz0FlLSxSiCwExRZ5QZtx4aPU/wUs8axLDU0G2fE940CtTyFlIJjp9gt
        UIV6nfSsGHC5qIl7mk6UC5dvOZsx/XRqOO+yPD6stc0w509ukfRUQgpnKeSnOhXcgLg8ep
        r/C9Iy6EZNovrTtVZbwitC3M3zgS7sZfofqwyix3J1qnW3KCYpJDm8fIiLkO93Q/eeWUmI
        3L887kT1LxDZz+KTlq6IrhlAaOfQRwgxnwQVsdf3OffL1DJufU+OdnP5ZLbWqj7nVd9AKQ
        okDTG0I5Jllknc957rsrov3EpyPh4eGtEtH+wjSs2FkEPWi5panZvJUuLEwcWA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Oct 2022 11:25:57 +0200
Message-Id: <CNO39RACPFL9.13SXHBXOMYMT2@ancom>
Cc:     "Henrik Rydberg" <rydberg@bitmath.org>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] Input: add driver for Himax hx83112b touchscreen
 devices
From:   "Job Noorman" <job@noorman.info>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
References: <20221016102756.40345-1-job@noorman.info>
 <20221016102756.40345-3-job@noorman.info> <Y0zX0e6WbLaRuTqv@penguin>
In-Reply-To: <Y0zX0e6WbLaRuTqv@penguin>
X-Rspamd-Queue-Id: 4MrWng1gwgz9tcv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review! I've addressed all your comments and will send an
update momentarily. I just have a small reply below.

On Mon Oct 17, 2022 at 6:19 AM CEST, Dmitry Torokhov wrote:
> > +struct himax_event {
> > +	struct himax_event_point points[HIMAX_MAX_POINTS];
> > +	u8 majors[HIMAX_MAX_POINTS];
> > +	u8 pad0[2];
> > +	u8 num_points;
> > +	u8 pad1[2];
> > +	u8 checksum_fix;
> > +} __packed;
> > +
> > +static_assert(sizeof(struct himax_event) =3D=3D 56);
>
> Is this different from BUILD_BUG_ON()?

Their intent is the same but BUILD_BUG_ON() cannot be used at the global
scope. Hence, static_assert() is necessary here.

Best regards,
Job
