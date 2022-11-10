Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B290624434
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKJOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiKJOZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:25:10 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195C827DDC;
        Thu, 10 Nov 2022 06:25:10 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id c15so963062qtw.8;
        Thu, 10 Nov 2022 06:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYrdIwlw/lJKu3AnvAKe/flDTUx8RRjiQQvOO8furMY=;
        b=llbB5NAk5NEhzhrsh8ZeFXwW3N7uTFPMdeOX7LQRnU6QCk9njyjwVRsU6EVhxos+zi
         QRY6C3NtR1MnJriUo96m5KOGuNnZanG0fusD0i/3lnQzpnt3A8q9bAPg+rjgoM9C7w4/
         PZ20noXpsNzp2Vsi8wU6zhigA+PUVnjmdUzL+hp8wU4IjeDqCl81K4s+h8faDNRXKCfw
         xGhETgt8NJkj30nyvqYPeAD0tmKAvAo/RnysorSXUcokqcoNbaeczMnWkQMpcAI6pQ6a
         HwDVD509hLsBuuSrAawzX9XqodeN08TPIyLArC8lFmnUuTT19mun3B/3Q/n52FY2oI5J
         Acew==
X-Gm-Message-State: ACrzQf2fZhlsqW4aAx6pbvQghL6Y6jGc43s4u2tdaFi4gND/8VpO1v7Q
        iLAWFLlC4hlFKQcQiACCYPdNFy6yYswUV8aeAWQ=
X-Google-Smtp-Source: AMsMyM4FsPdzHNBl+WwP9MoBmdL61DTI6zZH2YMFXCRPO1hibDl0jdOsB052Yb46NanZ6Be+se6kG8vDk/J70gkqF2A=
X-Received: by 2002:ac8:7d15:0:b0:3a5:449:87c3 with SMTP id
 g21-20020ac87d15000000b003a5044987c3mr51914311qtb.357.1668090309233; Thu, 10
 Nov 2022 06:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-7-linux@roeck-us.net>
 <CAJZ5v0hMbzEdLecy_OWquOqdauBc1nsN7Q9mPkt2tOU4nEpHVw@mail.gmail.com> <20221110142149.GC2404288@roeck-us.net>
In-Reply-To: <20221110142149.GC2404288@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 15:24:58 +0100
Message-ID: <CAJZ5v0j4w_oTZHX4r9QpOV_VYmgc7+HTMS=mDFTgT4F1dp5pyg@mail.gmail.com>
Subject: Re: [PATCH 6/9] thermal/core: Protect hwmon accesses to thermal
 operations with thermal zone mutex
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 3:21 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Nov 09, 2022 at 08:19:13PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> [ ... ]
> >
> > And I wouldn't change the code below (the ternary operator is out of
> > fashion in particular).
> >
>
> I tried to introduce some consistency; the ternary operator is used
> in some of the existing thermal code. Guess I went the wrong direction.
> Never mind; I don't have a strong opinion either way.
> I updated the series patches to no longer use ternary operators in
> updated code, but I left existing code alone (changing that should not
> be part of this patch set anyway).

Thanks, that's what I would have done too.
