Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15917676C60
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjAVLdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVLds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:33:48 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844E1E1C5;
        Sun, 22 Jan 2023 03:33:46 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1pJYbW-003cIW-JV; Sun, 22 Jan 2023 12:33:42 +0100
Received: from pd9f631ca.dip0.t-ipconnect.de ([217.246.49.202] helo=[192.168.144.87])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1pJYbW-003jRK-DR; Sun, 22 Jan 2023 12:33:42 +0100
Message-ID: <c74cad7b-9ea3-5223-8292-3fe1172a9419@mkarcher.dialup.fu-berlin.de>
Date:   Sun, 22 Jan 2023 12:33:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     jakub@gcc.gnu.org
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
 <2085aec3-796b-71c3-7cb2-d4103d3b6175@infradead.org>
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <2085aec3-796b-71c3-7cb2-d4103d3b6175@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-Originating-IP: 217.246.49.202
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.01.2023 um 08:00 schrieb Randy Dunlap:
>> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>> +#define _INTC_ARRAY(a) a, sizeof(a)/(_Generic((a), typeof(NULL): 0xFFFFFFFFU, default: sizeof(*a)))
> s/: / : / in 2 places.
>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks for your confirmation! Are you sure about the space before the 
colon? The colon in this case terminates a case descriptor for the 
type-level switch construction using "_Generic". It says: "In case 'a' 
has the 'type of NULL', divide by 0xFFFFFFFFU, in all other cases, 
divide by the size of a single array element". It's not a colon of the 
ternary ?: operator, in which case I would agree with the space before it.

If you confirm that you want a space before the colon in this case as 
well, I'm going to add it, though.

> How far back in gcc versions does this work?

I tested the support of _Generic on Compiler Explorer at godbolt.org. 
This construction is rejected by gcc 4.8, but accepted by gcc 4.9.

Kind regards,
   Michael Karcher

