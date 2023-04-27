Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575456F0E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjD0WSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjD0WSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:18:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FC30EE;
        Thu, 27 Apr 2023 15:18:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517c01edaaaso6686526a12.3;
        Thu, 27 Apr 2023 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682633881; x=1685225881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgxbPMJ7xUQDEudjDb2tgUkteEVXo/Z62mLiKg0b33g=;
        b=Z5eao2yloeRGKjFH79FDobwF4GBZyz/El+hwcAktCg26P3OkFYrJ7nMe5ZQKD3tjVL
         4NYP58f09Che6fBHQ+jJ3uCI56k+2WJvbSXb1sVp7bJkDb4EobiWttlTHa6zsSRipyol
         07q/pm0WqBMYJIKszuGd6Cv7qK1/Y/h7ykBatvFSedb+ApiDXlrKZuUtXL4JtH9YbAHH
         PBbc9iPZIPjyhZGX66vB5MMYF1/da+kQTop1ldLiL9/9U5daQVz6GJI35qEFaiFebxCe
         XLkuroA89QMqM2vE2pjgSVnSO087ZoAq3jNsT+OY3XCRmXQ0ooaFg0KMQAq8n9bftrX7
         ELgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633881; x=1685225881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgxbPMJ7xUQDEudjDb2tgUkteEVXo/Z62mLiKg0b33g=;
        b=ROstWA5TkLtOOP/j03RqMruL9TxmCaysA3RPHPQaZoEv7Mlie3/1pUHVFmsVtx4XeZ
         yxTBIQWz+SbpiTD2a3AEQKDN9n36YjcT0tFnmr3CUBhjtN9159PxqpJtq3KSsDA7A9w3
         SoaHWmuHOWfj+BwK78q1PxGYh44eYeQlV6mDjX1etOEIvfsxEGqp9SaATvKY/SJe/a+N
         Qg8qb09+gF3JYMheSbcBD1eKlDCmzgPX8NfH5lsWii64erxQGoyw+FvgEYp1b4HtjfOL
         aXgA2xPJcWuXk9xgweKMOLi3jLPcBMzchsN3ecK3KrNwfazu1oRvX6qoCX64LT5GqK8P
         KpEw==
X-Gm-Message-State: AC+VfDyMtgDkkDGExL/1Z4S7LkMrEmljOKMg+jjRLOJ8k6pq0NsYuM7J
        2d2XDKBSxrza9d1LZuA3NCQ=
X-Google-Smtp-Source: ACHHUZ7eSWrluGbR6ecEaWglSsdJ5YgAKU4czFvJC0nJqJ9oXV0AJgk8++DPGgLfYyUxPo5udaVM/A==
X-Received: by 2002:a17:902:f20b:b0:19f:3b86:4715 with SMTP id m11-20020a170902f20b00b0019f3b864715mr2916598plc.8.1682633881183;
        Thu, 27 Apr 2023 15:18:01 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b001a661000398sm12022783pll.103.2023.04.27.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:18:00 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [RFC PATCH 0/3] input: gpio-keys - fix pm ordering
Date:   Thu, 27 Apr 2023 15:16:22 -0700
Message-Id: <20230427221625.116050-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 52cdbdd49853 ("driver core: correct device's shutdown
order") allowed for proper sequencing of the gpio-keys device
shutdown callbacks by moving the device to the end of the
devices_kset list at probe which was delayed by child
dependencies.

However, commit 722e5f2b1eec ("driver core: Partially revert
"driver core: correct device's shutdown order"") removed this
portion of that commit causing a reversion in the gpio-keys
behavior which can prevent waking from shutdown.

This RFC is an attempt to find a better solution for properly
creating gpio-keys device links to ensure its suspend/resume and
shutdown services are invoked before those of its suppliers.

The first patch here is pretty brute force but simple and has
the advantage that it should be easily backportable to the
versions where the regression first occurred.

The second patch is perhaps better in spirit though still a bit
inelegant, but it can only be backported to versions of the
kernel that contain the commit in its 'Fixes:' tag. That isn't
really a valid 'Fixes:' tag since that commit did not cause the
regression, but it does represent how far the patch could be
backported.

Both commits shouldn't really exist in the same kernel so the
third patch reverts the first in an attempt to make that clear
(though it may be a source of confusion for some).

Hopefully someone with a better understanding of device links
will see a less intrusive way to automatically capture these
dependencies for parent device drivers that implement the
functions of child node devices.

Doug Berger (3):
  input: gpio-keys - use device_pm_move_to_tail
  input: gpio-keys - add device links of children
  Revert "input: gpio-keys - use device_pm_move_to_tail"

 drivers/input/keyboard/gpio_keys.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.34.1

