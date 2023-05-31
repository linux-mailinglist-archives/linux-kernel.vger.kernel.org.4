Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3661717FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjEaMVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaMVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:21:48 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7A10F;
        Wed, 31 May 2023 05:21:46 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 568DC41E12;
        Wed, 31 May 2023 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685535704;
        bh=2RCEej4K5XPwpOdjmGnUsEFbXkDnSBYDQGM0QVWDj1s=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=L5DSDLE/du/kQdCq1yNvvc3K4Gx6NmH+18ZvXkQ7sjp9P4es8/Q++47hs8diF+nVm
         wjk7Y8VH3VTf/gbt8XDwXbkyfKiJpZvL26u6vQWVIIzmdg9z96gCw+MxolgGQIVJVo
         Xw7O7DSXWwDF5W/wgNgxF0CfPBGk2UzvZnhooZukpTuPwuKBGqfDb9TWxbdUXkxjNq
         jTYMMDOmPyooRTUgQtnpZore5X+A0hgQyLi64VrUEv491y107FUwtZ4KduESsupr75
         ibLCUDtoTx3Sm41No/ec9i+cR2WuQMr41nsjlpTlOS/DdaCy6MHRfb7fMm/i/4jxYq
         01Tu6BfbuVfrg==
Message-ID: <1f35dbba-9344-75c5-e870-31bc3198dbe0@canonical.com>
Date:   Wed, 31 May 2023 05:21:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230511213441.never.401-kees@kernel.org>
 <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
 <202305301555.102E1890@keescook>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <202305301555.102E1890@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 15:55, Kees Cook wrote:
> On Thu, May 11, 2023 at 02:48:29PM -0700, John Johansen wrote:
>> On 5/11/23 14:34, Kees Cook wrote:
>>> In the ongoing effort to convert all fake flexible arrays to proper
>>> flexible arrays, replace aa_buffer's 1-element "buffer" member with a
>>> flexible array.
>>>
>>> Cc: John Johansen <john.johansen@canonical.com>
>>> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> Cc: Paul Moore <paul@paul-moore.com>
>>> Cc: James Morris <jmorris@namei.org>
>>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>>> Cc: apparmor@lists.ubuntu.com
>>> Cc: linux-security-module@vger.kernel.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Acked-by: John Johansen <john.johansen@canonical.com>
>>
>> I have pulled this into my tree.
> 
> Just a quick ping: I haven't seen this show up in -next yet...
> 

oop, sorry looks like I didn't push, it should be fixed now

