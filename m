Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2BE6A83CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCBNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCBNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:49:29 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861D15C83
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:49:26 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t14so17662747ljd.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iueLlhkJnKVWnKpGU+Y50/0H8Xgr6AsobmPXkM/XL+A=;
        b=YY6xM7EDrdJyx14rhCDNllwm89MTiHZHWEYkQyXVeEsr0pC6QQwhH2qpPdRshQJ0X3
         7VujWszdurF/4oU4BM2mGVabmRNli2mWdivwdZbJcMIXhhr9lV08G4huz+ZOaht7YzZH
         GioPDDFoaqxsk89esSfUqkPnWQHNR9wSZydZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iueLlhkJnKVWnKpGU+Y50/0H8Xgr6AsobmPXkM/XL+A=;
        b=0Zqf7T46xY00oYYxOxX+jNj1a3wh4cTqGGS0QyZ3fXsz4aoI3QOZKd0Tk2h+tar2EB
         8BrI9I9H2TmL25S6vk6NYlwBG2uu3rY/ht3q1pYB8aki2dEwIiyMnPUPV2/2aD2ShBs/
         Pffs/V2hN7eXEbQwforvkMHOzpxiOZbwuwsiDj6yVP+Yg2XZDt/UwH51oIcJgfXHE35Y
         KBup8wV+Rd6DnUCQGPsQhEiLgavSUP+q9XH2+f3RSLYuSQJaybV8pBfq6V3JdZgeO/CG
         lRitn1rvcKsSJopP1iLELR2WlisZew1gN2iiB3R9IdU9oZz1FMOaQZW79N68kNdcFn+6
         Jp1w==
X-Gm-Message-State: AO0yUKWkFIM3XiwH/kKJ1SIO2Hw37FmBH2tMnjw9cM1x1V4fAwYdUA4x
        zywSobwdIBRGAZP+KQfxj/kQ9A==
X-Google-Smtp-Source: AK7set/5gQNxzqnOWtQpW4JWEgRJCOFSkRB4NM4BnWrEvGgO3CNnk6CXVgfUqURzoTo8Ve0ljNrDbQ==
X-Received: by 2002:a2e:22c3:0:b0:294:6cfd:8a88 with SMTP id i186-20020a2e22c3000000b002946cfd8a88mr3067433lji.9.1677764964511;
        Thu, 02 Mar 2023 05:49:24 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s16-20020ac25ff0000000b004cb3e97bff8sm2139088lfg.284.2023.03.02.05.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:49:24 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/2] iio: ad74413r: allow setting sink current for digital input
Date:   Thu,  2 Mar 2023 14:49:19 +0100
Message-Id: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
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

Rasmus Villemoes (2):
  dt-bindings: iio: ad74413r: allow setting sink current for digital
    input
  iio: ad74413r: wire up support for drive-strength-microamp property

 .../bindings/iio/addac/adi,ad74413r.yaml      | 10 ++++++++
 drivers/iio/addac/ad74413r.c                  | 24 +++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.37.2

