Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04839632F66
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiKUV5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiKUV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:57:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5EC11A13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:57:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5A16B81668
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05F6C433C1;
        Mon, 21 Nov 2022 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669067829;
        bh=tW6oDiQLZzIDYUBrQo2sq/hmd7+t5SdreSyS6ItzKtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ihXFCwVvli5ByfuA4LL+UaxP0w9KQIz+0rjMq6WwB+cjRLGVDyZtRn4Xu26X1ZxwP
         +5wI+t62G4SaW4IKMPck8YpkWpE5qlAo+1H0wQwcZDHl3sW3VQscKYMZKZEuc1SdY/
         ioiWFVYEuV271SIUlWN8MN7L5VgNmX/TrX1XB5XI=
Date:   Mon, 21 Nov 2022 13:57:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     <pmladek@suse.com>, <mcgrof@kernel.org>, <elver@google.com>,
        <gpiccoli@igalia.com>, <bigeasy@linutronix.de>,
        <tangmeng@uniontech.com>, <andriy.shevchenko@linux.intel.com>,
        <yangtiezhu@loongson.cn>, <john.ogness@linutronix.de>,
        <daniel.vetter@ffwll.ch>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>
Subject: Re: [PATCH RESEND] panic: Add register_panic_notifier and
 unregister_panic_notifier
Message-Id: <20221121135708.47f9a852a81d664a9b695336@linux-foundation.org>
In-Reply-To: <20221119080305.111863-1-xuqiang36@huawei.com>
References: <20221119080305.111863-1-xuqiang36@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 08:03:05 +0000 Xu Qiang <xuqiang36@huawei.com> wrote:

> Add two methods to manipulate panic_notifier_list and export them.
> Subsequently, panic_notifier_list is changed to static variable.

Fair enough, I guess.  But...

- It would be better to include a followup patch which converts at
  least some of the existing sites, so we know the code is getting
  tested.

- Better names would be panic_notifier_register() and
  panic_notifier_unregister()

- You forgot to make panic_notifier_list static to panic.c.

