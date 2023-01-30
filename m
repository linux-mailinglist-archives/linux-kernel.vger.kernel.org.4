Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58394681572
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbjA3PqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbjA3Pp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:45:58 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930633FF0E;
        Mon, 30 Jan 2023 07:45:43 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id gr7so8358857ejb.5;
        Mon, 30 Jan 2023 07:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PvbEcYxraBBpiH7uTe+5RKHDm8u6Tluv0rEzDxAUZg=;
        b=rT4QkrcAAG1zo2sYK1nW8k2vCLgR5nGF9j+ke9b5nxweTOgXIAl2cR+0SJ3OxutiFn
         be11SqSymcjnxGxQ7IhpNrRLNLYJACo5SXku/RggiXOwuQhXvtJVo6/nM3WYeH1OwsgM
         Y6SfzJN6XI8+GoFTdmFLfGxERbqvBjhby6mnrgDJ6YVoldVOPOvv0CpFr/T5kaQhU5yY
         rYcJ7jgPR7Ru7S0IgnGxhAwGEB2N61Hm4d4NrtnWjty30LGFibhiY5/IWzRfgDv6X8u6
         +cuj8in+ZSle2wKZfeSPeGmo8cICNtStp3eZb8oiurUZ4Ye1Ba1jUVxldrB9O3xeOCfT
         sRLg==
X-Gm-Message-State: AO0yUKUUR0ZBa3VxrM3dTINdFUEeqkxLRHT6cNnuoCWe1XNSNAZbxarN
        yds/T9nqW8mx/qbJet5J8CzAzMxXDeI9WldYxJA=
X-Google-Smtp-Source: AK7set/Ulxsu+qRUJPbaTJqX2uabotCXwgGrTXh+6Eaa/BktTHIkqHNwrMuGvW2EEEi21/g527R5TYsgKYhSzFKOiGo=
X-Received: by 2002:a17:907:58d:b0:878:581b:63ee with SMTP id
 vw13-20020a170907058d00b00878581b63eemr3809440ejb.244.1675093542178; Mon, 30
 Jan 2023 07:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20230119142115.38260-1-W_Armin@gmx.de> <8e3ddde5-87aa-a72a-dcfa-5a6041377b15@gmx.de>
 <CAJZ5v0jkN_Qi+DNmQvbk+bRKfGkgZOvwLmYEujpn9d47TMSrng@mail.gmail.com>
In-Reply-To: <CAJZ5v0jkN_Qi+DNmQvbk+bRKfGkgZOvwLmYEujpn9d47TMSrng@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 16:45:30 +0100
Message-ID: <CAJZ5v0h_4=CyjONaqpsC4fdVuu_zEZWDsLDXczkRdPQ=+hnkTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: battery: Fix various string handling issues
To:     Armin Wolf <w_armin@gmx.de>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 1:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jan 30, 2023 at 10:14 AM Armin Wolf <W_Armin@gmx.de> wrote:
> >
> > Am 19.01.23 um 15:21 schrieb Armin Wolf:
> >
> > > On my Dell Inspiron 3505, the battery model name was displayed
> > > differently than when running Windows. While i first suspected an
> > > ACPI issue, it turned out that the real reason was the ACPI battery
> > > driver failing to handle strings larger than 32 bytes.
> > >
> > > This caused the model name of the battery (35 bytes long, hex string)
> > > to miss proper NUL-termination, resulting in a buffer overread later.
> > > Luckily, a valid string was stored right after the now invalid string,
> > > appending only the battery serial number to the original model name.
> > >
> > > The first patch fixes a potential buffer overread then handling buffers,
> > > while the second patch finally increases the maximum string length to
> > > avoid truncating such larger strings.
> > >
> > > The patch series was tested on a Dell Inspiron 3505 and appears
> > > to work properly.
> >
> > Are there any outstanding issues with the patch series which need
> > to be fixed for mainline inclusion?
>
> I'll have a look shortly and let you know.

I've queued up the patches for 6.3, thanks!
