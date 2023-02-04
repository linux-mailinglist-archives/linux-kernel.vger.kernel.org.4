Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9548968AA33
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjBDNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjBDNdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:33:17 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612E3EFDF;
        Sat,  4 Feb 2023 05:32:24 -0800 (PST)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 314DWEKn097633;
        Sat, 4 Feb 2023 22:32:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 04 Feb 2023 22:32:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 314DWDFf097627
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Feb 2023 22:32:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
Date:   Sat, 4 Feb 2023 22:32:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Converting dev->mutex into dev->spinlock ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

There is a long-standing deadlock problem in driver core code caused by
"struct device"->mutex being marked as "do not apply lockdep checks".

We can make this deadlock visible by applying [1], and we can confirm that
there is a deadlock problem that I think needs to be addressed in core code [2].

Also, since driver developers are taking it for granted that driver callback
functions can behave as if dev->mutex is not held (because possibility of deadlock
was never reported), it would solve many deadlocks in driver code if you can update
driver core code to avoid calling driver callback functions with dev->mutex held
(by e.g. replacing dev->mutex with dev->spinlock and dev->atomic_flags).
But I'm not familiar enough to propose such change...

[1] https://lkml.kernel.org/r/8c3fc3d1-8fed-be22-e0e7-ef1e1ea723ce@I-love.SAKURA.ne.jp
[2] https://lkml.kernel.org/r/b7bc63c8-bb28-d21d-7c3f-97e4e79a9292@I-love.SAKURA.ne.jp
