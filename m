Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844A46C8ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 05:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjCYEb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 00:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCYEbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 00:31:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF519C7A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 21:31:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3-20020a251103000000b00b732e362449so3674869ybr.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 21:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679718675;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Poo0P8oQ4B8Rz+UE7IFFhX4GmiQM6xAOtDrDKrEFNJ4=;
        b=TGdGfEPHq5foESifnm1RGl+oqnWesFgXeKgGW3CxCel1xBl4KJZNq8Ofitt+GTclcW
         s0p62Xvcok2mEILqLMDYtOUT+TyLRW0iw0ATuNn9N+Ned9i5y2tCpT+z5+foRWZYHLbc
         K3TUjNS8gHR50barI+Kub0r9YCQDtJ4A/Uw6k+AMIpFpkMXdA411rV64+OQR98ApbrsF
         8RrilYIx4NcceKvRN00mRXtw4zCwxM9++/OQP2PwMB1feeQeMwBOrswREoThfTy6eP85
         d1mgETdzfOF8UY8ckVmDXuTwy9/yXG1JH/s7biSZg1tH0C4QgT9O77HFaIExM28n6xAX
         SEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718675;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Poo0P8oQ4B8Rz+UE7IFFhX4GmiQM6xAOtDrDKrEFNJ4=;
        b=Ls69xDl1pMna7yY/nDaFLwj8btds8pn6fCG4Y9AWvRcuDd/cgc+M/c1HV8piw90Y3q
         stulx3j8r55sEjaJf+o7aTaPLbTwHWH++Uem878bZ/2us4GVbI+RV6RMJfpRrkl69wuY
         BXT+HD39G9ZCcDVEpKeEeE9GzKKWNoyJDmge7MkrO54rYxo3TpwT2vZRvVc78mg0qX1x
         KSQI9gMzJP/81Qs499ZE7df+EqXPzkei7r11imWEjj5pQOehIDyDHFr8MJ2dVxtJlWHe
         qXcaRBD+n5FdGmlyszJkRNHd5Rfq/dY+qEm76UsCsEpgvEw+wZVGmjnIwZmeCI+DxzEn
         tcbA==
X-Gm-Message-State: AAQBX9eJ2BQfZCVGzbd62fNYRAMGhhUZ7qNiOcK/vQz0mxVHJeP7eqJa
        wYp6hgfJjYH/JFlZmsOOEeCHlqChCF+TWg==
X-Google-Smtp-Source: AKy350YENK3MeXLRY7cLlGwBrmfPDghrr6/boH+ZQmmvr5X2B/1OPe73sw2htg9LcNl3UgI1H8uKIjrjd2fRnA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:b286:0:b0:545:7b92:2890 with SMTP id
 q128-20020a81b286000000b005457b922890mr2123479ywh.7.1679718674890; Fri, 24
 Mar 2023 21:31:14 -0700 (PDT)
Date:   Sat, 25 Mar 2023 12:31:02 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230325043104.3761770-1-davidgow@google.com>
Subject: [RFC PATCH 0/2] KUnit device API proposal
From:   David Gow <davidgow@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a follow-up to the conversation[1] about adding helpers to create a
struct device for use in KUnit tests. At the moment, most tests are
using root_device_register(), which doesn't quite fit, and a few are
using platform_devices instead.

This adds a KUnit-specific equivalent: kunit_device_register(), which
creates a device which will be automatically cleaned up on test exit
(such as, for example, if an assertion fails).
It's also possible to unregister it earlier with
kunit_device_unregister().

This can replace the root_device_register() users pretty comfortably,
though doesn't resolve the issue with devm_ resources not being released
properly as laid out in [2]. Updating the implementation here to use a
'kunit' bus should, I think, be reasonably straightforward.

The first patch in the series is an in-progress implementation of a
separate new 'kunit_defer()' API, upon which this device implementation
is built.

If the overall idea seems good, I'll make sure to add better
tests/documentation, and patches converting existing tests to this API.

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com/
[2]: https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/

---
David Gow (2):
  kunit: resource: Add kunit_defer() functionality
  kunit: Add APIs for managing devices

 include/kunit/device.h   |  25 +++++++++
 include/kunit/resource.h |  87 +++++++++++++++++++++++++++++++
 lib/kunit/Makefile       |   1 +
 lib/kunit/device.c       |  68 ++++++++++++++++++++++++
 lib/kunit/resource.c     | 110 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 291 insertions(+)
 create mode 100644 include/kunit/device.h
 create mode 100644 lib/kunit/device.c

-- 
2.40.0.348.gf938b09366-goog

