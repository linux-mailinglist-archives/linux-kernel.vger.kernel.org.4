Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0515F731676
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbjFOLY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbjFOLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:24:22 -0400
Received: from sasl.smtp.pobox.com (pb-sasl1.pobox.com [64.147.108.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209012949;
        Thu, 15 Jun 2023 04:24:20 -0700 (PDT)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl1.pobox.com (Postfix) with ESMTP id 6AA32AA013;
        Thu, 15 Jun 2023 07:24:17 -0400 (EDT)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=R9REBIl2cJpk
        vNtAOVV6nK22FQwV/7KTOjLjZ7mcB48=; b=tS3ATrgD8sVwNv2VFlvLuLwPJnm/
        0cBHpbCJkX1iBUdvh06MVqEO0N1JHvHKds0p8PaXPkWlg8CjQOnxGuo1Zvqo+cfZ
        LKUFdgiSvg0/pmZlH09g2hDKelNxaTFQcOqlwJddw8kVS6EqwXUXznlzWtDrjCSb
        0SvjRzUzTaI6PLk=
Received: from pb-sasl1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-sasl1.pobox.com (Postfix) with ESMTP id 508E6AA011;
        Thu, 15 Jun 2023 07:24:17 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.156.181.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl1.pobox.com (Postfix) with ESMTPSA id 41322AA010;
        Thu, 15 Jun 2023 07:24:16 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm>
 <42b6e582-f642-7521-135a-449140984211@leemhuis.info>
 <53903462-2552-b707-3831-cad3ef873b0d@leemhuis.info>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <aa0e3371-dad1-3296-18fb-1957b92aa4d1@pobox.com>
Date:   Thu, 15 Jun 2023 07:24:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <53903462-2552-b707-3831-cad3ef873b0d@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 29ECEAB2-0B6F-11EE-A78A-8E2B5958DECB-82205200!pb-sasl1.pobox.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 03:24 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>
...
> https://bugzilla.kernel.org/show_bug.cgi?id=217412
> 
> --- Comment #47 from Mark Blakeney ---
> @Juha, kernel 6.3.7 adds the 2 patches intended to fix this bug and the
> startup delay is now gone. However, I have had 2 cases over the last 5
> days in which I have been running 6.3.7 where my mouse fails to be
> detected at all after startup. I have to pull the Logitech receiver
> out/in to get the mouse working. Never seen this issue before so I
> suspect the patches are not right.
> ```

I too have had that happen with recent kernels, but have not yet put
a finger to a specific version or cause.

Just toggling the power button on the wireless mouse is enough for
it to "re-appear".

The 5.4.xx kernels never had this issue.  I went straight from those
to the 6.3.xx ones, where it does happen sometimes, both with and without
the recent "delay" fixes.
-- 
Mark Lord
