Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE31722927
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjFEOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjFEOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:46:52 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 07:46:51 PDT
Received: from sasl.smtp.pobox.com (pb-sasl20.pobox.com [173.228.157.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE8B83;
        Mon,  5 Jun 2023 07:46:51 -0700 (PDT)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl20.pobox.com (Postfix) with ESMTP id 1FDAF1BE33;
        Mon,  5 Jun 2023 10:31:47 -0400 (EDT)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=U0Tis20OpqUo
        3bpus5BxRJzVibsUNUNZ8qYd/qWYHo8=; b=V5U/M9wEN4M3LSgk1ldC94U/nfLE
        Ihd1FxWmLnoCL0RBi7VxHtoaUPSp1pm9yMMTEdDI3BhCkaIzoBaovVHYTDuIi8ih
        0t9nQU5ycTliej6379Vwxwp0FrvbLVMeW8vfLn4iE8BIJmFWXHWCs5QaQvnZ5qST
        dG9yGJzJOj/MY/Y=
Received: from pb-sasl20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-sasl20.pobox.com (Postfix) with ESMTP id 17C1B1BE32;
        Mon,  5 Jun 2023 10:31:47 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.156.181.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl20.pobox.com (Postfix) with ESMTPSA id 826031BE2F;
        Mon,  5 Jun 2023 10:31:43 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <ccae168a-4be0-f085-8d8e-03bfbd71ac8f@pobox.com>
 <jafrw2wirzegnf7v2pcm52sao5yc4futa7ok4ccmywigj3y2c4@pep4b3ebus7s>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <87a3b3fd-e7b0-d6b5-af80-f14557cbbc33@pobox.com>
Date:   Mon, 5 Jun 2023 10:31:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <jafrw2wirzegnf7v2pcm52sao5yc4futa7ok4ccmywigj3y2c4@pep4b3ebus7s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: B1E2CF46-03AD-11EE-9269-89925CB417C6-82205200!pb-sasl20.pobox.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-05 10:20 AM, Benjamin Tissoires wrote:
> 
> On Jun 03 2023, Mark Lord wrote:
..
>> I wonder if this code could be re-worked to not even do this (waiting)
>> from the _probe() function?  It ought to be able to throw it on a workqueue
>> or something, rather than stalling system boot for a minimum of 5-seconds
>> (or much longer as as-is).
> 
> That's an option, but the fact that I can not replicate locally with the
> exact same hardware seems to indicate that we would just be papering
> over the issue.
> 
> Here, I admittely have the USB receiver running through USB-C ports, and
> the communication never fails and I get immediate bring ups of the
> devices. Which means I am not hitting that path.
> 
> The hidpp driver should have everything ready to delay the init in a
> workqueue, but the impacted users would still get a delay when they plug
> in the device (which is better than stalling the boot, I agree).
..

Oddly, it's only a boot-time thing.
If I unplug the Logitech Unifying receiver, wait a few seconds,
and then plug it back in.. my mouse, keyboard, and touchpad all work immediately.
Unlike during boot.
-- 
Mark Lord
