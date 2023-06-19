Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A81735E83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFSUap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFSUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBEEFE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC77360EF6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E323EC433CA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:30:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Mdj1XKAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687206637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cWUl5faROZgsnrQLNI6JQn1pacbA8GX5iSb9nqF1oe4=;
        b=Mdj1XKAVxspk5cHMow8Ld9gGcUq52GpmjgiWXLamXhfGdVJ3mDjzGa7HeihGYGd3bFqPCh
        yXnpSDaFrzO1mi7TVqCfryc2boSNscWwqDp/lZT16eGR3yZOF6jGJOY5Usyxhdv4sAq0ws
        KB/Y+YAqY3S/CK6ldGaK2W2xwDww7co=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 14dbed16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 19 Jun 2023 20:30:36 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6b58e439794so317293a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:30:36 -0700 (PDT)
X-Gm-Message-State: AC+VfDzESEMztS5QPrHTFaCYtIMANje7fqFQOQ1aKzPRSayKJCkBjSXC
        Y3LAWRT0YyHGMqfJCce0EAlVzafrr2mJpeTBfec=
X-Google-Smtp-Source: ACHHUZ7POhX6wt0Gt/K1xBy3Bs2SlbrS0NGwnYeON4r79UtFA65YQy3i49Vw/gyMuKKsROiW6wZVnJqKDSq+8EbFo4A=
X-Received: by 2002:a05:6359:c28:b0:12e:e3a7:3ba4 with SMTP id
 gn40-20020a0563590c2800b0012ee3a73ba4mr2757694rwb.14.1687206634519; Mon, 19
 Jun 2023 13:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230531095119.11202-1-bchalios@amazon.es> <20230531095119.11202-2-bchalios@amazon.es>
In-Reply-To: <20230531095119.11202-2-bchalios@amazon.es>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 19 Jun 2023 22:30:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
Message-ID: <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
Subject: Re: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
To:     Babis Chalios <bchalios@amazon.es>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        graf@amazon.de, mzxreary@0pointer.de, xmarcalx@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the other patch, and as discussed before too, I don't think this
has any business being part of (virtual) hardware drivers, and instead
belongs in random.c, which might receive these notifications from a
variety of devices, and can thus synchronize things accordingly.
Please stop posting more of these same approaches. Same nack as the
other ones.
