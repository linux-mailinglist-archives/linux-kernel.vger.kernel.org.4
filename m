Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BBF5F8C48
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJIQWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJIQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:22:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6E275FD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:22:42 -0700 (PDT)
X-QQ-mid: bizesmtp63t1665332545tg35vcz9
Received: from localhost.localdomain ( [58.247.70.42])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 00:22:18 +0800 (CST)
X-QQ-SSF: 01100000002000G0Z000B00A0000000
X-QQ-FEAT: DoD8xN2rKozHQmBqd9LmJAE/V3dv05ZHImZ5xKfTLc1VocmPYmpKo4QlQsheE
        OyZJL84jjHBGKcRPR6jT54Kb5KyCiqdUQL8gLRQfFFd5Ih+IA0WAvoi2haKK2HvaheaMOfS
        Gl3k5Rmk4oMKHRTPX1+U03xPnK5tlW8fw08Tk3nTxG+RoJ7QDk+coAn/+mKZgI+Gq0qXYsv
        HJgqwU9ea9FOCuoOOvHxHnsY5dhrPw1BBxNMid7EpRXKpnlM9KHAuwMWxt2dIlfMWnmqku+
        jp1eFfur0XzAjJ5aV2viU9ndrr6CkJW7lYTxwhktrSAyydGEE32ttRFZlYORZQvZMJx2ZAi
        MToX6H8AQCw7xPyYf5rZGpQAcp7VtrXGiKve7sC7qj3MuytKrI=
X-QQ-GoodBg: 0
From:   Soha Jin <soha@lohu.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, Soha Jin <soha@lohu.info>
Subject: [PATCH 0/3] Case-insensitive match_string and fwnode_is_compatible()
Date:   Mon, 10 Oct 2022 00:21:52 +0800
Message-Id: <20221009162155.1318-1-soha@lohu.info>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am introducing these patches for the patch for ethernet driver which I
will send later.

In Patch 1, I abstract `match_string` to `__match_string` with a comparison
function, make the original name calling it with `strcmp` and add
`match_string_nocase` calling it with `strcasecmp`.

In Patch 2 & 3, I implement `{device,fwnode}_property_match_string_nocase`
and `fwnode_is_compatible` for compatible property matching.

Soha Jin (3):
  string: add match_string_nocase() for case-insensitive match
  device property: add {device,fwnode}_property_match_string_nocase()
  device property: add fwnode_is_compatible() for compatible match

 drivers/base/property.c  | 92 ++++++++++++++++++++++++++++++++--------
 include/linux/property.h | 13 ++++++
 include/linux/string.h   | 31 +++++++++++++-
 lib/string_helpers.c     | 10 +++--
 4 files changed, 123 insertions(+), 23 deletions(-)

-- 
2.30.2

