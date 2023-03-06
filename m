Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366336ABA32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCFJnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:43:11 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938720695
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:43:08 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z5so8934131ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1678095786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcMN9JbZ9ifDcLCp57SFNkdO1pBah9zhn6rddcb4N9U=;
        b=SMu+sHcAvQi9deN6JwtNl1jeQXl5VLbmWVqeMFlMBrv9A8wi3LPwoAwQNMNtkUKuYQ
         0YyGbBTSISJxegmefjs4LQ81NxAhg+KLFYmJutcczFDdTOocc3Wg6S8zi3FDAM74LQf6
         s9cJasQ3MP49ILq9pq1BmIbSkn0mYDJ3RHtY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678095786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcMN9JbZ9ifDcLCp57SFNkdO1pBah9zhn6rddcb4N9U=;
        b=4O49IWs098E5mdrnij0F1YRKwYI/l7Mm667athbbZwNEdbuuZb2pYO47HCmAU0zO46
         vklkUIxbCSR8X7ixNfu8XXm2sHWkaSlhCc+CNPKKQdfkSOZ4JE2MSkVURkzXISTA1bgg
         T3lVmYYwVY8z8CsQjonYfMBpDKmTJmIETsIzN0+hVaZ9Yi7v1nD12PK7ocsBLUnmkHL0
         9om9MyrOXWIU3GdwgHYKvdpuHOIjg54iw/0Eqs57c6pb3diCfZmVczf3l80H0JQEjKcp
         K7AyTxWTCu75qE7JmsCP1cGB1Q/nup2esjsvmDmsTUu0EdgqXBzzT4iiegfFXm0Ru+au
         H8Fg==
X-Gm-Message-State: AO0yUKXsdMiPuQLSPe/SEWBQyUKkpjI0/fLGi7q6laJNGSj1qbimvtKo
        SbFoDcZrh/jM4dxhzq4DgGjwxA==
X-Google-Smtp-Source: AK7set9x+mvolD3p05ZthWcLiglULj+eqru/lw1Gx6a+cBBIEqiG/7Tgp3cKZLEy6oedNS2+5HPKhg==
X-Received: by 2002:a2e:910d:0:b0:295:c39c:d8ab with SMTP id m13-20020a2e910d000000b00295c39cd8abmr2691274ljg.39.1678095786609;
        Mon, 06 Mar 2023 01:43:06 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b002934ed148afsm1620091ljj.52.2023.03.06.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:43:06 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/2] iio: ad74413r: allow setting sink current for digital input
Date:   Mon,  6 Mar 2023 10:42:59 +0100
Message-Id: <20230306094301.1357543-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the actual hardware wired up to a digital input channel,
it may be necessary to configure the ad74413r to sink a small
current. For example, in the case of a simple mechanical switch, the
charge on the external 68 nF capacitor (cf. the data sheet's Figure
34) will keep the channel as reading high even after the switch is
turned off again.

Add a DT binding and driver support for setting the desired sink current.

I have chosen the term "drive strength" because it matches existing
practice, even if this is only a sink. E.g. there's

 * @PIN_CONFIG_DRIVE_STRENGTH_UA: the pin will sink or source at most the current
 *      passed as argument. The argument is in uA.

and indeed it would be trivial to hook up that
PIN_CONFIG_DRIVE_STRENGTH_UA in ad74413r_gpio_set_comp_config().

However, unlike the debounce time, there does not appear to be any way
to actually tweak the drive strength from userspace, nor do I know if
that would actually be a good idea. For our application(s), the
current sink needed is a property of the attached hardware, and thus
can and should be defined in DT.

v2:
- remove redundant type info in binding per Rob's bot
- use min() instead of if() in ad74413r_set_comp_drive_strength() per Jonathan

Rasmus Villemoes (2):
  dt-bindings: iio: ad74413r: allow setting sink current for digital
    input
  iio: ad74413r: wire up support for drive-strength-microamp property

 .../bindings/iio/addac/adi,ad74413r.yaml      |  9 ++++++++
 drivers/iio/addac/ad74413r.c                  | 23 +++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.37.2

