Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90866783EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjAWSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjAWSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:00:49 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E1302B9;
        Mon, 23 Jan 2023 10:00:48 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1pK17Z-003ZWl-9s; Mon, 23 Jan 2023 19:00:41 +0100
Received: from pd9f631ca.dip0.t-ipconnect.de ([217.246.49.202] helo=[192.168.144.87])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1pK17Z-0046ih-3e; Mon, 23 Jan 2023 19:00:41 +0100
Message-ID: <f5eb6cb1-c1f5-5a13-2b22-374adc70acec@mkarcher.dialup.fu-berlin.de>
Date:   Mon, 23 Jan 2023 19:00:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
To:     Jakub Jelinek <jakub@redhat.com>,
        David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "jakub@gcc.gnu.org" <jakub@gcc.gnu.org>
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
 <c411961861df4ae4b011317ff2c3c7df@AcuMS.aculab.com> <Y86xofsIk3NzidQO@tucnak>
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <Y86xofsIk3NzidQO@tucnak>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-Originating-IP: 217.246.49.202
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.01.2023 um 17:11 schrieb Jakub Jelinek:

> On Mon, Jan 23, 2023 at 04:06:27PM +0000, David Laight wrote:
>> From: Michael.Karcher
>>> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>> FWIW it is (currently) enough to add 0 to the top or bottom
>> of the division.
> If you don't want the warning at all, sure.  But if you want the compiler
> to warn if you use the macro on a (non-void *) pointer rather than array,
> what has been posted is needed.

Exactly. I actually had sizeof(a)/(sizeof(*a) + 0) at first, but a test showed
that it would silently generate invalid code on

   struct intc_mask_reg singleton = {...};
   _INTC_ARRAY(&singleton)

If it would expand to "&singleton, 1", it would be fine, but it will
expand to "&singleton, 0", as sizeof(intc_mask_reg*) is smaller than
sizeof(intc_mask_reg). The version I posted generates the intended warning
(upgraded to an error with -Werror) in that case. The old version also
generated the intended warning in this case, and not generating a warning
here is a regression I didn't want to be responsible for.

Kind regards,
   Michael Karcher

