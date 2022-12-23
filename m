Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C637F6549BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLWAVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLWAVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:21:47 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911792736;
        Thu, 22 Dec 2022 16:21:45 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id AA79D5870460D; Fri, 23 Dec 2022 01:21:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id A4B4260C29174;
        Fri, 23 Dec 2022 01:21:42 +0100 (CET)
Date:   Fri, 23 Dec 2022 01:21:42 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     oss-security@lists.openwall.com
cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
In-Reply-To: <Y6TUJcr/IHrsTE0W@codewreck.org>
Message-ID: <s5r028oo-n662-9qqq-9130-208poq85418p@vanv.qr>
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 2022-12-22 23:03, Dominique Martinet wrote:
>> +
>> +Note that \fIcomm\fP can contain space and closing parenthesis characters. 
>> +Parsing /proc/${pid}/stat with split() or equivalent, or scanf(3) isn't
>> +reliable. The correct way is to locate closing parenthesis with strrchr(')')
>> +from the end of the buffer and parse integers from there.
>
>That's still not enough unless new lines are escaped, which they aren't:

strrchr does not concern itself with "lines".
If your input buffer contains the complete content of /proc/X/stat (and not
just a "line" thereof), the strrchr approach appears quite workable.
